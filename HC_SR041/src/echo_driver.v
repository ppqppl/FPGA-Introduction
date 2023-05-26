module 	echo_driver(
	input  wire 		clk		,
	input  wire			clk_us	,
	input  wire 		rstn	,
		   
	input  wire 		echo	,
	output wire [18:00]	data_o	  //检测距离，保留3位小数，*1000实现
);

	parameter T_MAX = 16'd5_9999;//510cm 对应计数值

	reg				r1_echo,r2_echo; //边沿检测	
	wire			echo_pos,echo_neg; //
	
	reg		[15:00]	cnt		; 
	
	reg		[18:00]	data_r	;
	
	//如果使用clk_us 检测边沿，延时2us，差值过大
	always @(posedge clk or negedge rstn)begin  
		if(!rstn)begin  
			r1_echo <= 1'b0;
			r2_echo <= 1'b0;
		end  
		else begin  
			r1_echo <= echo;
			r2_echo <= r1_echo;
		end  
	end
	
	assign echo_pos = r1_echo & ~r2_echo;
	assign echo_neg = ~r1_echo & r2_echo;
	
	always @(posedge clk_us or negedge rstn) begin
		if(!rstn) begin
			cnt <= 16'd0;
		end
		else if(echo) begin
			if(cnt == T_MAX) begin
				cnt <= 16'd0;
			end
			else begin
				cnt <= cnt + 16'd1;
			end
		end
		else begin
			cnt <= 16'd0;
		end
	end
	
	always @(posedge clk or negedge rstn)begin  
		if(!rstn)begin  
			data_r <= 'd2;
		end  
		else if(echo_neg)begin  
			data_r <= (cnt << 4) + cnt;
		end  
		else begin  
			data_r <= data_r;
		end  
	end
	
	assign data_o = data_r >> 1;

endmodule 
