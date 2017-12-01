/* ALU Control */


module control(
		input  wire [5:0] opcode,
		output reg branch_eq, branch_ne,
		output reg [1:0] aluop,
		output reg memread, memwrite, memtoreg,
		output reg regdst, regwrite, alusrc);
		

	always @(*) begin
		/* defaults */
		aluop[1:0]	<= 2'b10;
		alusrc		<= 1'b0;
		branch_eq	<= 1'b0;
		memread		<= 1'b0;
		memtoreg	<= 1'b0;
		memwrite	<= 1'b0;
		regdst		<= 1'b1;
		regwrite	<= 1'b1;
		

		case (opcode)
			6'b100011: begin	/* lw */
				memread  <= 1'b1;
				regdst   <= 1'b0;
				memtoreg <= 1'b1;
				aluop[1] <= 1'b0;
				alusrc   <= 1'b1;
			end
			6'b000000: begin	/* R-Format (add-and-or-all)*/
				
			end
			6'b000100: begin	/* beq */
				aluop[0]  <= 1'b1;
				aluop[1]  <= 1'b0;
				branch_eq <= 1'b1;
				regwrite  <= 1'b0;
			end
			6'b101011: begin	/* sw */
				memwrite <= 1'b1;
				aluop[1] <= 1'b0;
				alusrc   <= 1'b1;
				regwrite <= 1'b0;
			end
			
		endcase
	end
endmodule
