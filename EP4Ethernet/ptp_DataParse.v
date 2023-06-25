module ptp_DataParse
	#(
    //开发板MAC地址 01_00_5e_00_01_81 
    parameter BOARD_MAC = 48'h2C_FE_07_19_68_33,       
//	 parameter BOARD_MAC = 48'h01_00_5e_7f_ff_fa,
    //开发板IP地址 8'd192,8'd168,8'd1,8'd110    
    parameter BOARD_IP  = {8'd192,8'd168,8'd1,8'd110}
    )
	 (
	input rst_n,
	input eth_rx_clk_250m,
	input eth_tx_clk_125m,
	input [15:0] data_cnt,
	input [15:0] data_scnt,
	input	[15:0] txdata_cnt,
	input [31:0] rec_data_s,
	input [48:0] src_mac,
	output  reg  tx_start_en,
   output  reg  first1_2,
	output  reg  [3:0]  ptp_state_s,
	output  reg  [15:0] sequenceid,
	output  reg  [31:0] tx_data,
	output  reg  [48:0] delay_s,
	output  reg  [32:0] delay_n,
	output  reg  [48:0] offset_s,
	output  reg  [32:0] offset_n,
	output  reg  [15:0] resp_sequid,
	output  reg  [47:0] tsecond,
   output  reg  [31:0] tnano	
);


reg first1			;
reg first2			;
reg first4			;
reg [3:0]  count	;
reg [3:0]  ptp_err;
reg [31:0] ptpnt1 ;
reg [47:0] ptpst1 ;
reg [31:0] ptpnt2 ;
reg [47:0] ptpst2 ;
reg [31:0] ptpnt3 ;
reg [47:0] ptpst3 ;
reg [31:0] ptpnt4 ;
reg [47:0] ptpst4 ;

