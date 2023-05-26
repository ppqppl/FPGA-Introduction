
`timescale 1ns/1ns 		//仿真系统时间尺度定义

`define clk_period 20  	//时钟周期参数定义	

module tb_hc_sr(); 
//激励信号定义  
	reg				Clk		; 
	reg				Rst_n	; 
	reg				echo; //
	
//响应信号定义	  
	wire	 		trig	;
	
	wire	[6:0]	hex1	;
	wire	[6:0]	hex2	;
	wire	[6:0]	hex3	;
	wire	[6:0]	hex4	;
	wire	[6:0]	hex5	;
	wire	[6:0]	hex6	;
	wire	[6:0]	hex7	;
	wire	[6:0]	hex8	;
//实例化
	HC_SR04_TOP		HC_SR04_TOP(
		/*input  		*/.Clk		(Clk		), //system clock 50MHz
		/*input   		*/.Rst_n	(Rst_n		), //reset ，low valid
		
		/*input   		*/.echo		(echo		), //
		/*output   		*/.trig		(trig		), //触发测距信号
		
		/*output  [6:0]	*/.hex1		(hex1		), // -共阳极，低电平有效
		/*output  [6:0]	*/.hex2		(hex2		), // -
		/*output  [6:0]	*/.hex3		(hex3		), // -
		/*output  [6:0]	*/.hex4		(hex4		), //连接符
		/*output  [6:0]	*/.hex5		(hex5		), //cm - 
		/*output  [6:0]	*/.hex6		(hex6		), //cm - 
		/*output  [6:0]	*/.hex7		(hex7		), //cm - 
		/*output  [6:0]	*/.hex8		(hex8		)  //熄灭
	);

//产生时钟							       		 
	initial Clk = 1'b0;		       		 
	always #(`clk_period / 2) Clk = ~Clk;  		 

//产生激励	 
	initial  begin	 
		Rst_n = 1'b0;	 
		echo  = 1'b0;
		#(`clk_period * 20 + 3);	 
		Rst_n = 1'b1;	 
		#(`clk_period * 20); 
		
		wait(HC_SR04_TOP.hc_sr_driver.hc_sr_trig.cnt == 240);
		echo = 1'b1;//测试超声波信号发送完成，echo拉高
		
		#(50 * `clk_period * 2500 + 7);
		echo = 1'b0;
		
		#(`clk_period * 200);
		$stop(2); 
	end	 

endmodule 