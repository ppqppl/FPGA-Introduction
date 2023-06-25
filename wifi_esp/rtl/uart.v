module uart(
	input wire 	clk	,
	input wire 	rst_n	,
	input	[2:0]	key	,
	input wire 	rx_esp,
	output wire tx_esp,     //串行输出
	input wire 	rx_pc,
	output wire tx_pc     //串行输出	
	);

wire [7:0] rx_byte		;
wire       rx_byte_vld	;
wire [7:0] rx_byte1		;
wire       rx_byte_vld1	;
wire [2:0] temp			;
wire	   tx_AT	 	;
wire	   tx_data	 	;

reg		en;
assign tx_esp=en==1?tx_AT:tx_data;

always @(posedge clk or negedge rst_n)begin 
	if(!rst_n)begin
		en <= 0;
	end 
	else if(temp[0])begin 
		en <= ~en;
	end 
	else begin 
		en <= en;
	end 
end
key_debounce(
.clk(clk),
.rst_n(rst_n),
.key(key[0]),

.temp(temp[0])
);


key_debounce(
.clk(clk),
.rst_n(rst_n),
.key(key[1]),

.temp(temp[1])
);


key_debounce(
.clk(clk),
.rst_n(rst_n),
.key(key[2]),

.temp(temp[2])
);

uart_rx u_uart_rx(
.clk		(clk),
.rst_n	(rst_n),
.rx_din	(rx_pc),//串行数据输入
	
.rx_dout	(rx_byte),//并行数据输出
.dout_vld(rx_byte_vld)//串转并完成标志
);


uart_rx u_uart_rx1(
.clk		(clk),
.rst_n	(rst_n),
.rx_din	(rx_esp),//串行数据输入
	
.rx_dout	(rx_byte1),//并行数据输出
.dout_vld(rx_byte_vld1)//串转并完成标志
);


uart_tx u_uart_tx(
.clk	(clk),
.rst_n	(rst_n),
.tx_req(rx_byte_vld),//发送请求
.tx_din(rx_byte),//并行数据输入
	
.tx_dout(tx_AT)//串行数据输出
//.dout_vld()//并转串完成标志
	

);

date_send u_date_send(
.clk	(clk),
.rst_n	(rst_n),
.key	(temp[2:1]),	
.tx_dout(tx_data)//串行数据输出	

);

uart_tx u_uart_tx1(
.clk	(clk),
.rst_n	(rst_n),
.tx_req(rx_byte_vld1),//发送请求
.tx_din(rx_byte1),//并行数据输入
	
.tx_dout(tx_pc)//串行数据输出
//.dout_vld()//并转串完成标志
	

);
endmodule 
