module fifo_pp(
 input rst_n,
 input clk,
 input rdfifoclk, 
 input [31:0]data_in,
 input wr_en,
 output wire rd_en,
 output wire adtx_en,
 output reg [15:0] count1,
 output reg [15:0] count2,
 output reg [31:0] trans_data,
 output reg [2:0]  bit_sel
 //output [7:0]data_out
);

//reg define
reg fifo1_wr_en	  ;
reg fifo2_wr_en	  ;
reg fifo1_rd_en	  ;
reg fifo2_rd_en	  ;

reg[3:0]state;
reg[3:0]next_state;
//wire define
wire       wr_full1 ;
wire  	  wr_full2 ;
wire		  rd_empty1;
wire 		  rd_empty2;
//wire [8:0] fifo_cnt1;
//wire [8:0] fifo_cnt2;
wire [7:0] data_out ;
wire [7:0] data_out1;
wire [7:0] data_out2;

//assign
assign data_out = fifo1_rd_en ? data_out1 : data_out2;
assign rd_en    = (fifo2_wr_en && (!rd_empty1)) || (fifo1_wr_en && (!rd_empty2))   ;
assign adtx_en  = (count1 == 16133) || (count2 == 16133); 
parameter idle  = 4'b0000,
			 start = 4'b0001,
          ping  = 4'b0010,
          pang  = 4'b0100;
  
  //count
always @(posedge rdfifoclk or negedge rst_n)begin
	if(!rst_n)begin
		count1  <= 16'd0;
		count2  <= 16'd0;
		end
	else if(!fifo2_wr_en)begin
		count1  <= count1 + 1'b1;
		count2  <= 16'd0;
		end
	else if(fifo2_wr_en)begin
		count2  <= count2 + 1'b1;
		count1  <= 16'd0;
		end
end


//8bit to 32bit
always@(posedge rdfifoclk or negedge rst_n)begin
	if(!rst_n)
		trans_data  <= 32'h0;
	else if(fifo2_rd_en)begin
		bit_sel		<= bit_sel + 1'b1;
		if(bit_sel == 3'd0)
			trans_data[31:24] <= data_out;
		else if(bit_sel == 3'd1)	
			trans_data[23:16] <= data_out;
		else if(bit_sel == 3'd2)	
			trans_data[15:8] <= data_out;
		else if(bit_sel == 3'd3)begin
			bit_sel  <= 3'd0;
			trans_data[7:0] <= data_out;
		end
	end
	else if(fifo1_rd_en)begin
		bit_sel		<= bit_sel + 1'b1;
		if(bit_sel == 3'd0)
			trans_data[31:24] <= data_out;
		else if(bit_sel == 3'd1)	
			trans_data[23:16] <= data_out;
		else if(bit_sel == 3'd2)	
			trans_data[15:8] <= data_out;
		else if(bit_sel == 3'd3)begin
			bit_sel  <= 3'd0;
			trans_data[7:0] <= data_out;
		end
	end
	else
		bit_sel  <= 3'd0;
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n) 
		state <= idle;
	else 
		state <= next_state;
end
//
always@(posedge clk)begin 
 case(state)
  idle:if(wr_en) 
				next_state <= start;
       else 
				next_state <= idle;
  start:if(wr_full1)
				next_state <= ping;
        else 
				next_state <= start;
  ping:if(wr_full2)
				next_state <= pang;
	    else 
				next_state <= ping;
  pang:if(wr_full1)
				next_state <= ping;
       else 
				next_state <= pang;
  default: next_state <= idle;	   
 endcase
end


//
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		fifo1_wr_en <= 0;
		fifo2_wr_en <= 0;
		fifo2_rd_en <= 0;
		fifo1_rd_en <= 0;
	end
	else case(state)
		idle:begin
			fifo1_wr_en <= 0;
			fifo2_wr_en <= 0;
			fifo2_rd_en <= 0;
			fifo1_rd_en <= 0;
		end
		start:begin
			fifo1_wr_en <= 1;
			fifo2_wr_en <= 0;
			fifo2_rd_en <= 0;
			fifo1_rd_en <= 0;
		end  
		ping:begin
			fifo1_wr_en <= 0;
			fifo2_wr_en <= 1;
			fifo1_rd_en <= !rd_empty1;
			fifo2_rd_en <= 0;
	   end
		pang:begin
			fifo1_wr_en <= 1;
			fifo2_wr_en <= 0;
			fifo1_rd_en <= 0;
			fifo2_rd_en <= !rd_empty2;
	   end
		default:begin
         fifo1_wr_en <= 0;
			fifo2_wr_en <= 0;
			fifo2_rd_en <= 0;
			fifo1_rd_en <= 0;
		end
 endcase
end


fifo fifo1(
 .wrreq(fifo1_wr_en),
 .rdreq(fifo1_rd_en),
 .data(data_in),
 .aclr(!rst_n),
 .wrclk(clk),
 .rdclk(rdfifoclk),
 .q(data_out1),
 .wrfull(wr_full1),
 .rdempty(rd_empty1)
 //.wrusedw(fifo_cnt1)
);

fifo fifo2(
 .wrreq(fifo2_wr_en),
 .rdreq(fifo2_rd_en),
 .data(data_in),
 .aclr(!rst_n),
 .wrclk(clk),
 .rdclk(rdfifoclk),
 .q(data_out2),
 .wrfull(wr_full2),
 .rdempty(rd_empty2)
 //.wrusedw(fifo_cnt2)
);

endmodule
