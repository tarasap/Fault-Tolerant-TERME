// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      ECC_Encoder.v
// Author:         Tara Sarpoolaki /Tarasarpoolaki@gmail.com
// Last Modified:  2026-9-18
// Description:    
// 
// License:        CERN-OHL-S-v2
// =============================================================================

`timescale 1ns / 1ps

module ECC_Encoder #(parameter size = 32)(
    input   [size - 1 : 0] data_in,
    output  [38 : 0] codeword
);

wire p1, p2, p4, p8, p16, p32;
wire  parity_of_data, parity_of_p, pG;

    assign p1  = (((data_in[0]  ^ data_in[1])  ^ (data_in[3]  ^ data_in[4]))  ^ 
                 ((data_in[6]  ^ data_in[8])  ^ (data_in[10] ^ data_in[11]))) ^
                 (((data_in[13] ^ data_in[15]) ^ (data_in[17] ^ data_in[19])) ^ 
                 ((data_in[21] ^ data_in[23]) ^ (data_in[25] ^ data_in[26]))) ^
                 ((data_in[28] ^ data_in[30]));

    assign p2  = (((data_in[0]  ^ data_in[2])  ^ (data_in[3]  ^ data_in[5]))  ^ 
                 ((data_in[6]  ^ data_in[9])  ^ (data_in[10] ^ data_in[12]))) ^
                 (((data_in[13] ^ data_in[16]) ^ (data_in[17] ^ data_in[20])) ^ 
                 ((data_in[21] ^ data_in[24]) ^ (data_in[25] ^ data_in[27]))) ^
                 ((data_in[28] ^ data_in[31]));

    assign p4  = (((data_in[1]  ^ data_in[2])  ^ (data_in[3]  ^ data_in[7]))  ^ 
                 ((data_in[8]  ^ data_in[9])  ^ (data_in[10] ^ data_in[14]))) ^
                 (((data_in[15] ^ data_in[16]) ^ (data_in[17] ^ data_in[22])) ^ 
                 ((data_in[23] ^ data_in[24]) ^ (data_in[25] ^ data_in[29]))) ^
                 ((data_in[30] ^ data_in[31]));

    assign p8  = (((data_in[4]  ^ data_in[5])  ^ (data_in[6]  ^ data_in[7]))  ^ 
                 ((data_in[8]  ^ data_in[9])  ^ (data_in[10] ^ data_in[18]))) ^
                 (((data_in[19] ^ data_in[20]) ^ (data_in[21] ^ data_in[22])) ^ 
                 ((data_in[23] ^ data_in[24]) ^  data_in[25]));

    assign p16 = (((data_in[11] ^ data_in[12]) ^ (data_in[13] ^ data_in[14])) ^ 
                 ((data_in[15] ^ data_in[16]) ^ (data_in[17] ^ data_in[18]))) ^
                 (((data_in[19] ^ data_in[20]) ^ (data_in[21] ^ data_in[22])) ^ 
                 ((data_in[23] ^ data_in[24]) ^  data_in[25]));
 
    assign p32 = (((data_in[26] ^ data_in[27]) ^ (data_in[28] ^ data_in[29])) ^ 
                 ((data_in[30] ^ data_in[31])));


    assign parity_of_data = (((data_in[0]  ^ data_in[1])  ^ (data_in[2]  ^ data_in[3]))  ^ 
                            ((data_in[4]  ^ data_in[5])  ^ (data_in[6]  ^ data_in[7])))  ^
                            (((data_in[8]  ^ data_in[9])  ^ (data_in[10] ^ data_in[11])) ^ 
                            ((data_in[12] ^ data_in[13]) ^ (data_in[14] ^ data_in[15]))) ^
                            (((data_in[16] ^ data_in[17]) ^ (data_in[18] ^ data_in[19])) ^ 
                            ((data_in[20] ^ data_in[21]) ^ (data_in[22] ^ data_in[23]))) ^
                            (((data_in[24] ^ data_in[25]) ^ (data_in[26] ^ data_in[27])) ^ 
                            ((data_in[28] ^ data_in[29]) ^ (data_in[30] ^ data_in[31])));

    assign parity_of_p    = (((p1 ^ p2) ^ (p4 ^ p8)) ^ (p16 ^ p32));
    
    assign pG = parity_of_data ^ parity_of_p;

    // Output codeword
    assign codeword = {pG, p32, p16, p8, p4, p2, p1, data_in};

endmodule