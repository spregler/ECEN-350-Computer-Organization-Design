`timescale 1ns / 1ps


`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.
			
        {BusA, BusB, ALUCtrl} = {64'h10, 64'h20, 4'h2}; #40; passTest({Zero, BusW}, 65'h30, "ADD 0x10,0x20", passed);
        {BusA, BusB, ALUCtrl} = {64'h4, 64'h8, 4'h2}; #40; passTest({Zero, BusW}, 65'hC, "ADD 0x4,0x8", passed);
        {BusA, BusB, ALUCtrl} = {64'hFFFC, 64'h4, 4'h2}; #40; passTest({Zero, BusW}, 65'h0000000010000, "ADD 0xFFFC,0x4", passed);
        
        {BusA, BusB, ALUCtrl} = {64'h20, 64'h10, 4'h6}; #40; passTest({Zero, BusW}, 65'h000000010, "SUB 0x20,0x10", passed);
        {BusA, BusB, ALUCtrl} = {64'h12, 64'h12, 4'h6}; #40; passTest({Zero, BusW}, {1'b1,64'h0}, "SUB 0x12,0x12", passed);
        {BusA, BusB, ALUCtrl} = {64'h4, 64'hFFFC, 4'h6}; #40; passTest({Zero, BusW}, 65'h0ffffffffffff0008, "SUB 0x1234,0xABCD0000", passed);
        
        {BusA, BusB, ALUCtrl} = {64'h5, 64'hA, 4'h7}; #40; passTest({Zero, BusW}, 65'hA, "PASS B 0x5,0xA", passed);
        {BusA, BusB, ALUCtrl} = {64'h5, 64'h4, 4'h7}; #40; passTest({Zero, BusW}, 65'h4, "PASS B 0x5,0x4", passed);
        {BusA, BusB, ALUCtrl} = {64'hF, 64'h6, 4'h7}; #40; passTest({Zero, BusW}, 65'h6, "PASS B 0xF,0x6", passed);
        
        {BusA, BusB, ALUCtrl} = {64'h5, 64'hA, 4'h0}; #40; passTest({Zero, BusW}, {1'b1,64'h0}, "AND 0x5,0xA", passed);
        {BusA, BusB, ALUCtrl} = {64'h5, 64'h4, 4'h0}; #40; passTest({Zero, BusW}, 65'h4, "AND 0x5,0x4", passed);
        {BusA, BusB, ALUCtrl} = {64'hF, 64'h6, 4'h0}; #40; passTest({Zero, BusW}, 65'h6, "AND 0xF,0x6", passed);
        
        {BusA, BusB, ALUCtrl} = {64'h5, 64'hA, 4'h1}; #40; passTest({Zero, BusW}, 65'hF, "OR 0x5,0xA", passed);
        {BusA, BusB, ALUCtrl} = {64'h5, 64'h4, 4'h1}; #40; passTest({Zero, BusW}, 65'h5, "OR 0x5,0x4", passed);
        {BusA, BusB, ALUCtrl} = {64'hF, 64'h6, 4'h1}; #40; passTest({Zero, BusW}, 65'hF, "OR 0xF,0x6", passed);
        
        {BusA, BusB, ALUCtrl} = {64'h5, 64'hA, 4'h3}; #40; passTest({Zero, BusW}, 65'h1400, "LSL 0x5,0xA", passed);
        {BusA, BusB, ALUCtrl} = {64'h5, 64'h4, 4'h3}; #40; passTest({Zero, BusW}, 65'h50, "LSL 0x5,0x4", passed);
        {BusA, BusB, ALUCtrl} = {64'hF, 64'h6, 4'h3}; #40; passTest({Zero, BusW}, 65'h3C0, "LSL 0xF,0x6", passed);
        
        {BusA, BusB, ALUCtrl} = {64'h5, 64'hA, 4'h4}; #40; passTest({Zero, BusW}, {1'b1,64'h0}, "LSR 0x5,0xA", passed);
        {BusA, BusB, ALUCtrl} = {64'h5, 64'h4, 4'h4}; #40; passTest({Zero, BusW}, {1'b1,64'h0}, "LSR 0x5,0x4", passed);
        {BusA, BusB, ALUCtrl} = {64'hF, 64'h2, 4'h4}; #40; passTest({Zero, BusW}, 65'h000000003, "LSR 0xF,0x2", passed);;

		allPassed(passed, 22);
	end
      
endmodule

