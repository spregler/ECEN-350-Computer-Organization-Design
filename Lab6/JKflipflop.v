`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2021 09:46:53 AM
// Design Name: 
// Module Name: JK
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


module JK(out, j, k, clk, reset);
    input j, k, clk, reset;
    output out;
    
    wire temp1, temp2, temp3, temp4;
    wire resetnot;
    
    not #2 not1(resetnot, reset);
    nand #2 nand1(temp1, j, temp4, clk);
    nand #2 nand2(temp2, clk, temp3, k);
    nand #2 nand3(temp3, temp1, temp4);
    nand #2 nand4(temp4, temp3, temp2, resetnot);
    assign out = temp3;
    

endmodule
