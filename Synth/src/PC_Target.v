module PC_Target(
    // input clk,
    // input rst,
    input      [31 : 0] PC_In,
    input      [31 : 0] Imm_In,
    output     [31 : 0] PC_Target
);
// always @(posedge clk ) begin
//     if (rst)
//         pc_target <= 0;
//     else
//         pc_target <= pc_in + imm_in;
    
// end
        assign PC_Target = PC_In + Imm_In;

endmodule