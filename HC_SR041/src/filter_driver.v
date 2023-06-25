module filter_driver(
	input   wire                clk         ,
    input   wire                rstn        ,
    input   wire    [18: 0]     data_in  	,

	output  wire				flag_out	, 
	output  reg     [18: 0]     data_out
);
	
	localparam Time		=	21'd1250_0000	;	// 250ms

	wire 				flag_in				;

	reg		[21: 0]		data		[4:0]	;
	reg 	[3 : 0]		num					;
	reg 	[18: 0]		data1  				;
	reg 	[18: 0]		data0  				;
	reg 	[20: 0]		cnt_time			;
	reg 	[22: 0]		data_add			;

	always @(posedge clk or negedge rstn) begin
		if(!rstn) begin
			cnt_time <= 0;
		end
		else if(cnt_time == Time - 1'd1) begin
			cnt_time <= 0;
		end
		else begin
			cnt_time <= cnt_time + 1'd1;
		end
	end

	// 14641 高斯滤波
	always@(posedge clk or negedge rstn)begin
		if(!rstn) begin
			data_add <= 1'b0;
		end
		else if(num == 4'd5)begin
			data_add = data[0] * 1 + data[1] * 4 + data[2] * 6 + data[3] * 4 + data[4] * 1;
			data_out = data_add / 16;
		end
	end

	always @(posedge clk or negedge rstn) begin
		if(!rstn) begin
			num <= 4'd0;
		end
		else if(num == 4'd5) begin
			num <= 4'd5;
		end
		else if(flag_in && num < 4'd5) begin
			num <= num + 4'd1;
		end
		else begin
			num <= num;
		end
	end

	// 数据存储
	always @(posedge clk or negedge rstn) begin
		if(!rstn) begin
			data1 <= 0;
			data0 <= 0;
		end
		//250 ms 接收一次数据
		else if(flag_in) begin
			data0 <= data1;
			data1 <= data_in;
			data[1] <= data[0]	;
			data[2] <= data[1]	;
			data[3] <= data[2]	;
			data[4] <= data[3]	;
			data[0] <= data_in	;
		end
	end
	
	assign flag_in = cnt_time == Time - 1'b1;

endmodule