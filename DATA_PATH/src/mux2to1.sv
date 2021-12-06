module mux2to1 
#(
	parameter DATA_WIDTH = 32
)
(
	input [DATA_WIDTH-1:0] 	x,
	input [DATA_WIDTH-1:0]	y,
	input [1:0] 				Selector,
	
	output [DATA_WIDTH-1:0] Data_out
   
);

	assign Data_out = Selector ? x : y;
	
endmodule 