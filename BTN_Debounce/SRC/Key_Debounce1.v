module Key_Debounce1#(parameter TIME_20MS = 1_000_000)(   // 下降沿判断
    input           clk,
    input           rst_n,
    input           key_in,
    output  reg     key_out
);

    // parameter TIME_20MS = 1_000_000;

    reg     [19:0]      cnt_20ms    ;
    wire                add_cnt_20ms;
    wire                end_cnt_20ms;
    
    reg                 key_r0      ;   // 同步
    reg                 key_r1      ;   // 打拍
    wire                nedge       ;   // 下降沿
    // 1. 这是同一条线 只是延时一个时钟周期 2. 要检测 一定是在同一时刻下才能检测 3. 如果同一时刻下两个值不一样 就可以判断发生了变化 1->0 发生了下降沿
    wire                podge       ;   // 上升沿
    reg                 flag        ;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            flag <= 0;
        end
        else if(nedge)begin
            flag <= 1;
        end
        else begin
            flag <= flag;
        end
    end

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_20ms <= 0;
        end
        else if(add_cnt_20ms)begin
            if(end_cnt_20ms)begin
                cnt_20ms <= 0;
            end
            else begin
                cnt_20ms <= cnt_20ms + 1;
            end
        end
    end

    assign  add_cnt_20ms = flag;
    assign  end_cnt_20ms = add_cnt_20ms && cnt_20ms == TIME_20MS - 1;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n) begin
            key_r0 <= 0;
            key_r1 <= 0;
        end
        else begin
            key_r0 <= key_in;   // 同步
            key_r1 <= key_r0;   // 打拍
        end
    end 

    // assign nedge = key_r0 == 0 && key_r1 == 1;
    assign nedge = ~key_r0 && key_r1;   // 1 && 1 = 1 
    assign podge = key_r0 && ~key_r1;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n) begin
            key_out <= 0;
        end
        else if(end_cnt_20ms) begin
            key_out <= ~key_r1; // 1 的时候就是按键按下
        end
        else begin
            key_out <= key_out;
        end
    end


endmodule