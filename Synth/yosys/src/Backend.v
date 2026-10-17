// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      Backend.v
// Author:         Tara Sarpoolaki /Tarasarpoolaki@gmail.com
// Last Modified:  2026-9-18
// Description:    
// 
// License:        CERN-OHL-S-v2
// =============================================================================

`timescale 1ns / 1ps

module Backend #(parameter size = 32)(
    input  [1 : 0]          ResultSrc_i,
    input                   Mul_Sel_i,
    input                   CSR_Imm_i,

    input  [size - 1 : 0]   Alu_Result_i,
    input  [size - 1:0]     Mul_Result_i,
    input  [size - 1 : 0]   PC_Plus_i,
    input  [size - 1 : 0]   SrcA_i,
    input  [4 : 0]          Rs1_i,

    input  [size - 1 : 0]   Load_Data_i,
    input  [size - 1 : 0]   CSR_Rdata_i,
    output [size - 1 : 0]   Writeback_Result_o,
    output [size - 1 : 0]   CSR_Wdata_o
);
    wire       [size - 1 : 0] Exec_Result;
    assign Exec_Result      = Mul_Sel_i ? Mul_Result_i : Alu_Result_i;

    Mux_4 #(.size(size)) result_mux (
        .select             (ResultSrc_i),
        .in_1               (Exec_Result),
        .in_2               (Load_Data_i),
        .in_3               (PC_Plus_i),
        .in_4               (CSR_Rdata_i),
        .mux_out            (Writeback_Result_o)
    );

    Mux_2 #(.size(size)) csr_wdata_mux (
        .select             (CSR_Imm_i),
        .in_1               (SrcA_i),
        .in_2               ({27'd0, Rs1_i}),
        .mux_out            (CSR_Wdata_o)
    );

endmodule