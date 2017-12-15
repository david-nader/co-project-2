//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none

module EXMEM (clk, reset,
		//inputs:
		wb_RegWrite, wb_MemToReg,
		mem_MemRead, mem_MemWrite,
		AluResult, MuxForwardB, MuxRegDst,
		//outpus:
		wb_RegWrite_out, wb_MemToReg_out,
		mem_MemRead_out, mem_MemWrite_out,
		AluResult_out, MuxForwardB_out, MuxRegDst_out);

//inputs:
input wire clk, reset;
input wire wb_RegWrite, wb_MemToReg,
	   mem_MemRead, mem_MemWrite;
input wire [31:0] AluResult, MuxForwardB;
input wire [4:0] MuxRegDst;
//outputs:
output reg wb_RegWrite_out, wb_MemToReg_out,
	   mem_MemRead_out, mem_MemWrite_out;
output reg [31:0] AluResult_out, MuxForwardB_out;
output reg [4:0] MuxRegDst_out;

always @(posedge clk) begin

if(!reset) begin
wb_RegWrite_out <= wb_RegWrite;
wb_MemToReg_out <= wb_MemToReg;
mem_MemRead_out <= mem_MemRead;
mem_MemWrite_out <= mem_MemWrite;

AluResult_out <= AluResult;
MuxForwardB_out <= MuxForwardB;
MuxRegDst_out <= MuxRegDst;
end //if
end //always

endmodule



/*

module EX_MEM (clock,Inst,
		Alu_out, Dest_reg, WB, M, Forwarding_in,
		WB_out, M_out, Instreg, Alu_outreg);
input clock;
input [1:0] WB;
input [2:0] M;
input [31:0] Inst,Alu_out;
input [4:0] Dest_reg;

output [4:0] Forwarding_in;
output [1:0] WB_out;
output [2:0] M_out;
output [31:0] Instreg,Alu_outreg;

reg [4:0] Forwarding_in;
reg [1:0] WB_out;
reg [2:0] M_out;
reg [31:0] Instreg,Alu_outreg;

initial
begin
Forwarding_in=0;
Instreg=0;
Alu_outreg=0;
WB_out=0;
M_out=0;
end
always @ (posedge clock)
begin
Forwarding_in <= Dest_reg;
Instreg <= Inst;
Alu_outreg <= Alu_out;
WB_out <= WB;
M_out <= M;
end
endmodule

*/


