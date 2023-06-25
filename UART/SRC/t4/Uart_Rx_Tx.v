`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/16 22:40:25
// Design Name: 
// Module Name: Uart_Rx_Tx
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


module Uart_Rx_Tx(
input clk,
input reset_n,
input rxd,
output Rs232_Tx
    );

wire [7:0]data_byte;
wire rxd_finish_pos;
   
uart_rxd uart_rxd(
	.clk(clk),
	.rst_n(reset_n),
	.bps_set(2'b11),
	.rxd(rxd),
	.data_byte(data_byte),
	.rxd_finish_pos(rxd_finish_pos)
    );  
wire [23:0]receiveData;
wire receiveDataDone;
DataReceive DataReceive(
.clk(clk),
.reset_n(reset_n),
.data_byte(data_byte),
.rxd_finish_pos(rxd_finish_pos),

.receiveData(receiveData),
.receiveDataDone(receiveDataDone)

    );

reg [23:0]receiveDataTemp;
reg [7:0]TxDataByte;
reg TxSendEnFlag;
wire Tx_Done;
reg [2:0]cnt;
parameter IDLE=4'b0001,TxSendEn=4'b0010,START=4'b0100,WAITE=4'b1000;
reg [3:0]state;

reg [1:0]txDoneTemp;
always@(posedge clk or negedge reset_n)
if(!reset_n)txDoneTemp<=2'b00;
else txDoneTemp<={txDoneTemp[0],Tx_Done};

wire TCDONE_POS;
assign TCDONE_POS=!txDoneTemp[1]&txDoneTemp[0];


always@(posedge clk or negedge reset_n)
if(!reset_n)state<=IDLE;
else case(state)
IDLE:begin cnt<=2'd0;if(receiveDataDone)state<=TxSendEn;end
TxSendEn:begin receiveDataTemp<=receiveData;state<=START;end
START:begin TxDataByte<=receiveDataTemp[23:16];TxSendEnFlag<=1'b1;cnt<=cnt+1'b1;receiveDataTemp<=receiveDataTemp<<8;state<=WAITE;
        if(cnt==3'd3)begin state<=IDLE;TxSendEnFlag<=1'b0;end
end
WAITE:begin TxSendEnFlag<=1'b0;if(TCDONE_POS)state<=START;end
endcase 


    
uart_byte_tx uart_byte_tx(
	.Clk(clk),       //50M时钟输入
	.Rst_n(reset_n),     //模块复位
	.data_byte(TxDataByte), //待传�?8bit数据
	.send_en(TxSendEnFlag),   //发�?�使�?
	.baud_set(3'd4),  //波特率设�?
	.Tx_Done(Tx_Done),
	.Rs232_Tx(Rs232_Tx)
);    

endmodule
