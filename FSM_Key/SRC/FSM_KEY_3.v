module FSM_Key#(parameter TIME_20MS = 1_000_000)(   // 定义一个延时
    input           clk     ,
    input           rst_n   ,
    input           key0_in  ,
    input           key1_in  ,
    input           key2_in  ,
    output  reg     key_out 
);
    
    parameter   IDLE            =   4'b0001,    // 状态机 参数定义 空闲 
                FILTER_DOWN     =   4'b0001,    // 按键按下
                HOLD_DOWN       =   4'b0001,    // 保持
                FILTER_UP       =   4'b0001;    // 按键释放

    wire            idle2filter_down        ;
    wire            filter_dowm2idle        ;   // 如果是抖动的话 会返回 IDLE
    wire            filter_down2hold_dowm   ;
    wire            hold_down2filter_up     ;
    wire            filter_up2idle          ;

    reg     [3:0]   state_c     ;    // 现态
    reg     [3:0]   state_n     ;    // 次态

    reg     [19:0]  cnt_20ms    ;
    wire            add_cnt_20ms;
    wire            end_cnt_20ms;

    reg             key0_r0     ;   // 按键1 同步
    reg             key0_r1     ;   // 打拍
    reg             key1_r0     ;   // 按键2 同步
    reg             key1_r1     ;   // 打拍
    reg             key2_r0     ;   // 按键3 同步
    reg             key2_r1     ;   // 打拍
    wire            nedge       ;   // 下降沿
    wire            podge       ;   // 上升沿

    // 第一段时序逻辑
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            state_c <= IDLE;
        end
        else begin
            state_c <= state_n;
        end
    end

    // 第二段状态机 组合逻辑 次态只在第二段状态机里面运用
    always @(*)begin
        case(state_c)
        IDLE : begin
            if(idle2filter_down)
                state_n = FILTER_DOWN;
            else
                state_n = state_c;
        end
        FILTER_DOWN : begin
            if(filter_dowm2idle)
                state_n = IDLE;
            else if(filter_down2hold_dowm)
                state_n = HOLD_DOWN;
            else
                state_n = state_c; 
        end
        HOLD_DOWN : begin
            if(hold_down2filter_up)
                state_n = FILTER_UP;
            else
                state_n = state_c; 
        end
        FILTER_UP : begin
            if(filter_up2idle)
                state_n = IDLE;
            else
                state_n = state_c; 
        end
        default : state_n = state_c;
        endcase
    end

    assign idle2dilter_down         = state_c == IDLE           && (nedge !=0)                  ;   // 出现了下降沿
    assign filter_dowm2idle         = state_c == FILTER_DOWN    && (podge !=0)                  ;   // 一个周期内（20ms）出现了上升沿 就证明是一个抖动 过滤掉
    assign filter_down2hold_dowm    = state_c == FILTER_DOWN    && (end_cnt_20ms && podge == 0) ;   // 20ms 计数完了 仍然没有出现上升沿 就认定这次为有效下降沿
    assign hold_down2filter_up      = state_c == HOLD_DOWN      && (podge !=0)                  ;   // 出现了上升沿
    assign filter_up2idle           = state_c == FILTER_UP      && (end_cnt_20ms)               ;   // 延时结束就进入空闲状态

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            key0_r0 <= 0;
            key0_r1 <= 0;
            key1_r0 <= 0;
            key1_r1 <= 0;
            key2_r0 <= 0;
            key2_r1 <= 0;
        end
        else begin
            if(key0_in != 0)begin
                key0_r0 = key0_in;
                key0_r1 <= key0_r0;
            end
            if(key1_in != 0)begin
                key1_r0 = key1_in;
                key1_r1 <= key1_r0;
            end
            if(key2_in != 0)begin
                key2_r0 = key2_in;
                key2_r1 <= key2_r0;
            end
        end
    end

    assign nedge = ~key0_r0 && key0_r1;
    assign podge = key0_r0 && ~key0_r1;

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
        else begin
            cnt_20ms <= cnt_20ms;
        end
    end

    assign add_cnt_20ms = state_c == FILTER_DOWN || state_c == FILTER_UP;
    assign end_cnt_20ms = add_cnt_20ms && (cnt_20ms == TIME_20MS-1 || podge);

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            key_out <= 0;
        end
        else if(filter_down2hold_dowm||filter_up2idle)begin
            key_out <= ~key0_r1;
        end
        else begin
            key_out <= key_out;
        end
    end

endmodule