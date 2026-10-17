module Instruction_Memory #(
    parameter MEM_SIZE = 64*4096
)(
    input  wire        clk,

    input  wire        req_i,
    input  wire [31:0] addr_i,

    output reg [31:0]  rdata_o
);

    reg [7:0] mem [0:MEM_SIZE-1];

    initial begin
        $readmemh("coremark.hex",mem);
    end

    always @(*) begin
        rdata_o = {
            mem[addr_i + 3],
            mem[addr_i + 2],
            mem[addr_i + 1],
            mem[addr_i]
        };

    end

endmodule