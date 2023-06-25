module UART_send
#(
    parameter  CLK        =   26'd50000000    ,    // 时钟频率
    parameter  BAUD        =   17'd115200           // 波特率
)
(
    input   wire            clk         ,
    input   wire            rstn        ,   
    input   wire    [7 : 0] data_in     ,   // 需要发送的数据
    input   wire            flag_in     ,   // 数据接收标志位，既发送标志位

    output  reg             UART_tx         // 串口输出位         
);

    localparam Baud_Clk     =   CLK/BAUD       ;    // 传输每个 Baud 需要的时钟数

    reg             tx_en       ;   // 发送使能
    reg             flag_bit    ;   // 比特标志位，采用下降沿发送
    reg [8 : 0]     cnt_baud    ;   // 波特率计数器
    reg [3 : 0]     cnt_bit     ;   // 比特计数器

    // 发送使能
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            tx_en <= 1'b0;
        end
        // 已经发送了十位 bit 并且到达下一个下降沿，输入只需要判断到数据位最后一位，输出则需要判断完整输出
        else if(cnt_bit == 4'd9 && flag_bit == 1'b1) begin
            tx_en <= 1'b0;
        end
        else if(flag_in == 1'b1) begin
            tx_en <= 1'b1;
        end
    end

    // 波特计数器
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_baud <= 9'd0;
        end
        // 传输完成所有波特或者使能失效，表示发送结束
        else if(cnt_baud == Baud_Clk - 1'b1 || tx_en == 1'b0) begin
            cnt_baud <= 9'd0;
        end
        else begin
            cnt_baud <= cnt_baud + 9'd1;
        end
    end

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            flag_bit <= 1'b0;
        end
        // 只有刚开始发送的一瞬间会产生一个时钟周期上升沿和下降沿
        else if(cnt_baud == 9'd1) begin
            flag_bit <= 1'b1;
        end
        else begin
            flag_bit <= 1'b0;
        end
    end

    // 计数10分有效数据位
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_bit <= 4'd0;
        end
        // 已经发送了十位 bit 并且到达下一个下降沿
        else if(cnt_bit == 4'd9 && flag_bit == 1'b1) begin
            cnt_bit <= 4'd0;
        end
        // 使能有效，下降沿发送数据
        else if(flag_bit == 1'b1 && tx_en == 1'b1) begin
            cnt_bit <= cnt_bit + 4'd1;
        end
        else begin
            cnt_bit <= cnt_bit;
        end
    end

    // 满足 RS232 协议 起始位为 0，停止位为 1，并按位输出
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            UART_tx <= 1'd1;
        end
        // 下降沿发送数据
        else if(flag_bit == 1'b1) begin
            case (cnt_bit)
                0:       UART_tx <= 1'd0        ;
                1:       UART_tx <= data_in[0]  ;
                2:       UART_tx <= data_in[1]  ;
                3:       UART_tx <= data_in[2]  ;
                4:       UART_tx <= data_in[3]  ;
                5:       UART_tx <= data_in[4]  ;
                6:       UART_tx <= data_in[5]  ;
                7:       UART_tx <= data_in[6]  ;
                8:       UART_tx <= data_in[7]  ;
                9:       UART_tx <= 1'd1        ;
                default: UART_tx <= 1'd1        ;
            endcase
        end
    end

endmodule //UART_send