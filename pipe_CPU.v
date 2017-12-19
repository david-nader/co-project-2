//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none


module cpu_pipe(clk, reset);

input wire clk;
input wire reset;

//--------------------------------------
//	Internal Wires
//--------------------------------------

//By defining a wire for every output in each module,
//we get a list of all internal wires
//
//Conventions for naming internal wires:
//1. ModuleName_PortName
//2. CamelCase
//3. CamelCase also for abbreviations (eg AluControl, not ALUControl) except pipeline registers
// e.g. MuxRegDst_Output: wire from RegDst MUX output port


//Fetch
wire [31:0] PC_output, InstMem_ReadData, MuxBranch_Output;
wire And_Output;
wire [31:0] AdderPc_Output;

wire [31:0] IFID_Instruction, IFID_Pc4;

//Decode
wire Control_RegDst, Control_Branch, Control_MemRead, Control_MemtoReg;
wire Control_MemWrite, Control_AluSrc, Control_RegWrite;
wire [1:0] Control_AluOp;
wire [31:0] Reg_ReadData1, Reg_ReadData2;
wire [8:0] MuxHazard_Output;
wire Hazard_IFIDHold, Hazard_PcHold, Hazard_Mux, Hazard_IFIDFlush;

wire IDEX_RegWrite, IDEX_MemToReg, IDEX_MemRead, IDEX_MemWrite, IDEX_Branch, IDEX_RegDst, IDEX_AluSrc;
wire [1:0] IDEX_AluOp;
wire [31:0] IDEX_Pc4, IDEX_ReadData1, IDEX_ReadData2;
wire [15:0] IDEX_Immediate;
wire [4:0] IDEX_Rs, IDEX_Rt, IDEX_Rd;

//Execute
wire [31:0] SignExtend_Output;
wire [31:0] ShiftLeft2_Output;
wire [31:0] AdderBeq_Result;
wire [31:0] MuxForwardA_Output, MuxForwardB_Output, MuxAluSrc_Output;
wire [4:0] MuxRegDst_Output;
wire [3:0] AluControl_Output;
wire [31:0] Alu_Result;
wire Alu_Zero;
wire [1:0] ForwardAlu_ForwardA, ForwardAlu_ForwardB;

wire EXMEM_RegWrite, EXMEM_MemToReg, EXMEM_MemRead, EXMEM_MemWrite;
wire [31:0] EXMEM_AluResult, EXMEM_MuxForwardB;
wire [4:0] EXMEM_MuxRegDst;

//Memory
wire [31:0] MuxWriteData_Output;
wire [31:0] DataMemory_ReadData;
wire ForwardMem_ForwardWriteData;

wire MEMWB_RegWrite, MEMWB_MemToReg;
wire [31:0] MEMWB_ReadData, MEMWB_AluResult;
wire [4:0] MEMWB_MuxRegDst;

//Write Back
wire [31:0] MuxMemToReg_Output;


//--------------------------------------
//	Modules
//--------------------------------------

//Fetch
PC Pc(MuxBranch_Output, PC_output, reset, clk, Hazard_PcHold);
instructions_memory IMem(InstMem_ReadData, PC_output, clk, reset);
alu_adder AdderPc(4, PC_output, AdderPc_Output);
mux_32x2 MuxBranch(AdderPc_Output, AdderBeq_Result, And_Output, MuxBranch_Output);
and AndGate(And_Output, IDEX_Branch, Alu_Zero);

IFID IFIDReg(clk, reset, InstMem_ReadData, AdderPc_Output,
	Hazard_IFIDHold, IFID_Pc4, IFID_Instruction, Hazard_IFIDFlush);

//Decode
hazard HazardUnit(IDEX_MemRead, Control_MemWrite, IDEX_Rt, IFID_Instruction[25:21], IFID_Instruction[20:16],
			Hazard_PcHold, Hazard_IFIDHold, Hazard_Mux, Control_Branch, IDEX_Branch, Hazard_IFIDFlush,
			And_Output);
control ControlUnit(	reset,
			IFID_Instruction[31:26],
			Control_Branch,
			Control_AluOp,
			Control_MemRead, Control_MemWrite, Control_MemtoReg,
			Control_RegDst, Control_RegWrite, Control_AluSrc);
register_file RegFile(IFID_Instruction[25:21], IFID_Instruction[20:16], MEMWB_MuxRegDst,
		Reg_ReadData1, Reg_ReadData2, MuxMemToReg_Output, MEMWB_RegWrite, clk);

mux_9x2 MuxHazard(	{
				Control_RegWrite, Control_MemtoReg,
				Control_MemRead, Control_MemWrite,
				Control_RegDst, Control_AluSrc, Control_AluOp, Control_Branch
			},
			9'd0,
			Hazard_Mux, MuxHazard_Output);

