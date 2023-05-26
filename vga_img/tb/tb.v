`timescale 1ps/1ps
  module vga_top_tb(); 
     reg            clk     ;//时钟信号
     reg            rst_n   ;//复位信号
     
     wire           hsync   ;//
     wire           vsync   ;// 
     wire           sync    ;
     wire   [7:0]   vga_r   ;//三通道,红色
     wire   [7:0]   vga_g   ;//三通道,绿色
     wire   [7:0]   vga_b   ;//三通道,蓝色 
     wire           vga_blk ;//复合空白信号控制信号,VGA消隐信号显示数据时为1电产,其他时候为低电平
     wire           vga_clk ;//显示器显示时钟
  
 //参数定义
  parameter CYCLE = 40;

  always #(CYCLE/2) clk = ~ clk;
 //例化
   vga_top vga_top(
     .clk           (clk     ),//时钟信号
     .rst_n         (rst_n   ),//复位信号

     .hsync         (hsync   ),//
     .vsync         (vsync   ),// 
     .sync          (sync    ) ,
     .vga_r         (vga_r   ),//三通道,红色
     .vga_g         (vga_g   ),//三通道,绿色
     .vga_b         (vga_b   ),//三通道,蓝色 
     .vga_blk       (vga_blk ),//复合空白信号控制信号,VGA消隐信号显示数据时为1电产,其他时候为低电平
     .vga_clk       (vga_clk )//显示器显示时钟
    ); 

 //ASCII 显示颜色字母
    reg  [63:0]   CHAR_CLO;//1位ASCII码需要8bit显示
 //参数定义
    parameter    BLACK    = 24'h000000,
                 RED      = 24'hFF0000,
                 GREEN    = 24'h00FF00,
                 BLUE     = 24'h0000FF,
                 YELLOW   = 24'hFFFF00,
                 SKY_BLUE = 24'h00FFFF,
                 PURPLE   = 24'hFF00FF,
                 GRAY     = 24'hC0C0C0,
                 WHITE    = 24'hFFFFFF;

    always@(*)begin
       case(vga_top.data_dis)
            BLACK    :CHAR_CLO = "BLACK"   ;
            RED      :CHAR_CLO = "RED"     ;
            GREEN    :CHAR_CLO = "GREEN"   ;
            BLUE     :CHAR_CLO = "BLUE"    ;
            YELLOW   :CHAR_CLO = "YELLOW"  ;
            SKY_BLUE :CHAR_CLO = "SKY_BLUE";
            PURPLE   :CHAR_CLO = "PURPLE"  ;
            GRAY     :CHAR_CLO = "GRAY"    ;
            WHITE    :CHAR_CLO = "WHITE"   ; 
            default  :CHAR_CLO = "WHITE"   ;
       endcase
    end
 //初始化
  initial begin
      clk = 1'b1;
      rst_n = 1'b0;
      #(CYCLE * 20 +3);
      rst_n = 1'b1;
      #(CYCLE * 20);
      repeat(2)begin
        @(negedge vsync);
      end
      #1000;
      $stop;

  end

  endmodule
