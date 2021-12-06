module Register_File
#(
	parameter WIDTH = 32,
	parameter SELECTOR = 5
)
(
	input 						clk,
	input 						rst,
	input 						Reg_Write_i, 			//enb 	/ When is 1 allows writing on Write register
	input [SELECTOR-1:0]		Read_Register_1_i, 	//rs		/ It is the internal register that is delivered by the Read Data 1 signal.
	input [SELECTOR-1:0]		Read_Register_2_i, 	//rt		/ It is the internal register that is delivered by the Read Data 2 signal.
	input [SELECTOR-1:0]		Write_Register_i,		//rd		/ Is the internal register that will be written with the value in Write Data
	input [WIDTH-1:0]			Write_Data_i,			//R[rd]	/ It is a data port where the value to be written in the internal registers will be placed.
	
	output [WIDTH-1:0]		Read_Data_1_o,			//R[rs]	/ It is the output port where the register requested in Read register 1 is delivered.
	output [WIDTH-1:0]		Read_Data_2_o			//R[rt]	/ It is the output port where the register requested in Read register 2 is delivered.
);

logic [WIDTH-1:0][WIDTH-1:0] conection;
logic [WIDTH-1:0] cp_o;

CP CP(
	.in(Write_Register_i), 
	.out(cp_o)
);

FF_D_32 FF_D_32(
	.data(Write_Data_i), 
	.clk(clk), 
	.rst(rst), 
	.and_i1(Reg_Write_i), 
	.and_i2(cp_o), 
	.q(conection)
);

Mux_32 Read_data1(
	.select(Read_Register_1_i), 
	.data(conection),
	.out(Read_Data_1_o)
);

Mux_32 Read_data2(
	.select(Read_Register_2_i),
	.data(conection),
	.out(Read_Data_2_o)
);

endmodule 
