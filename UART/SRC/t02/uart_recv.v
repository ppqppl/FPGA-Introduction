module uart_recv (
    input                     sys_clk,
    input                     sys_rst_n,
    input                    uart_rxd,        //接收端口的信号
    output    reg                uart_done,        //接收完成
    output    reg[7:0]        uart_data        //接收的数据，并行
);
parameter     CLK_FREQ = 50000000;            //时钟频率，50M
parameter    UART_BPS = 115200;                //波特率，bit/s
parameter    BPS_CNT = CLK_FREQ/UART_BPS;    //每个bit传输需要的时钟数
reg                uart_rxd_d0;
reg                uart_rxd_d1;
reg    [15:0]        clk_cnt;        //时钟数，最大到BPS_CNT
reg    [3:0]        rx_cnt;            //接收数据bit的个数，最大到9
reg    [7:0]        rxdata;            //接收的数据寄存器
reg                rx_flag;        //接收数据的标志位

wire                start_flag;    //起始位开始的标志位
//起始位触发（捕获下降沿），d1延后d0一个周期，所以当d0为0，d1为1，意味着下降沿
assign start_flag = uart_rxd_d1 & (~uart_rxd_d0);
//d1和d0都是数据线上信号，保证d1延后d0一个时钟周期
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (~sys_rst_n) begin    //复位时数据信号清0
        uart_rxd_d0 <= 1'b0;
        uart_rxd_d1 <= 1'b0;
    end
    else begin
        uart_rxd_d0 <= uart_rxd;
        uart_rxd_d1 <= uart_rxd_d0;
    end
        
end
//确立信号接收标志位
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (~sys_rst_n)
    rx_flag <= 1'd0;
    else begin
        if (start_flag)
            rx_flag <= 1'd1;
        else if ((rx_cnt == 4'd9) && (clk_cnt == BPS_CNT/2))    //判断停止位，在第9个bit的中间时钟处
            rx_flag <= 1'd0;
        else
            rx_flag <= rx_flag;
    end
end

//对时钟进行计数（最大到BPS_CNT），对接收的bit数进行计数，
//根据这两个数判断停止位
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (~sys_rst_n) begin                //复位时计数都清零
        rx_cnt <= 4'd0;
        clk_cnt <= 16'd0;
    end
    else if (rx_flag) begin                //开始数据传输
        if (clk_cnt < BPS_CNT)
            clk_cnt <= clk_cnt + 1'b1;
        else begin                        //经过了一个bit的时钟数
            clk_cnt <= 1'b0;            //时钟数清零
            rx_cnt <= rx_cnt + 1'b1;    //bit数加1，1bit即从第一个数据位开始，包含了起始位
        end
    end    
    else begin
        clk_cnt <= 16'd0;
        rx_cnt <= 4'd0;
    end
end
//寄存接收数据
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (~sys_rst_n)
        rxdata <= 8'd0;
    else if (rx_flag) 
        if (clk_cnt == BPS_CNT/2) begin    //在一个比特的时钟中间处对数据进行接收
            case (rx_cnt)                        //寄存接收数据
                4'd1:    rxdata[0] <= uart_rxd_d1;
                4'd2:    rxdata[1] <= uart_rxd_d1;
                4'd3:    rxdata[2] <= uart_rxd_d1;
                4'd4:    rxdata[3] <= uart_rxd_d1;
                4'd5:    rxdata[4] <= uart_rxd_d1;
                4'd6:    rxdata[5] <= uart_rxd_d1;
                4'd7:    rxdata[6] <= uart_rxd_d1;
                4'd8:    rxdata[7] <= uart_rxd_d1;
                default:    ;
            endcase
        end
        else
        rxdata <= rxdata;
    else
        rxdata <= 8'd0;
end
//判断接收数据是否完成以及把数据赋给输出信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (~sys_rst_n) begin
        uart_done <= 1'd0;
        uart_data <= 8'd0;
    end
    else if (rx_cnt == 4'd9) begin
        uart_data <= rxdata;
        uart_done <= 1'd1;
    end
    else begin
        uart_data <= 8'd0;
        uart_done <= 1'd0;
    end
end
endmodule