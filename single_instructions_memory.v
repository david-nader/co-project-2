
module instructions_memory(instruction, read_address, clk, reset);

output wire [31:0] instruction;

input wire [31:0] read_address; //address of byte (not word)
input wire clk;
input wire reset;

//memory size in words (word is 4 bytes)
parameter mem_size = 256;
reg [7:0] memory [0:mem_size*4-1];

assign instruction = {memory[read_address], memory[read_address+1], memory[read_address+2], memory[read_address+3]};

//reset is asynchronus
always @(posedge reset) begin
	//read instructions memory from file
	$readmemh("inst_mem.txt", memory);
end //always

endmodule



module instructions_memory_testbench;

wire [31:0] instruction;
reg [31:0] read_address;
reg clk;
reg reset;

instructions_memory DUT(instruction, read_address, clk, reset);

initial begin
$monitor("time: ", $time, "\n",
		"reset:        %b\n", reset,
		"read_address: %d (%b)\n", read_address, read_address,
		"instruction:  %d (%b)\n", instruction, instruction);
clk = 1;
reset = 0;

#10
reset = 1;
read_address = 0;

#10
reset = 0;

#10
read_address = 32;


end //initial

always #1 clk = ~clk;

endmodule