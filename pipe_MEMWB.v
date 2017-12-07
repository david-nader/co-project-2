//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none

module EXMEM (clk,
		//inputs:
		wb_RegWrite, wb_MemToReg,
		DataMemory_ReadData, ExMem_AluResult, ExMem_MuxRegDst,
		//outpus:
		wb_RegWrite_out, wb_MemToReg_out,
		DataMemory_ReadData_out, ExMem_AluResult_out, ExMem_MuxRegDst_out);

//inputs:
input wire clk;
input wire wb_RegWrite, wb_MemToReg;
input wire [31:0] DataMemory_ReadData, ExMem_AluResult;
input wire [4:0] ExMem_MuxRegDst;
//outputs:
output reg wb_RegWrite_out, wb_MemToReg_out;
output reg [31:0] DataMemory_ReadData_out, ExMem_AluResult_out;
output reg [4:0] ExMem_MuxRegDst_out;


always @(posedge clk) begin

wb_RegWrite_out <= wb_RegWrite;
wb_MemToReg_out <= wb_MemToReg;

DataMemory_ReadData_out <= DataMemory_ReadData;
ExMem_AluResult_out <= ExMem_AluResult;
ExMem_MuxRegDst_out <= ExMem_MuxRegDst_out;

end //always

endmodule


/*
module MEM_WB (clock,Inst,
		WB,Dest_reg,Alu_out,Forwarding_in,Instreg,Alu_outreg,WB_out);
input clock;
input [31:0] Inst,Alu_out;
input [1:0] WB;
input [4:0] Dest_reg;
output [4:0] Forwarding_in;
output [31:0] Instreg,Alu_outreg;
output [1:0] WB_out;

reg [4:0] Forwarding_in;
reg [31:0] Instreg,Alu_outreg;
reg [1:0] WB_out;

initial
begin
Forwarding_in=0;
Instreg=0;
Alu_outreg=0;
WB_out=0;
end
always @ (posedge clock)
begin
Forwarding_in <= Dest_reg;
Instreg <= Inst;
Alu_outreg <= Alu_out;
WB_out <= WB;
end
endmodule

*/