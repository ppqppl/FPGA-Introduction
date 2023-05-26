`timescale 1ns/1ns
module TB_Key1();

    reg         tb_clk      ;
    reg         tb_rst_n    ;
    reg         tb_key_in   ;
    wire         tb_key_out  ;

    Key_Debounce1#(.TIME_20MS(10)) u_Key_Debounce1(
        .clk        (tb_clk     ),
        .rst_n      (tb_rst_n   ),
        .key_in     (tb_key_in  ),
        .key_out    (tb_key_out )
    );

    parameter CYCLE = 20;
    always #(CYCLE / 2) tb_clk = ~tb_clk;

    initial begin
        tb_clk = 1'b0;
        tb_rst_n = 1'b0;
        tb_key_in = 1'b1;
        #(CYCLE * 3);
        tb_rst_n = 1'b1;
        #(CYCLE * 10);
        tb_key_in = 1'b0;
        #(CYCLE * 20);
        tb_key_in = 1'b1;
        #(CYCLE * 100);
        $stop;
    end


endmodule