module data_generate(
 input   wire         clk             , //VGA时钟，640*480 60hz 25.2MHz
 input   wire         rst_n           , //复位

 input   wire  [10:0] h_addr           , //数据有效显示区域，行地址
 input   wire  [10:0] v_addr           , //数据有效显示区域，列地址
 output  reg  [23:0] data_display       //显示数据
);
wire [23:0] q_sig;//从ip核里取出的图片数据
reg  [15:0] address_sig;//取图片的地址
wire        pic_area;//是否在图片显示的区域
parameter PIC_WIDTH = 9'd200;//图片长
parameter PIC_HEIGH = 9'd200;//图片宽
parameter BALCK    = 24'h000000,
          RED      = 24'hFF0000,
          GREEN    = 24'h00FF00,
          BLUE     = 24'h0000FF,
          YELLOW   = 24'hFFFF00,
          SKY_BULE = 24'h00FFFF,
          PURPLE   = 24'hFF00FF,
          GRAY     = 24'hC0C0C0,
          WHITE    = 24'hFFFFFF;

//调用ip核，取数据
//存入的图片为512*512，640*480
rom	rom_inst (
	.address ( address_sig ),
	.clock ( clk ),
	.q ( q_sig )
	);

assign pic_area = h_addr <= PIC_WIDTH && v_addr <= PIC_HEIGH;
//位置变化
always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
      address_sig <= 16'd0;
     end else if ( address_sig == 40000 ) begin
      address_sig <= 16'd0;
     end else if ( pic_area ) begin//在显示区域里随着地址变化自动变换
      address_sig <= h_addr + v_addr * 200 ;
     end
     else begin //大于图片显示区域，将保持地址
      address_sig <= address_sig ;
     end
end


//状态输出
always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
        data_display <= WHITE   ; 
     end else begin
        case (pic_area)
            0   : data_display <=   RED           ;
            1   : data_display <=   q_sig         ;  
            default: data_display <= data_display ;
        endcase
     end
end

/* //状态输出
always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
        data_display <= WHITE   ; 
     end else begin
        case (h_addr)
            0   : data_display <=   BALCK         ;  
            80  : data_display <=   RED           ;
            160 : data_display <=   GREEN         ;  
            240 : data_display <=   BLUE          ; 
            320 : data_display <=   YELLOW        ;   
            400 : data_display <=   SKY_BULE      ;     
            480 : data_display <=   PURPLE        ;   
            560 : data_display <=   GRAY          ; 
            default: data_display <= data_display ;
        endcase
     end
end */

endmodule