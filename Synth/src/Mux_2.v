module Mux_2 #(parameter size = 32)(

    input                       select,
    input      [size - 1 : 0]   in_1,
    input      [size - 1 : 0]   in_2,
    output     [size - 1 : 0]   mux_out
);
    assign mux_out = (select) ? in_2 : in_1;
endmodule