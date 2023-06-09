/***********************************************/

//Project Name : UDP_Send
//Email		   :
//Create Time	: 2021/01/09 13:36
//Editor       : Liu
//Version		: Rev1.0.0

/***********************************************/

module udp_send
	#(
    //开发板MAC地址 01_00_5e_00_01_81 
    parameter BOARD_MAC = 48'h2C_FE_07_19_68_33,       
//	 parameter BOARD_MAC = 48'h01_00_5e_7f_ff_fa,
    //开发板IP地址 8'd192,8'd168,8'd1,8'd110    
    parameter BOARD_IP  = {8'd192,8'd168,8'd1,8'd110},   
    //目的MAC地址        
//    parameter  DES_MAC  = 48'hDC_FE_07_19_68_34,
	parameter	DES_MAC	=	48'h00_2B_67_DD_6C_1C,
    //目的IP地址 192.168.1.11     
    parameter  DES_IP   = {8'd192,8'd168,8'd1,8'd11} 
	)
(
          
		input                clk,			    //时钟信号
		input						rst_n,        	 //复位信号，低电平有效	 
		input						tx_start_en,    //以太网开始发送数据信号
		input			 [31:0]	tx_data,	    	 //以太网待发送数据
		input        [15:0]  tx_byte_num,    //以太网发送的有效字节数
	   input        [31:0]  crc_data   ,    //CRC校验数据
		input        [3:0]   crc_next   ,    //CRC下次校验完成数据
		output  reg          tx_done    ,    //以太网发送完成信号
		output  reg          tx_req     ,    //读数据请求信号
		output  reg          eth_tx_en  ,    //MII输出数据有效信号
		output  reg  [7:0]   eth_tx_data_s,  //MIIH输出数据
		output  reg  [15:0]	txdata_cnt,
		output  reg  [15:0]  data_cnt,
		output  reg          crc_en     ,    //CRC开始校验使能
		output  reg          crc_clr        //CRC数据复位信号 
);


//状态机
localparam  st_idle      = 7'b0000001;   //初始状态，等待开始发送信号
localparam  st_check_sum = 7'b0000010;   //IP首部校验和
localparam  st_preamble  = 7'b0000100;   //发送前导码+帧起始界定符
localparam  st_eth_head  = 7'b0001000;   //发送以太网帧头
localparam  st_ip_head   = 7'b0010000;   //发送IP首部+UDP首部
localparam  st_tx_data   = 7'b0100000;   //发送数据
localparam  st_crc       = 7'b1000000;   //发送CRC校验值

localparam  ETH_TYPE     = 16'h0800;    	//以太网协议类型 IP协议
//以太网数据最小46个字节，IP首部20个字节+UDP首部8个字节
//所以数据至少46-20-8=18个字节
localparam  MIN_DATA_NUM = 16'd18;

//reg define
reg    [6:0]       cur_state        ;
reg    [6:0]       next_state       ;
                                    
reg    [7:0]       preamble[8:0]    ;     //前导码
reg    [7:0]       eth_head[13:0]   ;     //以太网首部
reg    [31:0]      ip_head[6:0]     ;     //IP首部 + UDP首部
                                    
reg                start_en_d0      ;
reg                start_en_d1      ;
reg    [15:0]      tx_data_num      ;     //发送的有效数据字节个数
reg    [15:0]      total_num        ;     //总字节数
reg    [15:0]      udp_num          ;     //UDP字节数
reg                skip_en          ;     //控制状态跳转使能信号
reg    [4:0]       cnt              ;
reg    [31:0]      check_buffer     ;     //首部校验和
reg    [2:0]       tx_bit_sel       ;
//reg    [15:0]      data_cnt         ;     //发送数据个数计数器
reg                tx_done_t        ;
reg    [4:0]       real_add_cnt     ;     //以太网数据实际多发的字节数
reg  					 eth_tx_en_l		;                                    
//wire define                       
wire               pos_start_en     ;     //开始发送数据上升沿
wire   [15:0]      real_tx_data_num ;     //实际发送的字节数(以太网最少字节要求) 	

