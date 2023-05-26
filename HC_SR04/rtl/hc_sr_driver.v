/*================================================*\
		  Filename ﹕hc_sr_driver.v
			Author ﹕
	  Description  ﹕超声波驱动调度文件
		 Called by ﹕
Revision History   ﹕ mm/dd/202x
		  			  Revision 1.0
  			  Email﹕ 
			Company﹕ 
\*================================================*/
module 	hc_sr_driver(
	input  wire			Clk		, //system clock 50MHz
	input  wire 		Rst_n	, //reset ，low valid
	
	input  wire 		echo	, //
	output wire  		trig	, //触发测距信号
	
	output wire [18:00]	data_o	  //检测距离，保留3位小数，单位：cm
);
//Interrnal wire/reg declarations
	wire			clk_us; //	
	
//Module instantiations ， self-build module
	clk_div		clk_div(
		/*input  wire		*/.Clk		(Clk	), //system clock 50MHz
		/*input  wire 		*/.Rst_n	(Rst_n	), //reset ，low valid			
		/*output wire  		*/.clk_us 	(clk_us )  //
	);
	hc_sr_trig	hc_sr_trig(
		/*input  wire		*/.clk_us	(clk_us	), //system clock 1MHz
		/*input  wire 		*/.Rst_n	(Rst_n	), //reset ，low valid		   
		/*output wire  		*/.trig		(trig	)  //触发测距信号
	);

	hc_sr_echo	hc_sr_echo(
		/*input  wire 		*/.Clk		(Clk	), //clock 50MHz
		/*input  wire		*/.clk_us	(clk_us	), //system clock 1MHz
		/*input  wire 		*/.Rst_n	(Rst_n	), //reset ，low valid		   
		/*input  wire 		*/.echo		(echo	), //
		/*output reg [18:00]*/.data_o	(data_o	)  //检测距离，保留3位小数，*1000实现
	);
//Logic Description
	

endmodule 
