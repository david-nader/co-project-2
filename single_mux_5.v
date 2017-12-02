
module mux_1 ( x,y , RegDst , z);

input  [4:0] x,y;
input RegDst;
output reg [4:0] z;

always @(RegDst or x or y)
begin

if(RegDst==0)
   z=x;
else if(RegDst ==1)
   z=y;
end

endmodule
