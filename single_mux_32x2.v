
module mux_32x2(in1, in2, sel, out);

input  [31:0] in1,in2;
input sel;
output reg [31:0] out;

always @(sel or in1 or in2)
begin
if(sel==0)
   out=in1;
else
   out=in2;
end

endmodule

