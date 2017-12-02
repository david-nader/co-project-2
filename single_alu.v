
`include "single_defs.v"

/*
ALU
supports:
add, and, or, sll, lw, sw, beq
*/

module alu(result, zero, operand1, operand2, shamt, alu_operation);

output reg [31:0] result;
output wire zero;
input wire [31:0] operand1;
input wire [31:0] operand2;
input wire [4:0] shamt;
input wire [3:0] alu_operation;

//zero signal
assign zero = (result == 0);

always @(*) begin

case(alu_operation)

`alu_operation_add:
result <= operand1 + operand2;

`alu_operation_and:
result <= operand1 & operand2;

`alu_operation_or:
result <= operand1 | operand2;

`alu_operation_sll:
result <= operand1 << shamt;

default:
//should not be reached
//set result as a fall back for the synthesizer
result <= 0;

endcase
end //always

endmodule



module alu_testbench;

wire signed [31:0] result;
wire zero;
reg signed [31:0] operand1;
reg signed [31:0] operand2;
reg [4:0] shamt;
reg [3:0] alu_operation;

alu DUT(result, zero, operand1, operand2, shamt, alu_operation);

initial begin

$monitor("operand1: %d (%b)\noperand2: %d (%b)\nshamt: %2d, alu_operation: %2d (%b)\nresult:   %d (%b)\nzero: %b\n",
		operand1, operand1, operand2, operand2, shamt, alu_operation, alu_operation, result, result, zero);



//test +ve operands
#50
$display("\nPositive operands:\n");
operand1 = 3;
operand2 = 5;
shamt = 3;
alu_operation = `alu_operation_add;
#10
alu_operation = `alu_operation_and;
#10
alu_operation = `alu_operation_or;
#10
alu_operation = `alu_operation_sll;


//test -ve operands
#50
$display("\nNegative operands:\n");
operand1 = -3;
operand2 = -5;
shamt = 3;
alu_operation = `alu_operation_add;
#10
alu_operation = `alu_operation_and;
#10
alu_operation = `alu_operation_or;
#10
alu_operation = `alu_operation_sll;

//test the zero signal
#50
$display("\nZero signal:\n");
operand1 = 25;
operand2 = -25;
alu_operation = `alu_operation_add;
#10
alu_operation = `alu_operation_and;
#10
alu_operation = `alu_operation_or;
#10
alu_operation = `alu_operation_sll;

end //initial

endmodule

