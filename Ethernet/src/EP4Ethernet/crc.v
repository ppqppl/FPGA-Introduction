module crc32_d4(
  input [7:0] datain,
  input crc_en,
  output [31:0] crc_data,
  input rst_n,
  input clk,
  input clk1,
  input crc_clr );

  reg [31:0] lfsr_q,lfsr_c;
  wire [7:0] data;
  assign crc_data = lfsr_q;
  assign data = {datain[0],datain[1],datain[2],datain[3],datain[4],datain[5],datain[6],datain[7]};
  always @(posedge clk or negedge rst_n) begin
    lfsr_c[0] = lfsr_q[24] ^ lfsr_q[30] ^ data[0] ^ data[6];
    lfsr_c[1] = lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[30] ^ lfsr_q[31] ^ data[0] ^ data[1] ^ data[6] ^ data[7];
    lfsr_c[2] = lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[30] ^ lfsr_q[31] ^ data[0] ^ data[1] ^ data[2] ^ data[6] ^ data[7];
    lfsr_c[3] = lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[31] ^ data[1] ^ data[2] ^ data[3] ^ data[7];
    lfsr_c[4] = lfsr_q[24] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[30] ^ data[0] ^ data[2] ^ data[3] ^ data[4] ^ data[6];
    lfsr_c[5] = lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ lfsr_q[31] ^ data[0] ^ data[1] ^ data[3] ^ data[4] ^ data[5] ^ data[6] ^ data[7];
    lfsr_c[6] = lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ lfsr_q[31] ^ data[1] ^ data[2] ^ data[4] ^ data[5] ^ data[6] ^ data[7];
    lfsr_c[7] = lfsr_q[24] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[29] ^ lfsr_q[31] ^ data[0] ^ data[2] ^ data[3] ^ data[5] ^ data[7];
    lfsr_c[8] = lfsr_q[0] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[27] ^ lfsr_q[28] ^ data[0] ^ data[1] ^ data[3] ^ data[4];
    lfsr_c[9] = lfsr_q[1] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[28] ^ lfsr_q[29] ^ data[1] ^ data[2] ^ data[4] ^ data[5];
    lfsr_c[10] = lfsr_q[2] ^ lfsr_q[24] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[29] ^ data[0] ^ data[2] ^ data[3] ^ data[5];
    lfsr_c[11] = lfsr_q[3] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[27] ^ lfsr_q[28] ^ data[0] ^ data[1] ^ data[3] ^ data[4];
    lfsr_c[12] = lfsr_q[4] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ data[0] ^ data[1] ^ data[2] ^ data[4] ^ data[5] ^ data[6];
    lfsr_c[13] = lfsr_q[5] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[29] ^ lfsr_q[30] ^ lfsr_q[31] ^ data[1] ^ data[2] ^ data[3] ^ data[5] ^ data[6] ^ data[7];
    lfsr_c[14] = lfsr_q[6] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[30] ^ lfsr_q[31] ^ data[2] ^ data[3] ^ data[4] ^ data[6] ^ data[7];
    lfsr_c[15] = lfsr_q[7] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[31] ^ data[3] ^ data[4] ^ data[5] ^ data[7];
    lfsr_c[16] = lfsr_q[8] ^ lfsr_q[24] ^ lfsr_q[28] ^ lfsr_q[29] ^ data[0] ^ data[4] ^ data[5];
    lfsr_c[17] = lfsr_q[9] ^ lfsr_q[25] ^ lfsr_q[29] ^ lfsr_q[30] ^ data[1] ^ data[5] ^ data[6];
    lfsr_c[18] = lfsr_q[10] ^ lfsr_q[26] ^ lfsr_q[30] ^ lfsr_q[31] ^ data[2] ^ data[6] ^ data[7];
    lfsr_c[19] = lfsr_q[11] ^ lfsr_q[27] ^ lfsr_q[31] ^ data[3] ^ data[7];
    lfsr_c[20] = lfsr_q[12] ^ lfsr_q[28] ^ data[4];
    lfsr_c[21] = lfsr_q[13] ^ lfsr_q[29] ^ data[5];
    lfsr_c[22] = lfsr_q[14] ^ lfsr_q[24] ^ data[0];
    lfsr_c[23] = lfsr_q[15] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[30] ^ data[0] ^ data[1] ^ data[6];
    lfsr_c[24] = lfsr_q[16] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[31] ^ data[1] ^ data[2] ^ data[7];
    lfsr_c[25] = lfsr_q[17] ^ lfsr_q[26] ^ lfsr_q[27] ^ data[2] ^ data[3];
    lfsr_c[26] = lfsr_q[18] ^ lfsr_q[24] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[30] ^ data[0] ^ data[3] ^ data[4] ^ data[6];
    lfsr_c[27] = lfsr_q[19] ^ lfsr_q[25] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[31] ^ data[1] ^ data[4] ^ data[5] ^ data[7];
    lfsr_c[28] = lfsr_q[20] ^ lfsr_q[26] ^ lfsr_q[29] ^ lfsr_q[30] ^ data[2] ^ data[5] ^ data[6];
    lfsr_c[29] = lfsr_q[21] ^ lfsr_q[27] ^ lfsr_q[30] ^ lfsr_q[31] ^ data[3] ^ data[6] ^ data[7];
    lfsr_c[30] = lfsr_q[22] ^ lfsr_q[28] ^ lfsr_q[31] ^ data[4] ^ data[7];
    lfsr_c[31] = lfsr_q[23] ^ lfsr_q[29] ^ data[5];

  end 

  always @(posedge clk1 or negedge rst_n) begin
    if(!rst_n) begin
      lfsr_q <= {32{1'b1}};
    end
	 else if(crc_clr)
		lfsr_q <= {32{1'b1}};
    else begin
      lfsr_q <= crc_en ? lfsr_c : lfsr_q;
    end
  end 
endmodule // crc