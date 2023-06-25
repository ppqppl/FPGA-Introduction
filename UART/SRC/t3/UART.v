module UART (
    input   wire            clk         ,
    input   wire            rstn        ,
    input   wire            UART_rx     ,

    output  wire            UART_tx         
);

    localparam   CLK_50MHz   =   26'd50000000    ;    // 时钟频率
    localparam   BAUD        =   17'd115200      ;    // 波特率

    reg     [7:0]   data    ;
    reg             flag    ;
    wire            tx_done ;   
    wire            flag_cnt;

    reg     [25:0]  cnt_clk;  
    reg     [3:0]   xcnt   ;

    localparam
		byte1 = "H",
		byte2 = "E",
		byte3 = "L",
		byte4 = "L",
		byte5 = "O",
		byte6 = "1",
		byte7 = "2",
		byte8 = "3",
		byte9 = "\n";

    always@(posedge clk or negedge rstn) begin
        if(!rstn)
            xcnt <= 0;
        else if(tx_done)
            xcnt <= xcnt + 1'd1;
        else if(xcnt == 9)
            xcnt <= 0;
    end

    
always@(*)
    case(xcnt)	//组合逻辑没有阻塞非阻塞的概念 直接"="
        3'd0:data = byte1;
        3'd1:data = byte2;
        3'd2:data = byte3;
        3'd3:data = byte4;
        3'd4:data = byte5;
        3'd5:data = byte6;
        3'd6:data = byte7;
        3'd7:data = byte8;
        3'd8:data = byte9;
        default:data = 0;
    endcase

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_clk <= 0;
        end
        else if(cnt_clk == CLK_50MHz - 1) begin
            cnt_clk <= 0;
        end
        else begin
            cnt_clk = cnt_clk + 1;
        end
    end

    // assign flag = cnt_clk == CLK_50MHz/9 - 1;



    /////////////////////////

    assign flag_cnt = cnt_clk == CLK_50MHz && xcnt == 9;

always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        flag = 0;
    end
    else if(tx_done && flag_cnt) begin
        flag = 1;
    end
    else if(cnt_clk < CLK_50MHz - 1) begin
        flag = 0;
    end
    else begin
        flag = flag;
    end
end










    ///////////////////////

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
        .UART_tx     (UART_tx   ),   // 串口输出位         
        .tx_done     (tx_done   )  
    );



endmodule //UART