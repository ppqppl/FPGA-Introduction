//数据生成
 module data_gen(
     input                 clk     ,//时钟信号
     input                 rst_n   ,//复位信号
   
     input       [10:0]    h_addr  ,//数据有效显示区域行地址
     input       [10:0]    v_addr  ,//数据有效显示区域场地址

     output  reg [23:0]    data_dis //需要显示的信号 
 );         
 //参数定义
  parameter  BLACK    = 24'h000000,
             RED      = 24'hFF0000,
             GREEN    = 24'h00FF00,
             BLUE     = 24'h0000FF,
             YELLOW   = 24'hFFFF00,
             SKY_BLUE = 24'h00FFFF,
             PURPLE   = 24'hFF00FF,
             GRAY     = 24'hC0C0C0,
             WHITE    = 24'hFFFFFF;

 //赋值
  always@(posedge clk or negedge rst_n)begin
     if(!rst_n)begin
        data_dis <= BLACK;
     end
     else begin
        case(h_addr)
           0      : data_dis <= BLUE    ;
           80     : data_dis <= RED      ;
           160    : data_dis <= GREEN    ;
           240    : data_dis <= BLUE     ;
           320    : data_dis <= YELLOW   ;
           400    : data_dis <= SKY_BLUE ;
           480    : data_dis <= PURPLE   ;
           560    : data_dis <= GRAY     ;
           default: data_dis <= data_dis ;
        endcase
     end
  end
 
 endmodule
