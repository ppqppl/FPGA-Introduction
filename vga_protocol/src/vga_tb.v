`timescale 1ns/1ns
module vga_tb();
parameter CYCLE = 40;
reg           clk          ;
reg           rst_n        ;
wire          v_sync       ;
wire          h_sync       ;
wire   [7:0]  vga_r        ;
wire          disp_vld     ;
wire   [7:0]  vga_g        ;
wire   [7:0]  vga_b        ;
wire          vga_clk      ;


always #(CYCLE/2) clk = ~clk;  
initial begin
    clk = 1'b1;
    rst_n = 1'b1; 
    #CYCLE;
    rst_n = 1'b0;
    #CYCLE;
    rst_n = 1'b1;
    #(CYCLE*420_000);//一帧数据所需要的时间

end

vga_protocol_top u_vga_protocol_top(
    .clk       ( clk       ),
    .rst_n     ( rst_n     ),
    .v_sync    ( v_sync    ),
    .h_sync    ( h_sync    ),
    .vga_r     ( vga_r     ),
    .disp_vld  ( disp_vld  ),
    .vga_g     ( vga_g     ),
    .vga_b     ( vga_b     ),
    .vga_clk   ( vga_clk   )
);


endmodule