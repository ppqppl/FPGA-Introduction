module Bin2BCD
#(
    parameter  CLK        =   26'd50000000    ,    // 时钟频率
    parameter  BAUD        =   17'd115200           // 波特率
) (
    input   wire            clk         ,
    input   wire            rstn        ,
    input   wire            flag_1s     ,
    input   wire    [18:0]  data        ,

    output  wire            UART_tx  
);

    localparam  MAX_Byte    =   4'd8    ;

    reg                 tx_en           ;   // 发送使能
    reg                 tx_single_en    ;   // 单个发送使能
    reg                 tx_single_done  ;   // 发送单字节完成
    reg                 tx_single_done1 ;   // 延时一个周期，凑时序
    wire                tx_done         ;   // 数据全部发送完成

    reg     [3 : 0]     cnt_byte        ;   // 判断输出的字节数
    wire    [23: 0]     BCD_out         ;   // 转 BCD 之后的数据
    reg     [71: 0]     data_out1       ;   // 循环位移后的数据，9个字节
    wire    [71: 0]     data_out        ;   // 梳理后的初始shuju
    reg     [7 : 0]     data_tx         ;   // 要发送的一个字节

    // 发送使能判断
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            tx_en <= 1'b0;
        end
        // 开始发送判断
        else if(flag_1s && ~tx_en) begin
            tx_en <=  1'b1;
        end
        // 全部发送完成
        else if(tx_done) begin
            tx_en <= 1'b0;
        end
        else begin
            tx_en <= tx_en;
        end
    end

    // 循环右移，输出数据，每次输出一个字节
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            data_out1 <= 72'd0;
        end
        // 开始输出，但是还没有使能
        else if(flag_1s && !tx_en) begin
            data_out1 <=  data_out;
        end
        // 每发送完一个字节。右移 8 位
        else if(tx_single_done) begin
            data_out1 <= data_out1 >> 8 ;
        end
        else begin
            data_out1 <= data_out1;
        end
    end

    // 对发送的字节计数
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_byte <= 0;
        end
        else if(tx_en) begin 
            // 发送完成
            if(tx_single_done && cnt_byte == MAX_Byte) begin
                cnt_byte <= 0;
            end
            else if(tx_single_done) begin
                cnt_byte <= cnt_byte + 1'b1;
            end
            else begin
                cnt_byte <= cnt_byte;
            end
        end
        else begin
            cnt_byte <= 0;
        end
    end

    // 打拍，凑时序
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            tx_single_done1 <= 0;
        end
        else begin
            tx_single_done1 <= tx_single_done;
        end
    end

    // 发送单字节
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            data_tx <= 0;
        end
        else if(flag_1s && !tx_en) begin
            data_tx <= data_out[7:0];
        end
        else if(tx_single_done1) begin
            data_tx <= data_out1[7:0];
        end
        else begin
            data_tx <= data_tx;
        end
    end

    // 发送单字节使能
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            tx_single_en <= 0;
        end
        // 进入工作状态立即开始发送
        else if(flag_1s && ~tx_en) begin
            tx_single_en <= 1'b1;
        end
        else if(tx_single_done1 && tx_done) begin
            tx_single_en <= 1'b1;
        end
        else begin
            tx_single_en <= 0;
        end
    end


	assign  BCD_out[23:20] = data / 10 ** 5 % 10    ;
    assign  BCD_out[19:16] = data / 10 ** 4 % 10    ;
	assign  BCD_out[15:12] = data / 10 ** 3 % 10    ;
	assign  BCD_out[11: 8] = data / 10 ** 2 % 10    ;
	assign  BCD_out[7 : 4] = data / 10 ** 1 % 10    ;
	assign  BCD_out[3 : 0] = data / 10 ** 0 % 10    ;
    assign  data_out[7 : 0] = BCD_out[23:20] + 48  ;
    assign  data_out[15: 8] = BCD_out[19:16] + 48  ;
    assign  data_out[23:16] = BCD_out[15:12] + 48  ;
    assign  data_out[31:24] = 46                   ;
    assign  data_out[39:32] = BCD_out[11: 8] + 48  ;
    assign  data_out[47:40] = BCD_out[7 : 4] + 48  ;
    assign  data_out[55:48] = BCD_out[3 : 0] + 48  ;
    assign  data_out[63:56] = 99                   ;
    assign  data_out[71:64] = 109                  ;

    assign tx_done = cnt_byte == MAX_Byte && tx_single_done;

	UART_send #(
		.CLK 	   (CLK		),
		.BAUD	   (BAUD	)
	)
	u_UART_seng (
		.clk       (clk		        ),
		.rstn      (rstn	        ),   
		.data_in   (data_o	        ),   // 需要发送的数据
        .tx_en     (tx_single_en    ),
        .tx_done   (tx_single_done  ),
		.UART_tx   (UART_tx	        )    // 串口输出位         
	);

endmodule //Bin2BCD