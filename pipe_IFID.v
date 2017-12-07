//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none

module IFID (clock,Inst,Pc4,hazard_hold,pc4_reg,Instreg);

input wire clock, hazard_hold;
input wire [31:0] Inst, Pc4;

output reg [31:0] pc4_reg, Instreg;

always @ (posedge clock)
begin
if(!hazard_hold)
	begin
	Instreg <= Inst;
	pc4_reg <= Pc4;
	end
end

endmodule
