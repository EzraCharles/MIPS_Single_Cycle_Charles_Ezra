module ROM
#(
	parameter MEMORY_DEPTH 	= 64,
	parameter DATA_WIDTH 	= 32
)
(
	input 		[DATA_WIDTH-1:0] Address_i,
	output logic 	[DATA_WIDTH-1:0] Instruction_o
);

	logic [DATA_WIDTH-1:0] ROM [MEMORY_DEPTH-1:0];

	initial
	begin
		$readmemh("C:\\PROJECTS\\DATA_PATH\\src\\text.dat", ROM);
	end

	always @ (Address_i)
	begin
		Instruction_o <= ROM[(Address_i - 32'h40_0000) >> 2];
	end

endmodule
