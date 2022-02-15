`timescale 1ns / 1ps

module ALUControl(ALUCtrl, ALUop, Opcode);

    input [1:0] ALUop;
    input [10:0] Opcode;
    output reg [3:0] ALUCtrl;
    
    always@(*) begin
    
        $display("ALUop = %b & Opcode = %b", ALUop, Opcode);
        // for load and store instructions
        if (ALUop == 2'b00) begin
            #2 ALUCtrl <= 4'b0010;
        end
        
        // for CBZ instruction
        else if (ALUop == 2'b01) begin
            #2 ALUCtrl <= 4'b0111;
        end
        
        // R-type
        else if (ALUop == 2'b10) begin
            case(Opcode)
                11'b10001011000 : #2 ALUCtrl <= 4'b0010; // add
                11'b11001011000 : #2 ALUCtrl <= 4'b0110; // subtract
                11'b10001010000 : #2 ALUCtrl <= 4'b0000; // AND
                11'b10101010000 : #2 ALUCtrl <= 4'b0001; // OR
                default : ALUCtrl <= 0;
                
            endcase
        end
    end
      
endmodule
