module counter25M(
  input   wire          clk           , //VGA时
  input   wire          rst_n         , //复位
  output  reg         clk_25M         
);

always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
         clk_25M <= 1'b0     ; 
     end else  begin
         clk_25M <=  ~clk_25M;
     end 
end
endmodule