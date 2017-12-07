//prevent verilog from declaring undefined variables as wire,
//instead, it throws an error
`default_nettype none

module PC(PCNext, PCResult, Reset, Clk, PCWrite);

	input wire  [31:0]  PCNext;
	input wire          Reset, Clk, PCWrite;

	output reg  [31:0]  PCResult;

    always @(posedge Clk)
    begin
    	if (Reset)
    	begin
    		PCResult <= 32'h00000000;
    	end
    	else
    	begin
			if (!PCWrite) begin
				PCResult <= PCNext;
			end
    	end
    end

endmodule