assign  pos_start_en = (~start_en_d1) & start_en_d0;
assign  real_tx_data_num = (tx_data_num >= MIN_DATA_NUM) 
                           ? tx_data_num : MIN_DATA_NUM; 

//采tx_start_en的上升沿
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        start_en_d0 <= 1'b0;
        start_en_d1 <= 1'b0;
    end    
    else begin
        start_en_d0 <= tx_start_en;
        start_en_d1 <= start_en_d0;
    end
end 

//寄存数据有效字节
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        tx_data_num <= 16'd0;
        total_num <= 16'd0;
        udp_num <= 16'd0;
    end
    else begin
        if(pos_start_en && cur_state == st_idle) begin
            //数据长度
            tx_data_num <= tx_byte_num;        
            //IP长度：有效数据+IP首部长度            
            total_num <= 2*tx_data_num + 16'd28;  
            //UDP长度：有效数据+UDP首部长度            
            udp_num <= 2*tx_data_num + 16'd8;             
        end    
    end
end   

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cur_state <= st_idle;  
    else
        cur_state <= next_state;
end

always @(*) begin
    next_state = st_idle;
    case(cur_state)
        st_idle     : begin                               //等待发送数据
            if(skip_en)                
                next_state = st_check_sum;
            else
                next_state = st_idle;
        end  
        st_check_sum: begin                               //IP首部校验
            if(skip_en)
                next_state = st_preamble;
            else
                next_state = st_check_sum;    
        end                             
        st_preamble : begin                               //发送前导码+帧起始界定符
            if(skip_en)
                next_state = st_eth_head;
            else
                next_state = st_preamble;      
        end
        st_eth_head : begin                               //发送以太网首部
            if(skip_en)
                next_state = st_ip_head;
            else
                next_state = st_eth_head;      
        end              
        st_ip_head : begin                                //发送IP首部+UDP首部               
            if(skip_en)
                next_state = st_tx_data;
            else
                next_state = st_ip_head;      
        end
        st_tx_data : begin                                //发送数据                  
            if(skip_en)
                next_state = st_crc;
            else
                next_state = st_tx_data;      
        end
        st_crc: begin                                     //发送CRC校验值
            if(skip_en)
                next_state = st_idle;
            else
                next_state = st_crc;      
        end
        default : next_state = st_idle;   
    endcase
end    



