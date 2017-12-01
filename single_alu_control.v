/* ALU Control */


module alu_control_single ( aluop , functioncode ,aluoperation);
input wire [1:0] aluop;
input wire [5:0] functioncode;
output reg [3:0] aluoperation;
always @(*)
begin 
if(aluop==2'b10)
begin
if(functioncode==6'b000000)//shift left aluoperation 1111 
aluoperation <=4'b1111;

if(functioncode==6'b100000)//add
aluoperation <=4'b0010;

if(functioncode==6'b100100)//and
 aluoperation <=4'b0000;

if(functioncode==6'b100010)//sub
 aluoperation <=4'b0110;

if(functioncode==6'b100101)//or
 aluoperation <=4'b0001;

if(functioncode==6'b101010)//setless than
aluoperation=4'b0111;
end

else if (aluop==2'b00)
aluoperation <=4'b0010;

else if (aluop==2'b01)
 aluoperation <=4'b0110;

else //dont care
 aluoperation <=4'b0110;
end

endmodule



module alucontroltest;
reg  [1:0] aluop;
reg  [5:0] functioncode;
wire [3:0] aluoperation;
alu_control_single g1 ( aluop , functioncode ,aluoperation);

initial 
begin 
$monitor(" aluop= %b   functioncode=%b     aluoperation=%b  ",aluop,functioncode ,aluoperation);
#10 
aluop=00;

#10 
aluop='b01;

#10 
aluop='b10;
functioncode='b100000;
end

endmodule
