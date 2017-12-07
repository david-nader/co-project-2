/* ALU Control */

`include "single_defs.v"


module alu_control(aluop, functioncode, aluoperation);
input wire [1:0] aluop;
input wire [5:0] functioncode;
output reg [3:0] aluoperation;

always @(*)
begin

//default case, for synthesization,
//should be overriden by one of the conditions below
aluoperation <= `alu_operation_add;

if(aluop==2'b10)
begin
if(functioncode==6'b000000)//shift left aluoperation 1111 
aluoperation <= `alu_operation_sll;

if(functioncode==6'b100000)//add
aluoperation <= `alu_operation_add;

if(functioncode==6'b100100)//and
aluoperation <= `alu_operation_and;

if(functioncode==6'b100010)//sub
aluoperation <= `alu_operation_sub;

if(functioncode==6'b100101)//or
aluoperation <= `alu_operation_or;

if(functioncode==6'b101010)//setless than
aluoperation <= `alu_operation_slt;
end

else if (aluop==2'b00)
aluoperation <= `alu_operation_add; //add for lw

else if (aluop==2'b01)
 aluoperation <= `alu_operation_sub; //sub for beq
end

endmodule



module alucontroltest;
reg  [1:0] aluop;
reg  [5:0] functioncode;
wire [3:0] aluoperation;
alu_control g1 ( aluop , functioncode ,aluoperation);

initial 
begin 
$monitor(" aluop= %b   functioncode=%b     aluoperation=%b  ",aluop,functioncode ,aluoperation);
#10 
aluop='b00;

#10 
aluop='b01;

#10 
aluop='b10;
functioncode='b100000;
end

endmodule
