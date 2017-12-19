
module forward_memory (EXMEM_MemWrite, MEMWB_MemToReg, MEMWB_RegisterRt,EXMEM_RegisterRt ,forwardM );
input MEMWB_MemToReg;
input EXMEM_MemWrite;
input [4:0] MEMWB_RegisterRt;
input [4:0] EXMEM_RegisterRt;
output reg forwardM ;

/*
Forward memory (from lw to sw) when:

	(the instruction in WB stage is lw)
	and (the instruction in Mem stage is sw)
	and (the sw.rt was changed by lw)

i.e. when:
	(MEM/WB.MemToReg == 1) &&
	(EX/MEM.MemWrite == 1) &&
	(EX/MEM.Rt == MEM/WB.Rt)
*/
always@(*)
begin
if (MEMWB_MemToReg && EXMEM_MemWrite && (MEMWB_RegisterRt == EXMEM_RegisterRt))
forwardM <= 1'b1;
else
forwardM <= 1'b0;
end
endmodule



//testbench needs updating after the
//changes made to the DUT
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
forward_memory g3(opcode, MEMWB_RegisterRt,EXMEM_RegisterRt ,forwardM );
endmodule
