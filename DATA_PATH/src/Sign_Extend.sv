module Sign_Extend
#(
	parameter WIDTH = 32
)
(
	input 	[15:0] 		data_i, 
	output 	[WIDTH-1:0]	SignImm_o
);

assign SignImm_o = { {16{data_i[15]}}, data_i };

endmodule
