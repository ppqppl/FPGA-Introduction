`define vga_640_480

`include "vga_para.v"

module VGA_Pic(
    input                 clk         ,//时钟信号 //25.2MHZ
    input                 rst_n       ,//复位信号
    output  reg           vsync       ,
    output  reg           hsync       ,
    output  reg           vga_clk     ,
    output  wire          vga_sync    ,
    output  wire          vga_blank   ,

    output  reg   [7 :0]  vga_r       ,
    output  reg   [7 :0]  vga_b       ,
    output  reg   [7 :0]  vga_g       
);

//参数定义
    parameter   H_SYNC_START = 1,
                H_SYNC_STOP  = `H_Sync_Time ,
                H_DATA_START = `H_Sync_Time + `H_Back_Porch + `H_Left_Border,
                H_DATA_STOP  = `H_Sync_Time + `H_Back_Porch + `H_Left_Border + `H_Data_Time,

                V_SYNC_START = 1,
                V_SYNC_STOP  = `V_Sync_Time,
                V_DATA_START = `V_Sync_Time + `V_Back_Porch + `V_Top_Border,
                V_DATA_STOP  = `V_Sync_Time + `V_Back_Porch + `V_Top_Border + `V_Data_Time;

//信号定义
    reg     [11:0]  cnt_h_addr  ;//行地址计数器
    wire            add_h_addr  ;
    wire            end_h_addr  ;

    reg     [11:0]  cnt_v_addr  ;//长地址计数器
    wire            add_v_addr  ;
    wire            end_v_addr  ;

    reg     [11:0]  address     ;
    wire    [23:0]  q           ;
    wire    [23:0]  data_disp   ;
    
    reg     [10:0]  h_addr      ;//数据有效显示区域行地址
    reg     [10:0]  v_addr      ;//数据有效显示区域场地址

    wire    flag_begin_h        ;
    wire    flag_begin_v        ;
    wire    flag_clear_address  ;
    wire    flag_enable_out2    ;

    assign vga_sync = 1'b0;
    assign vga_blank = ~((cnt_h_addr<H_DATA_START-1)||(cnt_v_addr<V_DATA_START-1));  //当行计数器小于行空白总长或场计数器小于场空白总长时，空白信号低电平

pll	pll_inst (
	.areset ( !rst_n ),
	.inclk0 ( clk    ),
	.c0     ( c0     ),//50MHZ
	.c1     ( c1     ) //25MHZ
	);

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            vga_clk <= clk;
        end
        else begin
            vga_clk <= c1;
        end
    end


    always@(posedge vga_clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_h_addr <= 12'd0;
        end
        else if(add_h_addr)begin
            if(end_h_addr)begin
                cnt_h_addr <= 12'd0;
            end
            else begin
                cnt_h_addr <= cnt_h_addr + 12'd1;
            end
        end
        else begin
            cnt_h_addr <= 12'd0;
        end
    end

    assign add_h_addr = 1'b1;
    assign end_h_addr = add_h_addr && cnt_h_addr == `H_Total_Time - 1;

    always@(posedge vga_clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_v_addr <= 12'd0;
        end
        else if(add_v_addr)begin
            if(end_v_addr)begin
                cnt_v_addr <= 12'd0;
            end
            else begin
                cnt_v_addr <= cnt_v_addr + 12'd1;
            end
        end
        else begin
            cnt_v_addr <= cnt_v_addr;
        end
    end

    assign add_v_addr = end_h_addr;
    assign end_v_addr = add_v_addr && cnt_v_addr == `V_Total_Time - 1;

    //行场同步信号
    always@(posedge vga_clk or negedge rst_n)begin
        if(!rst_n)begin
            hsync <= 1'b1;
        end
        else if(cnt_h_addr == H_SYNC_START - 1)begin
            hsync <= 1'b0;
        end
        else if(cnt_h_addr == H_SYNC_STOP - 1)begin
            hsync <= 1'b1;
        end
        else begin
            hsync <= hsync;
        end
    end

    always@(posedge vga_clk or negedge rst_n)begin
        if(!rst_n)begin
            vsync <= 1'b1;
        end
        else if(cnt_v_addr == V_SYNC_START - 1)begin
            vsync <= 1'b0;
        end
        else if(cnt_v_addr == V_SYNC_STOP - 1)begin
            vsync <= 1'b1;
        end
        else begin
            vsync <= vsync;
        end
    end

    //数据有效显示区域定义
    always@(posedge vga_clk or negedge rst_n)begin
        if(!rst_n)begin
            h_addr <= 11'd0;
        end
        else if((cnt_h_addr >= H_DATA_START - 1) &&( cnt_h_addr <= H_DATA_STOP - 1))begin
            h_addr <= cnt_h_addr - H_DATA_START - 1;
        end
         else if(address == 48*48 - 1) begin
            h_addr <= 11'd0;
        end
    end

    always@(posedge vga_clk or negedge rst_n)begin
        if(!rst_n)begin
            v_addr <= 11'd0;
        end
        else if((cnt_v_addr >= V_DATA_START - 1) && (cnt_v_addr <= V_DATA_STOP - 1))begin
            v_addr <= cnt_v_addr - V_DATA_START -1;
        end
        else if(address == 48*48 - 1) begin
            v_addr <= 11'd0;
        end
    end

    //显示数据
    always@(posedge vga_clk or negedge rst_n)begin
        if(!rst_n)begin
            vga_r <= 8'b0;
            vga_g <= 8'b0;
            vga_b <= 8'b0;
        end
        else if((cnt_h_addr >= H_DATA_START - 1) &&( cnt_h_addr <= H_DATA_STOP - 1) 
                && (cnt_v_addr >= V_DATA_START - 1) && (cnt_v_addr <= V_DATA_STOP - 1))begin
            vga_r <= data_disp[23:16];
            vga_g <= data_disp[15: 8];
            vga_b <= data_disp[7 : 0];
        end
        else begin
            vga_r <= 8'b0;
            vga_g <= 8'b0;
            vga_b <= 8'b0;
        end
    end

    assign data_disp = q;

//ROM地址计数器
always @( posedge vga_clk or negedge rst_n ) begin
    if ( !rst_n ) begin
        address <= 0;
    end
    else if ( flag_clear_address ) begin //计数满清零
        address <= 0;
    end
        else if ( flag_enable_out2 ) begin  //在有效区域内+1
        address <= address + 1;
        end
    else begin  //无效区域保持
        address <= address;
    end
end
assign flag_clear_address = address == 48 * 48 - 1;
assign flag_begin_h     = h_addr > ( ( 640 - 48 ) / 2 ) && h_addr < ( ( 640 - 48 ) / 2 ) + 48 + 1;
assign flag_begin_v     = v_addr > ( ( 480 - 48 )/2 ) && v_addr <( ( 480 - 48 )/2 ) + 48 + 1;
assign flag_enable_out2 = flag_begin_h && flag_begin_v;

rom	rom_inst (
	.address    ( address),
	.clock      ( vga_clk),
	.q          ( q      )
	);

endmodule
