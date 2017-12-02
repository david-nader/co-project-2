
module register_file(reg_read1, reg_read2, reg_write, data_read1, data_read2, data_write, write_enable, clk);

input wire [4:0] reg_read1; //register address
input wire [4:0] reg_read2;
input wire [4:0] reg_write;
input wire [31:0] data_write; //data
input wire write_enable;
input wire clk;

output reg [31:0] data_read1;
output reg [31:0] data_read2;

//Memory
parameter bit_width = 32, num_registers = 32;
reg [bit_width-1:0] memory [num_registers-1:0];
//example: memory[0] refers to the first register

initial begin
//first register is always zero by design
memory[0] <= 0;
end

always @(posedge clk)
begin
data_read1 <= memory [reg_read1];
data_read2 <= memory [reg_read2];
if(write_enable && reg_write != 0)
	memory [reg_write] <= data_write;
end

endmodule


module register_file_testbench;

reg [31:0] reg_read1, reg_read2, reg_write, data_write;
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

