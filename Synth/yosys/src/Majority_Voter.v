// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      Majority_Voter.v
// Author:         Tara Sarpoolaki /Tarasarpoolaki@gmail.com
// Last Modified:  2026-9-18
// Description:    
// 
// License:        CERN-OHL-S-v2
// =============================================================================

`timescale 1ns / 1ps

module Majority_Voter #(parameter size = 32)(
    input  clk,
    input  rst,
    input  [size - 1 : 0] alu_result_mwb,
    input  [size - 1 : 0] alu_result_mwb_1,
    input  [size - 1 : 0] alu_result_mwb_2,

    input  [size - 1 : 0] writeback_result,
    input  [size - 1 : 0] writeback_result_1,
    input  [size - 1 : 0] writeback_result_2,

    input  [size - 1 : 0] SrcB_mwb,
    input  [size - 1 : 0] SrcB_mwb_1,
    input  [size - 1 : 0] SrcB_mwb_2,
    
    output   [size - 1 : 0] SrcB_mwb_voted,
    output   [size - 1 : 0] alu_result_mwb_voted,
    output   [size - 1 : 0] writeback_result_voted
);

    assign writeback_result_voted   = (writeback_result & writeback_result_1)
                                    | (writeback_result_1 & writeback_result_2)
                                    | (writeback_result & writeback_result_2);

    assign    alu_result_mwb_voted  = (alu_result_mwb & alu_result_mwb_1)
                                    | (alu_result_mwb_1 & alu_result_mwb_2)
                                    | (alu_result_mwb & alu_result_mwb_2);
                
    assign   SrcB_mwb_voted         = (SrcB_mwb & SrcB_mwb_1)
                                    | (SrcB_mwb_1 & SrcB_mwb_2)
                                    | (SrcB_mwb & SrcB_mwb_2);
    
endmodule