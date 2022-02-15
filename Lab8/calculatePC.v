`timescale 1ns / 1ps

module calculatePC (NextPC, CurrentPC, SignExtImm64, 
                    Branch, ALUZero, Uncondbranch);

    input [63:0] CurrentPC, SignExtImm64;
    input Branch, ALUZero, Uncondbranch;
    output reg [63:0] NextPC;


    reg [63:0] ShiftedImm64;

    always@(*) begin
        // must shift the sign-extended Imm64
        ShiftedImm64 <= SignExtImm64 <<< 2;

        if (Uncondbranch)
            #2 NextPC <= CurrentPC + SignExtImm64;

        else if (Branch && ALUZero == 1)
            #2 NextPC <= CurrentPC + SignExtImm64;
            
        else
           #2 NextPC = CurrentPC + 4;
    end 

endmodule