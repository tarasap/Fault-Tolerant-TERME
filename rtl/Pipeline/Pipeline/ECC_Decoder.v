// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      ECC_Decoder.v
// Author:         Tara Sarpoolaki /Tarasarpoolaki@gmail.com
// Last Modified:  2026-9-18
// Description:    
// 
// License:        CERN-OHL-S-v2
// =============================================================================

`timescale 1ns / 1ps

module ECC_Decoder #(parameter size = 32) (
    input   [38 : 0] read_codeword, 
    output  single_error, double_error,
	output  [5 : 0] syndrome
);
    // wire   [5 : 0] syndrome;
    wire   pG_s, p32_s, p16_s, p8_s, p4_s, p2_s, p1_s;
    wire   [31:0] d;
    wire   p1, p2, p4, p8, p16, p32;

    assign pG_s   = read_codeword[38];
    assign p32_s  = read_codeword[37];
    assign p16_s  = read_codeword[36];
    assign p8_s   = read_codeword[35];
    assign p4_s   = read_codeword[34];
    assign p2_s   = read_codeword[33];
    assign p1_s   = read_codeword[32];
    assign d      = read_codeword;


    // Recompute parity bits 
    assign p1  = (((d[0]  ^ d[1])  ^ (d[3]  ^ d[4]))  ^ 
                 ((d[6]  ^ d[8])  ^ (d[10] ^ d[11]))) ^
                 (((d[13] ^ d[15]) ^ (d[17] ^ d[19])) ^ 
                 ((d[21] ^ d[23]) ^ (d[25] ^ d[26]))) ^
                 ((d[28] ^ d[30]));

    assign p2  = (((d[0]  ^ d[2])  ^ (d[3]  ^ d[5]))  ^ 
                 ((d[6]  ^ d[9])  ^ (d[10] ^ d[12]))) ^
                 (((d[13] ^ d[16]) ^ (d[17] ^ d[20])) ^ 
                 ((d[21] ^ d[24]) ^ (d[25] ^ d[27]))) ^
                 ((d[28] ^ d[31]));

    assign p4  = (((d[1]  ^ d[2])  ^ (d[3]  ^ d[7]))  ^ 
                 ((d[8]  ^ d[9])  ^ (d[10] ^ d[14]))) ^
                 (((d[15] ^ d[16]) ^ (d[17] ^ d[22])) ^ 
                 ((d[23] ^ d[24]) ^ (d[25] ^ d[29]))) ^
                 ((d[30] ^ d[31]));

    assign p8  = (((d[4]  ^ d[5])  ^ (d[6]  ^ d[7]))  ^ 
                 ((d[8]  ^ d[9])  ^ (d[10] ^ d[18]))) ^
                 (((d[19] ^ d[20]) ^ (d[21] ^ d[22])) ^ 
                 ((d[23] ^ d[24]) ^ d[25]));

    assign p16 = (((d[11] ^ d[12]) ^ (d[13] ^ d[14])) ^ 
                 ((d[15] ^ d[16]) ^ (d[17] ^ d[18]))) ^
                 (((d[19] ^ d[20]) ^ (d[21] ^ d[22])) ^ 
                 ((d[23] ^ d[24]) ^ d[25]));

    assign p32 = (((d[26] ^ d[27]) ^ (d[28] ^ d[29])) ^ 
                 (d[30] ^ d[31]));
    

    assign syndrome = {
        (p32 ^ p32_s),
        (p16 ^ p16_s),
        (p8  ^ p8_s),
        (p4  ^ p4_s),
        (p2  ^ p2_s),
        (p1  ^ p1_s)
    };

    wire parity_data;
    wire parity_p;
    wire pG_calc; 
    wire global_mismatch;

    
    
    assign parity_data =    (((d[0]  ^ d[1])  ^ (d[2]  ^ d[3]))  ^ 
                            ((d[4]  ^ d[5])  ^ (d[6]  ^ d[7])))  ^
                            (((d[8]  ^ d[9])  ^ (d[10] ^ d[11])) ^ 
                            ((d[12] ^ d[13]) ^ (d[14] ^ d[15]))) ^
                            (((d[16] ^ d[17]) ^ (d[18] ^ d[19])) ^ 
                            ((d[20] ^ d[21]) ^ (d[22] ^ d[23]))) ^
                            (((d[24] ^ d[25]) ^ (d[26] ^ d[27])) ^ 
                            ((d[28] ^ d[29]) ^ (d[30] ^ d[31])));

    assign parity_p = p1_s ^ p2_s ^ p4_s ^ p8_s ^ p16_s ^ p32_s;
    assign pG_calc = parity_data ^ parity_p;
    assign global_mismatch = (pG_calc ^ pG_s);

    // syndrome == 0 & global=0  -> no error
    // syndrome != 0 & global=1  -> single-bit error (correctable)
    // syndrome == 0 & global=1  -> double-bit error (uncorrectable)
    // syndrome != 0 & global=0  -> parity bit pG flipped
    assign single_error = (syndrome != 0) && global_mismatch;
    assign double_error = (syndrome != 0) && ~ global_mismatch;

endmodule