`timescale 1ns/1ns 
module TB_CLOCK();

    reg         tb_clk ;
    reg         tb_rst_n;
    wire        tb_sel  ;
    wire        tb_dig  ;

    CLOCK#(.TIME_SCAN(50)) inst_CLOCK(
        .clk    (tb_clk     ) ,
        .rst_n  (tb_rst_n   ) ,
        .sel    (tb_sel     ) ,
        .dig    (tb_dig     ) 
    );

    parameter CYCLE = 20;
    always #(CYCLE/2) tb_clk = !tb_clk;

    initial begin  //产生激励
        tb_clk = 1'b0;
        tb_rst_n = 1'b0;
        #(CYCLE * 5);
        tb_rst_n = 1'b1;
        repeat (10)begin
            #(CYCLE * 1000_000);
        end
        $stop;
    end



endmodule