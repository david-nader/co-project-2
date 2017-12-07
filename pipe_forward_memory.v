
module memoryforwardunit (opcode, MEMWB_RegisterRt,EXMEM_RegisterRt ,forwardM );
input [5:0] opcode;
input [4:0] MEMWB_RegisterRt;
input [4:0] EXMEM_RegisterRt;
output reg forwardM ;

always@(*)
begin
if ((MEMWB_RegisterRt == EXMEM_RegisterRt) && (opcode == 6'b100011))
forwardM <= 1'b1;
else
forwardM <= 1'b0;
end  //always
endmodule




module testmemoryforwarding;
reg [5:0] opcode;
reg [4:0] MEMWB_RegisterRt;
reg [4:0] EXMEM_RegisterRt;
wire forwardM ;

initial 
begin 
$monitor("opcode=%d MEMWB_RegisterRt=%d EXMEM_RegisterRt=%d  forwardM=%b    ",opcode,MEMWB_RegisterRt,EXMEM_RegisterRt,forwardM);
#10
opcode<=6'b100011;
MEMWB_RegisterRt<=1;
EXMEM_RegisterRt<=1;

#10
opcode<=6'b100011;
MEMWB_RegisterRt<=6;
EXMEM_RegisterRt<=1;

#10
opcode<=6'b100111;
MEMWB_RegisterRt<=1;
EXMEM_RegisterRt<=1;
end
memoryforwardunit g3 (opcode, MEMWB_RegisterRt,EXMEM_RegisterRt ,forwardM );
endmodule
