`timescale 1ns / 1ps
 
module uart_rx
#(
    parameter   BAUD_MAX    =   'd115_200,
    parameter   CLK_MAX     =   'd50_000_000
)
(
    input               sys_clk     ,
    input               sys_rst_n   ,
    input               rx          ,
    
    output  reg [7:0]   po_data     ,
    output  reg         po_flag
    );
    
  
localparam  BAUD_CNT = CLK_MAX / BAUD_MAX;
  
reg         rx_reg1;                            //接收寄存器1
reg         rx_reg2;                            //接收寄存器2
reg         rx_reg3;                            //接收寄存器3
reg         bit_flag;                           //比特标志位
 
reg         rx_flag;                            //接收标志位
reg [8:0]   baud_cnt;                           //波特计数器
 
reg         start_flag  ;                       //开始接收标志
reg         rx_en       ;                       //接收使能
 
reg  [7:0]  rx_data     ;                       //接收数据寄存器
reg  [3:0]  bit_cnt     ;                       //比特计数器
    
//打3拍
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        rx_reg1 <= 1'b1;
        rx_reg2 <= 1'b1;
        rx_reg3 <= 1'b1;
    end
    else begin
        rx_reg1 <= rx;
        rx_reg2 <= rx_reg1;
        rx_reg3 <= rx_reg2;
    end
end
//取第三拍下降沿作为开始接收标志信号
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        start_flag <= 1'b0;
    else if((rx_reg3) && (~rx_reg2))
        start_flag <= 1'b1;
    else
        start_flag <= 1'b0;
end
 
//接收使能
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        rx_en <= 1'b0;
    else if(start_flag == 1'b1)
        rx_en <= 1'b1;
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
        rx_en <= 1'b0;
end
 
//波特计数器
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        baud_cnt <= 9'd0;
    else if((baud_cnt == BAUD_CNT - 1'b1) || (rx_en == 1'b0))
        baud_cnt <= 9'd0;
    else if(rx_en == 1'b1)
        baud_cnt <= baud_cnt + 9'd1;
end
 
//比特标志位
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        bit_flag <= 1'b0;
    else if(baud_cnt == BAUD_CNT/2 - 1'b1)
        bit_flag <= 1'b1;
    else
        bit_flag <= 1'b0;
end
 
//比特计数器
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        bit_cnt <= 4'd0;
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
        bit_cnt <= 4'b0;
    else if(bit_flag == 1'b1)
        bit_cnt <= bit_cnt + 4'd1;
end
 
//接收数据寄存器
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        rx_data <= 8'd0;
    else if((bit_cnt >= 4'd1) && (bit_cnt <= 4'd8) && (bit_flag == 1'b1))
        rx_data <= {rx_reg3, rx_data[7:1]};
end
 
//接收标志位
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        rx_flag <= 1'b0;
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
        rx_flag <= 1'b1;
    else
        rx_flag <= 1'b0;
end
//接收的串转并数据
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        po_data <= 8'd0;
    else if(rx_flag == 1'b1)
        po_data <= rx_data;
end
//接收完成信号
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        po_flag <= 1'b0;
    else
        po_flag <= rx_flag;
end
    
endmodule