module uart_send(
    input             sys_clk,
    input             sys_rst_n,
    
    input                uart_en,            //发送使能信号
    input     [7:0]    uart_data,        //需要发送的串口数据，并行
    output reg        uart_txd            //串口发送端
);
parameter     CLK_FREQ = 50000000;                //时钟频率，50M
parameter    UART_BPS = 115200;                //波特率，bit/s
parameter    BPS_CNT = CLK_FREQ/UART_BPS;    //每个bit传输需要的时钟数
reg                uart_en_d0;            
reg                uart_en_d1;
reg    [15:0]    clk_cnt;                //时钟计数寄存器
reg    [3:0]        tx_cnt;                //发送bit计数寄存器
reg                tx_flag;                //发送标志位
reg    [7:0]        tx_data;                //寄存发送数据
wire                en_flag;                //发送使能位
//找到发送使能信号的上升沿，将发送使能位置位
assign en_flag = uart_en_d0 & (~uart_en_d1);
//确定d0和d1，d1滞后d0一个时钟周期
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (~sys_rst_n) begin
        uart_en_d0 <= 1'd0;
        uart_en_d1 <= 1'd0;
    end
    else begin
        uart_en_d0 <= uart_en;
        uart_en_d1 <= uart_en_d0;
    end
end
//确定发送标志位
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (~sys_rst_n)
        tx_flag <= 1'd0;
    else if (en_flag) begin
        tx_flag <= 1'd1;
        tx_data <= uart_data;
    end
    else begin
        if ((tx_cnt == 4'd9) && (clk_cnt == BPS_CNT/2))    begin//已经发送了9比特数据，则发送结束，标志位清零
            tx_flag <= 1'd0;
            tx_data <= 8'd0;
        end
        else begin
            tx_flag <= tx_flag;
            tx_data <= tx_data;    
        end
    end
end
//对时钟和发送bit进行计数
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (~sys_rst_n) begin
        clk_cnt <= 16'd0;
        tx_cnt <= 4'd0;
    end
    else if (tx_flag) begin
        if (clk_cnt < BPS_CNT - 1'd1)
            clk_cnt <= clk_cnt + 1'd1;
        else begin
            clk_cnt <= 16'd0;
            tx_cnt <= tx_cnt + 1'd1;
        end
    end
end
//并转串，将数据放到串口发送信号线上
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (~sys_rst_n) 
        uart_txd <= 1'd1;
    else if (tx_flag) 
        case (tx_cnt)
            4'd0:    uart_txd <= 1'd0;
            4'd1:    uart_txd <= tx_data[0];
            4'd2:    uart_txd <= tx_data[1];
            4'd3:    uart_txd <= tx_data[2];
            4'd4:    uart_txd <= tx_data[3];
            4'd5:    uart_txd <= tx_data[4];
            4'd6:    uart_txd <= tx_data[5];
            4'd7:    uart_txd <= tx_data[6];
            4'd8:    uart_txd <= tx_data[7];
            4'd9:    uart_txd <= 1'd1;
            default:;
        endcase
    else
        uart_txd <= 1'd1;
end
endmodule