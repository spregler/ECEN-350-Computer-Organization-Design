`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2021 09:33:37 AM
// Design Name: 
// Module Name: Mux21
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
module Mux21(out, in, sel); // define the module name and its interface

    /*declare output and input ports*/
	output out;
	input [1:0] in;
	input sel;
	
  	wire sel_not;
    wire temp1, temp0;
    wire out_temp;

    not not1(sel_not, sel);
  	and and1(temp0, in[0], sel_not);
  	and and2(temp1, in[1], sel);
  	or or1(out_temp, temp1, temp0);

    assign out = out_temp;
  
endmodule // end of module
