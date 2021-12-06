module ALU 
#(
	parameter WIDTH = 32
)
(
	input	 [2:0]    		select,
	input  [WIDTH-1:0]  	a,
	input  [WIDTH-1:0]  	b,
	
	output [WIDTH-1:0]  	y,
	output  	           	zero
);

	logic z;
	logic [WIDTH-1:0] y_o;
	
	assign y = y_o;

	always @ (*)
	begin
   
	case (select)
		3'b000: y_o = a + b;
      3'b001: y_o = a & b;
      3'b010: y_o = a | b;
      3'b011: y_o = a ^ b;
      3'b100: y_o = ~a;
      3'b101: y_o = a << 1;
      3'b110: y_o = a >> 1;
      3'b111: y_o = 32'h0;
      default: y_o = 32'h0;
   endcase
 
	z = (y_o == 32'h0) ? 1 : 0;
	
	end
	
	assign zero = z;

endmodule
