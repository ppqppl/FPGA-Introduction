`include "param.v"
module uart_rx(
	input wire 			clk		,
	input wire 			rst_n		,
	input wire 			rx_din	,//串行数据输入
	
	output wire [7:0] rx_dout	,//并行数据输出
	output reg 		   dout_vld//串转并完成标志
);

reg [12:0] cnt_bps		;//波特率计数寄存器
wire       add_cnt_bps	;//波特率计数开始
wire       end_cnt_bps	;//波特率计数结束

reg [3:0]  cnt_bit      ;//比特计数寄存器
wire       add_cnt_bit  ;//比特计数开始
wire       end_cnt_bit  ;//比特计数结束

reg 			rx_din_r0;//同步
reg 			rx_din_r1;//打拍
wire     	nedge		;//下降沿

reg      	rx_flag;//接受标志

reg [9:0] 	rx_data;//寄存数据包


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

assign add_cnt_bps = rx_flag;
assign end_cnt_bps = add_cnt_bps && cnt_bps == (`SYS_FRQ / `BAUD_MAX) - 1'd1;

//比特计数器设计
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
assign end_cnt_bit = add_cnt_bit && cnt_bit == 4'd10 - 1'd1;

//起始位位置检测
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		rx_din_r0 <= 1'b1;
		rx_din_r1 <= 1'b1;
	end 
	else begin
		rx_din_r0 <= rx_din;
		rx_din_r1 <= rx_din_r0;
	end 
end 

assign nedge = ~rx_din_r0 && rx_din_r1;

//接受标志rx_flag约束
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		rx_flag <= 1'b0;
	end 
	else if(nedge)begin
		rx_flag <= 1'b1;
	end 
	else if(end_cnt_bit)begin
		rx_flag <= 1'b0;
	end
	else begin
		rx_flag <= rx_flag;
	end 

end 

//缓存接受到的数据
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		rx_data <= 10'b0;
	end 
	else if(rx_flag && cnt_bps == (`SYS_FRQ/`BAUD_MAX) >> 1)begin
		rx_data[cnt_bit] = rx_din_r0;
	end 
	else begin
		rx_data <= rx_data;
	end 

end 

assign rx_dout = rx_data[8:1];

//串转并完成标志dout_vld约束
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		dout_vld <= 1'b0;
	end 
	else if(end_cnt_bit)begin
		dout_vld <= 1'b1;
	end 
	else begin
		dout_vld <= 1'b0;
	end 
end 

endmodule 
