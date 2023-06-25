module time_count (
    input   wire        clk     ,
    input   wire        rstn    ,

    output  reg         flag_1s   
);

    localparam MAX_1s   =   26'd4999_9999  ;   // 1s 的计数值为 50MHz * 1s

    reg [25 : 0]    cnt_1s  ;   // 1s 计数器

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_1s <= 26'd0;
            flag_1s <= 1'b0;
        end
        else if(cnt_1s == MAX_1s) begin
            cnt_1s <= 26'd0;
            flag_1s <= 1'b1;
        end
        else begin
            cnt_1s <= cnt_1s + 26'd1;
            flag_1s <= 1'b0;
        end
    end

endmodule //time_count