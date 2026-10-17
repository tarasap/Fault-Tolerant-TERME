// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      TERME_Protected.v
// Author:         Tara Sarpoolaki /Tarasarpoolaki@gmail.com
// Last Modified:  2026-10-11
// Description:    
// 
// License:        CERN-OHL-S-v2
// =============================================================================

`timescale 1ns / 1ps

module TERME_Protected_presynth #(parameter size = 32)(
    input                           clk0,
    input                           rst0,
    input                           clk1,
    input                           rst1,

    input                           Irq_Timer_i,
    input                           Irq_Ext_i,
    input                           Irq_software_i,

    input                           DMem_Interface_Req_Ready_i,
    input  [size - 1 : 0]           DMem_Interface_Data_i,
    input                           Imem_Interface_Valid_i,
    input  [size - 1 : 0]           Imem_Interface_Data_i, 
    output                          Imem_Interface_Req_o,
    output                          Imem_Interface_Stall_o,
    output [size - 1 : 0]           Imem_Interface_Addr_o,
    output                          DMem_Interface_Read_En_o,
    output                          DMem_Interface_Write_En_o,
    output [3 : 0]                  DMem_Interface_Wstrb_o,
    output                          DMem_Interface_Req_Valid_o,
    output [size - 1 : 0]           DMem_Interface_Data_o,
    output [size - 1 : 0]           DMem_Interface_Addr_o,

    output                          mismatch_o
);

    wire                            ImmEnable0;
    wire                            Regread0;
    wire                            BrchEnable0;
    wire [2 : 0]                    Immediate_Type0;
    wire [1 : 0]                    ResultSrc0;
    wire [1 : 0]                    ALUSrc0;
    wire                            Regwrite0; 
    wire [2 : 0]                    R_Type0;                
    wire [1 : 0]                    W_Type0;               
    wire                            Mem_Read_En0;                
    wire                            Mem_Write_En0;                        
    wire                            Jump0;
    wire [4 : 0]                    ALUControl0;
    wire [1 : 0]                    ForwardA0;
    wire [1 : 0]                    ForwardB0;
    wire                            FlushF0; 
    wire                            FlushDEX0; 
    wire                            FlushWB0;
    wire                            StallF0;
    wire                            StallDEX0;
    wire [1 : 0]                    CSR_Opcode0;
    wire                            Mret0;
    wire                            CSR_Imm0;
    wire                            Irq_Taken0;
    wire                            External_Activated0;
    wire                            Timer_Activated0;
    wire                            Software_Activated0;
    wire                            CSR_En0;

    wire                            ImmEnable1;
    wire                            Regread1;
    wire                            BrchEnable1;
    wire [2 : 0]                    Immediate_Type1;
    wire [1 : 0]                    ResultSrc1;
    wire [1 : 0]                    ALUSrc1;
    wire                            Regwrite1; 
    wire [2 : 0]                    R_Type1;                
    wire [1 : 0]                    W_Type1;               
    wire                            Mem_Read_En1;                
    wire                            Mem_Write_En1;                        
    wire                            Jump1;
    wire [4 : 0]                    ALUControl1;
    wire [1 : 0]                    ForwardA1;
    wire [1 : 0]                    ForwardB1;
    wire                            FlushF1; 
    wire                            FlushDEX1; 
    wire                            FlushWB1;
    wire                            StallF1;
    wire                            StallDEX1;
    wire [1 : 0]                    CSR_Opcode1;
    wire                            Mret1;
    wire                            CSR_Imm1;
    wire                            Irq_Taken1;
    wire                            External_Activated1;
    wire                            Timer_Activated1;
    wire                            Software_Activated1;
    wire                            CSR_En1;

    wire [4 : 0]                    Rs1_0;
    wire [4 : 0]                    Rs2_0;
    wire [4 : 0]                    Rd_0;
    wire [6 : 0]                    OPCode_fe_0;
    wire [6 : 0]                    OPCode_dex_0;
    wire [2 : 0]                    Funct3_0;
    wire [6 : 0]                    Funct7_0;
    wire [11 : 0]                   Funct12_0;
    wire                            OPB5_0;
    wire                            PCSrc_0;

    wire [4 : 0]                    Rs1_1;
    wire [4 : 0]                    Rs2_1;
    wire [4 : 0]                    Rd_1;
    wire [6 : 0]                    OPCode_fe_1;
    wire [6 : 0]                    OPCode_dex_1;
    wire [2 : 0]                    Funct3_1;
    wire [6 : 0]                    Funct7_1;
    wire [11 : 0]                   Funct12_1;
    wire                            OPB5_1;
    wire                            PCSrc_1;

    wire                            Mip_Meip_0;
    wire                            Mip_Mtip_0;
    wire                            Mip_Msip_0;
    wire                            Mie_Meie_0;
    wire                            Mie_Mtie_0;
    wire                            Mie_Msie_0;
    wire                            Mstatus_Mie_0;
    wire [1 : 0]                    Current_Privilege_0;

    wire [1 : 0]                    ResultSrc_mwb0 ; 
    wire                            Regwrite_mwb0  ;  
    wire [6 : 0]                    OPCode_mwb0    ;  
    wire [6 : 0]                    Funct7_mwb0    ;  
    wire [2 : 0]                    Funct3_mwb0    ;  
    wire [4 : 0]                    Rd_mwb0        ;  
    
    wire [1 : 0]                    ResultSrc_mwb1 ; 
    wire                            Regwrite_mwb1  ;
    wire [6 : 0]                    OPCode_mwb1    ;  
    wire [6 : 0]                    Funct7_mwb1    ;  
    wire [2 : 0]                    Funct3_mwb1    ;  
    wire [4 : 0]                    Rd_mwb1        ;

    Pipe_Manager #(.size(size)) pm (
        .clk0                       (clk0),
        .rst0                       (rst0),
        .clk1                       (clk1),
        .rst1                       (rst1),
        .DMem_Interface_Req_Ready_i (DMem_Interface_Req_Ready_i),
        .DMem_Interface_Req_Valid_i (DMem_Interface_Req_Valid_o),

        .Mul_Busy0_i                (Mul_Busy_dex0),
        .Mul_Done0_i                (Mul_Done_dex0),
        .ResultSrc_mwb0_i           (ResultSrc_mwb0),
        .PCSrc0_i                   (PCSrc_0),
        .Regwrite_wb0_i             (Regwrite_mwb0),
        .OPCode_mwb0_i              (OPCode_mwb0),
        .OPCode_fe0_i               (OPCode_fe_0),
        .OPCode0_i                  (OPCode_dex_0),
        .Funct7_mwb0_i              (Funct7_mwb0),
        .Funct3_mwb0_i              (Funct3_mwb0),
        .Funct3_0_i                 (Funct3_0),
        .Funct7_0_i                 (Funct7_0),
        .Funct12_0_i                (Funct12_0),
        .OPB5_0_i                   (OPB5_0),
        .Rs1_0_i                    (Rs1_0),
        .Rs2_0_i                    (Rs2_0),
        .Rd_0_i                     (Rd_0),
        .Rd_mwb0_i                  (Rd_mwb0),
        
        .Mip_Meip0_i                (Mip_Meip_0),
        .Mip_Mtip0_i                (Mip_Mtip_0),
        .Mip_Msip0_i                (Mip_Msip_0),
        .Mie_Meie0_i                (Mie_Meie_0),
        .Mie_Mtie0_i                (Mie_Mtie_0),
        .Mie_Msie0_i                (Mie_Msie_0),
        .Mstatus_Mie0_i             (Mstatus_Mie_0),
        .Current_Privilege0_i       (Current_Privilege_0),

        .Mul_Busy1_i                (Mul_Busy_dex1),
        .Mul_Done1_i                (Mul_Done_dex1),
        .ResultSrc_mwb1_i           (ResultSrc_mwb1),
        .PCSrc1_i                   (PCSrc_1), ///////////////// or 0
        .Regwrite_wb1_i             (Regwrite_mwb1),
        .OPCode_mwb1_i              (OPCode_mwb1),
        .OPCode_fe1_i               (OPCode_fe_1),
        .OPCode1_i                  (OPCode_dex_1),
        .Funct7_mwb1_i              (Funct7_mwb1),
        .Funct3_mwb1_i              (Funct3_mwb1),
        .Funct3_1_i                 (Funct3_1),
        .Funct7_1_i                 (Funct7_1),
        .Funct12_1_i                (Funct12_1),
        .OPB5_1_i                   (OPB5_1),
        .Rs1_1_i                    (Rs1_1),
        .Rs2_1_i                    (Rs2_1),
        .Rd_1_i                     (Rd_1),
        .Rd_mwb1_i                  (Rd_mwb1),
        
        .Mip_Meip1_i                (Mip_Meip_0),
        .Mip_Mtip1_i                (Mip_Mtip_0),
        .Mip_Msip1_i                (Mip_Msip_0),
        .Mie_Meie1_i                (Mie_Meie_0),
        .Mie_Mtie1_i                (Mie_Mtie_0),
        .Mie_Msie1_i                (Mie_Msie_0),
        .Mstatus_Mie1_i             (Mstatus_Mie_0),
        .Current_Privilege1_i       (Current_Privilege_0),

        .ImmEnable0_o               (ImmEnable0),
        .Regread0_o                 (Regread0),
        .BrchEnable0_o              (BrchEnable0),
        .Immediate_Type0_o          (Immediate_Type0),
        .ResultSrc0_o               (ResultSrc0),
        .ALUSrc0_o                  (ALUSrc0),
        .Regwrite0_o                (Regwrite0),
        .R_Type0_o                  (R_Type0),
        .W_Type0_o                  (W_Type0),
        .Mem_Read_En0_o             (Mem_Read_En0),
        .Mem_Write_En0_o            (Mem_Write_En0),
        .Jump0_o                    (Jump0),
        .ALUControl0_o              (ALUControl0),
        .ForwardA0_o                (ForwardA0),
        .ForwardB0_o                (ForwardB0),
        .FlushF0_o                  (FlushF0),
        .FlushDEX0_o                (FlushDEX0),
        .FlushWB0_o                 (FlushWB0),
        .StallF0_o                  (StallF0),
        .StallDEX0_o                (StallDEX0),
        .CSR_Opcode0_o              (CSR_Opcode0),
        .Mret0_o                    (Mret0),
        .CSR_Imm0_o                 (CSR_Imm0),
        .Irq_Taken0_o               (Irq_Taken0),
        .External_Activated0_o      (External_Activated0),
        .Timer_Activated0_o         (Timer_Activated0),
        .Software_Activated0_o      (Software_Activated0),
        .CSR_En0_o                  (CSR_En0),
        .Mul_Start0_o               (Mul_Start0),
        .Mul_En0_o                  (Mul_En0),
        .Mul_Sel0_o                 (Mul_Sel0),
        .Mul_Hi0_o                  (Mul_Hi0),
        .Mul_Signa0_o               (Mul_Signa0),
        .Mul_Signb0_o               (Mul_Signb0),

        .ImmEnable1_o               (ImmEnable1),
        .Regread1_o                 (Regread1),
        .BrchEnable1_o              (BrchEnable1),
        .Immediate_Type1_o          (Immediate_Type1),
        .ResultSrc1_o               (ResultSrc1),
        .ALUSrc1_o                  (ALUSrc1),
        .Regwrite1_o                (Regwrite1),
        .R_Type1_o                  (R_Type1),
        .W_Type1_o                  (W_Type1),
        .Mem_Read_En1_o             (Mem_Read_En1),
        .Mem_Write_En1_o            (Mem_Write_En1),
        .Jump1_o                    (Jump1),
        .ALUControl1_o              (ALUControl1),
        .ForwardA1_o                (ForwardA1),
        .ForwardB1_o                (ForwardB1),
        .FlushF1_o                  (FlushF1),
        .FlushDEX1_o                (FlushDEX1),
        .FlushWB1_o                 (FlushWB1),
        .StallF1_o                  (StallF1),
        .StallDEX1_o                (StallDEX1),
        .CSR_Opcode1_o              (CSR_Opcode1),
        .Mret1_o                    (Mret1),
        .CSR_Imm1_o                 (CSR_Imm1),
        .Irq_Taken1_o               (Irq_Taken1),
        .External_Activated1_o      (External_Activated1),
        .Timer_Activated1_o         (Timer_Activated1),
        .Software_Activated1_o      (Software_Activated1),
        .CSR_En1_o                  (CSR_En1),
        .Mul_Start1_o               (Mul_Start1),
        .Mul_En1_o                  (Mul_En1),
        .Mul_Sel1_o                 (Mul_Sel1),
        .Mul_Hi1_o                  (Mul_Hi1),
        .Mul_Signa1_o               (Mul_Signa1),
        .Mul_Signb1_o               (Mul_Signb1)
    );

    Pipeline #(.size(size)) pipe (
        .clk0                       (clk0),
        .rst0                       (rst0),
        .clk1                       (clk1),
        .rst1                       (rst1),

        .DMem_Interface_Req_Ready_i (DMem_Interface_Req_Ready_i),
        .Irq_Timer_i                (Irq_Timer_i),
        .Irq_Ext_i                  (Irq_Ext_i),
        .Irq_software_i             (Irq_software_i),

        .Imem_Interface_Valid_i     (Imem_Interface_Valid_i),
        .Imem_Interface_Data_i      (Imem_Interface_Data_i), 
        .Load_Data_Interface_i      (DMem_Interface_Data_i),   
        .Imem_Req_p_o               (Imem_Interface_Req_o),
        .Imem_Stall_p_o             (Imem_Interface_Stall_o),
        .Imem_Addr_o                (Imem_Interface_Addr_o),
        .DMem_Interface_Read_En_o   (DMem_Interface_Read_En_o),
        .DMem_Interface_Write_En_o  (DMem_Interface_Write_En_o),
        .DMem_Interface_Wstrb_o     (DMem_Interface_Wstrb_o),
        .DMem_Interface_Req_Valid_o (DMem_Interface_Req_Valid_o),
        .Store_Data_Interface_o     (DMem_Interface_Data_o),
        .Mem_Addr_o                 (DMem_Interface_Addr_o),

        .CSR_En0_i                  (CSR_En0),
        .CSR_Opcode0_i              (CSR_Opcode0),
        .Mret0_i                    (Mret0),
        .CSR_Imm0_i                 (CSR_Imm0),
        .External_Activated0_i      (External_Activated0),
        .Timer_Activated0_i         (Timer_Activated0),
        .Software_Activated0_i      (Software_Activated0),
        .Irq_Taken0_i               (Irq_Taken0),
        .Immediate_Type0_i          (Immediate_Type0),
        .ResultSrc0_i               (ResultSrc0),
        .ALUControl0_i              (ALUControl0),
        .ALUSrc0_i                  (ALUSrc0),
        .Regwrite0_i                (Regwrite0),
        .Regread0_i                 (Regread0),
        .ImmEnable0_i               (ImmEnable0),
        .BrchEnable0_i              (BrchEnable0),
        .R_Type0_i                  (R_Type0),
        .W_Type0_i                  (W_Type0),
        .Mem_Read_en0_i             (Mem_Read_En0),
        .Mem_Write_en0_i            (Mem_Write_En0),
        .Jump0_i                    (Jump0),
        .Req_Ready0_i               (1'b1),
        
        .ForwardA0_i                (ForwardA0),
        .ForwardB0_i                (ForwardB0),
        .FlushF0_i                  (FlushF0),
        .FlushDEX0_i                (FlushDEX0),
        .FlushWB0_i                 (FlushWB0),
        .StallDEX0_i                (StallDEX0),
        .StallF0_i                  (StallF0),
        .Mul_Start0_i               (Mul_Start0),
        .Mul_Sel0_i                 (Mul_Sel0),
        .Mul_Hi0_i                  (Mul_Hi0),
        .Mul_Signa0_i               (Mul_Signa0),
        .Mul_Signb0_i               (Mul_Signb0),
        .Mul_Busy_dex0_o            (Mul_Busy_dex0),
        .Mul_Done_dex0_o            (Mul_Done_dex0),

        .Immediate_Type1_i          (Immediate_Type1),
        .ResultSrc1_i               (ResultSrc1),
        .ALUControl1_i              (ALUControl1),
        .ALUSrc1_i                  (ALUSrc1),
        .Regwrite1_i                (Regwrite1),
        .Regread1_i                 (Regread1),
        .ImmEnable1_i               (ImmEnable1),
        .BrchEnable1_i              (BrchEnable1),
        .Jump1_i                    (Jump1),
        
        .ForwardA1_i                (ForwardA1),
        .ForwardB1_i                (ForwardB1),
        .FlushF1_i                  (FlushF1),
        .StallDEX1_i                (StallDEX1),
        .StallF1_i                  (StallF1),

        .Regwrite_mwb_i             (1'b0),
        .Mul_Start1_i               (Mul_Start1),
        .Mul_Sel1_i                 (Mul_Sel1),
        .Mul_Hi1_i                  (Mul_Hi1),
        .Mul_Signa1_i               (Mul_Signa1),
        .Mul_Signb1_i               (Mul_Signb1),
        .Mul_Busy_dex1_o            (Mul_Busy_dex1),
        .Mul_Done_dex1_o            (Mul_Done_dex1),

        .Rs1_0_o                    (Rs1_0),
        .Rs2_0_o                    (Rs2_0),
        .Rd_0_o                     (Rd_0),
        .OPCode_fe_0_o              (OPCode_fe_0),
        .OPCode_dex0_o              (OPCode_dex_0),
        .Funct3_0_o                 (Funct3_0),
        .Funct7_0_o                 (Funct7_0),
        .Funct12_0_o                (Funct12_0),
        .OPB5_0_o                   (OPB5_0),
        .Funct3_mwb_0_o             (Funct3_mwb0),
        .Funct7_mwb_0_o             (Funct7_mwb0),
        .OPCode_mwb_0_o             (OPCode_mwb0),
        .PCSrc_0_o                  (PCSrc_0),

        .Rs1_1_o                    (Rs1_1),
        .Rs2_1_o                    (Rs2_1),
        .Rd_1_o                     (Rd_1),
        .OPCode_fe_1_o              (OPCode_fe_1),
        .OPCode_dex1_o              (OPCode_dex_1),
        .Funct3_1_o                 (Funct3_1),
        .Funct7_1_o                 (Funct7_1),
        .Funct12_1_o                (Funct12_1),
        .OPB5_1_o                   (OPB5_1),
        .Funct3_mwb_1_o             (Funct3_mwb1),
        .Funct7_mwb_1_o             (Funct7_mwb1),
        .OPCode_mwb_1_o             (OPCode_mwb1),
        .PCSrc_1_o                  (PCSrc_1),

        .Mip_Meip_0_o               (Mip_Meip_0),
        .Mip_Mtip_0_o               (Mip_Mtip_0),
        .Mip_Msip_0_o               (Mip_Msip_0),
        .Mie_Meie_0_o               (Mie_Meie_0),
        .Mie_Mtie_0_o               (Mie_Mtie_0),
        .Mie_Msie_0_o               (Mie_Msie_0),
        .Mstatus_Mie_0_o            (Mstatus_Mie_0),
        .Current_Privilege_0_o      (Current_Privilege_0),

        .mismatch_o                 (mismatch_o),

        .Regwrite_mwb0_o            (Regwrite_mwb0),
        .Regwrite_mwb1_o            (Regwrite_mwb1),
        .ResultSrc_mwb0_o           (ResultSrc_mwb0),
        .ResultSrc_mwb1_o           (ResultSrc_mwb1),
        .Rd_mwb0_o                  (Rd_mwb0),
        .Rd_mwb1_o                  (Rd_mwb1)
    );
endmodule