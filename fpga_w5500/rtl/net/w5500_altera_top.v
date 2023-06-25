module w5500_altera_top(
		input 					clk				,
		input 					rst_n			,
		input 					spi_miso		,
		input	wire [7: 0]		data_in			, 

		input   wire 			flag_start		,
		//input   wire 			flag_end		,

		
		output 					o_spi_cs		,
		output 					o_spi_sck		,
		output 					o_spi_mosi		,
		output 					o_w5500_rst
);
 
wire 						rxdat_vld	;
wire  		[07:00]	rxdat			;
wire  					rxdat_end	;


wire 						dat_tx_end	;
wire 						dat_tx_req	;
wire 						dat_tx_rden	;
wire 						dat_tx_end2	;
wire 			[07:00]	dat_tx		;	
wire 			[15:00]	dat_tx_len	;

reg 			flag_start2		;


// dat_proces
	// undat_proces(
		// .clk					( clk				),
		// .rst_n				( rst_n			),
		
		// .rxdat_vld			( 		),
		// .rxdat				( 	),
		// .rxdat_end			( 		),

		// // .rxdat_vld			( flag_start		),
		// // .rxdat				( data_in			),
		// // .rxdat_end			( flag_end			),
		
		// .dat_tx_end			( 	),
		// .o_dat_tx_req		( 	),
		// .dat_tx_rden		( 	),
		// .o_dat				( 	),
		// .o_dat_len			( 	),
		// .o_ts				(	)
// );

// reg [23:0] count=26'd0;

// always @(posedge clk or negedge rst_n) begin
//    if(!rst_n) begin
	//    count <= 24'd0;
//    end
//    else if(flag_start) begin	//count >= 50000
		// count <= count + 24'd1;
//    end
    // else if(count >= 50000) begin
		// count<=24'd0;
	// end
//    else begin
    //    count <= count; 
//    end
// end

reg [3:0] delay_counter;
reg [7:0] delayed_signal_reg;

  always @(posedge clk) begin
	if(dat_tx_end) begin
		flag_start2<=0;
	end
	else begin
		flag_start2<=flag_start;
	end
  end

  always @(posedge clk) begin
  if (delay_counter == 4&flag_start) begin//2
      delayed_signal_reg <= data_in;
	  delay_counter <=4'd0;
  end
  delay_counter <= delay_counter + 1;
end

  assign delayed_signal = delayed_signal_reg;

w5500_top
	unw5500_top(
		.clk				( clk			),
		.rst_n				( rst_n			),
	
		.o_rxdat_vld		( rxdat_vld		),
		.o_rxdat			( rxdat			),
		.o_rxdat_end		( rxdat_end		),
		
		.o_dat_tx_end		( dat_tx_end	),
		.dat_tx_req			( flag_start2	),//发送标志，一为1就发送，发重复，说明udp发快了,试试计时器flag_start
		.o_dat_tx_rden		( dat_tx_rden	),
		.dat				( delayed_signal_reg),
		.dat_len			( 1				),
		
		.spi_miso			( spi_miso		),
		.o_spi_cs			( o_spi_cs		),
		.o_spi_sck			( o_spi_sck		),
		.o_spi_mosi			( o_spi_mosi	),
		.o_w5500_rst		( o_w5500_rst   ),
		.o_tx_end           (dat_tx_end2)
);



endmodule 