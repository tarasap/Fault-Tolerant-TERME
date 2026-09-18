// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      RP_Register.v
// Author:         Tara Sarpoolaki /Tarasarpoolaki@gmail.com
// Last Modified:  2026-9-18
// Description:    
// 
// License:        CERN-OHL-S-v2
// =============================================================================

`timescale 1ns / 1ps

module RP_Register #(parameter size = 32) (
    input                   clk,
    input                   rst,
    input                   en,
    input  [size - 1 : 0]   d_in,
    output [size - 1 : 0]   rp_o
);

    reg [size - 1 : 0] rp_a, rp_b, rp_c;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rp_a <= {size{1'b0}};
            rp_b <= {size{1'b0}};
            rp_c <= {size{1'b0}};
        end else if (en) begin
            rp_a <= d_in;
            rp_b <= d_in;
            rp_c <= d_in;
        end
    end

    assign rp_o = (rp_a & rp_b) | (rp_b & rp_c) | (rp_a & rp_c);

endmodule