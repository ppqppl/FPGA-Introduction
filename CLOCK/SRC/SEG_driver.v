module SEG_driver#(parameter TIME_SCAN = 50_000 )(  //数码管驱动
    input               clk     ,
    input               rst_n   ,
    input       [16:0]  din     ,

    output reg  [5:0]   sel     , //片选
    output reg  [7:0]   dig       //段选     
);

    // parameter TIME_SCAN = 50_000 ; // 1MS 让片选一直扫描的移动

    parameter   ZER = 7'b100_0000,  // 0亮 1灭
                ONE = 7'b111_1001,
                TWO = 7'b010_0100,
                THR = 7'b011_0000,
                FOR = 7'b001_1001,
                FIV = 7'b001_0010,
                SIX = 7'b000_0010,
                SEV = 7'b111_1000,
                EIG = 7'b000_0000,
                NIN = 7'b001_0000;

    reg    [15:0]   cnt_scan    ; //扫描计数器
    wire            add_cnt_scan;
    wire            end_cnt_scan;

    reg    [3:0]    data        ; //寄存器 缓存数据
    reg             dot         ; //小数点

    wire   [3:0]    sec_l       ;  //秒低位
    wire   [3:0]    sec_h       ;  //秒 高位
    wire   [3:0]    min_l       ;  // 分地位
    wire   [3:0]    min_h       ;  //分高位
    wire   [3:0]    hou_l       ; 
    wire   [3:0]    hou_h       ;

    assign  sec_l = din[5:0]   % 10 ;  // 59 % 10 = 9 
    assign  sec_h = din[5:0]   / 10 ;  // 59 / 10 = 5 
    assign  min_l = din[11:6]  % 10 ;
    assign  min_h = din[11:6]  / 10 ;
    assign  hou_l = din[16:12] % 10 ;
    assign  hou_h = din[16:12] / 10 ;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_scan <= 16'b0;
        end
        else if(add_cnt_scan)begin
            if(end_cnt_scan)begin
                cnt_scan <= 16'b0;
            end
            else begin
                cnt_scan <= cnt_scan + 1'b1;
            end
        end
        else begin
            cnt_scan <= cnt_scan ;
        end
    end

    assign add_cnt_scan = 1'b1;
    assign end_cnt_scan = add_cnt_scan && cnt_scan == TIME_SCAN - 1;

    always @(posedge clk or negedge rst_n)begin   // 片选
        if(!rst_n)begin
            sel <= 6'b011_111;
        end
        else if(end_cnt_scan)begin
            sel <= {sel[0],sel[5:1]};//循环向右移动  
        end
        else begin
            sel <= sel;
        end
    end 

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            data <= 3'b0;
            dot  <= 1'b1;
        end
        else begin
            case(sel)
                6'b011_111 : begin data <= sec_l; dot <= 1'b1; end
                6'b101_111 : begin data <= sec_h; dot <= 1'b1; end
                6'b110_111 : begin data <= min_l; dot <= 1'b0; end
                6'b111_011 : begin data <= min_h; dot <= 1'b1; end
                6'b111_101 : begin data <= hou_l; dot <= 1'b0; end
                6'b111_110 : begin data <= hou_h; dot <= 1'b1; end
                default : begin data <= 3'b0; dot <= 1'b1;end
            endcase
        end
    end
    
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            dig <= 8'b0;
        end
        else begin
            case(data)
                0 : dig <= {dot,ZER};
                1 : dig <= {dot,ONE};
                2 : dig <= {dot,TWO};
                3 : dig <= {dot,THR};
                4 : dig <= {dot,FOR};
                5 : dig <= {dot,FIV};
                6 : dig <= {dot,SIX};
                7 : dig <= {dot,SEV};
                8 : dig <= {dot,EIG};
                9 : dig <= {dot,NIN};
                default : dig <= 8'b0;
            endcase
        end
    end



endmodule