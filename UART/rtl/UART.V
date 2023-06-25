module UART (
    input   wire            clk         ,
    input   wire            rstn        ,
    input   wire            UART_rx     ,

    output  wire            UART_tx         
);

    localparam   CLK_50MHz   =   26'd50000000    ;    // 时钟频率
    localparam   BAUD        =   17'd115200      ;    // 波特率

    wire    [7:0]   data    ;
    wire            flag    ;

    UART_send
    #(
        .CLK         (CLK_50MHz ),// 时钟频率
        .BAUD        (BAUD      ) // 波特率
    )
    UART_send_init(
        .clk         (clk       ),
        .rstn        (rstn      ),   
        .data_in     (data      ),   // 需要发送的数据
        .flag_in     (flag      ),   // 数据接收标志位，既发送标志位
        .UART_tx     (UART_tx   )    // 串口输出位         
    );

    UART_recv 
    #(
        .CLK         (CLK_50MHz ),    // 时钟频率
        .BAUD        (BAUD      )     // 波特率
    )
    UART_recv_init(
        .clk         (clk       ),
        .rstn        (rstn      ),   
        .UART_rx     (UART_rx   ),
        .flag_out    (flag      ),   // 数据接收完成标志位，既发送开始标志位，半个时钟周期为 1 ，用于判断数据已经全部接收完成
        .data_out    (data      )    // 接收的数据
    );

endmodule //UART