`timescale 1ns / 1ps

module DataMemory(ReadData, Address, WriteData,
                    MemoryRead, MemoryWrite, Clock);
                    
    input [63:0] Address, WriteData;
    input MemoryRead, MemoryWrite, Clock;
    output reg [63:0] ReadData;
    
    reg [63:0] Memory [63:0];                           // 64 memory registers each 64-bit
    
    always@(negedge(Clock)) begin                       // memory write on negedge of clock
        if (MemoryWrite && !MemoryRead) begin
            #20 Memory[Address] <= WriteData;
        end
    end
    
    always@(posedge(Clock)) begin                       // memory read on posedge of cloc
        if (MemoryRead && !MemoryWrite) begin
            #20 ReadData <= Memory[Address];
        end
    end
    
endmodule
