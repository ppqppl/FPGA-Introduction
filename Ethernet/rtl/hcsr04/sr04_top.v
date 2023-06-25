module sr04_top (
    input   wire            clk         ,
    input   wire            rstn        ,
    input   wire            echo        , // 距离信号

    output  wire            trig        , // 触发测距信号 
    output  wire    [7 : 0] sel         ,
    output  wire    [7 : 0] seg         ,
    output  wire    [18: 0] data_o  
);

    wire        clk_us;

    clk_div	u_clk_div(
        .clk		(clk	), 
        .rstn		(rstn	),
        .clk_us		(clk_us )
	);

    trig_driver	u_trig_driver(
        .clk_us		(clk_us	),
        .rstn		(rstn	),
        .trig		(trig	)
    );

    echo_driver	u_echo_driver(
        .clk		(clk	),
        .clk_us		(clk_us	),
        .rstn		(rstn	),
        .echo		(echo	),
        .data_o		(data_o	)
    );

    seg_driver u_seg_driver(  
        .clk		(clk	),
        .rstn		(rstn	),
        .data_in	(data_o	), //待显示数据
        .sel		(sel	),	// 我这里是8位段选，可以换6位，但是要自己改代码
        .seg		(seg	)     
	);	

endmodule //sr04_top

