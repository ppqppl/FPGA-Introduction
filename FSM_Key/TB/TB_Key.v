`timescale 1ns/1ns
module TB_Key();

    reg         tb_clk      ;
    reg         tb_rst_n    ;
    reg         tb_key_in   ;
    wire        tb_key_out  ;

    FSM_Key#(.TIME_20MS(50)) u_FSM_Key(
        .clk     (tb_clk        ),
        .rst_n   (tb_rst_n      ),
        .key_in  (tb_key_in     ),
        .key_out (tb_key_out    )
    );

    parameter CYCLE = 20;
    always #(CYCLE / 2) tb_clk = ~tb_clk;

    initial begin
        tb_clk  = 1'b0;
        tb_rst_n = 1'b0;
        tb_key_in = 1'b1;
        #(CYCLE * 3);   // 延时
        tb_rst_n = 1'b1;
        #(CYCLE * 10);
        tb_key_in = 1'b0;
        #(CYCLE * 100);
        tb_key_in = 1'b1;
        #(CYCLE * 500);
        $stop;
    end

endmodule