
module ALUControlTest;

    task passTest;
		input [3:0] actualOut, expectedOut;
	
		if (actualOut == expectedOut) begin 
		    $display ("passed: ALUCtrl = %b", actualOut);
		end 
		
		else 
		    $display ("failed: %b should be %b", actualOut, expectedOut);
		
	endtask

	// Inputs
	reg [1:0] ALUop;
	reg [10:0] Opcode;

	// Outputs
	wire [3:0] ALUCtrl;	

	// Instantiate the Unit Under Test (UUT)
	ALUControl uut(.ALUCtrl(ALUCtrl), 
	.ALUop(ALUop), 
	.Opcode(Opcode) 
	);

	initial begin
		// Initialize Inputs
		ALUop = 0;
		Opcode = 0;

		// Add stimulus here
		$display("Testing ALUCtrl...");
		$display("\n");
		
		// #1 D-type
		{ALUop, Opcode} = {2'b00, 11'b???????????};
		#2
		#50 passTest(ALUCtrl, 4'b0010);
		
		// #2 CBZ
		{ALUop, Opcode} = {2'b01, 11'b???????????};
		#2
		#50 passTest(ALUCtrl, 4'b0111);

		// #3 SUB
		{ALUop, Opcode} = {2'b10, 11'b11001011000};
		#2
		#50 passTest(ALUCtrl, 4'b0110);
		
		// #4 ORR
		{ALUop, Opcode} = {2'b10, 11'b10101010000};
		#2
		#50 passTest(ALUCtrl, 4'b0001);	

		// #5 AND
		{ALUop, Opcode} = {2'b10, 11'b10001010000};
		#2
		#50 passTest(ALUCtrl, 4'b0000);

		// #6 ADD
		{ALUop, Opcode} = {2'b10, 11'b10001011000};
		#2
		#50 passTest(ALUCtrl, 4'b0010);

		// #7 ORR
		{ALUop, Opcode} = {2'b10, 11'b10101010000};
		#2
		#50 passTest(ALUCtrl, 4'b0001);			
		
		// #8 ADD
		{ALUop, Opcode} = {2'b10, 11'b10001011000};
		#2
		#50 passTest(ALUCtrl, 4'b0010);
		
		// #9 SUB
		{ALUop, Opcode} = {2'b10, 11'b11001011000};
		#2
		#50 passTest(ALUCtrl, 4'b0110);
				
		
    end
		
        
      


endmodule
