module 	HC_SR04_TOP(
	input  				clk				, 
	input   			rstn			, 
	input   			echo			, // 距离信号
	input   wire		uart_rx			, // 串口输入 
	output   			trig			, // 触发测距信号
	output  wire [7:0]	sel				,
	output  wire [7:0]	seg				,
	output  wire [4:0]	led				, 
	output  wire 		uart_tx
);

    localparam   CLK         =   26'd50000000   ;    // 时钟频率
    localparam   BAUD        =   17'd115200     ;     // 波特率

	wire	[18:00]		data_o		;
	wire 				clk_us		;
	
	wire				flag_1s		;
	wire 				tx_done		;
	wire 	[7 : 0]		data_rx		;

	// 滤波程序待测试
	wire 				flag_out	;	// 开始输出标志，滤波数据满足条件
	wire 	[18: 0]		data_out	;

	seg_driver u_seg_driver(  
		.clk		(clk	),
		.rstn		(rstn	),
		.data_in	(data_o	), //待显示数据
		.sel		(sel	),	// 我这里是8位段选，可以换6位，但是要自己改代码
    	.seg		(seg	)     
	);	

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

	UART_driver u_UART_driver(
    	.clk         (clk		),
    	.rstn        (rstn		),
		.data_in	 (data_o	),
		// .data_in	 (data_out	),
		// .flag_in 	 (flag_out 	),
    	.UART_rx     (uart_rx	),
    	.UART_tx     (uart_tx	)    
	);

	led_driver u_led_driver(
		.clk         (clk		),
		.rstn        (rstn		),
		.data_in	 (data_o	), //待显示数据
		.led         (led		)
	);

	// filter_driver u_filter_driver(
	// .clk         	(clk		),
    // .rstn        	(rstn		),
    // .data_in  	 	(data_o		),
	// .flag_out	 	(flag_out	), 
	// .data_out    	(data_out	)
	// );	

endmodule