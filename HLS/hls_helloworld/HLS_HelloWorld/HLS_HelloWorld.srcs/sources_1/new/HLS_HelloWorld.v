`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/13 14:29:55
// Design Name: 
// Module Name: HLS_HelloWorld
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module HLS_HelloWorld(
	input 	wire 			clk 	,
	input 	wire 			rst_n 	,
	output 	wire 			led_o
    );

wire 			rst 			;//同步复位
wire			ap_ready 		;//当前可以接收下一次数据
reg 			ap_start 		;//IP开始工作
reg 			led_i_vld 		;//输入数据有效
wire  			led_o_vld 		;
reg 			led_i 			;//输入的led信号
wire 			led_o_r 		;
wire 			ap_done 		;
wire 			ap_idle 		;
reg  	[1:0] 	delay_cnt 		;

assign rst = ~rst_n ;
assign led_o = led_o_r 	;

//----------------delay_cnt------------------
always @(posedge clk) begin
	if (rst==1'b1) begin
		delay_cnt <= 'd0;
	end
	else if(delay_cnt[1]==1'b0) begin
		delay_cnt <= delay_cnt + 1'b1;
	end
end

//----------------ap_start------------------
always @(posedge clk) begin
	if (rst==1'b1) begin
		ap_start <= 1'b0;
	end
	else if(delay_cnt[1]==1'b1)begin
		ap_start <= 1'b1;
	end
end

//----------------led_i_vld------------------
always @(posedge clk) begin
	if (rst==1'b1) begin
		led_i_vld <= 1'b0;
	end
	else if(delay_cnt[1]==1'b1)begin
		led_i_vld <= 1'b1;
	end
end

//----------------ap_i------------------
always @(posedge clk) begin
	if (rst==1'b1) begin
		led_i <= 1'b0;
	end
	else if(led_o_vld==1'b1)begin
		led_i <= led_o_r ;
	end
end


flash_led_0 inst_flash_led (
  .led_o_V_ap_vld(led_o_vld),  // output wire led_o_V_ap_vld
  .led_i_V_ap_vld(led_i_vld),  // input wire led_i_V_ap_vld
  .ap_clk(clk),                  // input wire ap_clk
  .ap_rst(rst),                  // input wire ap_rst
  .ap_start(ap_start),              // input wire ap_start
  .ap_done(ap_done),                // output wire ap_done
  .ap_idle(ap_idle),                // output wire ap_idle
  .ap_ready(ap_ready),              // output wire ap_ready
  .led_o_V(led_o_r),                // output wire [0 : 0] led_o_V
  .led_i_V(led_i)                // input wire [0 : 0] led_i_V
);

wire 	[15:0] probe0;
assign probe0={
	led_i,
	led_i_vld,
	led_o,
	led_o_vld,
	ap_start,
	ap_ready,
	ap_done
};

ila_0 inst_ila (
	.clk(clk), // input wire clk


	.probe0(probe0) // input wire [15:0] probe0
);


endmodule

