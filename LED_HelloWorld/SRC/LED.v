module LED(
	input   wire            clk,//开发板晶振频率50MHz
	input   wire            rst_n,//复位下绛沿有效
	output  reg     [3:0]   led //led灯
);

    parameter TIME_IS = 50_000_000 ;

always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		cnt <= 26'd0;
	end
	else if(cnt == 56'd50_000_000-1)begin
		cnt <= 26'd0;
	end 
	else begin
		cnt <= cnt + 1'd1;
	end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        led <= 4'b0001;
    end
end
endmodule  
