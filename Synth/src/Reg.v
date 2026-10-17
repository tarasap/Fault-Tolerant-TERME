module Reg #(parameter size = 32)(
    input clk,
    input rst,
    input en,
    input      [size - 1 : 0] d_in,
    output reg [size - 1 : 0] q_out
);
always @(posedge clk or posedge rst) begin
    if (rst)
        q_out <= 0;
    else if(en)
        q_out <= d_in;
    
end

endmodule