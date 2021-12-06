module Memory_System 
#(	
	parameter MEMORY_DEPTH	= 64,
	parameter DATA_WIDTH 	= 32
)
(
	input 							Write_Enable_i, clk,
	input 	[DATA_WIDTH-1:0]	Write_Data_i,
	input 	[DATA_WIDTH-1:0]  Address_i,
	
	output 	[DATA_WIDTH-1:0]  Data_o
);

	logic [DATA_WIDTH-1:0] 	ROM_o;
	logic [DATA_WIDTH-1:0] 	RAM_o;
	logic [DATA_WIDTH-1:0] 	separator = 32'h1000_0000; 
	logic 						Mux_enable;
		
	assign Mux_enable = (Address_i < separator) ? 1 : 0;
	
	ROM rom(	
		.Address_i(Address_i),
		.Instruction_o(ROM_o)
	);
	
	RAM ram(
		.Write_Enable_i(Write_Enable_i),
		.clk(clk),
		.Write_Data_i(Write_Data_i),
		.Address_i(Address_i),
		.Read_Data_o(RAM_o)
	);
	
	mux2to1 mux2(
		.x(ROM_o), 
		.y(RAM_o), 
		.Selector(Mux_enable), 
		.Data_out(Data_o)
	);
	

endmodule
