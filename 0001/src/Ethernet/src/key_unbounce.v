module key_unbounce (
    input   wire            rstn        ,
    input   wire            clk         ,
    input   wire    [3:0]   key         ,
    input   wire            flag_20ms   , 

    output  wire    [3:0]   key_out     
);

    parameter   MAX_20ms    =   20'd100_0000    ;

    reg     [19:0]      cnt_20ms    ;
    reg     [3:0]       key_r0      ;
    reg     [3:0]       key_r1      ;
    reg     [3:0]       nedge       ;
    reg     [3:0]       key_r       ;

    reg                 start       ;

    // 20ms 倒计时计数器设计
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_20ms <= 20'd0;
        end
        else if(start) begin
            if(cnt_20ms == 1'd1)begin
                cnt_20ms <= MAX_20ms;
            end
            else begin
                cnt_20ms <= cnt_20ms - 1'd1; 
            end
        end
        else begin
            cnt_20ms <= cnt_20ms;
        end
    end

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            key_r0 <= 4'b1111;
            key_r1 <= 4'b1111;
        end
        else begin
            key_r0 <= key;  // 打一拍，同步时钟域，上升沿
            key_r1 <= key_r0;    // 打一拍，检测按键下降沿 
        end
    end

    // start 信号约束
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            start <= 1'b0;
        end
        else if(nedge) begin
            start <= 1'b1;
        end
        else if(cnt_20ms == 1'b1) begin
            start <= 1'b0;
        end
        else begin
            start <= start;
        end
    end
    // 约束 key_r 信号
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            key_r <= 4'b0000;
        end
        else if(cnt_20ms == 1'b1) begin
            key_r <= ~key_r0;
        end
        else begin
            key_r <= 4'b0000;
        end
    end

    assign key_out = key_r;

endmodule //key_unbounce