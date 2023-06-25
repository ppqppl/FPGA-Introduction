module UART (
    input     clk,
    input     rstn,
    input        uart_rxd,    //FPGA串口接收端
    output    uart_txd        //FPGA串口发送端
);
parameter CLK_FREQ = 50000000;
parameter UART_BPS = 115200;
//模块之间的交互一定要用线网变量
wire [7:0]    uart_data;
wire            uart_done;
//例化串口接收子模块
uart_recv #(
    .CLK_FREQ        (CLK_FREQ),
    .UART_BPS        (UART_BPS)
)u_uart_recv(
    .sys_clk            (clk),
    .sys_rst_n        (rstn),
    .uart_rxd        (uart_rxd),        //接收端口的信号
    .uart_done        (uart_done),    //接收完成
    .uart_data        (uart_data)        //接收的数据，并行
);
//例化串口发送子模块
uart_send #(
    .CLK_FREQ        (CLK_FREQ),
    .UART_BPS        (UART_BPS)
)u_uart_send(
    .sys_clk            (clk),
    .sys_rst_n        (rstn),
    
    .uart_en            (uart_done),    //发送使能信号
    .uart_data        (uart_data),    //需要发送的串口数据，并行
    .uart_txd        (uart_txd)        //串口发送端
);
endmodule