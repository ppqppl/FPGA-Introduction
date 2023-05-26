//顶层文件
 module VGA_Img( 
     input                  clk     ,//时钟信号
     input                  rst_n   ,//复位信号
     
     output  wire           hsync   ,//
     output  wire           vsync   ,// 
     output  wire           sync    ,
     output  wire [7:0]     vga_r   ,//三通道,红色
     output  wire [7:0]     vga_g   ,//三通道,绿色
     output  wire [7:0]     vga_b   ,//三通道,蓝色 
     output  wire           vga_blk ,
     output  wire           vga_clk 
     
   );           
     wire         [10:0]    h_addr  ;//数据有效显示区域行地址
     wire         [10:0]    v_addr  ;//数据有效显示区域场地址  
     wire         [23:0]    data_dis;
 //例化
  data_gen u_data_gen(
     .clk       (clk     ) ,//时钟信号
     .rst_n     (rst_n   ) ,//复位信号
     .h_addr    (h_addr  ) ,//数据有效显示区域行地址
     .v_addr    (v_addr  ) ,//数据有效显示区域场地址
     .data_dis  (data_dis) //需要显示的信号 
  );
 //例化
   vga_ctrl u_vga_ctrl(
     .clk       (clk     ) ,//时钟信号
     .rst_n     (rst_n   ) ,//复位信号
     .data_dis  (data_dis) ,//需要显示的信号
     .h_addr    (h_addr  ) ,//数据有效显示区域行地址
     .v_addr    (v_addr  ) ,//数据有效显示区域场地址
     .hsync     (hsync   ) ,//
     .vsync     (vsync   ) ,//
     .sync      (sync    ) ,
     .vga_r     (vga_r   ) ,//三通道,红色
     .vga_g     (vga_g   ) ,//三通道,绿色
     .vga_b     (vga_b   ) ,//三通道,蓝色
     .vga_blk   (vga_blk ) ,
     .vga_clk   (vga_clk )  //显示器显示时钟         
 );

 endmodule
