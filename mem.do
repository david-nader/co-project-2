restart

run 5
mem save -dataradix decimal -addressradix dec -wordsperline 4 -noaddress \
-outfile "Output_RegFile_before.txt" /cpu_pipe_testbench/DUT/RegFile/memory

mem save -dataradix decimal -addressradix dec -wordsperline 4 -noaddress -endaddress 63 \
-outfile "Output_DMem_before.txt" /cpu_pipe_testbench/DUT/DMem/memory

mem save -dataradix hex -addressradix dec -wordsperline 4 -noaddress -endaddress 63 \
-outfile "Output_IMem_before.txt" /cpu_pipe_testbench/DUT/IMem/memory


# Then run the reset of simulation

run 30
mem save -dataradix decimal -addressradix dec -wordsperline 4 -noaddress \
-outfile "Output_RegFile_after.txt" /cpu_pipe_testbench/DUT/RegFile/memory

mem save -dataradix decimal -addressradix dec -wordsperline 4 -noaddress -endaddress 63 \
-outfile "Output_DMem_after.txt" /cpu_pipe_testbench/DUT/DMem/memory