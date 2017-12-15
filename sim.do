vsim cpu_pipe_testbench

add wave -position insertpoint  \
sim:/cpu_pipe_testbench/DUT/reset \
sim:/cpu_pipe_testbench/DUT/clk


add wave -group "PC-related" -position insertpoint  \
sim:/cpu_pipe_testbench/DUT/PC_output \
sim:/cpu_pipe_testbench/DUT/AdderPc_Output \
sim:/cpu_pipe_testbench/DUT/ShiftLeft2_Output \
sim:/cpu_pipe_testbench/DUT/AdderBeq_Result \
sim:/cpu_pipe_testbench/DUT/And_Output \
sim:/cpu_pipe_testbench/DUT/MuxBranch_Output


add wave -group "Fetch" -position insertpoint  \
sim:/cpu_pipe_testbench/DUT/InstMem_ReadData


add wave -group "Decode" -position insertpoint  \
sim:/cpu_pipe_testbench/DUT/IFID_Pc4 \
sim:/cpu_pipe_testbench/DUT/IFID_Instruction \
sim:/cpu_pipe_testbench/DUT/Hazard_PcHold \
sim:/cpu_pipe_testbench/DUT/Hazard_IFIDHold \
sim:/cpu_pipe_testbench/DUT/Hazard_Mux \
sim:/cpu_pipe_testbench/DUT/Reg_ReadData1 \
sim:/cpu_pipe_testbench/DUT/Reg_ReadData2 \
sim:/cpu_pipe_testbench/DUT/Control_RegWrite \
sim:/cpu_pipe_testbench/DUT/Control_RegDst \
sim:/cpu_pipe_testbench/DUT/Control_MemtoReg \
sim:/cpu_pipe_testbench/DUT/Control_MemWrite \
sim:/cpu_pipe_testbench/DUT/Control_MemRead \
sim:/cpu_pipe_testbench/DUT/Control_Branch \
sim:/cpu_pipe_testbench/DUT/Control_AluSrc \
sim:/cpu_pipe_testbench/DUT/Control_AluOp \
sim:/cpu_pipe_testbench/DUT/MuxHazard_Output


add wave -group "Execute" -position insertpoint  \
sim:/cpu_pipe_testbench/DUT/IDEX_Rs \
sim:/cpu_pipe_testbench/DUT/IDEX_Rt \
sim:/cpu_pipe_testbench/DUT/IDEX_Rd \
sim:/cpu_pipe_testbench/DUT/IDEX_Immediate \
sim:/cpu_pipe_testbench/DUT/IDEX_RegWrite \
sim:/cpu_pipe_testbench/DUT/IDEX_RegDst \
sim:/cpu_pipe_testbench/DUT/IDEX_ReadData1 \
sim:/cpu_pipe_testbench/DUT/IDEX_ReadData2 \
sim:/cpu_pipe_testbench/DUT/IDEX_Pc4 \
sim:/cpu_pipe_testbench/DUT/IDEX_MemWrite \
sim:/cpu_pipe_testbench/DUT/IDEX_MemToReg \
sim:/cpu_pipe_testbench/DUT/IDEX_MemRead \
sim:/cpu_pipe_testbench/DUT/IDEX_Branch \
sim:/cpu_pipe_testbench/DUT/IDEX_AluSrc \
sim:/cpu_pipe_testbench/DUT/IDEX_AluOp \
sim:/cpu_pipe_testbench/DUT/MuxRegDst_Output \
sim:/cpu_pipe_testbench/DUT/SignExtend_Output \
sim:/cpu_pipe_testbench/DUT/MuxAluSrc_Output \
sim:/cpu_pipe_testbench/DUT/ForwardAlu_ForwardB \
sim:/cpu_pipe_testbench/DUT/ForwardAlu_ForwardA \
sim:/cpu_pipe_testbench/DUT/MuxForwardA_Output \
sim:/cpu_pipe_testbench/DUT/MuxForwardB_Output \
sim:/cpu_pipe_testbench/DUT/Alu_Zero \
sim:/cpu_pipe_testbench/DUT/Alu_Result \
sim:/cpu_pipe_testbench/DUT/AluControl_Output


add wave -group "Memory" -position insertpoint  \
sim:/cpu_pipe_testbench/DUT/EXMEM_RegWrite \
sim:/cpu_pipe_testbench/DUT/EXMEM_MuxRegDst \
sim:/cpu_pipe_testbench/DUT/EXMEM_MuxForwardB \
sim:/cpu_pipe_testbench/DUT/EXMEM_MemWrite \
sim:/cpu_pipe_testbench/DUT/EXMEM_MemToReg \
sim:/cpu_pipe_testbench/DUT/EXMEM_MemRead \
sim:/cpu_pipe_testbench/DUT/EXMEM_AluResult \
sim:/cpu_pipe_testbench/DUT/DataMemory_ReadData \
sim:/cpu_pipe_testbench/DUT/ForwardMem_ForwardWriteData \
sim:/cpu_pipe_testbench/DUT/MuxWriteData_Output


add wave -group "Write Back" -position insertpoint  \
sim:/cpu_pipe_testbench/DUT/MEMWB_RegWrite \
sim:/cpu_pipe_testbench/DUT/MEMWB_ReadData \
sim:/cpu_pipe_testbench/DUT/MEMWB_MuxRegDst \
sim:/cpu_pipe_testbench/DUT/MEMWB_MemToReg \
sim:/cpu_pipe_testbench/DUT/MEMWB_AluResult \
sim:/cpu_pipe_testbench/DUT/MuxMemToReg_Output


run 50