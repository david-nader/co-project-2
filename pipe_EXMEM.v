
module EX_MEM (clock,Inst,Alu_out,Dest_reg,WB,M,Forwarding_in,WB_out,M_out,Instreg,Alu_outreg);
input clock;
input [1:0] WB;
input [2:0] M;
input [31:0] Inst,Alu_out;
input [4:0] Dest_reg;

output [4:0] Forwarding_in;
output [1:0] WB_out;
output [2:0] M_out;
output [31:0] Instreg,Alu_outreg;

reg [4:0] Forwarding_in;
reg [1:0] WB_out;
reg [2:0] M_out;
reg [31:0] Instreg,Alu_outreg;

initial
begin
Forwarding_in=0;
Instreg=0;
Alu_outreg=0;
WB_out=0;
M_out=0;
end
always @ (posedge clock)
begin
Forwarding_in <= Dest_reg;
Instreg <= Inst;
Alu_outreg <= Alu_out;
WB_out <= WB;
M_out <= M;
end
endmodule
