
module mux_2 (Read_data_2,sign_extend_output , AluSrc , z);

input  [31:0] Read_data_2,sign_extend_output;
input AluSrc;
output reg [31:0] z;

always @(AluSrc or Read_data_2 or sign_extend_output)
begin
if(AluSrc==0)
   z=Read_data_2;
else if(AluSrc ==1)
   z=sign_extend_output;
end
endmodule



module mux_3 ( Read_data,Alu_output , MemtoReg , z);

input  [31:0] Read_data,Alu_output;
input MemtoReg;
output reg [31:0] z;

always @(MemtoReg or Read_data or Alu_output)
begin

if(MemtoReg==1)
   z=Read_data;
else if(MemtoReg==0)
   z=Alu_output;
end

endmodule
