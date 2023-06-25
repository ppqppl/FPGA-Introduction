// 100 50 20 10 0
module led_driver (
    input   wire                clk         ,
    input   wire                rstn        ,
	input	wire    [18: 0]	    data_in	    , //待显示数据

    output  reg     [4 : 0]     led         
);

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
			point_3 <= data_in / 10 % 10     ;
		end  
	end

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            led <= 5'b00000;
        end
        else if(cm_hund >= 1)
            led <= 5'b11111;
        else if(cm_ten >= 5)
            led <= 5'b01111;
        else if(cm_ten >= 1)
            led <= 5'b00111;
        else if(cm_unit >= 5)
            led <= 5'b00011;
        else if(cm_unit >= 2)
            led <= 5'b00001;
        else 
            led <= 5'b00000;
    end

endmodule //led_driver