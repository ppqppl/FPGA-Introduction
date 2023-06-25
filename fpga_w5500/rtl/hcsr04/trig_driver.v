module 	trig_driver(
	input  wire			clk_us	,
	input  wire 		rstn	,
		   
	output wire  		trig	  //触发测距信号
);

	parameter CYCLE_MAX = 19'd29_9999;

	reg		[18:00]	cnt		;

// 10毫秒持续电平输出
	
	always @(posedge clk_us or negedge rstn) begin
		if(!rstn) begin
			cnt <= 19'd0;
		end
		else if(cnt == CYCLE_MAX) begin
			cnt <= 19'd0;
		end
		else begin
			cnt <= cnt + 19'd1;
		end
	end
	
	assign trig = cnt < 15 ? 1'b1 : 1'b0;

endmodule 
