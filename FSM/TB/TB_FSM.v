`timescale 1ns/1ns  // 仿真尺度
module TB_FSM();    // 仿真模块没有输入输出

    reg             tb_clk  ; 
    reg             tb_rst_n;
    wire    [3:0]   tb_led  ;

    FSM_LED(.TIMS_1S(50)) U_FMS_LED(
        .clk    (tb_clk     ),
        .rst_n  (tb_rst_n   ),
        .led    (tb_led     )
    );


    parameter CYCLE = 20;
    always #(CYCLE / 2) tb_clk = ~tb_clk;

    initial begin
        tb_clk      = 1'b0;
        tb_rst_n    = 1'b0;
        #(CYCLE *3);
        tb_rst_n    = 1'b1;
        #(CYCLE * 500);
        $stop;
    end

endmodule