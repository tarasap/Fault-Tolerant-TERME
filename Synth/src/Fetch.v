/******************************************************************************/
//	Filename:		Fetch.v
//	Project:		Terme
//  Version:		 
//	History:
//	Last Modified:	11 May 2026
//	Last Author: 	Tara
//  Copyright (C) 2026 University of Tehran
//  This source file may be used and distributed without
//  restriction provided that this copyright statement is not
//  removed from the file and that any derivative work contains
//  the original copyright notice and the associated disclaimer.
//

/******************************************************************************/
//	File content description:
//                                
/******************************************************************************/

module Fetch #(parameter size = 32)(
    input                   clk,
    input                   rst,

    input                   Irq_Taken_i,
    input                   PCSrc_dex_i,
    input                   StallF_i, 
    input                   Mret_i,
    input                   Imem_Valid_i,
    output                  Imem_Req_fe_o,
    output                  Imem_Stall_fe_o, 

    input  [size - 1 : 0]   Trap_Next_PC_i,
    input  [size - 1 : 0]   Imem_Data_i,
    input  [size - 1 : 0]   PC_Target_i,     
    output [size - 1 : 0]   PC_Out_fe_o,        
    output [size - 1 : 0]   PC_Plus_fe_o,
    output [size - 1 : 0]   Instruction_fe_o,
    output [6 : 0]          OPCode_fe_o
);
    // PC
    wire [size - 1 : 0]     instruction_ilu;
    wire [size - 1 : 0]     instruction_dc;
    wire [size - 1 : 0]     pc_next_branch;
    wire [size - 1 : 0]     pc_next_mret;
    wire [size - 1 : 0]     pc_next_final;
    wire [size - 1 : 0]     pc_next;
    wire [size - 1 : 0]     pc_out;
    wire                    pc_enable;
    wire                    trap_or_mret;
    wire [15 : 0]           compressed_inst;
    wire                    is_compressed;

    /////////////////////////// Fetch Stage ///////////////////////////
    assign OPCode_fe_o  = Instruction_fe_o[6 : 0];
    assign trap_or_mret = Mret_i | Irq_Taken_i;

    Mux_2 #(.size(size)) M_pc_branch (
        .select             (PCSrc_dex_i),
        .in_1               (PC_Plus_fe_o),
        .in_2               (PC_Target_i),
        .mux_out            (pc_next_branch)
    );
    Mux_2 #(.size(size)) M_pc_mret (
        .select             (trap_or_mret),
        .in_1               (pc_next_branch), 
        .in_2               (Trap_Next_PC_i),         
        .mux_out            (pc_next)
    );
    Reg #(.size(size)) pc (
        .clk                (clk),  
        .rst                (rst),
        .en                 (pc_enable), //~StallF_i
        .d_in               (pc_next),
        .q_out              (pc_out)
    );


    assign PC_Plus_fe_o = pc_out + (is_compressed ? 32'd2 : 32'd4);
    // PC_4 pc_4 (
    //     .PC_In              (pc_out),
    //     .PC_Plus            (PC_Plus_fe_o)
    // );


    Instruction_Load_Unit #(.size(size)) ILU_Interface (
        .clk                (clk),
        .rst                (rst),

        .StallF_i           (StallF_i),
        .Imem_Valid_i       (Imem_Valid_i),
        .Imem_Req_ilu_o     (Imem_Req_fe_o), 
        .Imem_Stall_ilu_o   (Imem_Stall_fe_o), 
        .PC_Enable_ilu_o     (pc_enable),

        .PC_i               (pc_out),
        .Imem_Data_i        (Imem_Data_i),
        .Imem_Addr_ilu_o    (PC_Out_fe_o),   
        .Instruction_ilu_o  (instruction_ilu)
        
    );

    assign compressed_inst = (PC_Out_fe_o[1]) ? instruction_ilu[31 : 16] : instruction_ilu[15 : 0];
    assign is_compressed = (compressed_inst[1:0] != 2'b11);

    Decompressor #(.size(size)) dc(
        .instruction_i      (compressed_inst),
        .instruction_dc_o   (instruction_dc)
    );

    Mux_2 #(.size(size)) Inst_Select (
        .select             (is_compressed),
        .in_1               (instruction_ilu),
        .in_2               (instruction_dc),
        .mux_out            (Instruction_fe_o)
    );
endmodule


    // Instruction_Memory #(.size(size)) IM(
    //     .address(PC_Out_fe_o),
    //     .Instruction(Instruction_fe_o)
    // );