// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      Top_Protected.v
// Author:         Tara Sarpoolaki / Tarasarpoolaki@gmail.com
// Last Modified:  2026-10-17
// Description:
//    
// License:        CERN-OHL-S-v2
// =============================================================================

module Top_Protected #(parameter size = 32)(
    input                           clk0,
    input                           rst0,
    input                           clk1,
    input                           rst1,

    input                           Irq_Timer_i,
    input                           Irq_Ext_i,
    input                           Irq_software_i,

    output                          mismatch_o
);

    wire            Imem_Interface_Valid_i;
    wire            Imem_Interface_Stall_o;
    wire            Imem_Interface_Req_o;
    wire [31:0]     Imem_Interface_Data_i;
    wire [31:0]     Imem_Interface_Addr_o;

    wire            DMem_Interface_Req_Ready_i;
    wire            DMem_Interface_Req_Valid_o;
    wire            DMem_Interface_Read_En_o;
    wire            DMem_Interface_Write_En_o;
    wire [3:0]      DMem_Interface_Wstrb_o;
    wire [31:0]     DMem_Interface_Data_i;
    wire [31:0]     DMem_Interface_Data_o;
    wire [31:0]     DMem_Interface_Addr_o;

    wire            cache_cpu_ready;
    wire [31:0]     cache_cpu_rdata;

    wire            cache_mem_req;
    wire            cache_mem_wen;
    wire [31:0]     cache_mem_addr;
    wire [127:0]    cache_mem_wdata;

    wire            cache_mem_ready;
    wire [127:0]    cache_mem_rdata;

    localparam [31:0] CLINT_BASE   = 32'h0200_0000;
    localparam [31:0] UART_TX_ADDR = 32'h1000_0000;
    localparam [31:0] SIMEND_ADDR  = 32'h2000_0000;

    localparam integer RAM_SIZE_BYTES = 1024 * 1024;
    localparam [31:0]  RAM_END_ADDR   = 32'h0010_0000;

    wire            is_mem;
    assign          is_mem = (DMem_Interface_Addr_o < RAM_END_ADDR);


    TERME_Protected_presynth #(.size(size)) dut (
    // TERME_Protected  dut (
        .clk0                       (clk0),
        .clk1                       (clk1),
        .rst0                       (rst0),
        .rst1                       (rst1),

        .Irq_Timer_i                (Irq_Timer_i),
        .Irq_Ext_i                  (Irq_Ext_i),
        .Irq_software_i             (Irq_software_i),

        .DMem_Interface_Req_Ready_i (DMem_Interface_Req_Ready_i),

        .Imem_Interface_Valid_i     (Imem_Interface_Valid_i),
        .Imem_Interface_Stall_o     (Imem_Interface_Stall_o),
        .Imem_Interface_Req_o       (Imem_Interface_Req_o),
        .Imem_Interface_Data_i      (Imem_Interface_Data_i),
        .Imem_Interface_Addr_o      (Imem_Interface_Addr_o),

        .DMem_Interface_Req_Valid_o (DMem_Interface_Req_Valid_o),
        .DMem_Interface_Read_En_o   (DMem_Interface_Read_En_o),
        .DMem_Interface_Write_En_o  (DMem_Interface_Write_En_o),
        .DMem_Interface_Wstrb_o     (DMem_Interface_Wstrb_o),
        .DMem_Interface_Data_i      (DMem_Interface_Data_i),
        .DMem_Interface_Data_o      (DMem_Interface_Data_o),
        .DMem_Interface_Addr_o      (DMem_Interface_Addr_o),

        .mismatch_o                 (mismatch_o)
    );


    wire cacheable_req;

    assign cacheable_req =
        DMem_Interface_Req_Valid_o && is_mem;

    l1d_cache_blocking #(
        .ADDR_WIDTH         (32),
        .DATA_WIDTH         (32),
        .CACHE_SIZE_BYTES   (4096),
        .BLOCK_SIZE_BYTES   (16),
        .WAYS               (4)
    )
    dcache (
        .clk                (clk0),
        .rst                (rst0),

        .CPU_WEn_i          (DMem_Interface_Write_En_o),
        .CPU_REn_i          (DMem_Interface_Read_En_o),
        .CPU_Req_Valid_i    (cacheable_req),
        .CPU_Req_Ready_dc_o (cache_cpu_ready),

        .CPU_Addr_i         (DMem_Interface_Addr_o),
        .CPU_Data_i         (DMem_Interface_Data_o),
        .CPU_Wstrb_i        (DMem_Interface_Wstrb_o),
        .CPU_Data_dc_o      (cache_cpu_rdata),

        .Mem_Ready_i        (cache_mem_ready),
        .Mem_Rdata_i        (cache_mem_rdata),
        .Mem_Req_dc_o       (cache_mem_req),
        .Mem_WEn_dc_o       (cache_mem_wen),
        .Mem_Addr_dc_o      (cache_mem_addr),
        .Mem_Wdata_dc_o     (cache_mem_wdata)
    );

    Instruction_Memory imem (
        .clk                (clk0),
        .req_i              (Imem_Interface_Req_o),
        .addr_i             (Imem_Interface_Addr_o),
        .rdata_o            (Imem_Interface_Data_i)
    );

    assign Imem_Interface_Valid_i = Imem_Interface_Req_o;


    Data_Memory #(
        .MEM_SIZE           (RAM_SIZE_BYTES),
        .LATENCY_CYCLES     (1)
    )
    dmem (
        .clk                (clk0),
        .rst                (rst0),

        .req_i              (cache_mem_req),
        .wen_i              (cache_mem_wen),
        .addr_i             (cache_mem_addr),
        .wdata_i            (cache_mem_wdata),

        .ready_o            (cache_mem_ready),
        .rdata_o            (cache_mem_rdata)
    );

    

    assign DMem_Interface_Req_Ready_i   = is_mem ? cache_cpu_ready : 1'b1;
    assign DMem_Interface_Data_i        = is_mem ? cache_cpu_rdata : 32'h0000_0000;

endmodule
