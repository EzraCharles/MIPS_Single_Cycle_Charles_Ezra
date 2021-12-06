module FF_D_32
#(
	parameter WIDTH = 32
)
(
	input logic [WIDTH-1:0]					data, 
	input 		[WIDTH-1:0] 				and_i2,	// Each and of every Flip-Flop
	input bit									and_i1, 	// And enable
	input bit 									clk, rst, 
	output logic [WIDTH-1:0][WIDTH-1:0] 	q
);

logic [WIDTH-1:0] and_o;	// ands outputs of each Flip-Flop

genvar i;
generate
	for (i = 0; i < 32; i++) begin: gen_flip_flops	
		FF_D FF_D_32 (
			.d(data),
			.clk(clk),
			.rst(rst),
			.enable(and_o[i]),
			.q(q[i])
		);
		
		and(
			and_o[i],
			and_i1,
			and_i2[i]
		);
	end
endgenerate

endmodule
