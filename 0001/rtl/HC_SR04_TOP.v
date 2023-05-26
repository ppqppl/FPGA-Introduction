/*================================================*\
		  Filename ﹕
			Author ﹕
	  Description  ﹕
		 Called by ﹕
Revision History   ﹕ mm/dd/202x
		  			  Revision 1.0
  			  Email﹕ 
			Company﹕ 
\*================================================*/
module 	HC_SR04_TOP(
	input  			Clk		, //system clock 50MHz
	input   		Rst_n	, //reset ，low valid
	
	input   		echo	, //
	output   		trig	, //触发测距信号
	
	output 	[6:0]	hex1	, // -共阳极，低电平有效
	output  [6:0]	hex2	, // -
    output  [6:0]	hex3	, // -
    output  [6:0]	hex4	, //连接符
    output  [6:0]	hex5	, //cm - 
    output  [6:0]	hex6	, //cm - 
    output  [6:0]	hex7	, //cm - 
    output  [6:0]	hex8	  //熄灭
);
//Interrnal wire/reg declarations
	wire	[18:00]		line_data; //
	
	
//Module instantiations ， self-build module
	hc_sr_driver	hc_sr_driver(
		/*input  wire		*/.Clk		(Clk	), //system clock 50MHz
		/*input  wire 		*/.Rst_n	(Rst_n	), //reset ，low valid

		/*input  wire 		*/.echo		(echo	), //
		/*output wire  		*/.trig		(trig	), //触发测距信号

		/*output reg [18:00]*/.data_o	(line_data)  //检测距离，保留3位小数，单位：cm
);

	seg_driver		seg_driver(  
		/*input	wire		*/.clk		(Clk	),  //50MHz
		/*input	wire		*/.rst_n	(Rst_n	),  //low valid
		
		/*input	wire [18:0]	*/.data_in	(line_data), //待显示数据
		
		/*output reg [6:0]	*/.hex1		(hex1	), // -共阳极，低电平有效
		/*output reg [6:0]	*/.hex2		(hex2	), // -
		/*output reg [6:0]	*/.hex3		(hex3	), // -
		/*output reg [6:0]	*/.hex4		(hex4	), //连接符
		/*output reg [6:0]	*/.hex5		(hex5	), //cm - 
		/*output reg [6:0]	*/.hex6		(hex6	), //cm - 
		/*output reg [6:0]	*/.hex7		(hex7	), //cm - 
		/*output reg [6:0]	*/.hex8		(hex8	)  //熄灭
	);	

//Logic Description
	

endmodule 
