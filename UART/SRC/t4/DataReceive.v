`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/16 23:01:52
// Design Name: 
// Module Name: DataReceive
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


module DataReceive(
input clk,
input reset_n,
input [7:0]data_byte,
input rxd_finish_pos,

output reg receiveDataDone,
output reg [23:0]receiveData

    );
//input clk;
//input reset_n;
//input [7:0]data_byte;
//input rxd_finish_pos;

//output reg receiveDataDone; 
//output reg [23:0]receiveData;

reg [2:0]state;
parameter IDLE=3'b001,FFSTATE=3'b010,ABSTATE=3'b100;
reg [2:0]cnt;  

always@(posedge clk or negedge reset_n)
if(!reset_n)  begin   receiveData<=24'd0;state<=IDLE;end
else case(state)
IDLE:begin receiveDataDone<=1'b0;
    cnt<=2'd0;
     if(rxd_finish_pos)begin
        if(data_byte==8'hff)state<=FFSTATE;
        else state<=IDLE;
      end
      end
FFSTATE:if(rxd_finish_pos)begin
        if(data_byte==8'hab)state<=ABSTATE;
        else state<=IDLE;
      end
ABSTATE:if(rxd_finish_pos)begin 
            receiveData<={receiveData[15:0],data_byte};
            cnt<=cnt+1'b1;
            if(cnt==3'd2)begin state<=IDLE;receiveDataDone<=1'b1;end
         end
endcase 
    
endmodule
