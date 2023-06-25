module key_debounce(
    input clk,
    input rst_n,
    input key,

    output reg temp
);

parameter DELAY = 20'd1000_000;


reg [19:0] delay_cnt;
reg key_reg;//保存上一时刻的键值
reg flag,key_value;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        delay_cnt <= 20'd0;
        key_reg   <= 1'b1;
    end
    else begin
        key_reg <= key;
        if(key_reg != key)begin
            delay_cnt <= DELAY;
        end
        else begin
            if(delay_cnt > 20'd0)begin
                delay_cnt <= delay_cnt - 1'd1;
            end
            else begin
                delay_cnt <= 20'd0;
            end
        end
    end
end

always @(posedge clk or negedge rst_n) begin
   if(!rst_n)begin
    flag <= 1'b0;
    key_value <= 1'b1;
   end
   else if(delay_cnt == 1'd1)begin
    flag      <= 1'b1;
    key_value <= key;
   end
   else begin
    flag <= 1'b0;
    key_value <= key_value;
   end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
		temp <= 1'b0;
	end
	else begin
		if(flag&&~key_value)begin
			temp <= 1'b1;
		end
		else
			temp <= 1'b0;
	end
end	
endmodule 
