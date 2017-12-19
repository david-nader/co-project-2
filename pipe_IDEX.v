//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none

/*
Control has 8 signals (9 bits/wires):

RegDst, AluOp[1:0], AluSrc
Branch, MemRead, MemWrite
RegWrite, MemToReg
*/

module IDEX (clk, reset,
		//inputs:
		wb_RegWrite, wb_MemToReg,
		mem_MemRead, mem_MemWrite,
		ex_RegDst, ex_AluSrc, ex_AluOp, ex_branch,
		pc4, read_data1, read_data2, immediate, rs, rt, rd,
		//outpus:
		wb_RegWrite_out, wb_MemToReg_out,
		mem_MemRead_out, mem_MemWrite_out,
		ex_RegDst_out, ex_AluSrc_out, ex_AluOp_out, ex_branch_out,
		pc4_out, read_data1_out, read_data2_out, immediate_out, rs_out, rt_out, rd_out);
//inputs:
input wire clk, reset;
input wire wb_RegWrite, wb_MemToReg,
	   mem_MemRead, mem_MemWrite,
	   ex_RegDst, ex_AluSrc, ex_branch;
input wire [1:0] ex_AluOp;
input wire [31:0] pc4, read_data1, read_data2;
input wire [15:0] immediate;
input wire [4:0] rs, rt, rd;
//outputs:
output reg wb_RegWrite_out, wb_MemToReg_out,
	   mem_MemRead_out, mem_MemWrite_out,
	   ex_RegDst_out, ex_AluSrc_out, ex_branch_out;
output reg [1:0] ex_AluOp_out;
output reg [31:0] pc4_out, read_data1_out, read_data2_out;
output reg [15:0] immediate_out;
output reg [4:0] rs_out, rt_out, rd_out;

always @(posedge clk) begin

if(!reset) begin
wb_RegWrite_out <= wb_RegWrite;
wb_MemToReg_out <= wb_MemToReg;
mem_MemRead_out <= mem_MemRead;
mem_MemWrite_out <= mem_MemWrite;
ex_RegDst_out <= ex_RegDst;
ex_AluSrc_out <= ex_AluSrc;
ex_AluOp_out <= ex_AluOp;
ex_branch_out <= ex_branch;

pc4_out <= pc4;
read_data1_out <= read_data1;
read_data2_out <= read_data2;
immediate_out <= immediate;
rs_out <= rs;
rt_out <= rt;
rd_out <= rd;
end
else if(reset)
//required to ensure the PC will initially
//increment before an instruction reaches
//MEM stage, where it's control signals,
//specifically the Branch signal,
//would have propagated through the pipeline
//till it gives a valid input to the
//BranchAnd gate
ex_branch_out <= 1'd0;

end //always

endmodule

