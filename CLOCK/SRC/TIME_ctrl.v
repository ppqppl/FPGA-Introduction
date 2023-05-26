module  TIME_ctrl(
    input           clk     ,
    input           rst_n   ,
    output   [16:0] dout           
);
    parameter TIME_1S = 50_000_000 ;

    reg         [27:0]      cnt0        ;//一秒计数器
    wire                    add_cnt0    ;
    wire                    end_cnt0    ;

    reg         [5:0]       cnt_s       ;
    wire                    add_cnt_s   ;
    wire                    end_cnt_s   ;

    reg         [5:0]       cnt_m       ;
    wire                    add_cnt_m   ;
    wire                    end_cnt_m   ;

    reg         [4:0]       cnt_h       ;
    wire                    add_cnt_h   ;
    wire                    end_cnt_h   ;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt0 <= 0;
        end
        else if (add_cnt0)begin
            if(end_cnt0)begin
                cnt0 <= 0;
            end
            else begin
                cnt0 <= cnt0 + 1;
            end
        end
    end

    assign add_cnt0 = 1;
    assign end_cnt0 = add_cnt0 && cnt0 == TIME_1S -1 ;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_s <= 0;
        end
        else if (add_cnt_s)begin
            if(end_cnt_s)begin
                cnt_s <= 0;
            end
            else begin
                cnt_s <= cnt_s + 1;
            end
        end
    end
    assign add_cnt_s = end_cnt0;
    assign end_cnt_s= add_cnt_s && cnt_s ==60 -1 ;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_m <= 0;
        end
        else if (add_cnt_m)begin
            if(end_cnt_m)begin
                cnt_m <= 0;
            end
            else begin
                cnt_m <= cnt_m + 1;
            end
        end
    end

    assign add_cnt_m = end_cnt_s;
    assign end_cnt_m = add_cnt_m && cnt_m == 60 -1 ;
    
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_h <= 0;
        end
        else if (add_cnt_h)begin
            if(end_cnt_h)begin
                cnt_h <= 0;
            end
            else begin
                cnt_h <= cnt_h + 1;
            end
        end
    end
    assign add_cnt_h = end_cnt_m;
    assign end_cnt_h = add_cnt_h && cnt_h ==24 -1 ;

    assign dout = {cnt_h,cnt_m,cnt_s};

endmodule