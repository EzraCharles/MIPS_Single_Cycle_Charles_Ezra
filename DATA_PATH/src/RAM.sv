module RAM 
#(	
	parameter MEMORY_DEPTH	= 64,
	parameter DATA_WIDTH 	= 32
)
(
	input 							Write_Enable_i, clk,
	input 	[DATA_WIDTH-1:0] 	Write_Data_i,
	input 	[DATA_WIDTH-1:0]  Address_i,
	
	output 	[DATA_WIDTH-1:0]  Read_Data_o
);
	
	logic [DATA_WIDTH-1:0] substract = 32'h1001_0000;
	logic [DATA_WIDTH-1:0] RAM [MEMORY_DEPTH-1:0];

	always @ (posedge clk)
	begin
		if (Write_Enable_i)
			RAM[(Address_i - substract) >> 2] <= Write_Data_i;
	end
	
  	assign Read_Data_o = RAM[(Address_i - substract) >> 2];

endmodule