//发送数据
always @(posedge clk or negedge rst_n) begin	
    if(!rst_n) begin
        skip_en <= 1'b0; 
        cnt <= 5'd0;
        check_buffer <= 32'd0;
        ip_head[1][31:16] <= 16'd0;
        tx_bit_sel <= 3'b0;
        crc_en <= 1'b0;
        eth_tx_en <= 1'b0;
        eth_tx_data_s <= 8'd0;
        tx_req <= 1'b0;
        tx_done_t <= 1'b0; 
        data_cnt <= 16'd0;
        real_add_cnt <= 5'd0;
        //初始化数组    
        //前导码 7个8'h55 + 1个8'hd5
        //preamble[0] <= 8'h55;                 
        preamble[1] <= 8'h55;
        preamble[2] <= 8'h55;
        preamble[3] <= 8'h55;
        preamble[4] <= 8'h55;
        preamble[5] <= 8'h55;
        preamble[6] <= 8'h55;
        preamble[7] <= 8'h55;
		  preamble[8] <= 8'hd5;
        //目的MAC地址
        eth_head[0] <= DES_MAC[47:40];
        eth_head[1] <= DES_MAC[39:32];
        eth_head[2] <= DES_MAC[31:24];
        eth_head[3] <= DES_MAC[23:16];
        eth_head[4] <= DES_MAC[15:8];
        eth_head[5] <= DES_MAC[7:0];
        //源MAC地址
        eth_head[6] <= BOARD_MAC[47:40];
        eth_head[7] <= BOARD_MAC[39:32];
        eth_head[8] <= BOARD_MAC[31:24];
        eth_head[9] <= BOARD_MAC[23:16];
        eth_head[10] <= BOARD_MAC[15:8];
        eth_head[11] <= BOARD_MAC[7:0];
        //以太网类型
        eth_head[12] <= ETH_TYPE[15:8];
        eth_head[13] <= ETH_TYPE[7:0];        
    end
	 else begin
        skip_en <= 1'b0;
        tx_req <= 1'b0;
        crc_en <= 1'b0;
        eth_tx_en <= 1'b0;
        tx_done_t <= 1'b0;
        case(cur_state)
            st_idle     : begin
                if(pos_start_en)
                    skip_en <= 1'b1; 
                if(skip_en) begin
                    //版本号：4 首部长度：5(单位:32bit,20byte/4=5)
						  //IPV4:4 IPV6:6  
                    ip_head[0] <= {16'h4500, total_num};  
                    //16位标识，每次发送累加1      
                    ip_head[1][31:16] <= ip_head[1][31:16] + 1'b1; 
                    //bit[15:13]: 010表示不分片
                    ip_head[1][15:0] <= 16'h0000;    
                    //协议：17(udp)                  
                    ip_head[2] <= {8'h80,8'd17,16'h0000};//8'h01数据存活一秒  8'd17 = 8'h11   
                    //源IP地址               
                    ip_head[3] <= BOARD_IP;    
                    //目的IP地址                        
                    ip_head[4] <= DES_IP;       
                    //16位源端口号：319  16位目的端口号：8081                     
                    ip_head[5] <= {16'd319,16'd8081};  
                    //16位udp长度，16位udp	校验和设为16'h0000             
                    ip_head[6] <= {udp_num,16'h0000}; 
							//设为16'h0000作用为向接收端示意不进行udpchecksum检验，因为在fpga上实现udpchecksum检验较为繁琐.
							
								
								
                end                                                   
            end
				st_check_sum: begin                           //IP首部校验
                cnt <= cnt + 5'd1;	
                if(cnt == 5'd0) begin                   
                    check_buffer <=   ip_head[0][31:16] + ip_head[0][15:0]
                                    + ip_head[1][31:16] + ip_head[1][15:0]
                                    + ip_head[2][31:16] + ip_head[2][15:0]
                                    + ip_head[3][31:16] + ip_head[3][15:0]
                                    + ip_head[4][31:16] + ip_head[4][15:0];
                
					 end
                else if(cnt == 5'd1)                      //可能出现进位,累加一次
                    check_buffer <= check_buffer[31:16] + check_buffer[15:0];
                else if(cnt == 5'd2) begin                //可能再次出现进位,累加一次
                    check_buffer <= check_buffer[31:16] + check_buffer[15:0];
                    skip_en <= 1'b1;
						  
                end                             
                else if(cnt == 5'd3) begin                //按位取反 
						  cnt <= 5'd0;
                    ip_head[2][15:0] <= ~check_buffer[15:0];
                end    
            end 
				st_preamble : begin                           //发送前导码+帧起始界定符
                eth_tx_en <= 1'b1;
                eth_tx_data_s <= preamble[cnt][7:0];    
                  if(cnt == 5'd7)                       
                      skip_en <= 1'b1; 
						if(skip_en)
							 cnt <= 5'd0;
						else
							 cnt <= cnt + 5'd1;
				 end
            st_eth_head : begin                           //发送以太网首部
                eth_tx_en <= 1'b1;
                crc_en <= 1'b1;
                eth_tx_data_s <= eth_head[cnt][7:0];
					 
                if(cnt == 5'd12)
                    skip_en <= 1'b1;
					 if(skip_en)
						  cnt <= 5'd0; 
                else
						  cnt <= cnt + 5'd1;
            end 
				 st_ip_head  : begin                           //发送IP首部 + UDP首部
                crc_en <= 1'b1;
                eth_tx_en <= 1'b1; 
					 tx_bit_sel <= tx_bit_sel + 3'd1; 
                if(tx_bit_sel == 3'd1)
                    eth_tx_data_s <= ip_head[cnt][31:24];
                else if(tx_bit_sel == 3'd2)
                    eth_tx_data_s <= ip_head[cnt][23:16];
					 else if(tx_bit_sel == 3'd3)begin
                    eth_tx_data_s <= ip_head[cnt][15:8];
						  if(cnt == 5'd6)skip_en <= 1'b1;
					 end		   
                else if(tx_bit_sel == 3'd4) begin
                    eth_tx_data_s <= ip_head[cnt][7:0];
						  tx_bit_sel <= 3'd1; 
                    if(cnt == 5'd6) begin
								tx_bit_sel <= 3'd0;
                        //提前读请求数据，等待数据有效时发送
                        tx_req <= 1'b1;
							   cnt <= 5'd0;
                    end 
						  else
                        cnt <= cnt + 5'd1; 	  
						  end                            
            end
            st_tx_data  : begin                           //发送数据
                crc_en <= 1'b1;
                eth_tx_en <= 1'b1;
                tx_bit_sel <= tx_bit_sel + 3'd1;
					 txdata_cnt <= txdata_cnt + 3'd1;
                if(tx_bit_sel[0] == 1'b0) begin
                    if(data_cnt < tx_data_num - 16'd1)
                        data_cnt <= data_cnt + 16'd1;                        
                    else if(data_cnt == tx_data_num - 16'd1)begin
                        //如果发送的有效数据少于18个字节，在后面填补充位
                        //补充的值为最后一次发送的有效数据
                        if(data_cnt + real_add_cnt < real_tx_data_num - 16'd1)
                            real_add_cnt <= real_add_cnt + 5'd1;  
                        else
                            skip_en <= 1'b1;
                    end        
                end        
                if(tx_bit_sel == 3'd0)
                    eth_tx_data_s <= tx_data[31:24];
                else if(tx_bit_sel == 3'd1)
                    eth_tx_data_s <= tx_data[23:16];
                else if(tx_bit_sel == 3'd2)
                    eth_tx_data_s <= tx_data[15:8];
                else if(tx_bit_sel == 3'd3) begin
                    eth_tx_data_s <= tx_data[7:0];
						  tx_bit_sel <= 3'd0; 
                    if(data_cnt != tx_data_num - 16'd1)
                        tx_req <= 1'b1;  
                end                                                                                                                                                   
                if(skip_en) begin
                    data_cnt <= 16'd0;
                    real_add_cnt <= 5'd0;
                    tx_bit_sel <= 3'd0;
						  txdata_cnt <= 16'd0;
						  eth_tx_en_l <= 1'b1;
                end                                                          
            end  
            st_crc      : begin                          //发送CRC校验值
                eth_tx_en <= 1'b1 && eth_tx_en_l;
					 crc_en <= 1'b0;
                tx_bit_sel <= tx_bit_sel + 3'd1;
                if(tx_bit_sel == 3'd0)
                    //注意是crc_next       f4fc8dea
                    eth_tx_data_s <= {~crc_data[24],~crc_data[25],~crc_data[26],
                                   ~crc_data[27], ~crc_data[28],~crc_data[29],~crc_data[30],~crc_data[31]};
											  
                else if(tx_bit_sel == 3'd1)
                    eth_tx_data_s <= {~crc_data[16],~crc_data[17],~crc_data[18],
                                   ~crc_data[19],~crc_data[20],~crc_data[21],~crc_data[22], ~crc_data[23]};
							
                else if(tx_bit_sel == 3'd2)
						  eth_tx_data_s <= {~crc_data[8],~crc_data[9],~crc_data[10],
                                   ~crc_data[11], ~crc_data[12],~crc_data[13],~crc_data[14], ~crc_data[15]};
					 else if(tx_bit_sel == 3'd3)begin
                    eth_tx_data_s <= {~crc_data[0],~crc_data[1],~crc_data[2],
                                   ~crc_data[3], ~crc_data[4],~crc_data[5],~crc_data[6], ~crc_data[7]}; 
						  eth_tx_en <= 1'b0;
						  eth_tx_en_l <= 1'b0;
						  skip_en <= 1'b1;
						  tx_bit_sel <= 3'd0;
                    tx_done_t <= 1'b1; 
                end                                                                                                                                                                         
            end                          
            default :;  
        endcase                                             
    end
end            

//发送完成信号及crc值复位信号
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        tx_done <= 1'b0;
        crc_clr <= 1'b0;
    end
    else begin
        tx_done <= tx_done_t;
        crc_clr <= tx_done_t;
    end
end

endmodule















