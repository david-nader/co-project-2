
module MEM_WB (clock,Inst,WB,Dest_reg,Alu_out,Forwarding_in,Instreg,Alu_outreg,WB_out);
input clock;
input [31:0] Inst,Alu_out;
input [1:0] WB;
input [4:0] Dest_reg;
output [4:0] Forwarding_in;
output [31:0] Instreg,Alu_outreg;
output [1:0] WB_out;

reg [4:0] Forwarding_in;
reg [31:0] Instreg,Alu_outreg;
reg [1:0] WB_out;

initial
begin
Forwarding_in=0;
Instreg=0;
Alu_outreg=0;
WB_out=0;
end
always @ (posedge clock)
begin
Forwarding_in <= Dest_reg;
Instreg <= Inst;
Alu_outreg <= Alu_out;
WB_out <= WB;
end
endmodule
