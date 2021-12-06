module Mux_32
#(
	parameter WIDTH = 32,
	parameter SELECTOR = 5
)
(
	input 	[2**SELECTOR-1:0][WIDTH-1:0] 	data,
	input 	[SELECTOR-1:0]						select,
	output	[WIDTH-1:0] 						out
);

assign out = data[select];

endmodule 
