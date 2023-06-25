`define SYS_FRQ 50_000_000
`define BAUD_115200

`ifdef BAUD_9600
	`define BAUD_MAX 9600
`elsif BAUD_19200
	`define BAUD_MAX 19200
`elsif BAUD_38400
	`define BAUD_MAX 38400
`elsif BAUD_57600
	`define BAUD_MAX 57600
`elsif BAUD_115200
	`define BAUD_MAX 115200
`else
	`define BAUD_MAX 9600
`endif
	
