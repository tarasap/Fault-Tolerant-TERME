// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      FE_Comparator.v
// Author:         Tara Sarpoolaki /Tarasarpoolaki@gmail.com
// Last Modified:  2026-9-18
// Description:    
// 
// License:        CERN-OHL-S-v2
// =============================================================================

`timescale 1ns / 1ps

module FE_Comparator #(parameter size = 32)(
    input [size - 1 : 0] instr0,
    input [size - 1 : 0] instr1,
    input [size - 1 : 0] pc0,
    input [size - 1 : 0] pc1,
    output reg mismatch
);

    always @(*) begin

        mismatch = (instr0 != instr1) | (pc0 != pc1);
     end

endmodule