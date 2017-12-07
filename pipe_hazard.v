
/*
For Data Hazard:

if (ID/EX.MemRead and
((ID/EX.RegisterRt = IF/ID.RegisterRs) or
(ID/EX.RegisterRt = IF/ID.RegisterRt)))
	stall the pipeline
The first line tests to see if the instruction is a load: the only instruction
*/


module hazard (IDEXMemRead, IDEXRegisterRt, IFIDRegisterRs, IFIDRegisterRt,
			PCwrite, IFIDwrite, controlmux, ControlBranch, IDEXBranch);

//for data hazard
input IDEXMemRead;
input [4:0] IDEXRegisterRt;
input [4:0] IFIDRegisterRs;
input [4:0] IFIDRegisterRt;
output reg PCwrite;
output reg IFIDwrite;
output reg controlmux;

//for control hazard
input IDEXBranch;
input ControlBranch;

always @(*) begin
//Data Hazard (Memory to Alu forwarding hazard)
if((IDEXMemRead==1) && (IDEXRegisterRt == IFIDRegisterRs) || (IDEXRegisterRt==IFIDRegisterRt))
	begin
	PCwrite<=1;
	IFIDwrite<=1;
	controlmux<=1;
	end
else
	begin 
	PCwrite<=0;
	IFIDwrite<=0;
	controlmux<=0;
	end
//Control Hazard (beq),
//stall twice on branch
if(ControlBranch)
	begin
	PCwrite<=1;
	IFIDwrite<=1;
	//controlmux<=1; //let branch move to EX stage
	end
if(IDEXBranch)
	begin
	PCwrite<=1;
	IFIDwrite<=1;
	controlmux<=1;
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