IDEX IDEXReg(clk, reset,
		//inputs:
		MuxHazard_Output[8], MuxHazard_Output[7],
		MuxHazard_Output[6], MuxHazard_Output[5],
		MuxHazard_Output[4], MuxHazard_Output[3], MuxHazard_Output[2:1], MuxHazard_Output[0],
		IFID_Pc4, Reg_ReadData1, Reg_ReadData2, IFID_Instruction[15:0], IFID_Instruction[25:21], IFID_Instruction[20:16], IFID_Instruction[15:11],
		//outpus:
		IDEX_RegWrite, IDEX_MemToReg,
		IDEX_MemRead, IDEX_MemWrite,
		IDEX_RegDst, IDEX_AluSrc, IDEX_AluOp, IDEX_Branch,
		IDEX_Pc4, IDEX_ReadData1, IDEX_ReadData2, IDEX_Immediate, IDEX_Rs, IDEX_Rt, IDEX_Rd);

//Execute
mux_32x3 MuxForwardA(IDEX_ReadData1, MuxMemToReg_Output, EXMEM_AluResult, ForwardAlu_ForwardA, MuxForwardA_Output);
mux_32x3 MuxForwardB(IDEX_ReadData2, MuxMemToReg_Output, EXMEM_AluResult, ForwardAlu_ForwardB, MuxForwardB_Output);
mux_5x2 MuxRegDst(IDEX_Rt, IDEX_Rd, IDEX_RegDst, MuxRegDst_Output);
mux_32x2 MuxAluSrc(MuxForwardB_Output, SignExtend_Output, IDEX_AluSrc, MuxAluSrc_Output);
alu ALU(Alu_Result, Alu_Zero, MuxForwardA_Output, MuxAluSrc_Output, IDEX_Immediate[10:6], AluControl_Output);
sign_extend SignExtend(IDEX_Immediate, SignExtend_Output);
shift_left_2 ShiftLeft2(SignExtend_Output , ShiftLeft2_Output);
alu_adder AdderBeq(ShiftLeft2_Output, IDEX_Pc4, AdderBeq_Result);
alu_control AluControl(IDEX_AluOp, IDEX_Immediate[5:0], AluControl_Output);
forward_alu AluForwardUnit(	EXMEM_MemRead,
				EXMEM_RegWrite, EXMEM_MuxRegDst,
				IDEX_Rs, IDEX_Rt,
				MEMWB_RegWrite, MEMWB_MuxRegDst,
				ForwardAlu_ForwardA, ForwardAlu_ForwardB);

EXMEM EXMEMReg(clk, reset,
		//inputs:
		IDEX_RegWrite, IDEX_MemToReg,
		IDEX_MemRead, IDEX_MemWrite,
		Alu_Result, MuxForwardB_Output, MuxRegDst_Output,
		//outpus:
		EXMEM_RegWrite, EXMEM_MemToReg,
		EXMEM_MemRead, EXMEM_MemWrite,
		EXMEM_AluResult, EXMEM_MuxForwardB, EXMEM_MuxRegDst);

//Memory
mux_32x2 MuxWriteData(EXMEM_MuxForwardB, MuxMemToReg_Output, ForwardMem_ForwardWriteData, MuxWriteData_Output);
forward_memory MemoryForwardUnit(MEMWB_MemToReg, MEMWB_MuxRegDst, EXMEM_MuxRegDst , ForwardMem_ForwardWriteData);
data_memory DMem(DataMemory_ReadData, EXMEM_AluResult, MuxWriteData_Output, EXMEM_MemWrite, EXMEM_MemRead, clk);

MEMWB MEMWBReg(clk, reset,
		//inputs:
		EXMEM_RegWrite, EXMEM_MemToReg,
		DataMemory_ReadData, EXMEM_AluResult, EXMEM_MuxRegDst,
		//outpus:
		MEMWB_RegWrite, MEMWB_MemToReg,
		MEMWB_ReadData, MEMWB_AluResult, MEMWB_MuxRegDst);

//Write Back
mux_32x2 MuxMemToReg(MEMWB_AluResult, MEMWB_ReadData, MEMWB_MemToReg, MuxMemToReg_Output);

endmodule





module cpu_pipe_testbench;

reg clk, reset;

cpu_pipe DUT(clk, reset);
integer i;

always #1 clk = ~clk;

initial begin
clk = 0;
reset = 0;
//initialize register file with some values
for(i=0; i<32; i=i+1) begin
	DUT.RegFile.memory[i] = i * 10;
end //for
//initialize a part of Data memory
DUT.DMem.memory[0] = 0;
DUT.DMem.memory[1] = 0;
DUT.DMem.memory[2] = 0;
DUT.DMem.memory[3] = 99;



//make sure $monitor is before any delays,
//otherwise it starts printing after the delay
$monitor("time: %2t: ", $time,
	"reset: %d   ", reset,
	"op: %d, ", DUT.InstMem_ReadData[31:26],
	"rs: %d, ", DUT.InstMem_ReadData[25:21],
	"rt: %d, ", DUT.InstMem_ReadData[20:16],
	"[rd: %d, ", DUT.InstMem_ReadData[15:11],
	"shamt: %d, ", DUT.InstMem_ReadData[10:6],
	"funct: %d] | ", DUT.InstMem_ReadData[5:0],
	"[Immediate: %d]", DUT.InstMem_ReadData[15:0]);

#2
reset = 1;
#5
reset = 0;


end //initial

endmodule
