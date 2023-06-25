module UART_driver (
    input   wire            clk         ,
    input   wire            rstn        ,
    input   wire    [18:0]  data_in     , 
    input   wire            UART_rx     ,

    output  wire            UART_tx     ,
	output  wire    [7:0]   data_out2   , 
	output  wire            tx_falg2    //传输信号    
);

    localparam   CLK_50MHz   =   26'd50000000    ;    // 时钟频率
    localparam   BAUD        =   17'd115200      ;    // 波特率

    reg     [7:0]   data    ;
    wire            flag    ;
    wire            tx_done ;   
	wire 			flag_0	;	// 未启动超声波
	wire            tx_falg;

    reg     [25:0]      cnt_clk         ;  
    reg     [3:0]       xcnt            ;
    reg     [71: 0]     data_out        ;   // 最终发送的数据

    reg		[3:0]	    cm_hund	        ;//100cm
	reg		[3:0]	    cm_ten	        ;//10cm
	reg		[3:0]	    cm_unit	        ;//1cm
	reg		[3:0]	    point_1	        ;//1mm
	reg		[3:0]	    point_2	        ;//0.1mm
	reg		[3:0]	    point_3	        ;//0.01mm

    localparam
		byte0  = "0",
		byte1  = "1",
		byte2  = "2",
		byte3  = "3",
		byte4  = "4",
		byte5  = "5",
		byte6  = "6",
		byte7  = "7",
		byte8  = "8",
		byte9  = "9",
		byte10 = "\n";


    always@(posedge clk or negedge rstn) begin
        if(!rstn)
            xcnt <= 0;
        else if(tx_done)
            xcnt <= xcnt + 1'd1;
        else if(xcnt == 10)
            xcnt <= 0;
    end
	// reg [23:0] count=26'd0;

//    always @(posedge clk or negedge rstn) begin
	//   if(!rstn) begin
    	//   count <= 24'd0;
	//   end
	//   else if(count >= 50000) begin	
		//   count <= 24'd0;
	//   end
	//   else begin
		//   count <= count + 24'd1;
	//   end
    // end


    // assign flag = (count >= 49990) ? 1'b1 : 1'b0;//50000/49990    50000/49996
	assign tx_falg2=(xcnt!=10)&&tx_falg;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_clk <= 0;
        end
        else if(flag) begin
            cnt_clk <= 0;
        end
        else begin
            cnt_clk = cnt_clk + 1;
        end
    end

   assign flag 	= cnt_clk == CLK_50MHz/11 - 1;	// 一秒钟发送所有数据
	assign flag_0	= cm_hund == 0 && cm_ten == 0 && cm_unit == 0 && point_1 == 0 && point_2 == 0 && point_3 == 0;

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
			cm_hund <= data_in % 10;
			cm_ten	<= data_in / 10 ** 1 % 10;
			cm_unit <= data_in / 10 ** 2 % 10;
			point_1 <= data_in / 10 ** 3 % 10;
			point_2 <= data_in / 10 ** 4 % 10;
			point_3 <= data_in / 10 ** 5 % 10;
		end  
	end 

    always @(*) begin
		case (xcnt)
			0    :    data = hex_data(point_3);
			1    :    data = hex_data(point_2);
			2    :    data = hex_data(point_1);
			3    :    data = "."              ;
			4    :    data = hex_data(cm_unit);
			5    :    data = hex_data(cm_ten) ;
			6    :    data = hex_data(cm_hund);
			7    :    data = "c"              ;
			8    :    data = "m"              ;
			9    :    data = "\n"             ;
			default:    data = 6'h30;
		endcase
	end

    // 函数，4位输入，7位输出，判断要输出的数字
    function  [7:0]	hex_data; //函数不含时序逻辑相关
		input   [03:00]	data_i;//至少一个输入
		begin
			case(data_i)
				4'd0:hex_data = 6'h30;
				4'd1:hex_data = 6'h31;
				4'd2:hex_data = 6'h32;
				4'd3:hex_data = 6'h33;
				4'd4:hex_data = 6'h34;
				4'd5:hex_data = 6'h35;
				4'd6:hex_data = 6'h36;
				4'd7:hex_data = 6'h37;
				4'd8:hex_data = 6'h38;
				4'd9:hex_data = 6'h39;
				default:hex_data = 6'h30;
			endcase	
		end 
	endfunction
	assign data_out2=data;
    UART_send
    #(
        .CLK         (CLK_50MHz ),// 时钟频率
        .BAUD        (BAUD      ) // 波特率
    )
    UART_send_init(
        .clk         (clk       ),
        .rstn        (rstn      ),   
        .data_in     (data      ),   // 需要发送的数据
        .flag_in     (flag      ),   // 数据接收标志位，既发送标志位

        .UART_tx     (UART_tx   ),   // 串口输出位         
        .tx_done     (tx_done   ),
		.tx_en		 (tx_falg )
		//.tx_falg     (tx_falg )  
    );



endmodule //UART