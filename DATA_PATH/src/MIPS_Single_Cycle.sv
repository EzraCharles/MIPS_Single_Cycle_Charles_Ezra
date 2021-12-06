module MIPS_Single_Cycle
#(
	parameter WIDTH = 32,
	parameter SELECTOR = 5
)
(
	// Inputs
	input clk,
	input rst,	
	
	output [7:0] GPIO_o,
	output [5:0] Op_o,		// 31:26
	output [5:0] Funct_o, 	// 5:0
	
	/***** Control signals *****/
	input 		IorD, 
	input 		MemWrite,
	input 		IRWrite,
	input 		PCWrite,
	input 		Branch, 
	input 		PCSrc,
	input [2:0] ALUControl,
	input [1:0] ALUSrcB,
	input 		ALUSrcA,
	input 		RegWrite,
	input 		MemtoReg,
	input 		RegDst,
	/***************************/
	
	/***** Monitor signals *****/
	output [WIDTH-1:0] M_PC_n,
	output [WIDTH-1:0] M_PC_o,
	output [WIDTH-1:0] M_Addr,
	output [WIDTH-1:0] M_Instr,
	output [WIDTH-1:0] M_Data,
	output [WIDTH-1:0] M_A,
	output [WIDTH-1:0] M_B,
	output [WIDTH-1:0] M_SrcA,
	output [WIDTH-1:0] M_SrcB,
	output [WIDTH-1:0] M_ALUOut
	/***************************/
	
);
	
	// Signals (wires)
	logic [WIDTH-1:0] PC_n;
	logic [WIDTH-1:0] PC_o;
	logic [WIDTH-1:0] Addr;
	logic [WIDTH-1:0] RD;
	logic [WIDTH-1:0] Instr;
	logic [WIDTH-1:0] Data;
	logic [WIDTH-1:0] WD3;
	logic [WIDTH-1:0] SrcA;
	logic [WIDTH-1:0] SrcB;
	logic [WIDTH-1:0] ALUResult;
	logic [WIDTH-1:0] ALUOut;
	logic [4:0]			A3;
	logic 				Zero;
	
	
	// Intermediate Signals 
	logic 		PCEn;
	logic [5:0] Op; 		// 31:26
	logic [5:0] Funct;	// 5:0
	logic [4:0] A1;		// 25:21
	logic [4:0] A2;		// 20:16
	logic [4:0] A3_1;		// 20:16
	logic [4:0] A3_2;		// 15:11
	logic [15:0] Sign_Extend_i; // 15:0
	logic [15:0] Sign_Extend_o;
	logic [WIDTH-1:0] RD_1;		
	logic [WIDTH-1:0] RD_2;		
	logic [WIDTH-1:0] A;	
	logic [WIDTH-1:0] B;	
	
	// Assigns of intermediate Signals
	assign PCEn 			= ( (Branch & Zero) || PCWrite );
	assign Op_o				= Instr[31:26]; 		// 31:26
	assign Funct_o			= Instr[5:0];	// 5:0
	assign A1				= Instr[25:21];		// 25:21
	assign A2				= Instr[20:16];		// 20:16
	assign A3_1				= Instr[20:16];		// 20:16
	assign A3_2 			= Instr[15:11];		// 15:11
	assign Sign_Extend_i = Instr[15:0];
	assign Sign_Extend_o = { {16{Sign_Extend_i[15]}}, Sign_Extend_i };
	assign GPIO_o 			= ALUOut[7:0];
	
	// Assign of monitors
	assign M_PC_n		= PC_n;
	assign M_PC_o		= PC_o;
	assign M_Addr		= Addr;
	assign M_Instr		= Instr;
	assign M_Data		= Data;
	assign M_A			= A;
	assign M_B			= B;
	assign M_SrcA		= SrcA;
	assign M_SrcB		= SrcB;
	assign M_ALUOut	= ALUOut;

	// Program Counter (PC) register
	FF_D_PC PC_r (
		.d(PC_n),
		.clk(clk),
		.rst(rst),
		.enable(PCEn),
		.q(PC_o)
	);
	
	// PC in Mux2to1 out IorD
	mux2to1 IorD_m (
		.x(PC_o),
		.y(ALUOut),						
		.Selector(IorD),
		.Data_out(Addr)
	);
	
	// Memory System (Instr/Data Memory
	Memory_System Data_Memory (	
		.Write_Enable_i(MemWrite),	// WE
		.clk(clk),
		.Write_Data_i(B), 		// WD
		.Address_i(Addr), 	// A
		.Data_o(RD)				// RD
	);
	
	// Instr register
	FF_D Instr_r (
		.d(RD),
		.clk(clk),
		.rst(rst),
		.enable(IRWrite),
		.q(Instr)
	);
	
	// Data register
	FF_D Data_r (
		.d(RD),
		.clk(clk),
		.rst(rst),
		.enable(1),
		.q(Data)
	);
	
	// 20:16, 15:11 in Mux2to1 out A3
	mux2to1 #(.DATA_WIDTH(5)) RegDst_m (
		.x(A3_1),
		.y(A3_2), 
		.Selector(RegDst),	 // I:0, R:1
		.Data_out(A3)
	);
	
	// ALUOut in Mux2to1 out WD3
	mux2to1 MemtoReg_m (
		.x(ALUOut),			
		.y(Data),
		.Selector(MemtoReg),	
		.Data_out(WD3)		
	);
	
	// Register File
	Register_File Register_File (
		.clk(clk), 
		.rst(rst), 
		.Reg_Write_i(RegWrite), 
		.Read_Register_1_i(A1), 
		.Read_Register_2_i(A2),
		.Write_Register_i(A3), 
		.Write_Data_i(WD3), 
		.Read_Data_1_o(RD_1), 
		.Read_Data_2_o(RD_2) 
	);
	
	// RD1 register A
	FF_D A_r (
		.d(RD_1), 
		.clk(clk),
		.rst(rst),
		.enable(1),
		.q(A) 
	);
	
	// RD2 register B
	FF_D B_r (
		.d(RD_2), 
		.clk(clk),
		.rst(rst),
		.enable(1),
		.q(B) 
	);
	
	/*
	// Sign Extend
	Sign_Extend Signn_Extend (
		.data_i(),  //-------------
		.SignImm_o() //-------------
	);
	*/
	
	// B, 4, SignImm, SignImm<<2 in Mux2to1 out SrcB to ALU
	mux4to1 SrcB_m (
		.a(B), 
		.b(32'b100), 
		.c(Sign_Extend_o),
		.d(Sign_Extend_o << 2),
		.Select(ALUSrcB), 
		.Data_o(SrcB) 
	);
	
	// SrcA_m
	mux2to1 SrcA_m (
		.x(PC_o),
		.y(A), 
		.Selector(ALUSrcA),
		.Data_out(SrcA) 
	);
	
	// ALU
	ALU ALU (
		.a(SrcA), 
		.b(SrcB), 
		.select(ALUControl) ,
		.y(ALUResult),
		.zero(Zero)
	);
	
	// ALUResult in Register out ALUOut
	FF_D ALU_r (
		.d(ALUResult),
		.clk(clk),
		.rst(rst),
		.enable(1),
		.q(ALUOut) 
	);
	
	// ALUOut, ALUResult in Mux2to1 out PC'
	mux2to1 PCSrc_m (
		.x(ALUResult), 
		.y(ALUOut), 
		.Selector(PCSrc),
		.Data_out(PC_n)
	);
	
endmodule