//判断接收到的数据是Sync、Follow_Up、Delay_Resp中的哪一个
always @(posedge eth_rx_clk_250m or negedge rst_n) begin
	if(!rst_n)
			ptp_state_s <= 4'd0;
	else if(data_cnt == 4'd5 && rec_data_s[31:16] == 16'h8002)
			//ptp_state = "Sync";
			ptp_state_s <= 4'd1;
	else if(data_cnt == 4'd5 && rec_data_s[31:16] == 16'h8802)
			//ptp_state = "Follow_Up";
			ptp_state_s <= 4'd2;
	else if(data_cnt == 4'd5 && rec_data_s[31:16] == 16'h8902)
			//ptp_state = "Delay_Resp";
			ptp_state_s <= 4'd3;
	else if(data_cnt == 4'd0)
			//ptp_state = "Slave";
			ptp_state_s <= 4'd0;
end
//判断ptp数据clockidentity是否与源mac地址+FFFE符合
always @(posedge eth_rx_clk_250m or negedge rst_n) begin
	if(!rst_n)
			ptp_err <= 4'd0;
	else if(data_cnt == 5'd25 && rec_data_s != {src_mac[47:24],8'hFF})
			ptp_err <= 4'd1;
	else if(data_cnt == 5'd30 && rec_data_s != {8'hFE,src_mac[23:0]})
			ptp_err <= 4'd1;
	else if(data_cnt == 4'd0)
			ptp_err <= 4'd0;
end
//验证clockidentity后记录时间戳t2与SequenceId
always @(posedge eth_rx_clk_250m or negedge rst_n) begin
	if(!rst_n)begin
			ptpst2 <= 48'd0;
			ptpnt2 <= 32'd0;
			first2 <= 1'd0;
			first1_2 <= 1'd0;
			tx_start_en <= 1'b0;
			sequenceid <= 16'd0;
	end
	else if(data_cnt == 6'd33 && ptp_state_s == 4'd1 && ptp_err != 4'd1)
			first1_2 <= 1'd0;
	else if(data_cnt == 6'd41 && ptp_state_s == 4'd1 && ptp_err != 4'd1)begin
			first1_2 <= 1'd1;
			tx_start_en <= 1'b1;
			sequenceid  <= sequenceid + 1'd1;
			first2 <= 1'd1;
			ptpst2 <= tsecond;
			ptpnt2 <= tnano;
	end
	else if(first2 == 1 && data_cnt == 42 && first1_2 == 1)
			tx_start_en <= 1'b0;
	else begin
			first1_2 <= 1'd0;
			first2 <= 1'd0;
	end
end
//验证clockidentity后记录Follow_Up的时间戳t1
always @(posedge eth_rx_clk_250m or negedge rst_n) begin
	if(!rst_n)begin
			ptpst1 	<= 48'd0;
			ptpnt1 	<= 32'd0;
	end
	else if(data_cnt == 6'd35 && ptp_state_s == 4'd2 && ptp_err != 4'd1)
			first1   <= 1'd1;
	else if(first1 == 1 && data_cnt == 41)begin
			ptpst1   <= rec_data_s;
	end
	else if(first1 == 1 && data_cnt == 45)begin
			ptpnt1   <= rec_data_s;
			first1   <= 1'd0;
	end
end

//Slave端接收到Sync消息后及时返回Delay_Req消息
always @(posedge eth_tx_clk_125m or negedge rst_n) begin
	if(!rst_n)
			tx_data 		<= 32'h0;
	else if(data_scnt < 2)
			tx_data     <= 32'h8102002C;//8trans,1delayreq,0rese,2versionPtp,0036messagelength
	else if(data_scnt == 2)
			tx_data     <= {16'h0000,tx_data[15:0]};//00subdomain,00rese
	else if(data_scnt == 3)
			tx_data     <= {tx_data[31:16],16'h0200};//0200flags   
	else if(data_scnt == 4)
			tx_data     <= {16'h0000,tx_data[15:0]};//correction && correctionSubNs
	else if(data_scnt == 5)
			tx_data     <= {tx_data[31:16],16'h0000};		
	else if(data_scnt == 10)
			tx_data     <= {BOARD_MAC[47:32],tx_data[15:0]};//ClockIdentity
	else if(data_scnt == 11)
			tx_data     <= {BOARD_MAC[47:24],8'hFF};
	else if(data_scnt == 12)
			tx_data		<= {8'hFE,BOARD_MAC[23:16],tx_data[15:0]};
	else if(data_scnt == 13)
			tx_data 		<= {tx_data[31:16],BOARD_MAC[15:0]};
	else if(data_scnt == 14)
			tx_data 		<= {16'h0001,tx_data[15:0]};//0001Sourceportid
	else if(data_scnt == 15)begin
			tx_data		<= {tx_data[31:16],sequenceid};//sequenceidsequenceid
			ptpst3		<= tsecond;
			ptpnt3		<= tnano;
	end
	else if(data_scnt == 16)
			tx_data		<= {16'h017f,tx_data[15:0]};
	else if(data_scnt == 17)
			tx_data		<= 32'h00000000;
end
	
//slave端接收到delay_resp消息后记录t4时间并计算网路之间的delay以及offset
always @(posedge eth_rx_clk_250m or negedge rst_n) begin
	if(!rst_n)begin
			ptpst4 	<= 48'd0;
			ptpnt4 	<= 32'd0;
			resp_sequid <= 16'd0;
	end
	else if(data_cnt == 6'd32 && ptp_state_s == 4'd3)
			resp_sequid <= rec_data_s[15:0];
	else if(data_cnt == 6'd35 && ptp_state_s == 4'd3)
			first4   <= 1'd1;
	else if(first4 == 1 && data_cnt == 41 && ptp_state_s == 4'd3)begin
			ptpst4   <= rec_data_s;
	end
	else if(first4 == 1 && data_cnt == 45 && ptp_state_s == 4'd3)begin
			ptpnt4   <= rec_data_s;
			first4   <= 1'd0;
	end
	else if(first4 == 0 && data_cnt == 46 && ptp_state_s == 4'd3)begin
			delay_s		<= (ptpst2-ptpst1+ptpst4-ptpst3)/2;
			delay_n		<= (ptpnt2-ptpnt1+ptpnt4-ptpnt3)/2;
			offset_s		<= (ptpst1+ptpst4-ptpst2-ptpst3)/2;
    		offset_n		<= (ptpnt2-ptpnt1-ptpnt4+ptpnt3)/2;
	end

end	

//内部时钟
always @(posedge eth_rx_clk_250m or negedge rst_n) begin
	if(!rst_n)begin
			tsecond <= 48'd0;
			tnano   <= 32'd0;
	end
	else if(tnano == 32'd999999996)begin
			tsecond <= tsecond + 48'd1;
			tnano	  <= 32'd0;
	end
	else
			tnano <= tnano + 32'd4;
end
	
	

endmodule