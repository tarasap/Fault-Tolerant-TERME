// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      ECC_Corrector.v
// Author:         Tara Sarpoolaki /Tarasarpoolaki@gmail.com
// Last Modified:  2026-9-18
// Description:    
// 
// License:        CERN-OHL-S-v2
// =============================================================================

// `timescale 1ns / 1ps

module ECC_Corrector (
    input  [38 : 0] code,
    input  single_error,
    input  [5 : 0] syndrome,
    output reg [31 : 0] data_out
);
    

    always @(code, single_error,syndrome) begin
        data_out = code [31 : 0];      

        if (single_error) begin
            case (syndrome)
                3:  data_out[0]  = ~code[0];
                5:  data_out[1]  = ~code[1];
                6:  data_out[2]  = ~code[2];
                7:  data_out[3]  = ~code[3];
                9:  data_out[4]  = ~code[4];
                10: data_out[5]  = ~code[5];
                11: data_out[6]  = ~code[6];
                12: data_out[7]  = ~code[7];
                13: data_out[8]  = ~code[8];
                14: data_out[9]  = ~code[9];
                15: data_out[10] = ~code[10];
                17: data_out[11] = ~code[11];
                18: data_out[12] = ~code[12];
                19: data_out[13] = ~code[13];
                20: data_out[14] = ~code[14];
                21: data_out[15] = ~code[15];
                22: data_out[16] = ~code[16];
                23: data_out[17] = ~code[17];
                24: data_out[18] = ~code[18];
                25: data_out[19] = ~code[19];
                26: data_out[20] = ~code[20];
                27: data_out[21] = ~code[21];
                28: data_out[22] = ~code[22];
                29: data_out[23] = ~code[23];
                30: data_out[24] = ~code[24];
                31: data_out[25] = ~code[25];
                33: data_out[26] = ~code[26];
                34: data_out[27] = ~code[27];
                35: data_out[28] = ~code[28];
                36: data_out[29] = ~code[29];
                37: data_out[30] = ~code[30];
                38: data_out[31] = ~code[31];
            endcase
        end
    end
endmodule
