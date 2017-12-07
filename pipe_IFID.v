
module IF_ID (clock,Inst,Pc4,hazard_out,pc4_reg,Instreg);
input [31:0] Inst,Pc4;
input clock,hazard_out;
output [31:0] pc4_reg,Instreg;
reg [31:0] pc4_reg,Instreg;

initial
begin
pc4_reg =0;
Instreg =0;
end

always @ (posedge clock)
begin
if(hazard_out)
	begin
	Instreg <= Inst;
	pc4_reg <= Pc4;
	end
end //always

endmodule
