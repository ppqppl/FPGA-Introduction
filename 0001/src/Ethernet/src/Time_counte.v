module Time_counte (
    input   wire        clk         ,
    input   wire        rstn        ,

    output  wire        flag_1s     ,
    output  wire        flag_10us
);

    localparam TIME_1s      = 26'd4999_9999  ;
    localparam TIME_10us    = 10'd999      ;

    reg [25: 0]  cnt_1s         ;
    reg [9 : 0]   cnt_10us       ;

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_1s <= 0;
        end
        else if(cnt_1s == TIME_1s) begin
            cnt_1s <= 0;
        end
        else begin
            cnt_1s <= cnt_1s + 1;
        end
    end

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_10us <= 0;
        end
        else if(cnt_10us == TIME_10us) begin
            cnt_10us <= 0;
        end
        else begin
            cnt_10us <= cnt_10us + 1;
        end
    end

assign flag_1s = (cnt_1s == TIME_1s);
assign flag_10us = (cnt_10us == TIME_10us);

endmodule //Time_counte