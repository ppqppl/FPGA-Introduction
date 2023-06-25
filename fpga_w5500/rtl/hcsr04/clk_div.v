module 	clk_div(
	input  wire			clk		,
	input  wire 		rstn	,
		   
	output wire  		clk_us 	  //
);

	parameter CNT_MAX = 19'd49;//1us的计数值为 50 * Tclk（20ns）

	reg		[5:0]	cnt		; 
	wire			add_cnt ;
	wire			end_cnt ;
	
	// 时钟分频
	always @(posedge clk or negedge rstn) begin
		if(!rstn) begin
			cnt <= 6'd0;
		end
		else if(cnt == CNT_MAX) begin
			cnt <= 6'd0;
		end
		else begin
			cnt <= cnt + 6'd1;
		end
	end
	
	assign clk_us = cnt >= CNT_MAX ;
	

endmodule 
