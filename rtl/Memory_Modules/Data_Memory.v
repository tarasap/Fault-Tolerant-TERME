module Data_Memory #(
    parameter integer MEM_SIZE = 256*1024,
    parameter integer LATENCY_CYCLES = 3
)(
    input clk,
    input rst,
    input req_i,
    input wen_i,
    input [31:0] addr_i,
    input [127:0] wdata_i,
    output reg ready_o,
    output reg [127:0] rdata_o
);

    localparam [1:0] IDLE = 2'd0, WAIT_ACCESS = 2'd1, RESPONSE = 2'd2;

    reg [7:0] mem [0:MEM_SIZE-1];
    reg [1:0] state_q;
    reg write_q;
    reg [31:0] addr_q;
    reg [127:0] wdata_q;
    integer cycles_left_q;
    integer init_i;
    integer byte_i;

    initial begin
        if (MEM_SIZE < 16) $fatal(1, "MEM_SIZE must be at least 16 bytes");
        if (LATENCY_CYCLES < 1) $fatal(1, "LATENCY_CYCLES must be at least 1");
        for (init_i = 0; init_i < MEM_SIZE; init_i = init_i + 1) mem[init_i] = 8'h00;
        $readmemh("coremark.hex", mem);
    end

    always @(posedge clk) begin
        if (rst) begin
            state_q <= IDLE;
            ready_o <= 1'b0;
            rdata_o <= 128'b0;
            write_q <= 1'b0;
            addr_q <= 32'b0;
            wdata_q <= 128'b0;
            cycles_left_q <= 0;
        end
        else begin
            ready_o <= 1'b0;

            case (state_q)
                IDLE: begin
                    if (req_i) begin
                        if ((^addr_i) === 1'bx) $fatal(1, "Memory request has an unknown address");
                        if (addr_i[3:0] != 4'b0000) $fatal(1, "Memory line address is not aligned: %08h", addr_i);
                        if (addr_i > MEM_SIZE - 16) $fatal(1, "Memory line address is out of range: %08h", addr_i);

                        addr_q <= addr_i;
                        wdata_q <= wdata_i;
                        write_q <= wen_i;
                        cycles_left_q <= LATENCY_CYCLES;
                        state_q <= WAIT_ACCESS;
                    end
                end

                WAIT_ACCESS: begin
                    if (cycles_left_q > 1) begin
                        cycles_left_q <= cycles_left_q - 1;
                    end
                    else begin
                        if (write_q) begin
                            for (byte_i = 0; byte_i < 16; byte_i = byte_i + 1) mem[addr_q + byte_i] <= wdata_q[byte_i*8 +: 8];
                        end
                        else begin
                            for (byte_i = 0; byte_i < 16; byte_i = byte_i + 1) rdata_o[byte_i*8 +: 8] <= mem[addr_q + byte_i];
                        end

                        ready_o <= 1'b1;
                        cycles_left_q <= 0;
                        state_q <= RESPONSE;
                    end
                end

                RESPONSE: begin
                    state_q <= IDLE;
                end

                default: begin
                    state_q <= IDLE;
                end
            endcase
        end
    end

endmodule