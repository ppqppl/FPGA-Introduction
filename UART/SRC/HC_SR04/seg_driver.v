module seg_driver(  
	input	wire		clk		,  //50MHz
	input	wire		rst_n	,  //low valid
	
	input	wire [18:0]	data_in	, //待显示数据

    output  reg [7:0]   sel     ,	// 我这里是8位段选，可以换6位，但是要自己改代码
    output  reg [7:0]   seg     
);								  
 	//parameter define  
	localparam	NUM_0	=	7'b100_0000,	
				NUM_1 	= 	7'b111_1001,
				NUM_2   = 	7'b010_0100,
				NUM_3   = 	7'b011_0000,
				NUM_4   = 	7'b001_1001,
				NUM_5   = 	7'b001_0010,
				NUM_6   = 	7'b000_0010,
				NUM_7   = 	7'b111_1000,
				NUM_8   = 	7'b000_0000,
				NUM_9   = 	7'b001_0000,
				NUM_A   = 	7'b000_1000,
				NUM_B   = 	7'b000_0011,
				NUM_C   = 	7'b100_0110,
				NUM_D   = 	7'b010_0001,
				NUM_E   = 	7'b000_0110,
				NUM_F   = 	7'b000_1110,
				ALL_LIGHT = 7'b000_0000,
				LIT_OUT = 	7'b111_1111,
                LINE    =   7'b011_1111;

    localparam MAX_10us     =   10'd999     ;
 	//reg 、wire define		
	reg		[3:0]	cm_hund	    ;//100cm
	reg		[3:0]	cm_ten	    ;//10cm
	reg		[3:0]	cm_unit	    ;//1cm
	reg		[3:0]	point_1	    ;//1mm
	reg		[3:0]	point_2	    ;//0.1mm
	reg		[3:0]	point_3	    ;//0.01mm
    reg     [9:0]   cnt_10us    ;
    reg     [7:0]   num         ;// 段选输出判断
	
    // 数据处理，计算出每一位
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

    // 修改后   段选
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt_10us <= 10'd0;
		end
		else if(cnt_10us == MAX_10us) begin
			cnt_10us <= 10'd0;
		end
		else begin
			cnt_10us <= cnt_10us + 10'd1;
		end
	end

    // 数码管位移
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            sel <= 8'b1000_0000;
        end
        else if(cnt_10us == MAX_10us) begin
            sel <= {sel[0],sel[7:1]};
        end
        else begin
            sel <= sel;
        end
    end

    // 确定输出数字
    always @(*) begin
        case (sel)
			8'b0000_0001    :    num = num_data(point_3);
			8'b0000_0010    :    num = num_data(point_2);
			8'b0000_0100    :    num = num_data(point_1);
			8'b0000_1000    :    num = LINE;
			8'b0001_0000    :    num = num_data(cm_unit);
			8'b0010_0000    :    num = num_data(cm_ten);
			8'b0100_0000    :    num = num_data(cm_hund);
			8'b1000_0000    :    num = LIT_OUT;
            default         :    num = NUM_0;
        endcase
    end

    // 位选输出
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            seg <= LINE;
        end
        else begin
            case (num)
                NUM_0       :   seg[6:0] <= NUM_0    ;
                NUM_1       :   seg[6:0] <= NUM_1    ;
                NUM_2       :   seg[6:0] <= NUM_2    ;
                NUM_3       :   seg[6:0] <= NUM_3    ;
                NUM_4       :   seg[6:0] <= NUM_4    ;
                NUM_5       :   seg[6:0] <= NUM_5    ;
                NUM_6       :   seg[6:0] <= NUM_6    ;
                NUM_7       :   seg[6:0] <= NUM_7    ;
                NUM_8       :   seg[6:0] <= NUM_8    ;
                NUM_9       :   seg[6:0] <= NUM_9    ;
                LINE        :   seg[6:0] <= LINE     ;
                LIT_OUT     :   seg[6:0] <= LIT_OUT  ;
                ALL_LIGHT   :   seg[6:0] <= ALL_LIGHT;
            endcase
            if(sel == 8'b0001_0000) begin
                seg[7] <= 1'b0;
            end
            else begin
                seg[7] <= 1'b1;
            end
        end
    end

    // 函数，4位输入，7位输出，判断要输出的数字
    function  [6:0]	num_data; //函数不含时序逻辑相关
		input   [03:00]	data_i;//至少一个输入
		begin
			case(data_i)
				4'd0:num_data = NUM_0;
				4'd1:num_data = NUM_1;
				4'd2:num_data = NUM_2;
				4'd3:num_data = NUM_3;
				4'd4:num_data = NUM_4;
				4'd5:num_data = NUM_5;
				4'd6:num_data = NUM_6;
				4'd7:num_data = NUM_7;
				4'd8:num_data = NUM_8;
				4'd9:num_data = NUM_9;
				default:num_data = ALL_LIGHT;
			endcase	
		end 
	endfunction

endmodule  