/***********************************************/

//Project Name : Ethernet_tx_test
//Email		   :
//Create Time	: 2021/01/09 11:56
//Editor       : Liu
//Version		: Rev1.0.0

//将SW17打开，数据开始发送
/***********************************************/
//SignalTap添加过多的观测信号会导致FPGA程序出现各种不可预知的错误，在调试过程中尽量避免添加过多信号
`timescale 1 ns/ 1 ps
module ethernet  
	#(
    //开发板MAC地址 01_00_5e_00_01_81 
    parameter BOARD_MAC = 48'h2C_FE_07_19_68_33,       
    //开发板IP地址 8'd192,8'd168,8'd1,8'd110    
    parameter BOARD_IP  = {8'd192,8'd168,8'd1,8'd110},   
    //目的MAC地址        
//    parameter  DES_MAC  = 48'hDC_FE_07_19_68_34,
	parameter	DES_MAC	=	48'h00_2B_67_DD_6C_1C,
    //目的IP地址 192.168.1.11     
    parameter  DES_IP   = {8'd192,8'd168,8'd1,8'd11} 
    )
   (
	 input						sys_clk		    ,
    input                  rst_n           ,  //复位信号，低电平有效 
	 input                  eth_rx_clk      ,  //MII接收数据时钟
	 input                  eth_rxdv        ,  //MII输入数据有效信号
	 input						eth_rx_col		 ,	 //GMII and MII collision 2 
	 input						eth_rx_crs		 ,	 //GMII and MII carrier sense 2 
	 input					   SW16				 ,  //开关调试，arp模块测试
	 input 					   SW15				 ,	 //开关调试，传感器数据发送
	 input      [3: 0]      eth_rx_data     ,  //MII输入数据
	 input		[15:0]      ad					 ,  //AD7622输入信号
    output reg             eth_tx_en       ,  //MII输出数据有效信号
	 output reg [3: 0]      eth_tx_data     ,  //MII输出数据
	 output wire            eth_tx_clk_125m ,  //RGMII发送数据时钟
	 output wire 				cnvst				 ,
	 output reg             eth0_rst_n      ,  //以太网芯片复位信号，低电平有效
	 output reg             eth1_rst_n         //以太网芯片复位信号，低电平有效 		    
    ); 

//wire define 
wire			 cnt_1          ; 
wire 			 cnt_2			 ; 
wire         tx_done        ; 
wire         tx_req    	    ;
wire			 clk_2m			 ;
wire         clk_250m  		 ;
wire			 eth_tx_clk_250m;
wire 			 eth_rx_clk_250m;
wire         udpcrc_en  	 ;                //udp发送数据CRC开始校验使能
wire         arpcrc_en  	 ;
wire         udpcrc_clr 	 ;                //udp发送数据CRC数据复位信号
wire			 txdatacnt_en	 ; 
wire 			 tx_start_en    ;
wire         crc_clr 	    ;
wire		    datatrans_en	 ;
wire			 adtx_en			 ;

wire [7: 0]  crc_d4    	    ;
wire [7: 0]  arp_data       ;                //输入待校验4位数据
wire [7: 0]  eth_rx_data_s  ;
wire [15:0]	 txdata_cnt		 ;
wire [15:0]  data_scnt		 ;
wire [15:0]  data_cnt		 ;
wire [31:0]  trans_data	    ; 
wire [31:0]  crc_data  		 ;                //CRC校验数据
wire [31:0]  crc_next  		 ; 					//CRC下次校验完成数据
wire [31:0]  delay_n		    ;
wire [31:0]  delay_nn		 ;           
wire [31:0]  ptpdata        ;
wire [31:0]  rec_data_s		 ;
wire [47:0]	 src_mac			 ;

//reg define
reg			 cnt            ;
reg			 eth_tx_en_t	 ; 
reg   		 arp_req			 ;

reg  [7:0]   eth_tx_data_s  ; 
reg  [15:0]  tx_byte_num    ;
reg  [31:0]  count			 ;
reg  [31:0]  tx_data			 ;

//assign
assign  crc_d4  = SW16? arp_data : eth_tx_data_s;   
assign  crc_clr = ~eth_tx_en							; 
assign  cnt_1   = ~eth_tx_en							;

//以太网卡上电后需要复位才能启动
always @(posedge eth_tx_clk_125m or negedge rst_n) begin
	if(!rst_n)begin	
		eth0_rst_n 	<= 1'b0;
		eth1_rst_n 	<= 1'b0;
	end
	else begin
		eth0_rst_n 	<= 1'b1;
		eth1_rst_n 	<= 1'b1;
	end
end

//打开SW16时，每5秒一次ARP请求
always @(posedge eth_tx_clk_125m or negedge rst_n)begin
	if(!rst_n)begin
		count  <= 27'd0;
		arp_req<= 1'b0;
	end
	else if(SW16)begin
		count  <= count + 1'd1;
	   if(count == 625000000)begin
			arp_req<= 1'b1;
			count  <= 27'd0;
	   end
		else 
			arp_req<= 1'b0;
	end
end

//当标志位1时发送数据，2时发送Delay_req数据
always @(posedge eth_tx_clk_250m or negedge rst_n)begin
	if(!rst_n)
		tx_byte_num <= 16'd0;
	else if(datatrans_en)
		tx_byte_num <= 16'd512;
end
 
clk125m c1(
	.inclk0(sys_clk),
	.c0(eth_tx_clk_125m),    //Tx时钟125MHz
	.c1(eth_tx_clk_250m),
	.c2(clk_crc)
);

clk250 c2(
	.inclk0(sys_clk), 
	.c0(clk_250m)
);

//ARP应答与请求
eth_arp_send arp1(
	.clk		    (eth_tx_clk_125m				      ),
	.rst_n		 (rst_n									),
	.arp_ack_trig(											),//应答
	.arp_req_trig(arp_req                        ),//请求
   .arp_src_ip  (BOARD_IP                       ),
   .arp_dst_ip  (DES_IP                         ),
   .arp_src_mac (BOARD_MAC                      ),
   .arp_dst_mac (DES_MAC                        ),
   .arp_data    (arp_data                       ),
	.add_cnt		 (arp_tx_en								),
	.crc_data    (crc_data								),
	.crc_en		 (arpcrc_en								)
);


always @(posedge eth_tx_clk_125m or negedge rst_n) begin
	if(!rst_n)begin
		eth_tx_en <= 1'b0;
		end
	else begin
		if(eth_tx_en_t && SW15)
			eth_tx_en <= 1'b1;
		else if(arp_tx_en)
			eth_tx_en <= 1'b1;
		else begin
			eth_tx_en <= 1'b0;
			end
	end
end

always @(posedge eth_tx_clk_125m or negedge rst_n) begin
	if(!rst_n)
		tx_data <= 32'd0;
	else if(SW15)
		tx_data <= trans_data;
	else 
		tx_data <= 32'd0;
end

//上升沿发送改为上升沿和下降沿都发送
always @(posedge eth_tx_clk_250m or negedge rst_n)begin
	if(!rst_n)
		cnt 			<= 1'b1;
	else if(!cnt_1)begin
		if(SW16)begin
			if(cnt && (!cnt_1))begin
				cnt			<= 1'b0;
				eth_tx_data <= arp_data[3:0];
			end
			else if((!cnt) && (!cnt_1)) begin
				cnt			<= 1'b1;
				eth_tx_data <= arp_data[7:4];
			end
		end
		else if(SW15)begin
			if(!cnt_1 && cnt)begin
				cnt			<= 1'b0;
				eth_tx_data <= eth_tx_data_s[3:0];
			end
			else if((!cnt) && (!cnt_1)) begin
				cnt			<= 1'b1;
				eth_tx_data <= eth_tx_data_s[7:4];
			end
		end
	end
	else
		cnt <= 1'b1;
end
	
//以太网接收4bit数据转8bit数据
altddioin a1(
	.inclock(eth_rx_clk),
	.datain(eth_rx_data),
	.inclocken(cnt_2),
	.dataout_h(eth_rx_data_s[7:4]),
	.dataout_l(eth_rx_data_s[3:0]) 
	);

//以太网发送模块
udp_send
   #(
    .BOARD_MAC       (BOARD_MAC),         //参数例化
    .BOARD_IP        (BOARD_IP),
    .DES_MAC         (DES_MAC),
    .DES_IP          (DES_IP)
    )
   u_udp_send(
    .clk             (eth_tx_clk_125m),        
    .rst_n           (rst_n),             
    .tx_start_en     (tx_start_en || adtx_en),                   
    .tx_data         (tx_data),           
    .tx_byte_num     (tx_byte_num),       
    .crc_data        (crc_data),          
    .crc_next        (crc_next[31:28]),   
    .tx_done         (tx_done),           
    .tx_req          (tx_req), 
	 .txdata_cnt		(txdata_cnt),
	 .data_cnt			(data_scnt),
    .eth_tx_en       (eth_tx_en_t),         
    .eth_tx_data_s   (eth_tx_data_s),   
    .crc_en          (udpcrc_en),            
    .crc_clr         (udpcrc_clr)            
    ); 

//以太网接收模块    
udp_receive 
   #(
    .BOARD_MAC       (BOARD_MAC),         //参数例化
    .BOARD_IP        (BOARD_IP)
    )
   u_udp_receive(
    .clk             (eth_rx_clk),        
    .rst_n           (rst_n),
	 .eth_rx_clk_250m (eth_rx_clk_250m),
    .eth_rxdv        (eth_rxdv),                                 
    .eth_rx_data     (eth_rx_data),
	 .rx_data_s			(eth_rx_data_s),
	 .src_mac		   (src_mac),
	 .cnt_2				(cnt_2),
	 .data_cnt			(data_cnt),
    .rec_pkt_done    (rec_pkt_done),  
	 .rec_data_s		(rec_data_s),    
    .rec_en          (rec_en)               
    );                                    

//以太网发送CRC校验模块(8bit)
crc32_d4   u_crc32_d4(
    .clk             (eth_tx_clk_125m				),
    .clk1	 			(clk_crc						   ),
    .rst_n           (rst_n							),                          
    .datain          (crc_d4							),            
    .crc_en          (udpcrc_en || arpcrc_en		),                          
    .crc_clr         (crc_clr							),//udpcrc_clr&&                          
    .crc_data        (crc_data						)
    );

//数据采集
data_acq d1(
	.clk(sys_clk											),
	.rst_n(rst_n										   ),
	.rdfifoclk(eth_tx_clk_125m						   ),
	.cnvst(cnvst										   ),
	.adtx_en(adtx_en										),
	.datain(ad										      ),
	.data_trans(datatrans_en							),
	.trans_data(trans_data		  						)
	);

endmodule
