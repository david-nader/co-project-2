/* Shift left 2 */


module shift_left_2(inputtoshift , outputfromshift);
input [31:0] inputtoshift;
output wire [31:0] outputfromshift;
assign outputfromshift = inputtoshift<<2;
endmodule
