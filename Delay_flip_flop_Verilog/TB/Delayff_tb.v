`timescale 1ns / 1ns

module Delayff_tb;
    reg CLK,D;
    wire Q;

    Delayff u1(.D(D),.CLK(CLK),.Q(Q));

    initial
    begin
        CLK = 1;
        D <= 0;
        forever
        begin
            #60 D <= 1;//人为生成毛刺 
            #22 D <= 0;
            #2  D <= 1;
            #2  D <= 0;
            #16 D <= 0;//维持16ns的低电平，然后让它做周期性的循环
        end
    end

    always #20 CLK <= ~CLK;//半周期为20ns,全周期为40ns的一个信号
endmodule
	