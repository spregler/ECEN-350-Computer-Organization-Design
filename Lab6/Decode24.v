`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2021 09:45:33 AM
// Design Name: 
// Module Name: Decode24
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module Decode24(in, out);

	input [1:0]in;
	output reg [3:0] out;
	
	always @(in) begin
		case(in[1:0])
			2'b00:	assign out = 4'b0001;
			2'b01:	assign out = 4'b0010;
			2'b10:	assign out = 4'b0100;
			2'b11:	assign out = 4'b1000;
			default: assign out = 4'b1111;
		endcase
		
	end
endmodule
