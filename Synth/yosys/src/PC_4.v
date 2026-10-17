module PC_4(
    input      [31 : 0] PC_In,
    output  [31 : 0] PC_Plus
);
assign  PC_Plus = PC_In + 4;

endmodule