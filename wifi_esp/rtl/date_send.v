`include "param.v"
module date_send(
	input wire 			clk	,
	input wire 			rst_n	,
	input wire	[1:0]	key,
	output reg          tx_dout//串行数据输出
);
reg 		tx_req;//发送请求
reg [7:0] 	tx_din;//并行数据输入
reg [12:0] cnt_bps		;//波特率计数寄存器	
wire       add_cnt_bps	;//波特率计数开始
wire       end_cnt_bps  ;//波特率计数结束

reg [3:0]  cnt_bit      ;//比特计数寄存器
wire       add_cnt_bit  ;//比特计数开始
wire       end_cnt_bit  ;//比特计数结束

reg        tx_flag      ;//发送标志

reg [9:0]  tx_data      ;

always @(posedge clk or negedge rst_n)begin 
	if(!rst_n)begin
		tx_req <= 0;
		tx_din <= 0;
	end 
	else if(key[0]&&!key[1])begin 
		tx_req <= 1;
		tx_din <= 8'd48;
	end 
	else if(key[1]&&!key[0])begin 
		tx_req <= 1;
		tx_din <= 8'd49;
	end 
	else begin 
		tx_req <= 0;
	end 
end

//波特率计数器设计
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		cnt_bps <= 13'd0;
	end 
	else if(add_cnt_bps)begin
		if(end_cnt_bps)begin
			cnt_bps <= 13'd0;
		end 
		else begin
			cnt_bps <= cnt_bps + 1'd1;
		end 
	end 
	else begin
		cnt_bps <= cnt_bps;
	end 
end 

assign add_cnt_bps = tx_flag;
assign end_cnt_bps = add_cnt_bps && cnt_bps == (`SYS_FRQ/`BAUD_MAX) - 1'd1;

always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		cnt_bit <= 4'd0;
	end 
	else if(add_cnt_bit)begin
		if(end_cnt_bit)begin
			cnt_bit <= 4'd0;
		end 
		else begin
			cnt_bit <= cnt_bit + 1'd1;
		end 
	end 
	else begin
		cnt_bit <= cnt_bit;
	end 
end 

assign add_cnt_bit = end_cnt_bps;
assign end_cnt_bit = add_cnt_bit && cnt_bit == 9;

//发送标志tx_flag
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		tx_flag <= 1'b0;
	end 
	else if(tx_req)begin
		tx_flag <= 1'b1;
	end 
	else if(end_cnt_bit)begin
		tx_flag <= 1'b0;
	end 
	else begin
		tx_flag <= tx_flag;
	end 
end 


//数据缓存，tx_data
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		tx_data <= 10'b0;
	end 
	else if(tx_req)begin
		tx_data <= {1'b1, tx_din, 1'b0};
	end
	else begin
		tx_data <= tx_data;
	end 
end 

//tx_dout数据串行输出
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		tx_dout <= 1'b1;
	end 
	else if(tx_flag && cnt_bps == 1)begin
		tx_dout <= tx_data[cnt_bit];
	end 
	else begin
		tx_dout <= tx_dout;
	end 
end 

//dout_vld约束
assign dout_vld = ~tx_flag;

endmodule 
