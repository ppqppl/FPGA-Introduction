/***********************************************/

//Project Name : Data_acquisition
//Email		   :
//Create Time	: 2021/01/09 13:36
//Editor       : Liu
//Version		: Rev1.0.0

/***********************************************/

module data_acq (
	input clk           				,
	input rdfifoclk			  		,
	input rst_n         				,
	input [15: 0] datain				,
	output reg cnvst	  				,
	output wire adtx_en				,
	output wire filouten				,
	output wire data_trans       	,
	output wire [31: 0] trans_data

);


parameter T500NS=10'd24;

//reg define
reg [5: 0] i			  ; 

//wire define
wire acquire_en		  ;
wire [27:0] filter_out; 

//assign
assign   acquire_en = cnvst;
            
always @(posedge clk or negedge rst_n)begin
  if(!rst_n)begin 
		i		<=	6'd0;
		cnvst <= 1'b0;
	   end
  else if(i == T500NS)begin 
		i 		<= 6'd0;
		cnvst <= 1'b1;
		end
  else begin 
		i 		<= i + 1'b1;
		cnvst <= 1'b0;
		end
end

//fir带通滤波器
fir f1(
	.clk(clk),              
	.reset_n(rst_n),         
	.ast_sink_data(datain),        //滤波器输入数据
	.ast_sink_valid(acquire_en),   //滤波器输入数据有效
	.ast_sink_error(),                          
	.ast_source_data(filter_out),  //滤波器输出数据
   .ast_source_valid(filouten),   //滤波器输出使能                     
	.ast_source_error()         
);


fifo_pp fifo(
	.clk(filouten),
	.rdfifoclk(rdfifoclk),
	.rst_n(rst_n),
	.adtx_en(adtx_en),
	.data_in({4'h1,filter_out}),
	.wr_en(filouten),
	.rd_en(data_trans),
	.trans_data(trans_data)
);

//FIFO测试
//reg [19:0] test;
//always @(posedge filouten or negedge rst_n)begin
//	if(!rst_n)
//		test  <= 20'd0;
//	else 
//		test  <= test + 1'b1;
//end
endmodule
