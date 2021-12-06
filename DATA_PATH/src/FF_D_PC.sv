module FF_D_PC
#(
	parameter WIDTH = 32
)
(
	input logic 	[WIDTH-1:0]	d,
	input bit 						clk, rst, enable,
	output logic 	[WIDTH-1:0]	q
);

always@(posedge clk, negedge rst)
	begin
		if(!rst) begin
			q <= 32'h400000;
		end
		else if(enable) begin
			q <= d;
		end	
	end

endmodule
