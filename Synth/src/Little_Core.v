/******************************************************************************/
//	Filename:		Little_Core.v
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
module Little_Core #(parameter size = 32)(
    input                       clk,
    input                       rst,
    //          Control
    input                       Irq_Timer_i,            // From Top
    input                       Irq_Ext_i,              // From Top
    input                       Irq_software_i,         // From Top
    input                       CSR_En_i,               // From Controller
    input                       Mret_i,                 // From Controller
    input                       CSR_Imm_i,              // From Controller
    input                       External_Activated_i,   // From Controller
    input                       Timer_Activated_i,      // From Controller
    input                       Software_Activated_i,   // From Controller
    input                       Irq_Taken_i,            // From Controller
    input [2 : 0]               Immediate_Type_i,       // 000: I, 001: S, 010: B, 011: U, 100: J  ==ImmSrc
    input [1 : 0]               ResultSrc_i,            // From Controller
    input [4 : 0]               ALUControl_i,           // From Controller
    input [1 : 0]               ALUSrc_i,               // From Controller
    input                       Regwrite_i,             // From Controller
    input                       Regread_i,              // From Controller
    input                       ImmEnable_i,            // From Controller
    input                       BrchEnable_i,           // From Controller
    input [2 : 0]               R_Type_i,                
    input [1 : 0]               W_Type_i,
    input                       Mem_Read_en_i,          // From Controller
    input                       Mem_Write_en_i,         // From Controller
    input                       Jump_i,                 // From Controller
    input                       Req_Ready_i,
    input [1 : 0]               ForwardA_i,             // From Hazard Unit
    input [1 : 0]               ForwardB_i,             // From Hazard Unit
    input                       FlushF_i,               // From Hazard Unit
    input                       FlushDEX_i,             // From Hazard Unit
    input                       FlushWB_i,              // From Hazard Unit
    input                       StallDEX_i,             // From Hazard Unit        
    input                       StallF_i,               // From Hazard Unit
    input                       Imem_Interface_Valid_i,
    output                      Imem_Interface_Req_lc_o,
    output                      Imem_Interface_Stall_lc_o,
    output                      DMem_Interface_Read_En_lc_o,
    output                      DMem_Interface_Write_En_lc_o,
    output [3 : 0]              DMem_Interface_Wstrb_lc_o,
    output                      DMem_Interface_Req_Valid_lc_o,
    output                      PCSrc_lc_o,             // To Hazard Unit
    output                      Regwrite_lc_o,
    output [1 : 0]              ResultSrc_mwb_lc_o,
    

    //          Data
    input       [size - 1 : 0]  Imem_Interface_Data_i,
    input       [size - 1 : 0]  Load_Data_Interface_i,
    input       [1 : 0]         CSR_Opcode_i,   
    output      [size - 1 : 0]  Store_Data_Interface_lc_o,         // To The Interface
    output      [size - 1 : 0]  Mem_Addr_lc_o,
    output      [size - 1 : 0]  Imem_Interface_Addr_lc_o,
    output                      Mip_Meip_lc_o,
    output                      Mip_Mtip_lc_o,
    output                      Mip_Msip_lc_o,
    output                      Mie_Meie_lc_o,
    output                      Mie_Mtie_lc_o,
    output                      Mie_Msie_lc_o, 
    output                      Mstatus_Mie_lc_o, 
    output      [1 : 0]         Current_Privilege_lc_o,
    output      [size - 1 : 0]  Instruction_lc_o,
    output      [6 : 0]         OPCode_lc_o,
    output      [6 : 0]         OPCode_fe_lc_o,
    output      [6 : 0]         OPCode_mwb_lc_o, 
    output      [2 : 0]         Funct3_mwb_lc_o,
    output      [6 : 0]         Funct7_mwb_lc_o, 
    output      [2 : 0]         Funct3_lc_o,
    output      [6 : 0]         Funct7_lc_o,  
    output      [11 : 0]        Funct12_lc_o,  
    output                      OPB5_lc_o,
    output      [4 : 0]         Rs1_dex_lc_o,           // To Hazard Unit
    output      [4 : 0]         Rs2_dex_lc_o,           // To Hazard Unit
    output      [4 : 0]         Rd_dex_lc_o,            // To Hazard Unit
    output      [4 : 0]         Rd_mwb_lc_o             // To Hazard Unit
    
   
);
    wire [4 : 0] Rs1_dex, Rs2_dex, Rd_dex, Rs1_mwb, Rd_mwb;

    
    // PC_Pipe 
    wire [size - 1 : 0] PC_Plus_fe;
    wire [size - 1 : 0] PC_Plus_dex;
    wire [size - 1 : 0] PC_Target;
    wire [size - 1 : 0] PC_Out_fe;
    wire [size - 1 : 0] PC_Out_dex;
    wire [size - 1 : 0] pc_plus_mwb;

    // Decode Execute
    wire [size - 1 : 0]   SrcA_dex, SrcA_mwb, SrcB_dex, SrcB_mwb;
    wire [2 : 0]          Funct3_dex;
    wire [6 : 0]          Funct7_dex;
    wire [11 : 0]         Funct12_dex;
    wire [6 : 0]          OPCode_dex;

    // Instruction Mmeory
    wire [size - 1 : 0] Instruction_fe;
    wire [size - 1 : 0] Instruction_dex;
    wire [size - 1 : 0] Instruction_mwb;

    // Sign Extension signals
    wire [size - 1 : 0] Sign_Extended_dex;

    // ALU Signals 
    wire [size - 1 : 0] Alu_Result_dex;
    wire [size - 1 : 0] Alu_Result_mwb;
    
    // Write-Back Signal 
    wire [size - 1 : 0] Writeback_Result_mwb;
    wire [size - 1 : 0] Load_Data_mwb;   
    wire                Mem_Read_en_mwb;
    wire                Mem_Write_en_mwb;
    wire                Regwrite_mwb;
    wire [2 : 0]        R_Type_mwb;               
    wire [1 : 0]        W_Type_mwb;               
    wire [1 : 0]        ResultSrc_mwb;               
   
    // Pipeline control Signals 
    wire                ImmEnable_dex;
    wire                BrchEnable_dex;
    wire                Regread_dex;
    wire                PCSrc_dex;
    // wire                PCSrc_mwb;
    wire [4 : 0]        ALUControl_dex;

    // CSR Signals
    wire [1 : 0]        CSR_Opcode_mwb;
    wire [11 : 0]       CSR_Addr_mwb;
    wire [size - 1 : 0] CSR_Wdata_mwb;
    wire [size - 1 : 0] PC_Out_mwb;
    wire [size - 1 : 0] trap_next_pc;
    wire [size - 1 : 0] CSR_Rdata;
    wire [size - 1 : 0] CSR_Wdata_dex;

    
    //--------------------------------------------------------
                            // Fetch Unit
    //--------------------------------------------------------
    Fetch #(.size(size)) FE (
        .clk                    (clk),  
        .rst                    (rst),

        .Irq_Taken_i            (Irq_Taken_i),
        .PCSrc_dex_i            (PCSrc_dex),
        .StallF_i               (StallF_i),
        .Mret_i                 (Mret_i),
        .Imem_Valid_i           (Imem_Interface_Valid_i),
        .Imem_Req_fe_o          (Imem_Interface_Req_lc_o),
        .Imem_Stall_fe_o        (Imem_Interface_Stall_lc_o),
        
        .Imem_Data_i            (Imem_Interface_Data_i),
        .Trap_Next_PC_i         (trap_next_pc),
        .PC_Target_i            (Alu_Result_dex),
        .PC_Out_fe_o            (PC_Out_fe), 
        .PC_Plus_fe_o           (PC_Plus_fe), 
        .Instruction_fe_o       (Instruction_fe),
        .OPCode_fe_o            (OPCode_fe_lc_o)
    );
    assign Imem_Interface_Addr_lc_o = PC_Out_fe;
    
    Pipe_Register #((3)) PR_IF_IDEX_control(
        .clk(clk),  
        .rst(rst),
        .en(~StallF_i), 
        .clr(FlushF_i),
        .in({
            ImmEnable_i, BrchEnable_i, Regread_i
            }),
        .out({
            ImmEnable_dex, BrchEnable_dex, Regread_dex
            })
    );

    Pipe_Register #((32*3)) PR_IF_IDEX_data(
        .clk(clk),  
        .rst(rst),
        .en(~StallF_i), 
        .clr(FlushF_i),
        .in({
            Instruction_fe,PC_Out_fe,PC_Plus_fe
            }),
        .out({
            Instruction_dex,PC_Out_dex,PC_Plus_dex
            })
    );
    
    
    //--------------------------------------------------------
                            // Decode Execute Unit
    //--------------------------------------------------------
    Decode_Execute #(.size(size)) DEX(
        .clk                    (clk),  
        .rst                    (rst),
                      
        .Immediate_Type_i       (Immediate_Type_i),
        .Regread_i              (Regread_dex),
        .ImmEnable_i            (ImmEnable_dex),
        .ResultSrc_i            (ResultSrc_i),
        .ALUSrc_i               (ALUSrc_i),
        .ALUControl_i           (ALUControl_i),
        .ForwardA_i             (ForwardA_i),
        .ForwardB_i             (ForwardB_i),  
        .Jump_i                 (Jump_i),
        .Regwrite_wb_i          (Regwrite_mwb),
        .BrchEnable_i           (BrchEnable_dex),
        .PCSrc_dex_o            (PCSrc_dex),

        .PC_Out_i               (PC_Out_dex),
        .PC_Plus_i              (PC_Plus_dex),
        .Instruction_i          (Instruction_dex),
        .Rd_mwb_i               (Rd_mwb),
        .Writeback_Result_i     (Writeback_Result_mwb),
        .Rs1_dex_o              (Rs1_dex),
        .Rs2_dex_o              (Rs2_dex),             
        .Rd_dex_o               (Rd_dex),
        .OPCode_dex_o           (OPCode_dex),
        .Funct3_dex_o           (Funct3_dex),
        .Funct7_dex_o           (Funct7_dex),
        .Funct12_dex_o          (Funct12_dex),
        .OPB5_dex_o             (OPB5_dex),
        .Sign_Extended_dex_o    (Sign_Extended_dex),
        .Alu_Result_dex_o       (Alu_Result_dex),
        .SrcB_dex_o             (SrcB_dex),
        .SrcA_dex_o             (SrcA_dex)
    );
    
    assign Funct3_lc_o          = Funct3_dex;
    assign Funct7_lc_o          = Funct7_dex;
    assign Funct12_lc_o         = Funct12_dex;
    assign OPCode_lc_o          = OPCode_dex;
    // assign Sign_Extended_dex_o  = Sign_Extended_dex;
    assign OPB5_lc_o            = OPB5_dex;
    assign Rs1_dex_lc_o         = Rs1_dex;
    assign Rs2_dex_lc_o         = Rs2_dex;
    assign Rd_dex_lc_o          = Rd_dex;
    assign Rd_mwb_lc_o          = Rd_mwb;
    assign PCSrc_lc_o           = PCSrc_dex;


    Pipe_Register #((32*4 + 5 + 32 + 5)) PR_IDEX_MWB_data(
        .clk(clk),  
        .rst(rst),
        .en(1'b1),
        .clr(FlushDEX_i), //FlushWB_i),
        .in(
            {
            Instruction_dex, Alu_Result_dex, PC_Plus_dex,
            Rd_dex,
            SrcB_dex,
            SrcA_dex,
            Rs1_dex
            }),
        .out(
            {
            Instruction_mwb, Alu_Result_mwb, pc_plus_mwb,
            Rd_mwb,
            SrcB_mwb,
            SrcA_mwb, 
            Rs1_mwb
            })
    );

    Pipe_Register #((3+2+5)) PR_IDEX_MWB_control(
        .clk(clk),  
        .rst(rst),
        .en(1'b1),
        .clr(FlushDEX_i), //FlushWB_i),
        .in({
            Regwrite_i, ResultSrc_i, Mem_Read_en_i, Mem_Write_en_i,
            R_Type_i, W_Type_i}),
        .out({
            Regwrite_mwb, ResultSrc_mwb, Mem_Read_en_mwb, Mem_Write_en_mwb,
            R_Type_mwb, W_Type_mwb})
    );

    assign Regwrite_lc_o = Regwrite_mwb & ~Irq_Taken_i;
    assign ResultSrc_mwb_lc_o = ResultSrc_mwb;


    Pipe_Register #((12 + 32 + 3 + 7 + 7)) PR_IDEX_MWB_csr(
        .clk(clk),  
        .rst(rst),
        .en(1'b1),
        .clr(FlushDEX_i), //FlushWB_i),
        .in({ 
            Instruction_dex[31 : 20],       // Address from DEX
            // CSR_Wdata_dex,               // CSR Write Data (usually from Rs1 in DEX)
            
            PC_Out_dex,             // The PC to save if a trap occurs
            Funct3_dex,
            Funct7_dex,
            OPCode_dex
            }),
        .out({
            CSR_Addr_mwb, 
            // CSR_Wdata_mwb,
            PC_Out_mwb,
            Funct3_mwb_lc_o,
            Funct7_mwb_lc_o,
            OPCode_mwb_lc_o
        })
    );
    //--------------------------------------------------------
                            // Memory WriteBack Unit
    //--------------------------------------------------------
    wire  mem_write_internal;
    Memory_WriteBack #(.size(size)) MWB(
        .clk                        (clk),
        .rst                        (rst),
        
        .CSR_Imm_i                  (CSR_Imm_i),
        .Read_En_i                  (Mem_Read_en_mwb),
        .Write_En_i                 (Mem_Write_en_mwb),
        .RData_Type_i               (R_Type_mwb),
        .WData_Type_i               (W_Type_mwb),
        .Req_Ready_i                (Req_Ready_i), // this stage or wb?
        .ResultSrc_i                (ResultSrc_mwb),
        .Req_Valid_mwb_o            (DMem_Interface_Req_Valid_lc_o),
        .Read_En_mwb_o              (DMem_Interface_Read_En_lc_o),
        .Write_En_mwb_o             (mem_write_internal),
        .Wstrb_mwb_o                (DMem_Interface_Wstrb_lc_o),

        .Rs1_i                      (Rs1_mwb),
        .SrcA_i                     (SrcA_mwb),
        .Alu_Result_i               (Alu_Result_mwb),
        .Store_Data_i               (SrcB_mwb),
        .Load_Data_i                (Load_Data_Interface_i),
        .PC_Plus_i                  (pc_plus_mwb),
        .CSR_Rdata_i                (CSR_Rdata), ///////// change the name maybe?
        .Mem_Store_mwb_o            (Store_Data_Interface_lc_o),
        .Load_Data_mwb_o            (Load_Data_mwb),
        .Mem_Addr_mwb_o             (Mem_Addr_lc_o),
        .Writeback_Result_mwb_o     (Writeback_Result_mwb),
        .CSR_Wdata_mwb_o            (CSR_Wdata_mwb)
    );
    
    assign DMem_Interface_Write_En_lc_o = mem_write_internal & ~Irq_Taken_i;

    CSRs #(.size(size)) CSRs(
        .clk                        (clk),
        .rst                        (rst),

        .Irq_Timer_i                (Irq_Timer_i),
        .Irq_Ext_i                  (Irq_Ext_i),
        .Irq_software_i             (Irq_software_i),
        .CSR_En_i                   (CSR_En_i),
        .Mret_i                     (Mret_i),     // is the current instruction MRET
        .External_Activated_i       (External_Activated_i),
        .Timer_Activated_i          (Timer_Activated_i),
        .Software_Activated_i       (Software_Activated_i),
        .Irq_Taken_i                (Irq_Taken_i),

        .CSR_Opcode_i               (CSR_Opcode_i),  
        .CSR_Addr_i                 (CSR_Addr_mwb),
        .CSR_Wdata_i                (CSR_Wdata_mwb),        
        .Trap_PC_i                  (PC_Out_dex),
        .CSR_Rdata_o                (CSR_Rdata),  
        .Trap_Next_PC_o             (trap_next_pc),
        .Mip_Meip_csr_o             (Mip_Meip_lc_o),
        .Mip_Mtip_csr_o             (Mip_Mtip_lc_o),
        .Mip_Msip_csr_o             (Mip_Msip_lc_o),
        .Mie_Meie_csr_o             (Mie_Meie_lc_o),
        .Mie_Mtie_csr_o             (Mie_Mtie_lc_o),
        .Mie_Msie_csr_o             (Mie_Msie_lc_o), 
        .Mstatus_Mie_csr_o          (Mstatus_Mie_lc_o), 
        .Current_Privilege_csr_o    (Current_Privilege_lc_o)
    );
   
endmodule