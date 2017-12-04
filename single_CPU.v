//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none


module cpu_single(clk, reset);

input wire clk;
input wire reset;

reg [31:0] pc;

//Conventions for naming internal wires:
//1. ModuleName_PortName: wire from RegDst MUX output port
//2. CamelCase
//3. CamelCase also for abbreviations (eg AluControl, not ALUControl)

wire [31:0] InstMemory_Instruction;
wire [31:0] DataMemory_ReadData;
wire Control_RegDst, Control_Branch, Control_MemRead, Control_MemtoReg;
wire Control_MemWrite, Control_AluSrc, Control_RegWrite;
wire [1:0] Control_AluOp;
wire [4:0] MuxRegDst_Output;
wire [31:0] MuxMemToReg_Output;
wire [31:0] MuxAluSrc_Output;
wire [31:0] MuxBranch_Output;
wire [3:0] AluControl_Output;
wire [31:0] SignExtend_Output;
wire [31:0] ShiftLeft2_Output;
wire [31:0] Alu_Result;
wire Alu_Zero;
wire [31:0] Reg_ReadData1, Reg_ReadData2;
wire [31:0] AdderPC_Result;
wire [31:0] AdderBeq_Result;
wire And_Output;


instructions_memory IMem(InstMemory_Instruction, pc, clk, reset);

alu_adder AdderPC(pc, 4, AdderPC_Result);

mux_5x2 MUXRegDst(InstMemory_Instruction[20:16], InstMemory_Instruction[15:11], Control_RegDst, MuxRegDst_Output);

register_file Regs(InstMemory_Instruction[25:21],
		InstMemory_Instruction[20:16],
		MuxRegDst_Output,
		Reg_ReadData1,
		Reg_ReadData2,
		MuxMemToReg_Output,
		Control_RegWrite,
		clk);

control Control(InstMemory_Instruction[31:26],
		Control_Branch,
		Control_AluOp,
		Control_MemRead,
		Control_MemWrite,
		Control_MemtoReg,
		Control_RegDst,
		Control_RegWrite,
		Control_AluSrc);

mux_32x2 MUXALUSrc(Reg_ReadData2, SignExtend_Output, Control_AluSrc, MuxAluSrc_Output);

alu ALU(Alu_Result, Alu_Zero, Reg_ReadData1, MuxAluSrc_Output, InstMemory_Instruction[10:6], AluControl_Output);

alu_control ALUControl(Control_AluOp, InstMemory_Instruction[5:0], AluControl_Output);

sign_extend SignExtend(InstMemory_Instruction[15:0], SignExtend_Output);

shift_left_2 ShiftLeft2(SignExtend_Output , ShiftLeft2_Output);

alu_adder AdderBeq(AdderPC_Result, ShiftLeft2_Output, AdderBeq_Result);

and ANDBranch(And_Output, Control_Branch, Alu_Zero);

mux_32x2 MUXBranch(AdderPC_Result, AdderBeq_Result, And_Output, MuxBranch_Output);

data_memory DMem(DataMemory_ReadData, Alu_Result, Reg_ReadData2, Control_MemWrite, Control_MemRead, clk);

mux_32x2 MUXMemToReg(Alu_Result, DataMemory_ReadData, Control_MemtoReg, MuxMemToReg_Output);

always @(posedge clk)
pc <= MuxBranch_Output;

endmodule






module cpu_single_testbench;

reg clk, reset;

cpu_single DUT(clk, reset);
integer i;

always #1 clk = ~clk;

initial begin
clk = 0;
reset = 0;
//initialize register file with some values
for(i=0; i<32; i=i+1) begin
	DUT.Regs.memory[i] = i * 10;
end //for

#10
reset = 1;

#10
reset = 0;

end //initial

endmodule

