module seg_driver(  
	input	wire		clk		,  //50MHz
	input	wire		rst_n	,  //low valid
	
	input	wire [18:0]	data_in	, //待显示数据
	
	output	reg	[6:0]	hex1	, // -共阳极，低电平有效
	output	reg [6:0]	hex2	, // -
    output	reg [6:0]	hex3	, // -
    output	reg [6:0]	hex4	, //连接符
    output	reg [6:0]	hex5	, //cm - 
    output	reg [6:0]	hex6	, //cm - 
    output	reg [6:0]	hex7	, //cm - 
    output	reg [6:0]	hex8	  //熄灭
);								  
 	//parameter define  
	localparam	NUM_0	=	8'b1100_0000,	
				NUM_1 	= 	8'b1111_1001,
				NUM_2   = 	8'b1010_0100,
				NUM_3   = 	8'b1011_0000,
				NUM_4   = 	8'b1001_1001,
				NUM_5   = 	8'b1001_0010,
				NUM_6   = 	8'b1000_0010,
				NUM_7   = 	8'b1111_1000,
				NUM_8   = 	8'b1000_0000,
				NUM_9   = 	8'b1001_0000,
				NUM_A   = 	8'b1000_1000,
				NUM_B   = 	8'b1000_0011,
				NUM_C   = 	8'b1100_0110,
				NUM_D   = 	8'b1010_0001,
				NUM_E   = 	8'b1000_0110,
				NUM_F   = 	8'b1000_1110,
				ALL_LIGHT = 8'b0000_0000,
				LIT_OUT = 	8'b1111_1111;
 	//reg 、wire define		
	reg		[3:0]	cm_hund	;//100cm
	reg		[3:0]	cm_ten	;//10cm
	reg		[3:0]	cm_unit	;//1cm
	reg		[3:0]	point_1	;//1mm
	reg		[3:0]	point_2	;//0.1mm
	reg		[3:0]	point_3	;//0.01mm
	
	always @(posedge clk or negedge rst_n)begin  
		if(!rst_n)begin  
			cm_hund	<= 'd0;
			cm_ten	<= 'd0;
			cm_unit	<= 'd0;
			point_1	<= 'd0;
			point_2	<= 'd0;
			point_3	<= 'd0;
		end  
		else begin  
			cm_hund <= data_in / 10 ** 5;
			cm_ten	<= data_in / 10 ** 4 % 10;
			cm_unit <= data_in / 10 ** 3 % 10;
			point_1 <= data_in / 10 ** 2 % 10;
			point_2 <= data_in / 10 ** 1 % 10;
			point_3 <= data_in / 10 ** 0 % 10;
		end  
	end 
	
	always @(posedge clk or negedge rst_n)begin  
		if(!rst_n)begin  
			hex1 <= ALL_LIGHT;
			hex2 <= ALL_LIGHT;
			hex3 <= ALL_LIGHT;
			hex4 <= ALL_LIGHT;
			hex5 <= ALL_LIGHT;
			hex6 <= ALL_LIGHT;
			hex7 <= ALL_LIGHT;
			hex8 <= ALL_LIGHT;
		end  
		else begin  
			hex1 <= hex_data(point_3);
			hex2 <= hex_data(point_2);
			hex3 <= hex_data(point_1);
			hex4 <= 7'b011_1111;
			hex5 <= hex_data(cm_unit);
			hex6 <= hex_data(cm_ten);
			hex7 <= hex_data(cm_hund);
			hex8 <= LIT_OUT;
		end  
	end //always end
	
	function  [6:0]	hex_data; //函数不含时序逻辑相关
		input   [03:00]	data_i;//至少一个输入
		begin
			case(data_i)
				'd0:hex_data = NUM_0;
				'd1:hex_data = NUM_1;
				'd2:hex_data = NUM_2;
				'd3:hex_data = NUM_3;
				'd4:hex_data = NUM_4;
				'd5:hex_data = NUM_5;
				'd6:hex_data = NUM_6;
				'd7:hex_data = NUM_7;
				'd8:hex_data = NUM_8;
				'd9:hex_data = NUM_9;
				default:hex_data = ALL_LIGHT;
			endcase	
		end 
	endfunction
	
endmodule  