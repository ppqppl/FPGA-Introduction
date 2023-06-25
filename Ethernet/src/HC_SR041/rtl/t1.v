 
// *******************************************************************************************************************
// ** 作者 ： 孤独的单刀                                                   			
// ** 邮箱 ： zachary_wu93@163.com
// ** 博客 ： https://blog.csdn.net/wuzhikaidetb 
// ** 日期 ： 2022/07/31	
// ** 功能 ： 1、基于FPGA的串口多字节发送模块；
//			  2、可设置一次发送的字节数、波特率BPS、主时钟CLK_FRE；
//			  3、UART协议设置为起始位1bit，数据位8bit，停止位1bit，无奇偶校验（不可在端口更改，只能更改发送驱动源码）；                                           									                                                                          			
//			  4、每发送1次多字节后拉高指示信号一个周期，指示一次多字节发送结束；
//			  5、数据发送顺序，先发送低字节、再发送高字节。如：发送16’h12_34，先发送单字节8'h34，再发送单字节8'h12。                                          									                                                                          			
// *******************************************************************************************************************	
 
module uart_bytes_tx
#(
	parameter	integer	BYTES 	 = 4			,				//发送字节数，单字节8bit
	parameter	integer	BPS		 = 9_600		,				//发送波特率
	parameter 	integer	CLK_FRE	 = 50_000_000					//输入时钟频率
)
(
//系统接口
	input 							sys_clk			,			//系统时钟
	input 							sys_rst_n		,			//系统复位，低电平有效
//用户接口	
	input	[(BYTES * 8 - 1):0] 	uart_bytes_data	,			//需要通过UART发送的多字节数据，在uart_bytes_en为高电平时有效
	input							uart_bytes_en	,			//发送有效，当其为高电平时，代表此时需要发送的数据有效
//UART发送	
	output							uart_bytes_done	,			//成功发送完所有字节数据后拉高1个时钟周期
	output 							uart_txd					//UART发送数据线tx
);
 
 
//对端口赋值
assign uart_bytes_done = uart_bytes_done_reg;
 
 
//当发送使能信号到达时,寄存待发送的多字节数据以免后续变化、丢失
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)
		uart_bytes_data_reg <= 0;
	else if(uart_bytes_en && ~work_en)							//要发送有效的数据，且并未处于发送状态
		uart_bytes_data_reg <= uart_bytes_data;					//寄存需要发送的数据			
	else if(uart_sing_done)										
		uart_bytes_data_reg <= uart_bytes_data_reg >> 8;		//发送完一个数据后，把多字节数据右移8bit
	else 
		uart_bytes_data_reg <= uart_bytes_data_reg;
end	
 
//当发送使能信号到达时,进入工作状态
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)
		work_en <= 1'b0;
	else if(uart_bytes_en && ~work_en)							//要发送有效的数据且未处于工作状态
		work_en <= 1'b1;										//进入发送状态			
	else if(uart_sing_done && byte_cnt == BYTES - 1)			//发送完了最后一个字节的数据
		work_en <= 1'b0;										//发送完毕，退出工作状态	
	else 		
		work_en <= work_en;		
end			
		
//在工作状态对发送的数据个数进行计数		
always @(posedge sys_clk or negedge sys_rst_n)begin		
	if(!sys_rst_n)		
		byte_cnt <= 0;		
	else if(work_en)begin										//处于发送状态则需要对发送的字节个数计数
		if(uart_sing_done && byte_cnt == BYTES - 1)				//计数到了最大值则清零
			byte_cnt <= 0;										
		else if(uart_sing_done)									//发送完一个单字节则计数器+1
			byte_cnt <= byte_cnt + 1'b1;						
		else		
			byte_cnt <= byte_cnt;			
	end		
	else														//不处于发送状态则清零
		byte_cnt <= 0;	
end
 
//打拍凑时序·~·
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)
		uart_sing_done_reg <= 0;
	else 
		uart_sing_done_reg <= uart_sing_done;	
end
	
//发送单个字节的数据
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)
		uart_sing_data <= 8'd0;
	else if(uart_bytes_en && ~work_en)						//进入工作状态后马上发送第一个数据
		uart_sing_data <= uart_bytes_data[7:0];				//发送最低字节
	else if(uart_sing_done_reg)								//发送完一个字节则发送另一个字节
		uart_sing_data <= uart_bytes_data_reg[7:0];			//先右移8bit，然后取低8bit
	else
		uart_sing_data <= uart_sing_data;					//保持稳定
end
//发送单个字节的数据使能
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)
		uart_sing_en <= 1'b0;
	else if(uart_bytes_en && ~work_en)						//进入工作状态后马上发送第一个数据
		uart_sing_en <= 1'b1;		
	else if(uart_sing_done_reg && work_en)					//发送完一个字节则发送另一个字节
		uart_sing_en <= 1'b1;		
	else		
		uart_sing_en <= 1'b0;								//其他时候则为0
end
//例化发送驱动模块
uart_tx #(
	.BPS			(BPS			),		
	.CLK_FRE		(CLK_FRE		)		
)	
uart_tx_inst(	
	.sys_clk		(sys_clk		),			
	.sys_rst_n		(sys_rst_n		),
	
	.uart_tx_data	(uart_sing_data	),			
	.uart_tx_en		(uart_sing_en	),
	.uart_tx_done	(uart_sing_done	),
	.uart_txd		(uart_txd		)	
);
endmodule 