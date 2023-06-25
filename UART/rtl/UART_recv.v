module UART_recv 
#(
    parameter  CLK         =   26'd50000000    ,    // 时钟频率
    parameter  BAUD        =   17'd115200           // 波特率
)
(
    input   wire            clk         ,
    input   wire            rstn        ,   
    input   wire            UART_rx     ,

    output  reg             flag_out    ,   // 数据接收完成标志位，既发送开始标志位
    output  reg    [7 : 0]  data_out        // 接收的数据
);

    localparam Baud_Clk     =   CLK/BAUD       ;    // 传输每个 Baud 需要的时钟数

    reg             rx_en       ;   // 接收使能
    reg             start_flag  ;   // 开始接收标志
    reg             flag_rx     ;   // 接收标志位，半个时钟周期为 1 ，用于判断数据已经全部接收完成
    reg             flag_bit    ;   // 比特标志位，采用下降沿发送
    reg             rx_reg1     ;   // 接收寄存器1，同步打拍（打一拍延时一个时钟周期）
    reg             rx_reg2     ;   // 接收寄存器2
    reg             rx_reg3     ;   // 接收寄存器3，取第三拍下降沿进行边缘检测
    reg [8 : 0]     cnt_baud    ;   // 波特率计数器
    reg [7 : 0]     data_rx     ;   // 接收数据寄存器
    reg [3 : 0]     cnt_bit     ;   // 比特计数器

    // 打三拍
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            rx_reg1 <= 1'b1;
            rx_reg2 <= 1'b1; 
            rx_reg3 <= 1'b1;
        end
        else begin
            rx_reg1 <= UART_rx;
            rx_reg2 <= rx_reg1;
            rx_reg3 <= rx_reg2;
        end
    end

    // 检测第三拍下降沿，用作数据接收信号
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            start_flag <= 1'b0;
        end
        // 判断第三拍下降沿
        else if(rx_reg3 && ~rx_reg2) begin
            start_flag <= 1'b1;
        end
        else begin
            start_flag <= 1'b0;
        end
    end

    // 接收使能
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            rx_en <= 1'b0;
        end
        // 下降沿接收
        else if(start_flag == 1'b1) begin
            rx_en <= 1'b1;
        end
        // 接收完成，输入只需要判断到数据位最后一位，输出则需要判断完整输出
        else if(cnt_bit == 4'd8 && flag_bit == 1'b1) begin
            rx_en <= 1'b0;
        end
    end

     // 波特计数器
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_baud <= 9'd0;
        end
        // 传输完成所有波特或者使能失效，表示接收结束
        else if(cnt_baud == Baud_Clk - 1'b1 || rx_en == 1'b0) begin
            cnt_baud <= 9'd0;
        end
        // 只有输入使能才能计数
        else if(rx_en == 1'b1) begin
            cnt_baud <= cnt_baud + 9'd1;
        end
    end

    // 比特标志位
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            flag_bit <= 1'b0;
        end
        // 半个周期反转一次，输入一个bit需要两个时钟周期，输出需要三个
        else if(cnt_baud == Baud_Clk/2 - 1'b1) begin
            flag_bit <= 1'b1;
        end
        else begin
            flag_bit <= 1'b0;
        end
    end

    // 比特计数器
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_bit <= 4'd0;
        end
        // 输入判断完成
        else if(cnt_bit == 4'd8 && flag_bit == 1'b1) begin
            cnt_bit <= 4'd0;
        end
        // 前面判断了输入使能失效，无法进行波特计数
        else if(flag_bit == 1'b1) begin
            cnt_bit <= cnt_bit + 4'd1;
        end
    end

    // 接收数据
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            data_rx <= 8'd0;
        end
        // 只要开始接收，就开始存储数据，1-8为数据位，解析输入数据，从最低位向最高位输入
        else if(cnt_bit >= 4'd1 && cnt_bit <= 4'd8 && flag_bit == 1'b1) begin
            data_rx <= {rx_reg3,data_rx[7:1]};
        end
    end

    // 接收标志位
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            flag_rx <= 1'b0;
        end
        // 数据接收完成，输出半个时钟周期的 1 用于数据转存，将收到的数据再次发送出去
        else if(cnt_bit == 4'd8 && flag_bit == 1'b1) begin
            flag_rx <= 1'b1;
        end
        else begin
            flag_rx <= 1'b0;
        end
    end

    // 接收的串转并数据
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            data_out <= 8'd0;
        end
        // 判断数据已经全部接收完成
        else if(flag_rx == 1'b1) begin
            data_out <= data_rx;
        end
    end

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            flag_out <= 1'b0;
        end
        else begin
            flag_out <= flag_rx;
        end
    end

endmodule //UART_recv