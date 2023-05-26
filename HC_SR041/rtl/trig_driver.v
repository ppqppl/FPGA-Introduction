module trig_driver (
    input   wire        clk         , 
    input   wire        rstn        ,
    input   wire        flag_10us   , 

    output  wire        trig        
);

    assign  trig    =   flag_10us   ;

endmodule //trig_driver