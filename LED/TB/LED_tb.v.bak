`timescale 1ns/1ns  //仿真尺度
module LED_tb();  //设计输入 输出不管 仿真原文件 看输出的结果是否与预期相符合 tb是没有输入输出
    reg             tb_clk  ;
    reg             tb_rst_n;
    wire   [3:0]    tb_led  ;

    LED#(.TIME_1S(500)) u_LED( //模块例化 
        .clk    (tb_clk     )  ,
        .rst_n  (tb_rst_n   )  ,
        .led    (tb_led     ) 
    );

    parameter CYCLE = 20;  //定义周期为 20ns
    always #(CYCLE / 2) tb_clk = ~tb_clk;  // 经过周期的一半 tb_clk就取反

    initial begin
        tb_clk = 1'b0;
        tb_rst_n = 1'b0;
        #(CYCLE * 3); //延时
        tb_rst_n = 1'b1;
        #(CYCLE * 1000);
        $stop; //停止
    end


endmodule