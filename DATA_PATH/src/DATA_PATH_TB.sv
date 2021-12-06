module DATA_PATH_TB;

//parameter MEMORY_DEPTH 	= 64;
parameter WIDTH = 32;

logic clk_tb 	= 0;
logic rst_tb;
	
logic [7:0] GPIO_o_tb;
logic [5:0] Op_o_tb;
logic [5:0] Funct_o_tb;

/***** Control signals *****/
logic 		IorD_tb;
logic 		MemWrite_tb;
logic 		IRWrite_tb;
logic 		PCWrite_tb;
logic 		Branch_tb; 
logic 		PCSrc_tb;
logic 		ALUSrcA_tb;
logic 		RegWrite_tb;
logic 		MemtoReg_tb;
logic 		RegDst_tb;
logic [2:0] 	ALUControl_tb;
logic [1:0] 	ALUSrcB_tb;
/***************************/

/***** Monitor signals *****/
logic [WIDTH-1:0] M_PC_n_tb;
logic [WIDTH-1:0] M_PC_o_tb;
logic [WIDTH-1:0] M_Addr_tb;
logic [WIDTH-1:0] M_Instr_tb;
logic [WIDTH-1:0] M_Data_tb;
logic [WIDTH-1:0] M_A_tb;
logic [WIDTH-1:0] M_B_tb;
logic [WIDTH-1:0] M_SrcA_tb;
logic [WIDTH-1:0] M_SrcB_tb;
logic [WIDTH-1:0] M_ALUOut_tb;
/***************************/
  
MIPS_Single_Cycle
#(
	.WIDTH(WIDTH)
)
DUT(
	.clk(clk_tb),
	.rst(rst_tb),
	.GPIO_o(GPIO_o_tb),
	.Op_o(Op_o_tb),
	.Funct_o(Funct_o_tb),
	.IorD(IorD_tb),
	.MemWrite(MemWrite_tb),
	.IRWrite(IRWrite_tb),
	.PCWrite(PCWrite_tb),
	.Branch(Branch_tb),
	.PCSrc(PCSrc_tb),
	.ALUSrcA(ALUSrcA_tb),
	.RegWrite(RegWrite_tb),
	.MemtoReg(MemtoReg_tb),
	.RegDst(RegDst_tb),
	.ALUControl(ALUControl_tb),
	.ALUSrcB(ALUSrcB_tb),
	.M_PC_n(M_PC_n_tb),
	.M_PC_o(M_PC_o_tb),
	.M_Addr(M_Addr_tb),
	.M_Instr(M_Instr_tb),
	.M_Data(M_Data_tb),
	.M_A(M_A_tb),
	.M_B(M_B_tb),
	.M_SrcA(M_SrcA_tb),
	.M_SrcB(M_SrcB_tb),
	.M_ALUOut(M_ALUOut_tb)
);

// Clock generator
initial begin
   	forever #2 clk_tb = !clk_tb;
end

// General
initial begin
	#0 rst_tb = 0;
	#2 rst_tb = 1;
	#2 rst_tb = 0;
	#4 rst_tb = 1;
end 

// PC register 
initial begin
	#1 PCWrite_tb = 1;
		IorD_tb = 1;	// inverted logic
		MemWrite_tb = 0;
		IRWrite_tb = 1;
		RegWrite_tb = 0;
		
	#5 PCWrite_tb = 0;
end

// ALU (decode)
initial begin
	#1 ALUSrcA_tb = 1; // inverted logic
		ALUSrcB_tb = 2'b01;
		ALUControl_tb = 3'b000;
		
	#4 PCSrc_tb = 1; // inverted logic
end


// load and store------
initial begin
	#15 IRWrite_tb = 0;
		ALUSrcA_tb = 0;
		ALUSrcB_tb = 2'b10;
		ALUControl_tb = 3'b000;
		
		//load
	#5 IorD_tb = 0;
		RegWrite_tb = 0;
		MemtoReg_tb = 1;
		RegDst_tb = 1;
		
		//store
	#2 MemWrite_tb = 1;
		
	
end

endmodule
