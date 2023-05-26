`timescale 1ns/1ns

module TB_Full_adder4();

    reg     [3:0]   tb_a     ;
    reg     [3:0]   tb_b     ;
    reg             tb_cin   ;
    wire    [3:0]   tb_sum   ;
    wire            tb_cout  ;

    Full_adder4 u_Full_adder4(
        .a      (tb_a)      ,
        .b      (tb_b)      ,
        .cin    (tb_cin)    ,
        .sum    (tb_sum)    ,
        .cout   (tb_cout)
    );

    parameter CYCLE = 205;

    always begin
        # 5     tb_a = tb_a+1       ;
        # 7     tb_b = tb_b+1       ;
        # 10    tb_cin = ~tb_cin    ;
    end

    initial begin
        tb_a    = 4'b0000   ;
        tb_b    = 4'b0000   ;
        tb_cin  = 0         ;
        #(CYCLE * 2)        ;
        $stop               ;
    end
endmodule