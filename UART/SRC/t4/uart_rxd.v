module uart_rxd(
	clk,
	rst_n,
	bps_set,
	rxd,
	data_byte,
	rxd_finish_pos,
	uart_state
    );
	input           clk       ;
	input           rst_n     ;
	input     [1:0] bps_set   ;
	input           rxd       ;
	output    [7:0] data_byte ;
	output          rxd_finish_pos;
	output          uart_state;
	
	
	reg       [7:0] data_byte ;
	reg             rxd_finish;//当接收完�?个byte的信号之后，rxd_finish�?1
	reg             uart_state;
	parameter       BPS_4800    =16'd648,
                    BPS_9600    =16'd325,
					BPS_19200   =16'd160 ,
                    BPS_115200  =16'd26 ;
	
	//消除亚稳�?
	reg rxd_s0,rxd_s1;  //同步寄存�?
	always@(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			rxd_s0<=1'b0;
			rxd_s1<=1'b0;
		end
		else begin
			rxd_s0<=rxd;
			rxd_s1<=rxd_s0;
		end
	end
	reg rxd_temp0,rxd_temp1;//数据寄存�?
	always@(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			rxd_temp0<=1'b0;
			rxd_temp1<=1'b0;
		end
		else begin
			rxd_temp0<=rxd_s1;
			rxd_temp1<=rxd_temp0;
		end
	end
	
	wire rxd_negedge =~rxd_temp0&rxd_temp1;
	
	reg [15:0] div_cnt;
	reg [15:0] time_div;
	//波特率�?�择模块
	always@(*)begin
		if(rst_n==1'b0)begin
			time_div=BPS_19200;
		end
		else begin
			case(bps_set)
				2'b00: time_div = BPS_4800;
				2'b01: time_div = BPS_9600;
				2'b10: time_div = BPS_19200;
				2'b11: time_div = BPS_115200;
				default:time_div = BPS_9600;
			endcase
		end
	end
	//波特率计数模�?
	always@(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			div_cnt<=1'b0;
		end
		else if(uart_state==1'b1)begin
			if(div_cnt==time_div)begin
				div_cnt<=1'b0;
			end
			else begin
				div_cnt<=div_cnt+1'b1;
			end
		end
		else begin
			div_cnt<=1'b0;
		end
	end
	//波特率时钟模�?
	reg bps_clk;
	always@(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			bps_clk<=1'b0;
		end
		else if(div_cnt==time_div)begin
			bps_clk<=1'b1;
		end
		else begin
			bps_clk<=1'b0;
		end
	end
	//bps计数模块
	reg [7:0] bps_cnt;
	reg [2:0]Start,Stop;
	always@(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			bps_cnt<=8'd0;
		end
		else if(rxd_finish==1'b1||(bps_cnt==8'd12 && (Start>3'd3)))begin
			bps_cnt<=8'd0;
		end
		else if(bps_clk==1'b1)begin
			bps_cnt<=bps_cnt+1'b1;
		end
		else begin
			bps_cnt<=bps_cnt;
		end
	end
	always@(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			rxd_finish=1'b0;
		end
		else if(bps_cnt==8'd159)begin
			rxd_finish=1'b1;
		end
		else begin
			rxd_finish=1'b0;
		end
	end
	
	//数据缓冲区模�?
	reg [2:0] r_data_byte[7:0];
	//reg [2:0]Start,Stop;
	always@(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			Start<=3'd0;
			r_data_byte[0]<=3'd0;
			r_data_byte[1]<=3'd0;
			r_data_byte[2]<=3'd0;
			r_data_byte[3]<=3'd0;
			r_data_byte[4]<=3'd0;
			r_data_byte[5]<=3'd0;
			r_data_byte[6]<=3'd0;
			r_data_byte[7]<=3'd0;
			Stop<=3'd0;
		end
		else if(bps_clk==1'b1)begin
			if(bps_cnt==1'b0)begin
				Start<=3'd0;
				r_data_byte[0]<=3'd0;
				r_data_byte[1]<=3'd0;
				r_data_byte[2]<=3'd0;
				r_data_byte[3]<=3'd0;
				r_data_byte[4]<=3'd0;
				r_data_byte[5]<=3'd0;
				r_data_byte[6]<=3'd0;
				r_data_byte[7]<=3'd0;
				Stop<=3'd0;
			end
			if(16'd6<=bps_cnt&&bps_cnt<=16'd12)begin//每个bit采样8次，共占16个时�?
				Start<=Start+rxd_s1;
			end
			else if(16'd22<=bps_cnt&&bps_cnt<=16'd28)begin
				r_data_byte[0]<=r_data_byte[0]+rxd_s1;
			end
			else if(16'd38<=bps_cnt&&bps_cnt<=16'd44)begin
				r_data_byte[1]<=r_data_byte[1]+rxd_s1;
			end
			else if(16'd54<=bps_cnt&&bps_cnt<=16'd60)begin
				r_data_byte[2]<=r_data_byte[2]+rxd_s1;
			end
			else if(16'd70<=bps_cnt&&bps_cnt<=16'd76)begin
				r_data_byte[3]<=r_data_byte[3]+rxd_s1;
			end
			else if(16'd86<=bps_cnt&&bps_cnt<=16'd92)begin
				r_data_byte[4]<=r_data_byte[4]+rxd_s1;
			end
			else if(16'd102<=bps_cnt&&bps_cnt<=16'd108)begin
				r_data_byte[5]<=r_data_byte[5]+rxd_s1;
			end
			else if(16'd118<=bps_cnt&&bps_cnt<=16'd124)begin
				r_data_byte[6]<=r_data_byte[6]+rxd_s1;
			end
			else if(16'd134<=bps_cnt&&bps_cnt<=16'd140)begin
				r_data_byte[7]<=r_data_byte[7]+rxd_s1;
			end
			else if(16'd150<=bps_cnt&&bps_cnt<=16'd156)begin
				Stop<=Stop+rxd_s1;
			end
		end
		else;
	end
	
		always@(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			data_byte<=8'd0;
		end
		else if(bps_cnt==8'd159)begin
			data_byte[0]<=(r_data_byte[0]>3'd3)?1'b1:1'b0;
			data_byte[1]<=(r_data_byte[1]>3'd3)?1'b1:1'b0;
			data_byte[2]<=(r_data_byte[2]>3'd3)?1'b1:1'b0;
			data_byte[3]<=(r_data_byte[3]>3'd3)?1'b1:1'b0;
			data_byte[4]<=(r_data_byte[4]>3'd3)?1'b1:1'b0;
			data_byte[5]<=(r_data_byte[5]>3'd3)?1'b1:1'b0;
			data_byte[6]<=(r_data_byte[6]>3'd3)?1'b1:1'b0;
			data_byte[7]<=(r_data_byte[7]>3'd3)?1'b1:1'b0;
		end
		else begin
			data_byte<=data_byte;
		end
	end
	always@(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			uart_state<=1'b0;
		end
		else if(rxd_negedge==1'b1)begin
			uart_state<=1'b1;
		end
		else if(rxd_finish==1'b1||(bps_cnt==8'd12 && (Start>3'd3)))begin
			uart_state<=1'b0;
		end
		else begin
			uart_state<=uart_state;
		end
	end
 
 //因为rxd_finish会占用两个clk50的时钟上升沿，所以我决定做一个上升沿�?�?
 reg [1:0]rxd_finish_pos_r;
 //wire rxd_finish_pos;
 always@(posedge clk or negedge rst_n)
 if(rst_n==1'b0)
			rxd_finish_pos_r<=2'b00;
	else  rxd_finish_pos_r<={rxd_finish_pos_r[0],rxd_finish};
	
assign rxd_finish_pos=(~rxd_finish_pos_r[1])&rxd_finish_pos_r[0];
 
 
endmodule 