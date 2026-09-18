// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      Pipeline.v
// Author:         Tara Sarpoolaki /Tarasarpoolaki@gmail.com
// Last Modified:  2026-9-18
// Description:    
// 
// License:        CERN-OHL-S-v2
// =============================================================================

`timescale 1ns / 1ps

module Pipeline #(parameter size = 32)(
    input                                clk0,
    input                                rst0,

    input                                clk1,
    input                                rst1,

    input                                DMem_Interface_Req_Ready_i,
    input                                Irq_Timer_i,
    input                                Irq_Ext_i,
    input                                Irq_software_i,

    input                                Imem_Interface_Valid_i,
    input   [size - 1 : 0]               Imem_Interface_Data_i,
    input   [size - 1 : 0]               Load_Data_Interface_i,
    output                               Imem_Req_p_o,
    output                               Imem_Stall_p_o,
    output  [size - 1 : 0]               Imem_Addr_o,
    output                               DMem_Interface_Read_En_o,
    output                               DMem_Interface_Write_En_o,
    output  [3 : 0]                      DMem_Interface_Wstrb_o,
    output                               DMem_Interface_Req_Valid_o,
    output  [size - 1 : 0]               Store_Data_Interface_o,
    output  [size - 1 : 0]               Mem_Addr_o,

    input                                CSR_En0_i,
    input   [1 : 0]                      CSR_Opcode0_i,
    input                                Mret0_i,
    input                                CSR_Imm0_i,
    input                                External_Activated0_i,
    input                                Timer_Activated0_i,
    input                                Software_Activated0_i,
    input                                Irq_Taken0_i,
    input   [2 : 0]                      Immediate_Type0_i,
    input   [1 : 0]                      ResultSrc0_i,
    input   [4 : 0]                      ALUControl0_i,
    input   [1 : 0]                      ALUSrc0_i,
    input                                Regwrite0_i,
    input                                Regread0_i,
    input                                ImmEnable0_i,
    input                                BrchEnable0_i,
    input   [2 : 0]                      R_Type0_i,
    input   [1 : 0]                      W_Type0_i,
    input                                Mem_Read_en0_i,
    input                                Mem_Write_en0_i,
    input                                Jump0_i,
    input                                Req_Ready0_i,
    input   [1 : 0]                      ForwardA0_i,
    input   [1 : 0]                      ForwardB0_i,
    input                                FlushF0_i,
    input                                FlushDEX0_i,
    input                                FlushWB0_i,
    input                                StallDEX0_i,
    input                                StallF0_i,
    input                                Mul_Start0_i,
    input                                Mul_Sel0_i,
    input                                Mul_Hi0_i,
    input                                Mul_Signa0_i,
    input                                Mul_Signb0_i,
    output                               Mul_Busy_dex0_o,
    output                               Mul_Done_dex0_o,

    input   [2 : 0]                      Immediate_Type1_i,
    input   [1 : 0]                      ResultSrc1_i,
    input   [4 : 0]                      ALUControl1_i,
    input   [1 : 0]                      ALUSrc1_i,
    input                                Regwrite1_i,
    input                                Regread1_i,
    input                                ImmEnable1_i,
    input                                BrchEnable1_i,
    input                                Jump1_i,
    input   [1 : 0]                      ForwardA1_i,
    input   [1 : 0]                      ForwardB1_i,
    input                                FlushF1_i,
    input                                StallDEX1_i,
    input                                StallF1_i,
    input                                Regwrite_mwb_i,

    input                                Mul_Start1_i,
    input                                Mul_Sel1_i,
    input                                Mul_Hi1_i,
    input                                Mul_Signa1_i,
    input                                Mul_Signb1_i,
    output                               Mul_Busy_dex1_o,
    output                               Mul_Done_dex1_o,

    output  [4 : 0]                      Rs1_0_o,
    output  [4 : 0]                      Rs2_0_o,
    output  [4 : 0]                      Rd_0_o,
    output  [6 : 0]                      OPCode_fe_0_o,
    output  [6 : 0]                      OPCode_dex0_o,
    output  [2 : 0]                      Funct3_0_o,
    output  [6 : 0]                      Funct7_0_o,
    output  [11 : 0]                     Funct12_0_o,
    output                               OPB5_0_o,
    output  [2 : 0]                      Funct3_mwb_0_o,
    output  [6 : 0]                      Funct7_mwb_0_o,
    output  [6 : 0]                      OPCode_mwb_0_o,
    output                               PCSrc_0_o,

    output  [4 : 0]                      Rs1_1_o,
    output  [4 : 0]                      Rs2_1_o,
    output  [4 : 0]                      Rd_1_o,
    output  [6 : 0]                      OPCode_fe_1_o,
    output  [6 : 0]                      OPCode_dex1_o,
    output  [2 : 0]                      Funct3_1_o,
    output  [6 : 0]                      Funct7_1_o,
    output  [11 : 0]                     Funct12_1_o,
    output                               OPB5_1_o,
    output  [2 : 0]                      Funct3_mwb_1_o,
    output  [6 : 0]                      Funct7_mwb_1_o,
    output  [6 : 0]                      OPCode_mwb_1_o,
    output                               PCSrc_1_o,

    output                               Mip_Meip_0_o,
    output                               Mip_Mtip_0_o,
    output                               Mip_Msip_0_o,
    output                               Mie_Meie_0_o,
    output                               Mie_Mtie_0_o,
    output                               Mie_Msie_0_o,
    output                               Mstatus_Mie_0_o,
    output  [1 : 0]                      Current_Privilege_0_o,

    output                               mismatch_o,

    output                               Regwrite_mwb0_o,
    output                               Regwrite_mwb1_o,
    output  [1 : 0]                      ResultSrc_mwb0_o,
    output  [1 : 0]                      ResultSrc_mwb1_o,
    output  [4 : 0]                      Rd_mwb0_o,
    output  [4 : 0]                      Rd_mwb1_o
);

    wire                            pc_enable;
    wire    [size - 1 : 0]          pc_out_ilu;
    wire    [size - 1 : 0]          instruction_ilu;
    wire    [size - 1 : 0]          instruction_dc;
    wire    [15 : 0]                compressed_inst;
    wire                            is_compressed;

    wire    [size - 1 : 0]          pc_out_fe0;
    wire    [size - 1 : 0]          pc_out_fe1;

    wire    [size - 1 : 0]          PC_Out_dex0, PC_Plus_dex0;
    wire    [size - 1 : 0]          Instruction_dex0, Instruction_mwb0;
    wire                            PCSrc_dex0;
    wire    [size - 1 : 0]          Sign_Extended0;
    wire    [size - 1 : 0]          SrcA_al0, SrcB_al0;
    wire    [size - 1 : 0]          Alu_Result_al0, Alu_Result_mwb0;
    wire    [size - 1 : 0]          SrcA_mwb0, SrcB_mwb0, pc_plus_mwb0;
    wire    [4 : 0]                 Rs1_mwb0;
    wire    [6 : 0]                 OPCode_dex0;
    wire    [2 : 0]                 Funct3_dex0;
    wire    [6 : 0]                 Funct7_dex0;
    wire    [11 : 0]                Funct12_dex0;
    wire                            OPB5_dex0;
    wire    [4 : 0]                 Rs1_dex0, Rs2_dex0, Rd_dex0;

    wire    [size - 1 : 0]          PC_Out_dex1, PC_Plus_dex1, Instruction_dex1, Instruction_mwb1;
    wire                            PCSrc_dex1;
    wire    [size - 1 : 0]          Sign_Extended1;
    wire    [size - 1 : 0]          SrcA_al1, SrcB_al1;
    wire    [size - 1 : 0]          Alu_Result_al1, Alu_Result_mwb1;
    wire    [size - 1 : 0]          SrcA_mwb1, SrcB_mwb1, pc_plus_mwb1;
    wire    [4 : 0]                 Rs1_mwb1;

    wire [11 : 0]                   CSR_Addr_mwb0;
    wire [size - 1 : 0]             PC_Out_mwb0;
    wire [size - 1 : 0]             trap_next_pc;
    wire [size - 1 : 0]             CSR_Rdata;

    wire                            mismatch;
    assign mismatch_o = mismatch;

    wire [size - 1 : 0]             ReadReg1_rf, ReadReg2_rf;
    wire                            Regread_dex0 ,Regread_dex1;

    wire [size - 1 : 0]             Writeback_Result_mwb0, Writeback_Result_mwb1, Writeback_Result_mwb2;
    wire [size - 1 : 0]             Load_Data_lsu;
    wire                            Mem_Read_en_mwb0;
    wire                            Mem_Write_en_mwb0;
    wire                            Regwrite_mwb0;
    wire                            Regwrite_mwb1;
    wire [2 : 0]                    R_Type_mwb0;
    wire [1 : 0]                    W_Type_mwb0;
    wire [size - 1 : 0]             CSR_Wdata_mwb0, CSR_Wdata_mwb1, CSR_Wdata_mwb2;

    wire [size - 1 : 0]             SrcB_mwb_voted;
    wire [size - 1 : 0]             alu_result_mwb_voted;
    wire [size - 1 : 0]             writeback_result_voted;

    wire                            flush_f0_eff, flush_f1_eff, flush_dex0_eff, flush_dex1_eff;
    wire                            valid_dex0;
    wire                            Valid_mwb0;
    wire [size - 1 : 0]             rp_value;
    wire [size - 1 : 0]             next_pc_dex0;
    wire [size - 1 : 0]             next_pc_mwb0;
    wire [39 - 1 : 0]               read_codeword1, read_codeword2;
    wire [39 - 1 : 0]               encoded_writeback;
    wire [6 - 1 : 0]                syndrome1, syndrome2;    
    wire                            single_error1, double_error1;
    wire                            single_error2, double_error2;
    wire [size - 1 : 0]             read_data1, read_data2;   

    wire                            PCSrc_commit0, PCSrc_commit1;
    wire                            Regwrite_mwb_commit0, Regwrite_mwb_commit1;

    assign Regwrite_mwb_commit0 = Regwrite_mwb0 && !Irq_Taken0_i && ((ResultSrc_mwb0_o != 2'b01) || DMem_Interface_Req_Ready_i);
    assign PCSrc_commit0 = PCSrc_dex0 && !StallDEX0_i;

    assign Regwrite_mwb_commit1 = Regwrite_mwb1 && !Irq_Taken0_i && ((ResultSrc_mwb1_o != 2'b01) || DMem_Interface_Req_Ready_i);
    assign PCSrc_commit1 = PCSrc_dex1 && !StallDEX1_i;


    Instruction_Load_Unit #(.size(size)) ILU_Interface (
        .clk                        (clk0),
        .rst                        (rst0),

        .PCSrc_i                    (PCSrc_commit0),
        .StallF_i                   (StallF0_i),
        .Imem_Valid_i               (Imem_Interface_Valid_i),
        .Imem_Req_ilu_o             (Imem_Req_p_o),
        .Imem_Stall_ilu_o           (Imem_Stall_p_o),
        .PC_Enable_ilu_o            (pc_enable),

        .PC_i                       (pc_out_fe0),
        .Imem_Data_i                (Imem_Interface_Data_i),
        .Imem_Addr_ilu_o            (pc_out_ilu),
        .Instruction_ilu_o          (instruction_ilu)
    );

    assign compressed_inst = instruction_ilu[15:0];
    assign is_compressed   = (compressed_inst[1:0] != 2'b11);

    assign Imem_Addr_o   = pc_out_ilu;

    Decompressor #(.size(size)) dc (
        .instruction_i              (compressed_inst),
        .instruction_dc_o           (instruction_dc)
    );

    Frontend #(.size(size)) fe0 (
        .clk                        (clk0),
        .rst                        (rst0),

        .mismatch_i                 (mismatch),
        .rp_value_i                 (rp_value),

        .is_compressed_i            (is_compressed),
        .pc_enable_i                (pc_enable),
        .Irq_Taken_i                (Irq_Taken0_i),
        .StallF_i                   (StallF0_i),
        .Mret_i                     (Mret0_i),
        .FlushF_i                   (flush_f0_eff),

        .Trap_Next_PC_i             (trap_next_pc),
        .PC_Target_i                (Alu_Result_al0),
        .instruction_ilu_i          (instruction_ilu),
        .instruction_dc_i           (instruction_dc),
        .OPCode_fe_fe_o             (OPCode_fe_0_o),
        .pc_out_fe_o                (pc_out_fe0),

        .Immediate_Type_i           (Immediate_Type0_i),
        .Regread_i                  (Regread0_i),
        .ImmEnable_i                (ImmEnable0_i),
        .ResultSrc_i                (ResultSrc0_i),
        .ALUSrc_i                   (ALUSrc0_i),
        .ALUControl_i               (ALUControl0_i),
        .ForwardA_i                 (ForwardA0_i),
        .ForwardB_i                 (ForwardB0_i),
        .Jump_i                     (Jump0_i),
        .BrchEnable_i               (BrchEnable0_i),
        .Regread_dex_o              (Regread_dex0),

        .SrcA_al_i                  (SrcA_al0),
        .SrcB_al_i                  (SrcB_al0),
        .Rs1_dex_fe_o               (Rs1_0_o),
        .Rs2_dex_fe_o               (Rs2_0_o),
        .Rd_dex_fe_o                (Rd_0_o),
        .OPCode_dex_fe_o            (OPCode_dex0_o),
        .Funct3_dex_fe_o            (Funct3_0_o),
        .Funct7_dex_fe_o            (Funct7_0_o),
        .Funct12_dex_fe_o           (Funct12_0_o),
        .OPB5_dex_fe_o              (OPB5_0_o),
        .Sign_Extended_dex_fe_o     (Sign_Extended0),

        .PC_Out_dex_o               (PC_Out_dex0),
        .PC_Plus_dex_o              (PC_Plus_dex0),
        .Instruction_dex_o          (Instruction_dex0),
        .PCSrc_dex_o                (PCSrc_dex0)
    );

    assign PCSrc_0_o            = PCSrc_commit0;

    Frontend #(.size(size)) fe1 (
        .clk                        (clk1),
        .rst                        (rst1),
        
        .mismatch_i                 (mismatch),
        .rp_value_i                 (rp_value),

        .is_compressed_i            (is_compressed),
        .pc_enable_i                (pc_enable),
        .Irq_Taken_i                (Irq_Taken0_i),
        .StallF_i                   (StallF1_i),
        .Mret_i                     (Mret0_i),
        .FlushF_i                   (flush_f1_eff),

        .Trap_Next_PC_i             (trap_next_pc),
        .PC_Target_i                (Alu_Result_al1),
        .instruction_ilu_i          (instruction_ilu),
        .instruction_dc_i           (instruction_dc),
        .OPCode_fe_fe_o             (OPCode_fe_1_o),
        .pc_out_fe_o                (pc_out_fe1),

        .Immediate_Type_i           (Immediate_Type1_i),
        .Regread_i                  (Regread1_i),
        .ImmEnable_i                (ImmEnable1_i),
        .ResultSrc_i                (ResultSrc1_i),
        .ALUSrc_i                   (ALUSrc1_i),
        .ALUControl_i               (ALUControl1_i),
        .ForwardA_i                 (ForwardA1_i),
        .ForwardB_i                 (ForwardB1_i),
        .Jump_i                     (Jump1_i),
        .BrchEnable_i               (BrchEnable1_i),
        .Regread_dex_o              (Regread_dex1),

        .SrcA_al_i                  (SrcA_al1),
        .SrcB_al_i                  (SrcB_al1),
        .Rs1_dex_fe_o               (Rs1_1_o),
        .Rs2_dex_fe_o               (Rs2_1_o),
        .Rd_dex_fe_o                (Rd_1_o),
        .OPCode_dex_fe_o            (OPCode_dex1_o),
        .Funct3_dex_fe_o            (Funct3_1_o),
        .Funct7_dex_fe_o            (Funct7_1_o),
        .Funct12_dex_fe_o           (Funct12_1_o),
        .OPB5_dex_fe_o              (OPB5_1_o),
        .Sign_Extended_dex_fe_o     (Sign_Extended1),

        .PC_Out_dex_o               (PC_Out_dex1),
        .PC_Plus_dex_o              (PC_Plus_dex1),
        .Instruction_dex_o          (Instruction_dex1),
        .PCSrc_dex_o                (PCSrc_dex1)
    );

    assign PCSrc_1_o = PCSrc_commit1;

    FE_Comparator #(.size(size)) cmp (
        .instr0                     (Instruction_dex0),
        .instr1                     (Instruction_dex1),
        .pc0                        (PC_Out_dex0),
        .pc1                        (PC_Out_dex1),
        .mismatch                   (mismatch)
    );

    Regfile RF (
        .clk                        (clk0),
        .rst                        (rst0),
        .Regwrite_i                 (Regwrite_mwb_commit0),
        .Regread_i                  (Regread_dex0),
        .Read_Reg1_i                (Rs1_dex0),
        .Read_Reg2_i                (Rs2_dex0),
        .Read_Reg3_i                (Rd_mwb0_o),
        .Write_Data_i               (encoded_writeback),
        .Read_Data1_rf_o            (read_codeword1),
        .Read_Data2_rf_o            (read_codeword2)
    );

    ECC_Encoder #(.size(size)) ECC_Encoder(
        .data_in                    (writeback_result_voted),
        .codeword                   (encoded_writeback)
    );
   
    ECC_Decoder #(.size(size)) ecc1(
        .read_codeword              (read_codeword1),
        .syndrome                   (syndrome1),
        .single_error               (single_error1),
        .double_error               (double_error1)
    );
    
    ECC_Decoder #(.size(size)) ecc2(
        .read_codeword              (read_codeword2),
        .syndrome                   (syndrome2),
        .single_error               (single_error2),
        .double_error               (double_error2)
    );

    ECC_Corrector ECC_Corrector1 (
        .code                       (read_codeword1),
        .single_error               (single_error1),
        .syndrome                   (syndrome1),
        .data_out                   (read_data1)
    );

    ECC_Corrector ECC_Corrector2 (
        .code                       (read_codeword2),
        .single_error               (single_error2),
        .syndrome                   (syndrome2),
        .data_out                   (read_data2)
    );

    wire       [size - 1 : 0] Mul_Result_dex0;
    wire       [size - 1 : 0] Mul_Result_mwb0;
    wire       [size - 1 : 0] operand1_0;
    wire       [size - 1 : 0] operand2_0;

    
    ALU_Lane #(.size(size)) AL0 (
        .clk                        (clk0),
        .rst                        (rst0),

        .PC_Out_i                   (PC_Out_dex0),
        .Read_data1_i               (read_data1),
        .Read_data2_i               (read_data2),
        .Writeback_Result_i         (writeback_result_voted),
        .ForwardA_i                 (ForwardA0_i),
        .ForwardB_i                 (ForwardB0_i),
        .ALUSrc_i                   (ALUSrc0_i),
        .Sign_Extended_i            (Sign_Extended0),
        .ALUControl_i               (ALUControl0_i),
        .Alu_Result_al_o            (Alu_Result_al0),
        .SrcA_dex_al_o              (SrcA_al0),
        .SrcB_dex_al_o              (SrcB_al0),
        .operand1_o                 (operand1_0),
        .operand2_o                 (operand2_0)
    );

    
    Mul_Unit #(.size(size)) MUL_dex0(
        .clk                        (clk0),
        .rst                        (rst0),
        .Mul_Start_i                (Mul_Start0_i),
        .Mul_Hi_i                   (Mul_Hi0_i),
        .Mul_Signa_i                (Mul_Signa0_i),
        .Mul_Signb_i                (Mul_Signb0_i),
        .Mul_Busy_mul_o             (Mul_Busy_dex0_o),
        .Mul_Done_mul_o             (Mul_Done_dex0_o),
        .Operand_a_i                (operand1_0),
        .Operand_b_i                (operand2_0),
        .Mul_Result_mul_o           (Mul_Result_dex0)
    );
     
    wire       [size - 1 : 0] Mul_Result_dex1;
    wire       [size - 1 : 0] Mul_Result_mwb1;
    wire       [size - 1 : 0] operand1_1;
    wire       [size - 1 : 0] operand2_1;

    ALU_Lane #(.size(size)) AL1 (
        .clk                        (clk1),
        .rst                        (rst1),

        .PC_Out_i                   (PC_Out_dex1),
        .Read_data1_i               (read_data1),
        .Read_data2_i               (read_data2),
        .Writeback_Result_i         (writeback_result_voted),
        .ForwardA_i                 (ForwardA1_i),
        .ForwardB_i                 (ForwardB1_i),
        .ALUSrc_i                   (ALUSrc1_i),
        .Sign_Extended_i            (Sign_Extended1),
        .ALUControl_i               (ALUControl1_i),
        .Alu_Result_al_o            (Alu_Result_al1),
        .SrcA_dex_al_o              (SrcA_al1),
        .SrcB_dex_al_o              (SrcB_al1),
        .operand1_o                 (operand1_1),
        .operand2_o                 (operand2_1)
    );

    Mul_Unit #(.size(size)) MUL_dex1(
        .clk                        (clk1),
        .rst                        (rst1),
        .Mul_Start_i                (Mul_Start1_i),
        .Mul_Hi_i                   (Mul_Hi1_i),
        .Mul_Signa_i                (Mul_Signa1_i),
        .Mul_Signb_i                (Mul_Signb1_i),
        .Mul_Busy_mul_o             (Mul_Busy_dex1_o),
        .Mul_Done_mul_o             (Mul_Done_dex1_o),
        .Operand_a_i                (operand1_1),
        .Operand_b_i                (operand2_1),
        .Mul_Result_mul_o           (Mul_Result_dex1)
    );
    

    assign OPCode_dex0  = Instruction_dex0[6 : 0];
    assign Funct3_dex0  = Instruction_dex0[14 : 12];
    assign Funct7_dex0  = Instruction_dex0[31 : 25];
    assign Funct12_dex0 = Instruction_dex0[31 : 20];
    assign OPB5_dex0    = Instruction_dex0[5];
    assign Rs1_dex0     = Instruction_dex0[19 : 15];
    assign Rs2_dex0     = Instruction_dex0[24 : 20];
    assign Rd_dex0      = Instruction_dex0[11 : 7];

    Pipe_Register #(32*6 + 5 + 5) PR_FE_BE_data0 (
        .clk(clk0),
        .rst(rst0),
        .en(~StallDEX0_i),
        .clr(flush_dex0_eff),
        .in({
            Instruction_dex0, Alu_Result_al0, Mul_Result_dex0, PC_Plus_dex0,
            SrcB_al0, SrcA_al0, Rd_dex0, Rs1_dex0
            }),
        .out({
            Instruction_mwb0, Alu_Result_mwb0, Mul_Result_mwb0, pc_plus_mwb0,
            SrcB_mwb0, SrcA_mwb0, Rd_mwb0_o, Rs1_mwb0
            })
    );

    wire Mul_Sel0_mwb;
    Pipe_Register #(3+2+5+1) PR_FE_BE_control0 (
        .clk(clk0),
        .rst(rst0),
        .en(~StallDEX0_i),
        .clr(flush_dex0_eff),
        .in({
            Regwrite0_i, ResultSrc0_i, Mem_Read_en0_i, Mem_Write_en0_i, Mul_Sel0_i,
            R_Type0_i, W_Type0_i}),
        .out({
            Regwrite_mwb0, ResultSrc_mwb0_o, Mem_Read_en_mwb0, Mem_Write_en_mwb0, Mul_Sel0_mwb,
            R_Type_mwb0, W_Type_mwb0})
    );

    Pipe_Register #(32*6 + 5 + 5) PR_FE_BE_data1 (
        .clk(clk1),
        .rst(rst1),
        .en(~StallDEX1_i),
        .clr(flush_dex1_eff),
        .in({
            Instruction_dex1, Alu_Result_al1, Mul_Result_dex1, PC_Plus_dex1,
            SrcB_al1, SrcA_al1, Rd_1_o, Rs1_1_o
            }),
        .out({
            Instruction_mwb1, Alu_Result_mwb1, Mul_Result_mwb1, pc_plus_mwb1,
            SrcB_mwb1, SrcA_mwb1, Rd_mwb1_o, Rs1_mwb1
            })
    );

    assign OPCode_mwb_1_o = Instruction_mwb1[6:0];
    assign Funct3_mwb_1_o = Instruction_mwb1[14:12];
    assign Funct7_mwb_1_o = Instruction_mwb1[31:25];

    wire Mul_Sel1_mwb;
    Pipe_Register #(4) PR_FE_BE_control1 (
        .clk(clk1),
        .rst(rst1),
        .en(~StallDEX1_i),
        .clr(flush_dex1_eff),
        .in({
            Regwrite1_i,    ResultSrc1_i,       Mul_Sel1_i}),
        .out({
            Regwrite_mwb1,  ResultSrc_mwb1_o,   Mul_Sel1_mwb})
    );

    assign Regwrite_mwb0_o        = Regwrite_mwb_commit0 & ~ Irq_Taken0_i;
    assign Regwrite_mwb1_o        = Regwrite_mwb_commit1 & ~ Irq_Taken0_i;

    Pipe_Register #(12 + 32 + 3 + 7 + 7) PR_IDEX_MWB_csr (
        .clk(clk0),
        .rst(rst0),
        .en(~StallDEX0_i),
        .clr(flush_dex0_eff),
        .in({
            Instruction_dex0[31 : 20],
            PC_Out_dex0,
            Funct3_dex0,
            Funct7_dex0,
            OPCode_dex0
            }),
        .out({
            CSR_Addr_mwb0,
            PC_Out_mwb0,
            Funct3_mwb_0_o,
            Funct7_mwb_0_o,
            OPCode_mwb_0_o
        })
    );

    Backend #(.size(size)) be0 (
        .ResultSrc_i                (ResultSrc_mwb0_o),
        .Mul_Sel_i                  (Mul_Sel0_mwb),
        .CSR_Imm_i                  (CSR_Imm0_i),
        .Alu_Result_i               (Alu_Result_mwb0),
        .Mul_Result_i               (Mul_Result_mwb0),
        .PC_Plus_i                  (pc_plus_mwb0),
        .SrcA_i                     (SrcA_mwb0),
        .Rs1_i                      (Rs1_mwb0),
        .Load_Data_i                (Load_Data_lsu),
        .CSR_Rdata_i                (CSR_Rdata),
        .Writeback_Result_o         (Writeback_Result_mwb0),
        .CSR_Wdata_o                (CSR_Wdata_mwb0)
    );

    Backend #(.size(size)) be1 (
        .ResultSrc_i                (ResultSrc_mwb1_o),
        .Mul_Sel_i                  (Mul_Sel1_mwb),
        .CSR_Imm_i                  (CSR_Imm0_i),
        .Alu_Result_i               (Alu_Result_mwb1),
        .Mul_Result_i               (Mul_Result_mwb1),
        .PC_Plus_i                  (pc_plus_mwb1),
        .SrcA_i                     (SrcA_mwb1),
        .Rs1_i                      (Rs1_mwb1),
        .Load_Data_i                (Load_Data_lsu),
        .CSR_Rdata_i                (CSR_Rdata),
        .Writeback_Result_o         (Writeback_Result_mwb1),
        .CSR_Wdata_o                (CSR_Wdata_mwb1)
    );

    Backend #(.size(size)) be2 (
        .ResultSrc_i                (ResultSrc_mwb0_o),
        .Mul_Sel_i                  (Mul_Sel0_mwb),
        .CSR_Imm_i                  (CSR_Imm0_i),
        .Alu_Result_i               (Alu_Result_mwb0),
        .Mul_Result_i               (Mul_Result_mwb0),
        .PC_Plus_i                  (pc_plus_mwb0),
        .SrcA_i                     (SrcA_mwb0),
        .Rs1_i                      (Rs1_mwb0),
        .Load_Data_i                (Load_Data_lsu),
        .CSR_Rdata_i                (CSR_Rdata),
        .Writeback_Result_o         (Writeback_Result_mwb2),
        .CSR_Wdata_o                (CSR_Wdata_mwb2)
    );

    wire [size - 1 : 0] Instruction_mwb2, Alu_Result_mwb2, pc_plus_mwb2, SrcB_mwb2, SrcA_mwb2;
    wire [4 : 0] Rd_mwb2, Rs1_mwb2;
    wire Regwrite_mwb2, Mem_Read_en_mwb2, Mem_Write_en_mwb2;
    wire [1 : 0] ResultSrc_mwb2, W_Type_mwb2;
    wire [2 : 0] R_Type_mwb2;

    Pipe_Register #(32*5 + 5 + 5) PR_FE_BE_data2 (
        .clk(clk0),
        .rst(rst0),
        .en(~StallDEX0_i),
        .clr(flush_dex0_eff),
        .in({
            Instruction_dex0, Alu_Result_al0, PC_Plus_dex0,
            SrcB_al0, SrcA_al0, Rd_dex0, Rs1_dex0
        }),
        .out({
            Instruction_mwb2, Alu_Result_mwb2, pc_plus_mwb2,
            SrcB_mwb2, SrcA_mwb2, Rd_mwb2, Rs1_mwb2
        })
    );

    Pipe_Register #(3+2+5) PR_FE_BE_control2 (
        .clk(clk0),
        .rst(rst0),
        .en(~StallDEX0_i),
        .clr(flush_dex0_eff),
        .in({
            Regwrite0_i, ResultSrc0_i, Mem_Read_en0_i, Mem_Write_en0_i,
            R_Type0_i, W_Type0_i}),
        .out({
            Regwrite_mwb2, ResultSrc_mwb2, Mem_Read_en_mwb2, Mem_Write_en_mwb2,
            R_Type_mwb2, W_Type_mwb2})
    );

    Majority_Voter #(.size(size)) MV (
        .clk                        (clk0),
        .rst                        (rst0),
        .alu_result_mwb             (Alu_Result_mwb0),
        .alu_result_mwb_1           (Alu_Result_mwb1),
        .alu_result_mwb_2           (Alu_Result_mwb2),

        .writeback_result           (Writeback_Result_mwb0),
        .writeback_result_1         (Writeback_Result_mwb1), 
        .writeback_result_2         (Writeback_Result_mwb2), 
        
        .SrcB_mwb                   (SrcB_mwb0),
        .SrcB_mwb_1                 (SrcB_mwb1),
        .SrcB_mwb_2                 (SrcB_mwb2),

        .SrcB_mwb_voted             (SrcB_mwb_voted),
        .alu_result_mwb_voted       (alu_result_mwb_voted),
        .writeback_result_voted     (writeback_result_voted)
    );

    Load_Store_Unit #(.size(size)) LSU (
        .clk                        (clk0),
        .rst                        (rst0),

        .LSU_Read_En_i              (Mem_Read_en_mwb0),
        .LSU_Write_En_i             (Mem_Write_en_mwb0),
        .LSU_RData_Type_i           (R_Type_mwb0),
        .LSU_WData_Type_i           (W_Type_mwb0),
        .LSU_Req_Ready_i            (DMem_Interface_Req_Ready_i),
        .LSU_Req_Valid_o            (DMem_Interface_Req_Valid_o),
        .LSU_Read_En_o              (DMem_Interface_Read_En_o),
        .LSU_Write_En_o             (DMem_Interface_Write_En_o),
        .LSU_Wstrb_o                (DMem_Interface_Wstrb_o),

        .LSU_Address_i              (alu_result_mwb_voted),
        .LSU_Store_Data_i           (SrcB_mwb_voted),
        .LSU_Load_Data_i            (Load_Data_Interface_i),
        .LSU_Mem_Store_o            (Store_Data_Interface_o),
        .LSU_Load_Data_o            (Load_Data_lsu),
        .LSU_Mem_Addr_o             (Mem_Addr_o)
    );

    CSRs #(.size(size)) CSRs (
        .clk                        (clk0),
        .rst                        (rst0),

        .Irq_Timer_i                (Irq_Timer_i),
        .Irq_Ext_i                  (Irq_Ext_i),
        .Irq_software_i             (Irq_software_i),
        .CSR_En_i                   (CSR_En0_i),
        .Mret_i                     (Mret0_i),
        .External_Activated_i       (External_Activated0_i),
        .Timer_Activated_i          (Timer_Activated0_i),
        .Software_Activated_i       (Software_Activated0_i),
        .Irq_Taken_i                (Irq_Taken0_i),

        .CSR_Opcode_i               (CSR_Opcode0_i),
        .CSR_Addr_i                 (CSR_Addr_mwb0),
        .CSR_Wdata_i                (CSR_Wdata_mwb0),
        .Trap_PC_i                  (PC_Out_dex0),
        .CSR_Rdata_o                (CSR_Rdata),
        .Trap_Next_PC_o             (trap_next_pc),
        .Mip_Meip_csr_o             (Mip_Meip_0_o),
        .Mip_Mtip_csr_o             (Mip_Mtip_0_o),
        .Mip_Msip_csr_o             (Mip_Msip_0_o),
        .Mie_Meie_csr_o             (Mie_Meie_0_o),
        .Mie_Mtie_csr_o             (Mie_Mtie_0_o),
        .Mie_Msie_csr_o             (Mie_Msie_0_o),
        .Mstatus_Mie_csr_o          (Mstatus_Mie_0_o),
        .Current_Privilege_csr_o    (Current_Privilege_0_o)
    );

    assign next_pc_dex0 = PCSrc_commit0 ? Alu_Result_al0 : PC_Plus_dex0;

    assign flush_f0_eff   = FlushF0_i   | mismatch;
    assign flush_f1_eff   = FlushF1_i   | mismatch;
    assign flush_dex0_eff = FlushDEX0_i | mismatch;
    assign flush_dex1_eff = FlushDEX0_i | mismatch;
    assign valid_dex0     = ~flush_dex0_eff;

    Pipe_Register #(size) PR_RP_data0 (
        .clk                        (clk0),
        .rst                        (rst0),
        .en                         (~StallDEX0_i),
        .clr                        (1'b0),
        .in                         (next_pc_dex0),
        .out                        (next_pc_mwb0)
    );

    Pipe_Register #(.size(1)) PR_FE_BE_valid0 (
        .clk                        (clk0),
        .rst                        (rst0),
        .en                         (~StallDEX0_i),
        .clr                        (1'b0),
        .in                         (valid_dex0),
        .out                        (Valid_mwb0)
    );

    RP_Register #(.size(size)) RP (
        .clk                        (clk0),
        .rst                        (rst0),
        .en                         (Valid_mwb0),
        .d_in                       (next_pc_mwb0),
        .rp_o                       (rp_value)
    );

endmodule