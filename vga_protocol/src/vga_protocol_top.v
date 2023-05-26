module vga_protocol_top(
 input   wire          clk           , //VGA时钟，640*480 60hz 25.2MHz
 input   wire          rst_n         , //复位
 output  wire          v_sync        , //场同步信号
 output  wire          h_sync        , //行同步信号
 output  wire   [7:0]  vga_r         , //红色输出
 output  wire          disp_vld       , //是否是显示的时候
 output  wire   [7:0]  vga_g         , //绿色输出
 output  wire   [7:0]  vga_b         , //蓝色输出
 output  wire          vga_clk         //显示时钟,
);

wire  [23:0] data_display;
wire  [10:0] h_addr      ;
wire  [10:0] v_addr      ;
counter25M u_counter25M(
    .clk      ( clk      ),
    .rst_n    ( rst_n    ),
    .clk_25M  ( clk_25M  )
);

vga_contro u_vga_contro(
    .clk           ( clk_25M       ),
    .rst_n         ( rst_n         ),
    .data_display  ( data_display  ),
    .h_addr        ( h_addr        ),
    .v_addr        ( v_addr        ),
    .disp_vld      (disp_vld       ),
    .v_sync        ( v_sync        ),
    .h_sync        ( h_sync        ),
    .vga_r         ( vga_r         ),
    .vga_g         ( vga_g         ),
    .vga_b         ( vga_b         ),
    .vga_clk       ( vga_clk       )
);


data_generate u_data_generate(
    .clk     ( clk_25M ),
    .rst_n   ( rst_n   ),
    .h_addr  ( h_addr  ),
    .v_addr  ( v_addr  ),
    .data_display  ( data_display  )
);

endmodule