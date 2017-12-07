
module data_memory(read_data, address, write_data, mem_write, mem_read, clk);

output reg [31:0] read_data;

input wire [31:0] address; //address of byte (not word)
input wire [31:0] write_data;
input wire mem_write;
input wire mem_read;
input wire clk;

//memory size in words (word is 4 bytes)
parameter mem_size = 256;
reg [7:0] memory [0:mem_size*4-1];

always @(negedge clk) begin
//read or write in a cycle, but not both
if(mem_read)
	read_data = {memory[address], memory[address+1], memory[address+2], memory[address+3]};
else if(mem_write)
	{memory[address], memory[address+1], memory[address+2], memory[address+3]} = write_data;
end //always

endmodule



module data_memory_testbench;

wire [31:0] read_data;
reg [31:0] address;
reg [31:0] write_data;
reg mem_write, mem_read, clk;

data_memory DUT(read_data, address, write_data, mem_write, mem_read, clk);

always #1 clk=~clk;

initial begin

$monitor("address: %d (%b)\nmem_read: %b\nread_data: %d (%b)\nmem_write: %b\nwrite_data: %d (%b)\n",
		address, address, mem_read, read_data, read_data, mem_write, write_data, write_data);

#20
clk = 0;
address = 4;
mem_write = 0;
mem_read = 0;
write_data = 32'b0000_0000_1111_1111_0000_0000_1111_1111;

#10
mem_write = 1;

#10
mem_write = 0;
mem_read = 1;

#10
address = 8;
end //initial

endmodule



