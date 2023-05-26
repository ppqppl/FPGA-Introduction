module Full_adder1
(
	input	a,b,
	output	sum,
	output 	cout,
	input 	cin
);
assign{cout,sum} = a+b+cin;
endmodule
