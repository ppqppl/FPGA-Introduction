module echo_driver (
    input   wire        clk         ,
    input   wire        rstn        ,
    input   wire        echo        ,

    output  wire [18:0] data_o      
);

    localparam MAX_510cm   =   11'd1199   ;

    reg     [10:0]  cnt_510cm     ;
    reg             echo_r1       ;
    reg             echo_r2       ;
    wire            posedge_echo  ;
    wire            negedge_echo  ;
    reg     [18:0]  data_r        ;

    // echo 发送后开始计时，接收距离信息
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_510cm <= 11'd0;
        end
        else if(echo) begin // echo 信号发送后开始计时
            if(cnt_510cm < MAX_510cm) begin
                cnt_510cm <= cnt_510cm + 1'b1;
            end
            else begin
                cnt_510cm <= cnt_510cm;
            end
        end
        else begin
           cnt_510cm <= 11'd0;
        end
    end

    // 边沿检测

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            echo_r1 <= 1'b0;
            echo_r2 <= 1'b0;
        end
        else begin
            echo_r1 <= echo;
            echo_r2 <= echo_r1;
        end
    end

    assign posedge_echo = echo_r1 & ~echo_r2;
    assign negedge_echo = ~echo_r1 & echo_r2;

    // 数据处理
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            data_r <= 19'd0;
        end
        else if(negedge_echo) begin
            data_r <= (cnt_510cm << 4) + cnt_510cm;
        end
        else begin
            data_r <= data_r;
        end
    end

endmodule //echo_driver