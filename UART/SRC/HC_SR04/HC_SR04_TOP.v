module HC_SR04_TOP (
    input  wire        clk         ,
    input  wire        rstn        ,
    input  wire        echo        ,

    output wire        trig        ,
    output wire [7:0]  sel         ,
    output wire [7:0]  seg         
);

    wire    flag_1s     ;
    wire    flag_10us   ;
    wire    data_o      ;
    
time_counter u_time_counter(
    .clk        (clk        ),
    .rstn       (rstn       ),
    .flag_1s    (flag_1s    ),
    .flag_10us  (flag_10us  )
);

trig_driver u_trig_driver(
    .clk         (clk       ), 
    .rstn        (rstn      ),
    .flag_10us   (flag_10us ), 
    .trig        (trig      )
);

echo_driver u_echo_driver(
    .clk         (clk       ),
    .rstn        (rstn      ),
    .echo        (echo      ),
    .data_o      (data_o    )
);

seg_driver u_seg_driver(  
	.clk		(clk        ),   //50MHz
	.rst_n	    (rstn       ),   //low valid
	.data_in	(data_o     ),   //待显示数据
    .sel        (sel        ),   // 我这里是8位段选，可以换6位，但是要自己改代码
    .seg        (seg        )
);	

endmodule //HC_SR04_TOP