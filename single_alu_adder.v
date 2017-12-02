

module alu_adder2 (in1,in2,o);

input [31:0] in1,in2;
output [31:0] o;
assign o = in1 + in2;

endmodule
