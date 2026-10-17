module Instruction_Memory #(parameter size = 32)(
    input  [size - 1 : 0] address,
    output reg [size - 1 : 0] Instruction
);

    reg [size - 1 : 0] memory [0 : 255];
    initial begin
		$readmemh("instructionmemory_7.txt",memory);
  	end
    always @(address) begin
            Instruction = memory[address>>2];
    end
endmodule