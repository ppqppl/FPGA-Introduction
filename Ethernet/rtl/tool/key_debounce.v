module key_debounce(
	input 	wire	clk,
	input 	wire 	rstn,
	input 	wire 	key,
	
	output 	reg 	flag,// 0抖动, 1抖动结束
	output 	reg	key_value//key抖动结束后的值
);
 
parameter MAX_NUM = 20'd1_000_000;
 
reg [19:0] delay_cnt;//1_000_000
 
reg key_reg;//key上一次的值
 
always @(posedge clk or negedge rstn) begin
	if(!rstn) begin
		key_reg <= 1;
		delay_cnt <= 0;
	end
	
	else begin
		key_reg <= key;
		//当key为1 key 为0 表示按下抖动,开始计时
		if(key_reg  != key  ) begin 
		   delay_cnt <= MAX_NUM ;
		end
		else begin
		    if(delay_cnt > 0)
				delay_cnt <= delay_cnt -1;
			else
				delay_cnt <= 0;
		end
	end
end
 
 
//当计时完成,获取key的值
always @(posedge clk or negedge rstn) begin
	if(!rstn) begin
		flag <= 0;
		key_value <= 1;
	end
 
	else begin
		
		// 计时完成 处于稳定状态,进行赋值
		if(delay_cnt == 1) begin
			flag <= 1;
			key_value <= key;
		end
		else begin
			flag <= 0;
			key_value <= key_value;
		end
	end
end
 
endmodule