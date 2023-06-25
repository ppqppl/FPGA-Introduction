`timescale 1ns / 1ns
 
module uart_tx
#(
    parameter   BAUD_MAX    =   'd115_200,
    parameter   CLK_MAX     =   'd50_000_000
)
(
    input                sys_clk     ,
    input                sys_rst_n   ,
        
    input       [7:0]    pi_data     ,              //接收的数据
    input                pi_flag     ,              //接收标志位
                                                    
    output  reg          tx                         //发送端
);
 
 
localparam  BAUD_CNT = CLK_MAX / BAUD_MAX;
 
 
reg         tx_en       ;                           //发送使能
reg [8:0]   baud_cnt    ;                           //波特率计数器
reg         bit_flag    ;                           //比特标志位
reg [3:0]   bit_cnt     ;                           //比特计数器
 
 
//发送使能
always@(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)
        tx_en <= 1'b0;
    else if(bit_cnt == 4'd9 && bit_flag == 1'b1)
        tx_en <= 1'b0;
    else if(pi_flag == 1'b1)
        tx_en <= 1'b1;
 
//波特计数器
always@(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)
        baud_cnt <= 9'd0;
    else if((baud_cnt == BAUD_CNT - 1'b1) || tx_en == 1'b0)
        baud_cnt <= 9'd0;
    else
        baud_cnt <= baud_cnt + 9'd1;
 
 
//比特数据标志位
always@(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)
        bit_flag <= 1'b0;
    else if(baud_cnt == 9'd1)
        bit_flag <= 1'b1;
    else
        bit_flag <= 1'b0;
        
        
//比特计数器，数据位数个数计数， 10个有效数据（含起始位和停止位）到来后计数器清零
always@(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)
        bit_cnt <= 4'd0;
    else if(bit_cnt == 4'd9 && bit_flag == 1'b1)
        bit_cnt <= 4'd0;
    else if(bit_flag == 1'b1 && tx_en == 1'b1)
        bit_cnt <= bit_cnt + 4'd1;
        
//tx:输出数据在满足 rs232 协议（起始位为 0，停止位为 1）的情况下一位一位输出        
always@(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)
        tx <= 1'b1;
    else if(bit_flag == 1'b1)
        case(bit_cnt)
            // 10位输出，一位开始位，一位停止位，七位数据位
            0: tx <= 1'b0;
            1: tx <= pi_data[0];
            2: tx <= pi_data[1];
            3: tx <= pi_data[2];
            4: tx <= pi_data[3];
            5: tx <= pi_data[4];
            6: tx <= pi_data[5];
            7: tx <= pi_data[6];
            8: tx <= pi_data[7];
            9: tx <= 1'b1;
            default : 
                tx <= 1'b1;
        endcase
 
 
endmodule