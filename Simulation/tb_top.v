
// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      tb_top.v
// Author:         Tara Sarpoolaki / Tarasarpoolaki@gmail.com
// Last Modified:  2026-10-17
// Description:
//
// License:        CERN-OHL-S-v2
// =============================================================================


`timescale 1ns/1ns

module tb_top #(
    parameter size = 32
);


    reg clk0;
    reg clk1;

    reg rst0;
    reg rst1;


    initial begin
        clk0 = 1'b0;
        forever #1 clk0 = ~clk0;
    end

    initial begin
        clk1 = 1'b0;
        forever #1 clk1 = ~clk1;
    end

    initial begin
        rst0 = 1'b1;

        repeat (4)
            @(posedge clk0);

        @(negedge clk0);
        rst0 = 1'b0;
    end

    initial begin
        rst1 = 1'b1;

        repeat (4)
            @(posedge clk1);

        @(negedge clk1);
        rst1 = 1'b0;
    end


    reg Irq_Timer_i;
    reg Irq_Ext_i;
    reg Irq_software_i;

    initial begin
        Irq_Timer_i    = 1'b0;
        Irq_Ext_i      = 1'b0;
        Irq_software_i = 1'b0;
    end

    
    localparam [31:0] CLINT_BASE   = 32'h0200_0000;
    localparam [31:0] UART_TX_ADDR = 32'h1000_0000;
    localparam [31:0] SIMEND_ADDR  = 32'h2000_0000;

    localparam integer RAM_SIZE_BYTES = 1024 * 1024;
    localparam [31:0]  RAM_END_ADDR   = 32'h0010_0000;
    localparam integer TIMEOUT_CYCLES = 100_000_000;

    wire mismatch_o; 
    
    Top_Protected #(
        .size(size)
    )
    dut (
        .clk0                       (clk0),
        .clk1                       (clk1),
        .rst0                       (rst0),
        .rst1                       (rst1),

        .Irq_Timer_i                (Irq_Timer_i),
        .Irq_Ext_i                  (Irq_Ext_i),
        .Irq_software_i             (Irq_software_i),

        .mismatch_o                 (mismatch_o)
    );


    wire        dmem_req_valid;
    wire        dmem_read_en;
    wire        dmem_write_en;
    wire [3:0]  dmem_wstrb;
    wire [31:0] dmem_data_i;
    wire [31:0] dmem_data_o;
    wire [31:0] dmem_addr;
    wire [31:0] imem_addr;
    wire        dmem_req_ready;

    assign dmem_req_valid = dut.DMem_Interface_Req_Valid_o;
    assign dmem_read_en   = dut.DMem_Interface_Read_En_o;
    assign dmem_write_en  = dut.DMem_Interface_Write_En_o;
    assign dmem_wstrb     = dut.DMem_Interface_Wstrb_o;
    assign dmem_data_i    = dut.DMem_Interface_Data_i;
    assign dmem_data_o    = dut.DMem_Interface_Data_o;
    assign dmem_addr      = dut.DMem_Interface_Addr_o;
    assign imem_addr      = dut.Imem_Interface_Addr_o;
    assign dmem_req_ready = dut.DMem_Interface_Req_Ready_i;


    wire is_mem;
    wire clint_sel;
    wire uart_sel;
    wire simend_sel;
    wire known_mmio;
    assign is_mem       = (dmem_addr < RAM_END_ADDR);
    assign clint_sel    = (dmem_addr >= CLINT_BASE) && (dmem_addr < (CLINT_BASE + 32'h0001_0000));
    assign uart_sel     = (dmem_addr == UART_TX_ADDR);
    assign simend_sel   = (dmem_addr == SIMEND_ADDR);
    assign known_mmio   =  clint_sel ||  uart_sel || simend_sel;


    integer cycle_count;

    initial begin
        cycle_count = 0;
    end

    always @(posedge clk0) begin
        if (rst0)
            cycle_count <= 0;
        else
            cycle_count <= cycle_count + 1;
    end

    always @(posedge clk0) begin
        if (!rst0 && (cycle_count >= TIMEOUT_CYCLES)) begin
            $display("");
            $display("=============================================");
            $display("              SIMULATION TIMEOUT             ");
            $display("=============================================");
            $display("Cycle       = %0d", cycle_count);
            $display("Fetch PC    = %08h", imem_addr);
            $display("DMEM addr   = %08h", dmem_addr);
            $display("DMEM read   = %b", dmem_read_en);
            $display("DMEM write  = %b", dmem_write_en);
            $display("=============================================");
            $fatal;
        end
    end


    reg [7:0] reference_mem [0:RAM_SIZE_BYTES-1];
    reg [31:0] expected_word;

    integer ref_i;
    integer ref_b;

    initial begin
        for (ref_i = 0;  ref_i < RAM_SIZE_BYTES; ref_i = ref_i + 1) begin
            reference_mem[ref_i] = 8'h00;
        end
        $readmemh("coremark.hex", reference_mem);

    end


    wire   unmapped_access;
    assign unmapped_access =  dmem_req_valid && !is_mem && !known_mmio; 

    always @(posedge clk0) begin

        if (!rst0 && unmapped_access) begin

            $display("");
            $display("=============================================");
            $display("             UNMAPPED ACCESS                 ");
            $display("=============================================");
            $display("Cycle       = %0d", cycle_count);
            $display("PC          = %08h", imem_addr);
            $display("READ        = %b", dmem_read_en);
            $display("WRITE       = %b", dmem_write_en);
            $display("ADDR        = %08h", dmem_addr);
            $display("DATA        = %08h", dmem_data_o);
            $display("=============================================");

            $fatal;

        end

    end

    always @(posedge clk0) begin

        if (dmem_write_en && dmem_req_valid) begin
            
            if (uart_sel) begin
                $write("%c", dmem_data_o[7:0]);
            end

            else if (simend_sel) begin

                $display("");
                $display("=============================================");
                $display("       COREMARK FINISHED - SIMEND 3          ");
                $display("=============================================");
                $display(
                    "Exit code written: %0d",
                    dmem_data_o
                );
                $display(
                    "Total cycles: %0d",
                    cycle_count
                );
                $display("=============================================");
                $display("");

                // $finish;
            end

        end
    end


    integer fi_dmr_fe_count     = 0;
    integer fi_dmr_mwb_count    = 0;
    integer fi_tmr_masked_count = 0;
    integer fi_ecc_sec_count    = 0;
    integer fi_ecc_ded_count    = 0;
    integer fi_write_count      = 0;
    integer fi_trace_fd;

    integer fi_target_id;
    integer fi_inject_cycle;
    integer fi_bit_idx;
    integer fi_duration;

    wire fi_wr_valid = (dmem_write_en && dmem_req_valid && dmem_req_ready);
    wire fi_done     = (dmem_write_en && dmem_req_valid && simend_sel);

    wire tmr_wb_diff0 = (dut.dut.pipe.Writeback_Result_mwb0 != dut.dut.pipe.writeback_result_voted);
    wire tmr_wb_diff1 = (dut.dut.pipe.Writeback_Result_mwb1 != dut.dut.pipe.writeback_result_voted);
    wire tmr_wb_diff2 = (dut.dut.pipe.Writeback_Result_mwb2 != dut.dut.pipe.writeback_result_voted);

    wire tmr_alu_diff0 = (dut.dut.pipe.Alu_Result_mwb0 != dut.dut.pipe.alu_result_mwb_voted);
    wire tmr_alu_diff1 = (dut.dut.pipe.Alu_Result_mwb1 != dut.dut.pipe.alu_result_mwb_voted);
    wire tmr_alu_diff2 = (dut.dut.pipe.Alu_Result_mwb2 != dut.dut.pipe.alu_result_mwb_voted);

    wire tmr_wb_masked  = dut.dut.pipe.Valid_mwb0 && !dut.dut.pipe.mismatch_mwb && (tmr_wb_diff0 || tmr_wb_diff1 || tmr_wb_diff2);

    wire tmr_alu_masked = dut.dut.pipe.Valid_mwb0 && !dut.dut.pipe.mismatch_mwb && (tmr_alu_diff0 || tmr_alu_diff1 || tmr_alu_diff2);

    wire ecc_sec_hit = dut.dut.pipe.Regread_dex0 && (dut.dut.pipe.single_error1 || dut.dut.pipe.single_error2);

    wire ecc_ded_hit = dut.dut.pipe.Regread_dex0 && (dut.dut.pipe.double_error1 || dut.dut.pipe.double_error2);

    initial begin
        if ($test$plusargs("GOLDEN_RUN"))
            fi_trace_fd = $fopen("golden_writes.trace", "w");
        else
            fi_trace_fd = $fopen("faulty_writes.trace", "w");
    end

    always @(posedge clk0) begin
        if (!rst0) begin
            if (dut.dut.pipe.mismatch_fe) begin
                fi_dmr_fe_count <= fi_dmr_fe_count + 1;
                $display("FI_MON: C=%0d DMR_FE PC0=%08h PC1=%08h RP=%08h",
                         cycle_count,
                         dut.dut.pipe.PC_Out_dex0,
                         dut.dut.pipe.PC_Out_dex1,
                         dut.dut.pipe.rp_value);
            end

            if (dut.dut.pipe.mismatch_mwb) begin
                fi_dmr_mwb_count <= fi_dmr_mwb_count + 1;
                $display("FI_MON: C=%0d DMR_MWB ALU0=%08h ALU1=%08h RP=%08h",
                         cycle_count,
                         dut.dut.pipe.Alu_Result_mwb0,
                         dut.dut.pipe.Alu_Result_mwb1,
                         dut.dut.pipe.rp_value);
            end

            if (tmr_wb_masked || tmr_alu_masked) begin
                fi_tmr_masked_count <= fi_tmr_masked_count + 1;
                $display("FI_MON: C=%0d TMR_MASKED VotedWB=%08h",
                         cycle_count,
                         dut.dut.pipe.writeback_result_voted);
            end

            if (ecc_sec_hit) begin
                fi_ecc_sec_count <= fi_ecc_sec_count + 1;
                $display("FI_MON: C=%0d ECC_SEC Syn1=%02h Syn2=%02h",
                         cycle_count,
                         dut.dut.pipe.syndrome1,
                         dut.dut.pipe.syndrome2);
            end

            if (ecc_ded_hit) begin
                fi_ecc_ded_count <= fi_ecc_ded_count + 1;
                $display("FI_MON: C=%0d ECC_DED_UNCORRECTABLE", cycle_count);
            end

            if (fi_wr_valid) begin
                fi_write_count <= fi_write_count + 1;
                $fwrite(fi_trace_fd, "%0d %08h %08h %1h\n",
                        fi_write_count, dmem_addr, dmem_data_o, dmem_wstrb);
            end

            if (fi_done) begin
                $fclose(fi_trace_fd);
                $display("==========================================");
                $display("FI_SUMMARY: EXIT_CODE        = %0d", dmem_data_o);
                $display("FI_SUMMARY: TOTAL_CYCLES     = %0d", cycle_count);
                $display("FI_SUMMARY: TOTAL_WRITES     = %0d", fi_write_count);
                $display("FI_SUMMARY: DMR_FE_DETECTED  = %0d", fi_dmr_fe_count);
                $display("FI_SUMMARY: DMR_MWB_DETECTED = %0d", fi_dmr_mwb_count);
                $display("FI_SUMMARY: TMR_MASKED       = %0d", fi_tmr_masked_count);
                $display("FI_SUMMARY: ECC_SEC_MASKED   = %0d", fi_ecc_sec_count);
                $display("FI_SUMMARY: ECC_DED_DETECTED = %0d", fi_ecc_ded_count);
                $display("==========================================");
            end
        end
    end

    initial begin
        if (!$test$plusargs("GOLDEN_RUN")) begin
            if (!$value$plusargs("FI_TARGET=%d", fi_target_id))
                fi_target_id = 4;
            if (!$value$plusargs("FI_CYCLE=%d", fi_inject_cycle))
                fi_inject_cycle = 1000;
            if (!$value$plusargs("FI_BIT=%d", fi_bit_idx))
                fi_bit_idx = 0;
            if (!$value$plusargs("FI_DUR=%d", fi_duration))
                fi_duration = 1;

            wait (rst0 == 1'b0);
            wait (cycle_count == fi_inject_cycle);

            @(negedge clk0);
            $display("FI_INJ: C=%0d Inject Target=%0d Bit=%0d Dur=%0d", cycle_count, fi_target_id, fi_bit_idx, fi_duration);

            inject_seu(fi_target_id, fi_bit_idx);

            repeat (fi_duration) @(negedge clk0);

            release_seu(fi_target_id);
            $display("FI_INJ: C=%0d Fault Released", cycle_count);
        end
    end

    task inject_seu;
        input integer target;
        input integer bit_pos;
        reg [31:0] mask32;
        reg [38:0] mask39;
        begin
            mask32 = (32'h1 << bit_pos);
            mask39 = (39'h1 << bit_pos);

            case (target)
                1: force dut.dut.pipe.PC_Out_dex0           = (dut.dut.pipe.PC_Out_dex0 ^ mask32);
                2: force dut.dut.pipe.Instruction_dex0      = (dut.dut.pipe.Instruction_dex0 ^ mask32);
                3: force dut.dut.pipe.Alu_Result_al0        = (dut.dut.pipe.Alu_Result_al0 ^ mask32);
                4: force dut.dut.pipe.Writeback_Result_mwb0 = (dut.dut.pipe.Writeback_Result_mwb0 ^ mask32);
                5: force dut.dut.pipe.Writeback_Result_mwb2 = (dut.dut.pipe.Writeback_Result_mwb2 ^ mask32);
                6: force dut.dut.pipe.Alu_Result_mwb2       = (dut.dut.pipe.Alu_Result_mwb2 ^ mask32);
                7: force dut.dut.pipe.read_codeword1        = (dut.dut.pipe.read_codeword1 ^ mask39);
                default: $display("FI_INJ: Invalid Target=%0d", target);
            endcase
        end
    endtask

    task release_seu;
        input integer target;
        begin
            case (target)
                1: release dut.dut.pipe.PC_Out_dex0;
                2: release dut.dut.pipe.Instruction_dex0;
                3: release dut.dut.pipe.Alu_Result_al0;
                4: release dut.dut.pipe.Writeback_Result_mwb0;
                5: release dut.dut.pipe.Writeback_Result_mwb2;
                6: release dut.dut.pipe.Alu_Result_mwb2;
                7: release dut.dut.pipe.read_codeword1;
            endcase
        end
    endtask

endmodule



