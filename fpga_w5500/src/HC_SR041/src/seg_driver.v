module seg_driver(  
	input	wire		clk		,
	input	wire		rstn	,
	
	input	wire [18:0]	data_in	, //待显示数据

    output  reg [7:0]   sel     ,	// 我这里是8位段选，可以换6位，但是要自己改代码
    output  reg [7:0]   seg     
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
				LIT_OUT = 	8'b1111_1111,
                LINE    =   8'b1011_1111;

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

	always @(posedge clk or negedge rstn)begin  
		if(!rstn)begin  
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

	always @(posedge clk or negedge rstn) begin
		if(!rstn) begin
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
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
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
			8'b0000_0001    :    num = hex_data(point_3);
			8'b0000_0010    :    num = hex_data(point_2);
			8'b0000_0100    :    num = hex_data(point_1);
			8'b0000_1000    :    num = LINE;
			8'b0001_0000    :    num = hex_data(cm_unit);
			8'b0010_0000    :    num = hex_data(cm_ten);
			8'b0100_0000    :    num = hex_data(cm_hund);
			8'b1000_0000    :    num = LIT_OUT;
            default         :    num = NUM_0;
        endcase
    end

    // 位选输出
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            seg <= LINE;
        end
        else begin
            case (num)
                NUM_0       :   seg <= NUM_0    ;
                NUM_1       :   seg <= NUM_1    ;
                NUM_2       :   seg <= NUM_2    ;
                NUM_3       :   seg <= NUM_3    ;
                NUM_4       :   seg <= NUM_4    ;
                NUM_5       :   seg <= NUM_5    ;
                NUM_6       :   seg <= NUM_6    ;
                NUM_7       :   seg <= NUM_7    ;
                NUM_8       :   seg <= NUM_8    ;
                NUM_9       :   seg <= NUM_9    ;
                LINE        :   seg <= LINE     ;
                LIT_OUT     :   seg <= LIT_OUT  ;
                ALL_LIGHT   :   seg <= ALL_LIGHT;
            endcase
        end
    end

    // 函数，4位输入，7位输出，判断要输出的数字
    function  [7:0]	hex_data; //函数不含时序逻辑相关
		input   [03:00]	data_i;//至少一个输入
		begin
			case(data_i)
				4'd0:hex_data = NUM_0;
				4'd1:hex_data = NUM_1;
				4'd2:hex_data = NUM_2;
				4'd3:hex_data = NUM_3;
				4'd4:hex_data = NUM_4;
				4'd5:hex_data = NUM_5;
				4'd6:hex_data = NUM_6;
				4'd7:hex_data = NUM_7;
				4'd8:hex_data = NUM_8;
				4'd9:hex_data = NUM_9;
				default:hex_data = ALL_LIGHT;
			endcase	
		end 
	endfunction

endmodule  