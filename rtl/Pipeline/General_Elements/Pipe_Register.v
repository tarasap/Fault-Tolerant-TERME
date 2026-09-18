module Pipe_Register #(parameter size = 32)(clk, rst, in, en, clr, out);
	input clk, rst;
	input [size-1:0] in;
	input en,clr;
	output reg [size-1:0] out;

	always@(posedge clk or posedge rst) begin
		if(rst) out <= 0;
		else if (clr) out <= 0;
		else if (en) out <= in;
	end
endmodule