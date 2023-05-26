`timescale 1ns/1ns
module TB_UART();

    reg             tb_clk      ;
    reg             tb_rst_n    ;
    reg             tb_rx          ;
    wire            tb_tx          ;  

    UART instance_UART (
        .clk     (tb_clk     ),
        .rst_n   (tb_rst_n   ),
        .rx      (tb_rx      ),
        .tx      (tb_tx      )
    );

    parameter CYCLE = 20;
    always #(CYCLE/2) tb_clk = ~tb_clk;

    initial begin   // 激励
        tb_clk      = 1'b0;
        tb_rst_n    = 1'b0;
        tb_rx          = 1'b1;
        #(CYCLE * 5);
        tb_rst_n    = 1'b1;
        #(CYCLE * 450);
        tb_rx          = 1'b0; // 起始位
        #(CYCLE * 450);
        tb_rx          = 1'b1;
        #(CYCLE * 450);
        tb_rx          = 1'b1;
        #(CYCLE * 450);
        tb_rx          = 1'b1;
        #(CYCLE * 450);
        tb_rx          = 1'b1;
        #(CYCLE * 450);
        tb_rx          = 1'b0;
        #(CYCLE * 450);
        tb_rx          = 1'b0;
        #(CYCLE * 450);
        tb_rx          = 1'b0;
        #(CYCLE * 450);
        tb_rx          = 1'b0;
        #(CYCLE * 450);
        tb_rx          = 1'b1; // 停止位
        #(CYCLE * 5000);
        $stop;
    end


endmodule