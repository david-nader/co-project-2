
module register_file(reg_read1, reg_read2, reg_write, data_read1, data_read2, data_write, write_enable, clk);

input wire [4:0] reg_read1; //register address
input wire [4:0] reg_read2;
input wire [4:0] reg_write;
input wire [31:0] data_write; //data
input wire write_enable;
input wire clk;

output wire [31:0] data_read1;
output wire [31:0] data_read2;

//Memory
parameter bit_width = 32, num_registers = 32;
reg [bit_width-1:0] memory [0:num_registers-1];
//example: memory[0] refers to the first register

//read-after-write:
//writing occurs in first half of cycle,
//reading occurs in second half of cycle,
//so an instruction can read what another
//instruction has written in the same
//cycle

always @(negedge clk)
begin
if(write_enable && reg_write != 0)
	memory [reg_write] <= data_write;
memory[0] <= 0; //first register is always zero by design
end //always


assign data_read1 = memory [reg_read1];
assign data_read2 = memory [reg_read2];


endmodule


module register_file_testbench;

reg [4:0] reg_read1, reg_read2, reg_write;
reg [31:0] data_write;
wire [31:0] data_read1, data_read2;
reg write_enable;
reg clk;

register_file DUT(reg_read1, reg_read2, reg_write, data_read1, data_read2, data_write, write_enable, clk);

initial begin
reg_write = 0;
reg_read1 = 0;
reg_read2 = 15;
data_write = 0;
write_enable = 1;
clk = 0;
end //initial

always #1 clk = ~clk;

always @(posedge clk) begin

if(reg_write == 31) begin
reg_write = 0;
write_enable = 0;
end //if

reg_write = reg_write + 1;
data_write = data_write + 10;

end //always

endmodule

