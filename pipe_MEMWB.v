//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none

module MEMWB (clk, reset,
		//inputs:
		wb_RegWrite, wb_MemToReg,
		DataMemory_ReadData, ExMem_AluResult, ExMem_MuxRegDst,
		//outpus:
		wb_RegWrite_out, wb_MemToReg_out,
		DataMemory_ReadData_out, ExMem_AluResult_out, ExMem_MuxRegDst_out);

//inputs:
input wire clk, reset;
input wire wb_RegWrite, wb_MemToReg;
input wire [31:0] DataMemory_ReadData, ExMem_AluResult;
input wire [4:0] ExMem_MuxRegDst;
//outputs:
output reg wb_RegWrite_out, wb_MemToReg_out;
output reg [31:0] DataMemory_ReadData_out, ExMem_AluResult_out;
output reg [4:0] ExMem_MuxRegDst_out;


always @(posedge clk) begin
if(!reset) begin
wb_RegWrite_out <= wb_RegWrite;
wb_MemToReg_out <= wb_MemToReg;

DataMemory_ReadData_out <= DataMemory_ReadData;
ExMem_AluResult_out <= ExMem_AluResult;
ExMem_MuxRegDst_out <= ExMem_MuxRegDst;
end //if
end //always

endmodule

