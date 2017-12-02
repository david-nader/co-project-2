
module alu_adder1 (pc,out); 

input [31:0] pc;
output  [31:0] out ;
assign out = pc + 4;

endmodule



module alu_adder2 (in1,in2,o);

input [31:0] in1,in2;
output [31:0] o;
assign o = in1 + in2;

endmodule
