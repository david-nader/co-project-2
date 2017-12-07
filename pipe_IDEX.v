module ID_EX (clock,Branch_signal,WB,M,EX,pc4,Data_1,Data_2,immvalue,Rs,Rt,Rd,WB_out,Branch_signal_out,M_out,EX_out,Rs_out,Rt_out,Rd_out,Data_1_out,Data_2_out,immvalue_out,pc4_out);

input clock,Branch_signal;
input [1:0] WB;
input [2:0] M;
input [2:0] EX;
input [31:0] pc4,Data_1,Data_2,immvalue;
input [4:0] Rs,Rt,Rd;

output Branch_signal_out;
output [1:0] WB_out;
output [2:0] M_out; 
output [2:0] EX_out;
output [4:0] Rs_out,Rt_out,Rd_out;
output [31:0] Data_1_out,Data_2_out,immvalue_out,pc4_out;

reg Branch_signal_out;
reg [1:0] WB_out;
reg [2:0] M_out; 
reg [2:0] EX_out;
reg [4:0] Rs_out,Rt_out,Rd_out;
reg [31:0] Data_1_out,Data_2_out,immvalue_out,pc4_out;

initial
begin
Branch_signal_out=0;
WB_out=0;
M_out=0; 
EX_out=0;
Rs_out=0;
Rt_out=0;
Rd_out=0;
Data_1_out=0;
Data_2_out=0;
immvalue_out=0;
pc4_out=0;
end
always @ (posedge clock)
begin
Branch_signal_out <=Branch_signal;
WB_out <= WB;
M_out <= M; 
EX_out <= EX;
Rs_out <= Rs;
Rt_out <= Rt;
Rd_out <= Rd;
Data_1_out <= Data_1;
Data_2_out <= Data_2;
immvalue_out <= immvalue;
pc4_out <= pc4;

end
endmodule
