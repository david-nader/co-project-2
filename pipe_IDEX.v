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

always @(posedge clk or posedge reset) begin

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

//this is to make sure PC *starts* incrementing,
//before the first instruction reaches EX stage,
//OR when no instruction reaches EX stage at all.
//This is because MuxBranch depends on the signal
//from ID/EX, which won't be known before two
//clock cycles from the time the first instruction
//that is read from Instructions Memory enters Fetch
//stage.
//This should prevent problems when beq is the first
//instruction in execution (verify?), otherwise,
//a branch might occur, because beq reaches ID/EX
//while reset is asserted, but now, while reset is
//asserted, it is guaranteed that no branch will
//occur.
//To test this, keep the instructions memory empty
//and run the simulation
if(reset) begin
ex_branch_out <= 1'd0;
end //if

end //always

endmodule


/*
module ID_EX (clock,Branch_signal,WB,M,EX,pc4,Data_1,Data_2,immvalue,Rs,Rt,Rd,
		WB_out,Branch_signal_out,M_out,EX_out,Rs_out,Rt_out,Rd_out,Data_1_out,Data_2_out,immvalue_out,pc4_out);

input clock,Branch_signal;
input [1:0] WB;
input [2:0] M;
input [2:0] EX;
input [31:0] pc4,Data_1,Data_2,immvalue;
input [4:0] Rs,Rt,Rd;

output Branch_signal_out;
output [1:0] WB_out;
output [2:0] M_out; 
output [2:0] EX_out;
output [4:0] Rs_out,Rt_out,Rd_out;
output [31:0] Data_1_out,Data_2_out,immvalue_out,pc4_out;

reg Branch_signal_out;
reg [1:0] WB_out;
reg [2:0] M_out; 
reg [2:0] EX_out;
reg [4:0] Rs_out,Rt_out,Rd_out;
reg [31:0] Data_1_out,Data_2_out,immvalue_out,pc4_out;

initial
begin
Branch_signal_out=0;
WB_out=0;
M_out=0; 
EX_out=0;
Rs_out=0;
Rt_out=0;
Rd_out=0;
Data_1_out=0;
Data_2_out=0;
immvalue_out=0;
pc4_out=0;
end
always @ (posedge clock)
begin
Branch_signal_out <=Branch_signal;
WB_out <= WB;
M_out <= M; 
EX_out <= EX;
Rs_out <= Rs;
Rt_out <= Rt;
Rd_out <= Rd;
Data_1_out <= Data_1;
Data_2_out <= Data_2;
immvalue_out <= immvalue;
pc4_out <= pc4;

end
endmodule

*/
