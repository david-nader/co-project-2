//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none

module IFID (clock,reset,Inst,Pc4,hazard_hold,pc4_reg,Instreg,hazard_flush);

input wire clock, reset, hazard_hold, hazard_flush;
input wire [31:0] Inst, Pc4;

output reg [31:0] pc4_reg, Instreg;

always @ (posedge clock) begin
if (!reset) begin

if (!hazard_hold) begin
	Instreg <= Inst;
	pc4_reg <= Pc4;
end

//used by beq,
//note: it clears the instruction, but
//lets pc4 pass to the next cpu stage
//where it's needed in EX stage by beq
//for branch address calculation
if(hazard_flush)
	Instreg <= 0; //insert nop instruction (no-operation)

end //if (!reset)

end //always

endmodule
