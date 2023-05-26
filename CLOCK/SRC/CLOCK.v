module CLOCK#(parameter TIME_SCAN = 50_000 )(
    input           clk     ,
    input           rst_n   ,
    output [5:0]    sel     ,
    output [7:0]    dig     
);

    wire  [16:0]    dout    ;

    TIME_ctrl inst_TIME_ctrl(
        .clk    (clk     ) ,
        .rst_n  (rst_n   ) ,
        .dout   (dout    )  
    );

    SEG_driver#(.TIME_SCAN(TIME_SCAN)) inst_SEG_driver(
        .clk    (clk     ) ,
        .rst_n  (rst_n   ) ,
        .din    (dout    ) ,
        .sel    (sel     ) ,
        .dig    (dig     )  
    );


endmodule