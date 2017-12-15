//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none

module IFID (clock,reset,Inst,Pc4,hazard_hold,pc4_reg,Instreg);

input wire clock, reset, hazard_hold;
input wire [31:0] Inst, Pc4;

output reg [31:0] pc4_reg, Instreg;

always @ (posedge clock) begin
if (!reset) begin

if (!hazard_hold) begin
	Instreg <= Inst;
	pc4_reg <= Pc4;
end else if(hazard_hold)
	Instreg <= 0; //insert nop (no-operation) instruction

end //if (!reset)

end //always

endmodule
