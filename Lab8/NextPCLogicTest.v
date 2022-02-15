//NextPCLogicTest.v
`timescale 1ns / 1ps
`define STRLEN 32
module NextPCLogicTest_v;


	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask


	// Inputs

	reg  [63:0] CurrentPC, SignExtImm64;

	reg  Branch, ALUZero, Uncondbranch;

	reg  [63:0] expect;

	

	reg [7:0] passed;

	// Outputs
	wire [63:0] NextPC;

	

	// Instantiate the Unit Under Test (UUT)
	calculatePC uut (.NextPC(NextPC), .CurrentPC(CurrentPC), .SignExtImm64(SignExtImm64), .Branch(Branch), .ALUZero(ALUZero), .Uncondbranch(Uncondbranch)

	);

	initial begin

	Branch = 0;

	ALUZero = 0;

	Uncondbranch = 0;

	CurrentPC = 0;

	SignExtImm64 = 0;

	expect = 0;



	passed = 0;

	

	expect = 64'h4;

	{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h0, 64'h10, 1'b0, 1'b0, 1'b0};

	#5	passTest(NextPC, expect, "Regular counter test", passed);

	$display("CurrentPC = %h, SignExtImm64 = %h, Branch = %b, ALUZero = %b, UCbranch = %b, NextPC = %h, expected = %h\n", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC, expect);

	

	expect = 64'h14;

	{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'h10, 1'b1, 1'b0, 1'b0};

	#5	passTest(NextPC, expect, "Condition Branch, ALUZero false", passed);

	$display("CurrentPC = %h, SignExtImm64 = %h, Branch = %b, ALUZero = %b, UCbranch = %b, NextPC = %h, expected = %h", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC, expect);

	

	expect = 64'h20;

	{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'h10, 1'b1, 1'b1, 1'b0};

	#5	passTest(NextPC, expect, "Condition Branch", passed);

	$display("CurrentPC = %h, SignExtImm64 = %h, Branch = %b, ALUZero = %b, UCbranch = %b, NextPC = %h, expected = %h", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC, expect);

	

	expect = 64'h20;

	{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'h10, 1'b0, 1'b0, 1'b1};

	#5	passTest(NextPC, expect, "Unconditional Branch Test", passed);

	$display("CurrentPC = %h, SignExtImm64 = %h, Branch = %b, ALUZero = %b, UCbranch = %b, NextPC = %h, expected = %h", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC, expect);

	

	#2 allPassed(passed, 4); 

	end

endmodule
