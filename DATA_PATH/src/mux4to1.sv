module mux4to1
#(
	parameter WIDTH = 32
)
(
	input 	[WIDTH-1:0] a,
   input 	[WIDTH-1:0] b,
   input 	[WIDTH-1:0] c,   
   input 	[WIDTH-1:0] d,
   input 	[1:0] Select,
	
   output 	[WIDTH-1:0] Data_o
);

   // constant declaration
   localparam S0 = 2'b00;
   localparam S1 = 2'b01;
   localparam S2 = 2'b10;
   localparam S3 = 2'b11;
    
   logic [WIDTH-1:0] Data;
   assign Data_o = Data;
		
   always @ (*)
   begin
      case(Select)
         S0: begin
            Data <= a;
         end
         S1: begin
            Data <= b;
         end
         S2: begin
            Data <= c;
         end
         S3: begin
            Data <= d;
         end
	default: begin 
		Data <= a;
	end

	endcase
   end
endmodule
