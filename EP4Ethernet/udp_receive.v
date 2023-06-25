/***********************************************/

//Project Name : Ethernet_tx_test
//Email		   :
//Create Time	: 2021/01/22 16:20
//Editor       : Liu
//Version		: Rev1.0.0

/***********************************************/

module udp_receive
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
    input                clk         ,    //时钟信号
    input                rst_n       ,    //复位信号，低电平有效
    input                eth_rxdv    ,    //MII输入数据有效信号
    input        [3:0]   eth_rx_data ,    //MII输入数据
	 input  		  [7:0]	 rx_data_s	 ,
	 
	 output	reg			 cnt_2		 ,
    output  reg          rec_pkt_done,    //以太网单包数据接收完成信号
    output  reg          rec_en      ,    //以太网接收的数据使能信号
	 output  reg  [47:0]  rec_otss    ,		//时钟接收秒钟部分
	 output  reg  [31:0]  rec_otsn    ,		//时钟接收纳秒部分
	 output  wire     	 txdatacnt_en,

	 output  reg  [15:0]  data_cnt	 ,		 //有效数据计数 
	 output  reg  [31:0]  rec_data_s	 ,
	 output  reg  [47:0]  src_mac		 ,     //源MAC地址
	 output  wire			 eth_rx_clk_250m
    );

//parameter define
localparam  st_idle     = 7'b000_0001;    //初始状态，等待接收前导码
localparam  st_preamble = 7'b000_0010;    //接收前导码状态 
localparam  st_eth_head = 7'b000_0100;    //接收以太网帧头
localparam  st_ip_head  = 7'b000_1000;    //接收IP首部
localparam  st_udp_head = 7'b001_0000;    //接收UDP首部
localparam  st_rx_data  = 7'b010_0000;    //接收有效数据
localparam  st_rx_end   = 7'b100_0000;    //接收结束

//reg define
reg    [6:0]      cur_state       ;
reg    [6:0]      next_state      ;
                  
reg               rx_byte_sw      ;       //控制字节转换信号                         
reg               rx_byte_val     ;       //字节转换完成有效信号
reg    [15:0]  	rec_byte_num    ;       //以太网接收的有效字数 单位:byte
reg    [7:0]      rx_data         ;       //转换完成的8bit数据  
reg  	 [31:0]  	rec_data    	 ;	      //以太网接收的数据
                          
reg               skip_en         ;       //控制状态跳转使能信号
reg               error_en        ;       //解析错误使能信号
reg    [4:0]      cnt             ;       //解析数据计数器

reg    [47:0]     des_mac         ;       //目的MAC地址
reg    [15:0]     eth_type        ;       //以太网类型
reg    [31:0]     des_ip          ;       //目的IP地址
reg    [5:0]      ip_head_byte_num;       //IP首部长度
reg    [15:0]     udp_byte_num    ;       //UDP长度
reg    [15:0]     data_byte_num   ;       //数据长度  
reg    [1:0]      rec_en_cnt      ;       //4bit转32bit计数器

//wire define


rxclk250 c3(
	.inclk0(clk),
	.c0(eth_rx_clk_250m)
);

//*****************************************************
//**                    main code
//*****************************************************

always @(posedge eth_rx_clk_250m or negedge rst_n)begin
		
		if(!rst_n)
			cnt_2 			<= 1'b0;
		else if(eth_rxdv)begin
			cnt_2          <= 1'b1;
		end
		else if(!eth_rxdv)begin
			cnt_2				<= 1'b0;
		end
end
	
always @(posedge eth_rx_clk_250m or negedge rst_n) begin
		
		rx_data			<= rx_data_s;
end	

always @(posedge eth_rx_clk_250m or negedge rst_n) begin
		
		if(!rst_n)
			rx_byte_val <= 1'b0;
		else if(cnt_2)
			rx_byte_val 	<= ~rx_byte_val;
		else
			rx_byte_val <= 1'b0;
end

always @(posedge eth_rx_clk_250m or negedge rst_n) begin
    
		if(!rst_n)
			cur_state <= st_idle;  
		else begin
			cur_state <= next_state;
		end
end

