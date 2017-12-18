/* ALU Control */


module control(	input wire reset,
		input wire [5:0] opcode,
		output reg branch_eq,
		output reg [1:0] aluop,
		output reg memread, memwrite, memtoreg,
		output reg regdst, regwrite, alusrc);
		

	always @(*) begin
		/* defaults */
		aluop[1:0]	<= 2'b10;
		alusrc		<= 1'b0;
		memread		<= 1'b0;
		memtoreg	<= 1'b0;
		memwrite	<= 1'b0;
		regdst		<= 1'b1;
		regwrite	<= 1'b1;
		//branch_eq	<= 1'b0;
		
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
				//branch_eq <= 1'b1;
				regwrite  <= 1'b0;
			end
			6'b101011: begin	/* sw */
				memwrite <= 1'b1;
				aluop[1] <= 1'b0;
				alusrc   <= 1'b1;
				regwrite <= 1'b0;
				//set regdst to ensure that Register rt is the one
				//that reaches EX/MEM register, which is used
				//in the condition of Mem-to-Mem forwarding unit,
				//an alternative would be passing rt to EX/MEM (but this requires more
				//changes than changing the Control Unit)
				regdst	 <= 1'b0;
			end
		endcase
	end //always


	//when there is no instructions in the instructions
	//memory, i.e. memory is "don't cares",
	//this will let the PC increment idefinitely (because
	//the value is stored as a reg not a wire, so it stays
	//zero even after reset is de-asserted),
	//otherwise, PC will increment for a few times, before
	//it becomes a "don't care" value,
	//
	//however in hardware (and synthesization), the signal
	//should be wire not reg, and thus this effect should
	//not occur

	always @(*)
	if(!reset) begin
		/* defaults */
		branch_eq	<= 1'b0;
		case (opcode)
		6'b000100: begin	/* beq */
			branch_eq <= 1'b1;
		end
		endcase
	end
	else if(reset) begin
		branch_eq <= 0;
	end

endmodule
