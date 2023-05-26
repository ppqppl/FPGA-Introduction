`timescale 1ns/1ns

module TB_Halfadder();
    reg     tb_a    ;
    reg     tb_b    ;
    wire    tb_cout ;
    wire    tb_sum  ;

    Halfadder u_Halfadder(
        .a      (tb_a)      ,
        .b      (tb_b)      ,
        .cout   (tb_cout)   ,
        .sum    (tb_sum)
    );

    parameter CYCLE = 20;
    always # 5      tb_a = ~tb_a    ;
    always # 10     tb_b = ~tb_b    ;

    initial begin
        tb_a = 1'b0     ;
        tb_b = 1'b0     ;
        #(CYCLE * 4)    ;   
        $stop           ;
    end

endmodule