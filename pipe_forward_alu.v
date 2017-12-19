
module forward_alu (EXMEM_MemRead, EXMEM_RegWrite, EXMEM_RegisterRd, IDEX_RegisterRs, IDEX_RegisterRt, MEMWB_RegWrite, MEMWB_RegisterRd,forwardA ,forwardB);
input wire EXMEM_MemRead;
input wire EXMEM_RegWrite;
input wire MEMWB_RegWrite;
input wire[4:0] EXMEM_RegisterRd;
input wire[4:0] MEMWB_RegisterRd;
input wire[4:0] IDEX_RegisterRs ;
input wire[4:0] IDEX_RegisterRt ;

output reg[1:0] forwardA;
output reg[1:0] forwardB;

/* EX hazard:
if (EX/MEM.RegWrite
and (EX/MEM.RegisterRd ? 0)
and (EX/MEM.RegisterRd = ID/EX.RegisterRs)) ForwardA = 10

if (EX/MEM.RegWrite
and (EX/MEM.RegisterRd ? 0)
and (EX/MEM.RegisterRd = ID/EX.RegisterRt)) ForwardB = 10
*/

/* MEM hazard:
if (MEM/WB.RegWrite
and (MEM/WB.RegisterRd ? 0)
and ( MEM/WB.RegisterRd = ID/EX.RegisterRs)) ForwardA = 01
and not (EX hazard...)

if (MEM/WB.RegWrite
and (MEM/WB.RegisterRd ? 0)
and (MEM/WB.RegisterRd = ID/EX.RegisterRt)) ForwardB = 01
and not (EX hazard...)
*/

always @(*)
begin
//default values when no forwarding
forwardA<=2'b00;
forwardB<=2'b00;

//alu to alu forwarding
if(	(EXMEM_RegWrite==1) &&
	(EXMEM_RegisterRd != 0) &&
	(EXMEM_RegisterRd == IDEX_RegisterRs) &&
	//and if previous instruction is NOT lw (only needed when current instruction is sw)
	//which would happen because hazard unit ignores the case of lw then sw, leaving
	//it for the mem-to-mem forwarding unit
	(EXMEM_MemRead != 1)
)
begin 
	forwardA<=2'b10;
	if((EXMEM_RegWrite==1) && (EXMEM_RegisterRd != 0) &&( EXMEM_RegisterRd == IDEX_RegisterRt))
	forwardB<=2'b10;
end 
else if((EXMEM_RegWrite==1) &&
	(EXMEM_RegisterRd != 0) &&
	(EXMEM_RegisterRd == IDEX_RegisterRt) &&
	(EXMEM_MemRead != 1)
)
begin
	forwardB<=2'b10;
end 


//memory to alu forwarding:
if (
	( (MEMWB_RegWrite==1) && (MEMWB_RegisterRd != 0) && (MEMWB_RegisterRd == IDEX_RegisterRs) )
	&& //and not EX hazard (rs):
	!( (EXMEM_RegWrite==1) && (EXMEM_RegisterRd != 0) && (EXMEM_RegisterRd == IDEX_RegisterRs) && (EXMEM_MemRead != 1) )
)
begin
	forwardA<=2'b01;
	if ((MEMWB_RegWrite==1)&& (MEMWB_RegisterRd != 0)&& (MEMWB_RegisterRd == IDEX_RegisterRt))
	forwardB<=2'b01;
end 
else if (
	( (MEMWB_RegWrite==1)&& (MEMWB_RegisterRd != 0)&& (MEMWB_RegisterRd == IDEX_RegisterRt) )
	&& //and not EX hazard (rt):
	!( (EXMEM_RegWrite==1) && (EXMEM_RegisterRd != 0) && (EXMEM_RegisterRd == IDEX_RegisterRt) && (EXMEM_MemRead != 1) )
)
begin
	forwardB<=2'b01;
end

end //always

endmodule




//testbench needs updating after the
//changes made to the DUT
module testforwardunit;
reg [4:0] MEMWB_RegisterRd;
reg [4:0] EXMEM_RegisterRd;
reg [4:0] IDEX_RegisterRs;
reg [4:0] IDEX_RegisterRt;
reg [1:0] MEMWB_RegWrite;
reg [1:0] EXMEM_RegWrite;

wire [1:0] forwardA;
wire [1:0] forwardB;

