/*----------------------------------------------------------------------------------
Copyright(c) 2022-2022 
Project     :
FileName    :
Author      : zhaoxuesen
Email       : 137465153@qq.com
Description :
------------------------------------------------------------------------------------
Modification History:
DATE       By       Revision       Change Description
------------------------------------------------------------------------------------
2022-06-01    1.0     origin


------------------------------------------------------------------------------------
Warning:
Any bug or requrement , please report to the Author
-----------------------------------------------------------------------------------*/
`define vga_640_480
`include "vga_param.v"



module vga_contro(
 input   wire         clk            , //VGA时钟，640*480 60hz 25.2MHz
 input   wire         rst_n          , //复位
 input   wire  [23:0] data_display   , //显示数据

 output  reg   [10:0] h_addr         , //数据有效显示区域，行地址，只有当有效的时候，
 output  reg   [10:0] v_addr         , //数据有效显示区域，列地址
 output  reg           disp_vld      , //表示输入的是否是有效数据，即为显示区域内的数据
 output  wire          v_sync        , //场同步信号，有效数据的条件之一
 output  wire          h_sync        , //行同步信号，有效数据的条件之一，只有当行和场的同步信号都有效之后，后面输入的才是有效数据
 output  reg   [7:0]   vga_r         , //红色输出
 output  reg   [7:0]   vga_g         , //绿色输出
 output  reg   [7:0]   vga_b         , //蓝色输出
 output  wire          vga_clk         //显示时钟,
);
parameter H_SYNC_STA = 1;//行同步开始
parameter H_SYNC_END = `H_Sync_Time;//行同步结束
parameter H_DATA_STA = `H_Sync_Time+`H_Right_Border + `H_Front_Porch;//行数据开始
parameter H_DATA_END = `H_Sync_Time+`H_Right_Border + `H_Front_Porch + `H_Data_Time;//行数据结束

parameter V_SYNC_STA = 1;//场同步开始
parameter V_SYNC_END = `V_Sync_Time;//场同步结束
parameter V_DATA_STA = `V_Sync_Time +`V_Bottom_Border + `V_Front_Porch;//场数据开始
parameter V_DATA_END = `V_Sync_Time +`V_Bottom_Border + `V_Front_Porch+ `V_Data_Time;//场数据结束

reg [(12-1):0] cnt_h; //行地址的计数
wire add_cnt_h      ; //行地址开始标志
wire end_cnt_h      ; //行地址结束标志

reg [(12-1):0] cnt_v ; //场地址的计数
wire add_cnt_v       ; //场地址开始标志
wire end_cnt_v       ; //场地址结束标志



always @(posedge clk or negedge rst_n) begin
   if (!rst_n) begin                        
         cnt_h <= 12'b0;                 
   end else if(add_cnt_h) begin          
       if (end_cnt_h) begin              
           cnt_h <= 12'b0;               
       end else begin                       
           cnt_h <= cnt_h + 12'b1;     
       end                                  
   end                                      
end

assign add_cnt_h = 1'd1;
assign end_cnt_h = add_cnt_h && cnt_h == `H_Total_Time - 1;


always @(posedge clk or negedge rst_n) begin
   if (!rst_n) begin                        
         cnt_v <= 12'b0;                 
   end else if(add_cnt_v) begin          
       if (end_cnt_v) begin              
           cnt_v <= 12'b0;               
       end else begin                       
           cnt_v <= cnt_v + 12'b1;     
       end                                  
   end                                      
end

assign add_cnt_v = end_cnt_h;
assign end_cnt_v = add_cnt_v && cnt_v == `V_Total_Time - 1;


//同步信号
assign  h_sync = (cnt_h > ( H_SYNC_STA - 1) && cnt_h < (H_SYNC_END - 1) );
assign  v_sync = (cnt_v >= ( V_SYNC_STA - 1) && cnt_v <= (V_SYNC_END - 1) );

assign vga_clk = ~clk;


//定义有效显示区域
always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
        h_addr <=  11'd0; 
     end else if(cnt_h >= (H_DATA_STA - 1) && cnt_h <= (H_DATA_END - 1)) begin
        h_addr <=  cnt_h - (H_DATA_STA - 1);
     end else begin
        h_addr <=  11'd0;
     end
end

//定义有效显示区域
always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
        v_addr <=  11'd0; 
     end else if(cnt_v >= (V_DATA_STA - 1) && cnt_v <= (V_DATA_END - 1)) begin
        v_addr <=  cnt_v - (V_DATA_STA - 1);
     end else begin
        v_addr <=  11'd0;
     end
end


//有效区域输出
always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
        vga_r <= 8'd0  ;
        vga_g <= 8'd0  ;
        vga_b <= 8'd0  ; 
        disp_vld <= 1'b0;
        //数据有效时输出
     end else if(cnt_h >= (H_DATA_STA - 1) && cnt_h <= (H_DATA_END - 1) && cnt_v >= (V_DATA_STA - 1) && cnt_v <= (V_DATA_END - 1)) begin
        vga_r <= data_display[23-:8]  ;
        vga_g <= data_display[15-:8]  ;
        vga_b <= data_display[07-:8]  ; 
        disp_vld <= 1'b1 ;
     end else begin
        vga_r <= 8'd0 ;
        vga_r <= 8'd0 ;
        vga_r <= 8'd0 ; 
        disp_vld <= 1'b0 ;
     end
end


endmodule