module VGA (input			wire						clk,
                input			wire						rst_n,
                input			wire		[ 2:0 ]		    key,
                output			wire						vga_clk,
                output			wire						h_sync,
                output			wire						v_sync,
                output			wire		[ 4:0 ]			rgb_r,
                output			wire		[ 5:0 ]			rgb_g,
                output			wire		[ 4:0 ]			rgb_b,
                output			reg		    [ 3:0 ]			led);

reg			[ 27:0 ]			cnt			        ;
wire		[ 11:0 ]		    addr_h              ;
wire		[ 11:0 ]		    addr_v              ;
wire		[ 15:0 ]			rgb_data			;
wire		[ 2:0 ]			    key_flag			;
wire		[ 2:0 ]			    key_value			;

//vga模块
vga_dirve u_vga_dirve(
.clk      ( clk ),
.rst_n    ( rst_n ),
.rgb_data ( rgb_data ),
.vga_clk  ( vga_clk ),
.h_sync   ( h_sync ),
.v_sync   ( v_sync ),
.rgb_r    ( rgb_r ),
.rgb_g    ( rgb_g ),
.rgb_b    ( rgb_b ),
.addr_h   ( addr_h ),
.addr_v   ( addr_v )
);

//数据模块
data_drive u_data_drive(
.vga_clk ( vga_clk ),
.rst_n   ( rst_n ),
.addr_h  ( addr_h ),
.addr_v  ( addr_v ),
.key     ( {key_value[ 2 ] && key_flag[ 2 ], key_value[ 1 ] && key_flag[ 1 ], key_value[ 0 ] && key_flag[ 0 ] } ),
.rgb_data  ( rgb_data )
);


//按键消抖
key_debounce u_key_debounce0(
.clk   ( vga_clk ),
.rst_n ( rst_n ),
.key   ( key[ 0 ] ),
.flag  ( key_flag[ 0 ] ),
.key_value  ( key_value[ 0 ] )
);

key_debounce u_key_debounce1(
.clk   ( vga_clk ),
.rst_n ( rst_n ),
.key   ( key[ 1 ] ),
.flag  ( key_flag[ 1 ] ),
.key_value  ( key_value[ 1 ] )
);

key_debounce u_key_debounce2(
.clk   ( vga_clk ),
.rst_n ( rst_n ),
.key   ( key[ 2 ] ),
.flag  ( key_flag[ 2 ] ),
.key_value  ( key_value[ 2 ] )
);

// led
always @( posedge clk or negedge rst_n ) begin
    if ( !rst_n ) begin
        cnt <= 0;
    end
    else if ( cnt == 50_000_000 - 1 ) begin
        cnt <= 0;
    end
    else begin
        cnt <= cnt + 1;
    end
end
always @( posedge clk or negedge rst_n ) begin
    if ( !rst_n ) begin
        led <= 4'b0000;
    end
    else if ( cnt == 50_000_000 -1 )begin
        led <= ~led;
    end
    else begin
        led <= led;
    end
end
endmodule // vga_top

