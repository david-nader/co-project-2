//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none


module cpu_pipe(clk, reset);

input wire clk;
input wire reset;

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
wire Hazard_IFIDHold, Hazard_PcHold, Hazard_Mux;

wire IDEX_RegWrite, IDEX_MemToReg, IDEX_MemRead, IDEX_MemWrite, IDEX_Branch, IDEX_RegDst, IDEX_AluSrc;
wire [1:0] IDEX_AluOp;
wire [31:0] IDEX_ReadData1, IDEX_ReadData2, IDEX_Immediate;
wire [4:0] IDEX_Rs, IDEX_Rt, IDEX_Rd;

//Execute
wire [31:0] SignExtend_Output;
wire [31:0] ShiftLeft2_Output;
wire [31:0] AdderBeq_Result;
wire [31:0] MuxForwardA_Output, MuxForwardB_Output, MuxRegDst_Output, MuxAluSrc_Output;
wire [3:0] AluControl_Output;
wire [31:0] Alu_Result;
wire Alu_Zero;
wire ForwardAlu_ForwardA, ForwardAlu_ForwardB;

wire EXMEM_RegWrite, EXMEM_MemToReg, EXMEM_MemRead, EXMEM_MemWrite;
wire [31:0] EXMEM_AluResult, EXMEM_MuxForwardB, EXMEM_MuxRegDst;

//Memory
wire [31:0] Mux_WriteData;
wire [31:0] DataMemory_ReadData;
wire ForwardMem_Mux;

wire MEMWB_RegWrite, MEMWB_MemToReg;
wire MEMWB_ReadData, MEMWB_AluResult, MEMWB_MuxRegDst;

//Write Back
wire [31:0] MuxMemToReg_Output;



endmodule
