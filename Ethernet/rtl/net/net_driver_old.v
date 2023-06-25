module net_driver (
    	input 					clk			,
		input 					rstn		,
		input 					spi_miso	,
        input   wire	[18:00]	data_in		,

		output 					o_spi_cs	,
		output 					o_spi_sck	,
		output 					o_spi_mosi	,
		output 					o_w5500_rst	
		
);


    w5500_altera_top u_w5500_altera_top(
		.clk			(clk            ),
		.rst_n			(rstn           ),
		.spi_miso		(spi_miso       ),
        .data_in        (data_in	    ),

		.o_spi_cs		(o_spi_cs       ),
		.o_spi_sck	    (o_spi_sck      ),
		.o_spi_mosi	    (o_spi_mosi     ),
		.o_w5500_rst    (o_w5500_rst    )
);

endmodule //net_driver