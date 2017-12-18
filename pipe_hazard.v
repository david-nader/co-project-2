
/*
For Data Hazard:

if (ID/EX.MemRead and
((ID/EX.RegisterRt = IF/ID.RegisterRs) or
(ID/EX.RegisterRt = IF/ID.RegisterRt)))
	stall the pipeline
The first line tests to see if the instruction is a load: the only instruction
*/


module hazard (IDEXMemRead, ControlMemWrite, IDEXRegisterRt, IFIDRegisterRs, IFIDRegisterRt,
			PCwrite, IFIDwrite, controlmux, ControlBranch, IDEXBranch, IFIDflush);



//for data hazard
input wire IDEXMemRead;
input wire ControlMemWrite;
input wire [4:0] IDEXRegisterRt;
input wire [4:0] IFIDRegisterRs;
input wire [4:0] IFIDRegisterRt;
output reg PCwrite;
output reg IFIDwrite;
output reg controlmux;

//for control hazard
input wire IDEXBranch;
input wire ControlBranch;
output reg IFIDflush;

always @(*) begin

//default values,
//to ensure synthesization as a combinational module
PCwrite = 0;
IFIDwrite = 0;
controlmux = 0;
IFIDflush = 0;

//Data Hazard (Memory to Alu forwarding hazard),
//when Rt==Rt, check if the current instruction
//is NOT sw (bec. this will be mem-to-mem)
if(	(IDEXMemRead==1) && //if previous instruction is lw 
	( (IDEXRegisterRt == IFIDRegisterRs) || ((IDEXRegisterRt==IFIDRegisterRt) && (ControlMemWrite!=1)) )
)
	begin
	PCwrite = 1;
	IFIDwrite = 1;
	controlmux = 1;
	end
//Control Hazard (beq),
//stall twice on branch
else if(IDEXBranch || ControlBranch)
	begin
	PCwrite = 1;
	IFIDflush = 1;
	end

end //always
endmodule





module testdatahazard_detection;
reg [4:0] IDEXMemRead;
reg [4:0] IDEXRegisterRt;
reg [4:0] IFIDRegisterRs;
reg [4:0] IFIDRegisterRt;

wire PCwrite;
wire IFIDwrite;
wire controlmux;

initial 
begin
$monitor("IDEXMemRead=%d   IDEXRegisterRt=%d   IFIDRegisterRs=%d   IFIDRegisterRt=%d  PCwrite=%b  IFIDwrite=%b  controlmux=%b " ,
IDEXMemRead,IDEXRegisterRt,IFIDRegisterRs,IFIDRegisterRt,PCwrite,IFIDwrite,controlmux);
#10 
IDEXMemRead<=1;
IDEXRegisterRt<=1;
IFIDRegisterRs<=1;
IFIDRegisterRt<=1;

#10 
IDEXMemRead<=0;
IDEXRegisterRt<=7;
IFIDRegisterRs<=1;
IFIDRegisterRt<=5;
end //initial

hazard g2(IDEXMemRead,IDEXRegisterRt,IFIDRegisterRs,IFIDRegisterRt,PCwrite,IFIDwrite,controlmux);

endmodule