initial begin
$display ("MEMWB_RegisterRd=%d  ,EXMEM_RegisterRd=%d  ,IDEX_RegisterRs=%d  , IDEX_RegisterRt=%d  MEMWB_RegWrite=%d EXMEM_RegWrite=%d forwardA=%b forwardB=%b ",
	MEMWB_RegisterRd,EXMEM_RegisterRd,
	IDEX_RegisterRs,IDEX_RegisterRt,MEMWB_RegWrite,EXMEM_RegWrite,forwardA,forwardB);

#10
MEMWB_RegisterRd='d10;
EXMEM_RegisterRd='d1;//don't care
IDEX_RegisterRs='d1;
IDEX_RegisterRt='d5;

MEMWB_RegWrite='b1;
EXMEM_RegWrite='b1;

$display ("MEMWB_RegisterRd=%d  ,EXMEM_RegisterRd=%d  ,IDEX_RegisterRs=%d  , IDEX_RegisterRt=%d  MEMWB_RegWrite=%d EXMEM_RegWrite=%d forwardA=%b forwardB=%b ",
	MEMWB_RegisterRd,EXMEM_RegisterRd,
	IDEX_RegisterRs,IDEX_RegisterRt,MEMWB_RegWrite,EXMEM_RegWrite,forwardA,forwardB);

#10
MEMWB_RegisterRd='d5;
EXMEM_RegisterRd='d3;
IDEX_RegisterRs='d5;
IDEX_RegisterRt='d4;

MEMWB_RegWrite='b1;
EXMEM_RegWrite='b1;

$display ("MEMWB_RegisterRd=%d  ,EXMEM_RegisterRd=%d  ,IDEX_RegisterRs=%d  , IDEX_RegisterRt=%d  MEMWB_RegWrite=%d EXMEM_RegWrite=%d forwardA=%b forwardB=%b ",
	MEMWB_RegisterRd,EXMEM_RegisterRd,
	IDEX_RegisterRs,IDEX_RegisterRt,MEMWB_RegWrite,EXMEM_RegWrite,forwardA,forwardB);

#10
MEMWB_RegisterRd='d5;
EXMEM_RegisterRd='d5;
IDEX_RegisterRs='d5;
IDEX_RegisterRt='d7;

MEMWB_RegWrite='b1;
EXMEM_RegWrite='b1;

$display ("MEMWB_RegisterRd=%d  ,EXMEM_RegisterRd=%d  ,IDEX_RegisterRs=%d  , IDEX_RegisterRt=%d  MEMWB_RegWrite=%d EXMEM_RegWrite=%d forwardA=%b forwardB=%b ",
	MEMWB_RegisterRd,EXMEM_RegisterRd,
	IDEX_RegisterRs,IDEX_RegisterRt,MEMWB_RegWrite,EXMEM_RegWrite,forwardA,forwardB);

#10
MEMWB_RegisterRd='d1;
EXMEM_RegisterRd='d1;
IDEX_RegisterRs='d5;
IDEX_RegisterRt='d5;

MEMWB_RegWrite='b1;
EXMEM_RegWrite='b0;

$display ("MEMWB_RegisterRd=%d  ,EXMEM_RegisterRd=%d  ,IDEX_RegisterRs=%d  , IDEX_RegisterRt=%d  MEMWB_RegWrite=%d EXMEM_RegWrite=%d forwardA=%b forwardB=%b ",
	MEMWB_RegisterRd,EXMEM_RegisterRd,
	IDEX_RegisterRs,IDEX_RegisterRt,MEMWB_RegWrite,EXMEM_RegWrite,forwardA,forwardB);

#10
MEMWB_RegisterRd='d5;
EXMEM_RegisterRd='d5;
IDEX_RegisterRs='d5;
IDEX_RegisterRt='d5;

MEMWB_RegWrite='b1;
EXMEM_RegWrite='b1;

$display ("MEMWB_RegisterRd=%d  ,EXMEM_RegisterRd=%d  ,IDEX_RegisterRs=%d  , IDEX_RegisterRt=%d  MEMWB_RegWrite=%d EXMEM_RegWrite=%d forwardA=%b forwardB=%b ",
	MEMWB_RegisterRd,EXMEM_RegisterRd,
	IDEX_RegisterRs,IDEX_RegisterRt,MEMWB_RegWrite,EXMEM_RegWrite,forwardA,forwardB);
end //initial

forward_alu g1 (EXMEM_RegWrite, EXMEM_RegisterRd, IDEX_RegisterRs, IDEX_RegisterRt, MEMWB_RegWrite, MEMWB_RegisterRd,forwardA ,forwardB);
endmodule 