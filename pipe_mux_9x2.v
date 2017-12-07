
module mux_9x2(in1, in2, sel, out);

input wire [8:0] in1, in2;
input wire sel;
output wire [8:0] out;

assign out = (sel == 0) ? in1 : in2;

endmodule