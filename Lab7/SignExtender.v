`timescale 1ns / 1ps

module SignExtender(Out, Instr);

      input [31:0] Instr;
      output reg [63:0] Out;
      
      always @(*) begin
            // if else block to determine the case dependent logic
            if ( Instr[31:26] == 6'b000101 /* B */ || Instr[31:26] == 6'b100101 /* BL */)   // if instr. type B
                    Out = {{38{Instr[25]}}, Instr[25:0]}; // concat sign bit with lower 26 bit
                    
            else if ( Instr[26] == 1'b0 )   // LEGv8 opcode bit 26 = 0 means D-type
                    Out = {{55{Instr[20]}}, Instr[20:12]};                
                    
            else if ( Instr[26] == 1'b1 )    // LEGv8 opcode bit 26 = 1 means CB-type      
                    Out = {{45{Instr[23]}}, Instr[23:5]};
            
            else
                    Out = {64{1'b0}};
                    
        end

endmodule
