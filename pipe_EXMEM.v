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



