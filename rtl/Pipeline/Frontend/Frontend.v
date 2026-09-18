// =============================================================================
// Project Name:   Fault-Tolerant-TERME
// File Name:      Frontend.v
// Author:         Tara Sarpoolaki /Tarasarpoolaki@gmail.com
// Last Modified:  2026-9-18
// Description:    
// 
// License:        CERN-OHL-S-v2
// =============================================================================

`timescale 1ns / 1ps

module Frontend #(parameter size = 32)(
    input                   clk,
    input                   rst,

    input                   mismatch_i,
    input  [size - 1 : 0]   rp_value_i,

    input                   is_compressed_i,
    input                   pc_enable_i,
    input                   Irq_Taken_i,
    input                   StallF_i,
    input                   Mret_i,
    input                   FlushF_i,
    
    input  [size - 1 : 0]   Trap_Next_PC_i,
    input  [size - 1 : 0]   PC_Target_i,
    input  [size - 1 : 0]   instruction_ilu_i,
    input  [size - 1 : 0]   instruction_dc_i,
    output [6 : 0]          OPCode_fe_fe_o,

    output [size - 1 : 0]   pc_out_fe_o,
    
    input  [2 : 0]          Immediate_Type_i,
    input                   Regread_i,                
    input                   ImmEnable_i,                
    input  [1 : 0]          ResultSrc_i,
    input  [1 : 0]          ALUSrc_i,
    input  [4 : 0]          ALUControl_i,
    input  [1 : 0]          ForwardA_i, 
    input  [1 : 0]          ForwardB_i,  
    input                   Jump_i,
    input                   BrchEnable_i,
    output                  Regread_dex_o,

    input  [size - 1 : 0]   SrcA_al_i,
    input  [size - 1 : 0]   SrcB_al_i,

    output [4 : 0]          Rs1_dex_fe_o,             
    output [4 : 0]          Rs2_dex_fe_o,             
    output [4 : 0]          Rd_dex_fe_o,     
    output [6 : 0]          OPCode_dex_fe_o,
    output [2 : 0]          Funct3_dex_fe_o,
    output [6 : 0]          Funct7_dex_fe_o, 
    output [11 : 0]         Funct12_dex_fe_o, 
    output                  OPB5_dex_fe_o,
    output [size - 1 : 0]   Sign_Extended_dex_fe_o,

    output [size - 1 : 0]   PC_Out_dex_o,
    output [size - 1 : 0]   PC_Plus_dex_o,
    output [size - 1 : 0]   Instruction_dex_o,

    output                  PCSrc_dex_o
);

    wire [size - 1 : 0]     pc_out;          
    wire [size - 1 : 0]     pc_plus;          
    wire [size - 1 : 0]     pc_next_branch;
    wire [size - 1 : 0]     pc_next;
    wire [size - 1 : 0]     Instruction_fe;   

    wire [size - 1 : 0]     PC_Out_dex;
    wire [size - 1 : 0]     Instruction_dex;

    wire                    PCSrc_dex;
    wire                    trap_or_mret;
    wire                    BrchEnable_dex;
    wire                    ImmEnable_dex;

    assign pc_out_fe_o      = pc_out;
    assign OPCode_fe_fe_o   = Instruction_fe[6 : 0];
    assign trap_or_mret     = Mret_i | Irq_Taken_i;

    wire [size - 1 : 0] pc_next_final;

    Mux_2 #(.size(size)) M_pc_recovery (
        .select             (mismatch_i),
        .in_1               (pc_next),      
        .in_2               (rp_value_i),   
        .mux_out            (pc_next_final)
    );

    assign pc_next         = trap_or_mret   ? Trap_Next_PC_i :
                             PCSrc_dex    ? PC_Target_i    :
                             pc_plus;


    Reg #(.size(size)) pc (
        .clk                (clk),  
        .rst                (rst),
        .en                 (pc_enable_i),
        .d_in               (pc_next_final),
        .q_out              (pc_out)
    );

    assign pc_plus = pc_out + (is_compressed_i ? 32'd2 : 32'd4);

    Mux_2 #(.size(size)) Inst_Select (
        .select             (is_compressed_i),
        .in_1               (instruction_ilu_i),
        .in_2               (instruction_dc_i),
        .mux_out            (Instruction_fe)
    );

    Pipe_Register #(32*3) PR_IF_IDEX_data (
        .clk    (clk), 
        .rst    (rst), 
        .en     (~StallF_i), 
        .clr    (FlushF_i),
        .in     ({Instruction_fe,  pc_out,     pc_plus}),
        .out    ({Instruction_dex, PC_Out_dex, PC_Plus_dex_o})
    );

    Pipe_Register #(3) PR_IF_IDEX_control (
        .clk    (clk), 
        .rst    (rst), 
        .en     (~StallF_i), 
        .clr    (FlushF_i),
        .in     ({  
                    Regread_i,
                    BrchEnable_i,
                    ImmEnable_i
                    }),
        .out    ({  
                    Regread_dex_o,
                    BrchEnable_dex,
                    ImmEnable_dex 
                    })
    );

    wire [size - 1 : 0] Sign_Extended_se;
    wire                BrchTaken_bd;

    assign OPCode_dex_fe_o     = Instruction_dex[6 : 0];
    assign Funct3_dex_fe_o     = Instruction_dex[14 : 12];
    assign Funct7_dex_fe_o     = Instruction_dex[31 : 25];
    assign Funct12_dex_fe_o    = Instruction_dex[31 : 20];
    assign OPB5_dex_fe_o       = Instruction_dex[5];
    assign Rs1_dex_fe_o        = Instruction_dex[19 : 15];
    assign Rs2_dex_fe_o        = Instruction_dex[24 : 20];
    assign Rd_dex_fe_o         = Instruction_dex[11 : 7];

    Sign_Extension SE (
        .Instruction_i              (Instruction_dex[31 : 7]),
        .OPCode_i                   (OPCode_dex_fe_o),
        .Funct3_i                   (Funct3_dex_fe_o),
        .ImmEnable_i                (ImmEnable_dex),
        .Immediate_Type_i           (Immediate_Type_i),
        .Sign_Extended_se_o         (Sign_Extended_se)
    ); 
    
    assign Sign_Extended_dex_fe_o = Sign_Extended_se;

    Branch_Unit #(.size(size)) BJU (
        .BrchEnable_i               (BrchEnable_dex),
        .BrchTaken_bd_o             (BrchTaken_bd),
        .Funct3_i                   (Funct3_dex_fe_o),
        .Operand1_i                 (SrcA_al_i),
        .Operand2_i                 (SrcB_al_i)
    );

    assign PCSrc_dex = BrchTaken_bd | Jump_i;

    assign PC_Out_dex_o       = PC_Out_dex;
    assign Instruction_dex_o  = Instruction_dex;
    assign PCSrc_dex_o        = PCSrc_dex;

endmodule