always @(posedge eth_rx_clk_250m or negedge rst_n) begin
	if(!rst_n)
		rec_data_s <= 32'd0;
	else if(rec_en_cnt == 2'd0)
		rec_data_s <= rec_data;
end



//解析数据状态跳转
always @(*) begin
    next_state = st_idle;
    case(cur_state)
        st_idle : begin                                     //等待接收前导码
            if(skip_en) 
                next_state = st_preamble;
            else
                next_state = st_idle;    
        end
        st_preamble : begin                                 //接收前导码
            if(skip_en) 
                next_state = st_eth_head;
            else if(error_en) 
                next_state = st_rx_end;    
            else
                next_state = st_preamble;    
        end
        st_eth_head : begin                                 //接收以太网帧头
            if(skip_en) 
                next_state = st_ip_head;
            else if(error_en) 
                next_state = st_rx_end;
            else
                next_state = st_eth_head;           
        end  
        st_ip_head : begin                                  //接收IP首部
            if(skip_en)
                next_state = st_udp_head;
            else if(error_en)
                next_state = st_rx_end;
            else
                next_state = st_ip_head;       
        end 
        st_udp_head : begin                                 //接收UDP首部
            if(skip_en)
                next_state = st_rx_data;
            else
                next_state = st_udp_head;    
        end                
        st_rx_data : begin                                  //接收有效数据
            if(skip_en)
                next_state = st_rx_end;
            else
                next_state = st_rx_data;    
        end                           
        st_rx_end : begin                                   //接收结束
            if(skip_en)
                next_state = st_idle;
            else
                next_state = st_rx_end;          
        end
        default : next_state = st_idle;
    endcase                                          
end    

//解析以太网数据
always @(posedge eth_rx_clk_250m or negedge rst_n) begin
    if(!rst_n) begin
        skip_en <= 1'b0;
        error_en <= 1'b0;
        cnt <= 5'd0;
        des_mac <= 48'd0;
		  src_mac <= 48'd0;
        eth_type <= 16'd0;
        des_ip <= 32'd0;
        ip_head_byte_num <= 6'd0;
        udp_byte_num <= 16'd0;
        data_byte_num <= 16'd0;
        data_cnt <= 16'd0;
        rec_en_cnt <= 2'd0;
        rec_en <= 1'b0;
        rec_data <= 32'd0;
        rec_pkt_done <= 1'b0;
        rec_byte_num <= 16'd0;
    end
    else begin
        skip_en <= 1'b0;
        error_en <= 1'b0;  
        rec_en <= 1'b0;
        rec_pkt_done <= 1'b0;
        case(cur_state)
            st_idle : begin
                if((rx_byte_val == 1'b1) && (rx_data == 8'h55)) 
                    skip_en <= 1'b1;
            end
            st_preamble : begin
                if(rx_byte_val) begin                       //解析前导码
						  skip_en <= 1'b0;
                    cnt <= cnt + 5'd1;
                    if((cnt < 5'd4) && (rx_data != 8'h55))  //7个8'h55 cnt < 5'd4小一点程序稳定，但不建议低于3 
                        error_en <= 1'b1;
                    else if(cnt == 5'd6) begin
                        cnt <= 5'd0;
                        if(rx_data==8'hd5)                  //1个8'hd5
                            skip_en <= 1'b1;
                        else
                            error_en <= 1'b1;    
                    end  
                end  
            end
            st_eth_head : begin
                if(rx_byte_val) begin
                    cnt <= cnt + 5'b1;
                    if(cnt < 5'd6) 
                        des_mac <= {des_mac[39:0],rx_data}; //目的MAC地址
						  else if(cnt > 5'd5 && cnt < 5'd12)
								src_mac <= {src_mac[39:0],rx_data};
                    else if(cnt == 5'd12) 
                        eth_type[15:8] <= rx_data;          //以太网协议类型
                    else if(cnt == 5'd13) begin
                        eth_type[7:0] <= rx_data;
                        cnt <= 5'd0;
                        //判断MAC地址是否为开发板MAC地址或者公共地址
                        if((des_mac == BOARD_MAC)
                            ||(des_mac == 48'h01_00_5e_7f_ff_fa))//ff_ff_ff_ff_ff_ff))           
                            skip_en <= 1'b1;    
                        else
                            error_en <= 1'b1;
                    end        
                end  
            end
            st_ip_head : begin
                if(rx_byte_val) begin
                    cnt <= cnt + 5'd1;
                    if(cnt == 5'd0)
                        ip_head_byte_num <= {rx_data[3:0],2'd0};
                    else if((cnt >= 5'd16) && (cnt <= 5'd18))
                        des_ip <= {des_ip[23:0],rx_data};   //目的IP地址
                    else if(cnt == 5'd19) begin
                        des_ip <= {des_ip[23:0],rx_data}; 
                        //判断IP地址是否为开发板IP地址
                        if(((des_ip[23:0] == BOARD_IP[31:8])
                            && (rx_data == BOARD_IP[7:0])) 
									  ||((des_ip[23:0] == 24'hE00001)
									    &&(rx_data == 8'h81))) begin 
                            if(cnt == ip_head_byte_num - 1'b1) begin
                                skip_en <=1'b1;                     
                                cnt <= 5'd0;
										  /*des_ip_s <= des_ip;去掉注释并将des_ip_s定义为output reg类型的时候，
												des_ip显示正确，不过不进行操作也不影响实际使用
												例如设置目标IP为192.168.1.13时，SignalTap显示的des_ip为00A8010D
												实际应为C0A8010D,但不影响状态机进行判断，可能是SignalTap的BUG，也可能是
												本人水平有限没有发现问题。*/
                            end                             
                        end    
                        else begin            
                        //IP错误，停止解析数据                        
                            error_en <= 1'b1;               
                            cnt <= 5'd0;
                        end                                                  
                    end                          
                    else if(cnt == ip_head_byte_num - 1'b1) begin 
                        skip_en <=1'b1;                     //IP首部解析完成
                        cnt <= 5'd0;                    
                    end    
                end                                
            end 
            st_udp_head : begin
                if(rx_byte_val) begin
                    cnt <= cnt + 5'd1;
                    if(cnt == 5'd4)
                        udp_byte_num[15:8] <= rx_data;      //解析UDP字节长度 
                    else if(cnt == 5'd5)
                        udp_byte_num[7:0] <= rx_data;
                    else if(cnt == 5'd7) begin
                        //有效数据字节长度，（UDP首部8个字节，所以减去8）
                        data_byte_num <= udp_byte_num - 16'd8;    
                        skip_en <= 1'b1;
                        cnt <= 5'd0;
                    end  
                end                 
            end          
            st_rx_data : begin         
                //接收数据，转换成32bit            
                if(rx_byte_val) begin
                    data_cnt <= data_cnt + 16'd1;
                    rec_en_cnt <= rec_en_cnt + 2'd1;
                    if(data_cnt == data_byte_num + 16'd2) begin
                        skip_en <= 1'b1;                    //有效数据接收完成
                        data_cnt <= 16'd0;
                        rec_en_cnt <= 2'd0;
                        rec_pkt_done <= 1'b1;               
                        rec_en <= 1'b1;                     
                        rec_byte_num <= data_byte_num;
                    end    
					//先收到的数据放在了rec_data的高位,所以当数据不是4的倍数时,
					//低位数据为无效数据，可根据有效字节数来判断(rec_byte_num)
                    if(rec_en_cnt == 2'd0)begin
                        rec_data[31:24] <= rx_data;
						  end
                    else if(rec_en_cnt == 2'd1)
                        rec_data[23:16] <= rx_data;
                    else if(rec_en_cnt == 2'd2) 
                        rec_data[15:8] <= rx_data;        
                    else if(rec_en_cnt==2'd3) begin
                        rec_en <= 1'b1;
                        rec_data[7:0] <= rx_data;
                    end    
                end  
            end    
            st_rx_end : begin                               //单包数据接收完成   
                if(eth_rxdv == 1'b0 && skip_en == 1'b0)begin
                    skip_en <= 1'b1;
						  cnt		 <= 1'b0;
				    end 
            end    
            default : ;
        endcase                                                        
    end
end

endmodule


