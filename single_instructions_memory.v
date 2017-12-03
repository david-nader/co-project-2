
module instructions_memory(instruction, read_address, clk, reset);

output reg [31:0] instruction;

input wire [31:0] read_address; //address of byte (not word)
input wire clk;
input wire reset;

//memory size in words (word is 4 bytes)
parameter mem_size = 256;
reg [7:0] memory [0:mem_size*4-1];

//reset is asynchronus 
always @(posedge clk or posedge reset) begin

if(reset)
	//read instructions memory from file
	$readmemb("inst_mem.txt", memory);
else
	instruction = {memory[read_address], memory[read_address+1], memory[read_address+2], memory[read_address+3]};

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