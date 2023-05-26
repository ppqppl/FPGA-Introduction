module time_counter (
    input   wire            clk     ,
    input   wire            rstn    ,

    output  reg             flag_1s ,
    output  wire            flag_10us
);

    localparam  MAX_10us    =   9'd499         ;
    localparam  MAX_1s      =   26'd2499_9999  ;

    reg     [25:0]  cnt_1s      ;
    reg     [8:0]   cnt_10us    ;

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            flag_1s <= 1'b0;
            cnt_1s  <= 26'd0;
        end
        else if(cnt_1s == MAX_1s) begin
            flag_1s <= 1'b1;
            cnt_1s  <= 26'd0;
        end
        else begin
            flag_1s <= 1'b0;
            cnt_1s  <= cnt_1s + 1'b1;
        end
    end

    assign flag_10us = (cnt_10us >= 9'd500 && cnt_10us < 10'd999) ? 1'b1 : 1'b0;

endmodule //time_counter