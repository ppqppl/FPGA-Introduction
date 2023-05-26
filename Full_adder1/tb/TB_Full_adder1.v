`timescale 1ns/1ns
module TB_Full_adder1();    // 设置仿真引脚
    reg     tb_a       ;
    reg     tb_b       ;
    reg     tb_cin     ;
    wire    tb_sout    ;
    wire    tb_cout    ;    

    Full_adder1 u_Full_adder1(  // 绑定引脚，绑定仿真文件与源代码文件中对应的引脚
        .a      (tb_a)      ,
        .b      (tb_b)      ,
        .cin    (tb_cin)    ,
        .cout   (tb_cout)   ,
        .sum    (tb_sout)   
    );
    parameter CYCLE = 40;   // 设置周期
    always  # 5     tb_a    =   ~tb_a   ;   // 设置输入变量
    always  # 10    tb_b    =   ~tb_b   ;
    always  # 20    tb_cin  =   ~tb_cin ;

    initial begin       // 初始化变量
        tb_a        =       1'b0    ;
        tb_b        =       1'b0    ;
        tb_cin      =       1'b0    ;
        #(CYCLE * 4)                ;   // 设置到达指定周期停止
        $stop                       ;  
    end

endmodule