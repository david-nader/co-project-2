/* Shift left 2 */


module shiftleft(inputtoshift , outputfromshift);
input [31:0] inputtoshift;
output wire [31:0] outputfromshift;
assign outputfromshift = inputtoshift<<2;
endmodule
