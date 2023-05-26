/*================================================*\
		  Filename ﹕
			Author ﹕
	  Description  ﹕产生周期为1us的时钟信号
		 Called by ﹕
Revision History   ﹕ mm/dd/202x
		  			  Revision 1.0
  			  Email﹕ 
			Company﹕ 
\*================================================*/
module 	clk_div(
	input  wire			Clk		, //system clock 50MHz
	input  wire 		Rst_n	, //reset ，low valid
		   
	output wire  		clk_us 	  //
);
//Parameter Declarations
	parameter CNT_MAX = 19'd50;//1us的计数值为 50 * Tclk（20ns）

//Interrnal wire/reg declarations
	reg		[5:00]	cnt		; //Counter 
	wire			add_cnt ; //Counter Enable
	wire			end_cnt ; //Counter Reset 
	
//Logic Description
	
	always @(posedge Clk or negedge Rst_n)begin  
		if(!Rst_n)begin  
			cnt <= 'd0; 
		end  
		else if(add_cnt)begin  
			if(end_cnt)begin  
				cnt <= 'd0; 
			end  
			else begin  
				cnt <= cnt + 1'b1; 
			end  
		end  
		else begin  
			cnt <= cnt;  
		end  
	end 
	
	assign add_cnt = 1'b1; 
	assign end_cnt = add_cnt && cnt >= CNT_MAX - 19'd1;
	
	assign clk_us = end_cnt;
	

endmodule 
