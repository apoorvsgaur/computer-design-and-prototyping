`ifndef PIPELINE_REGISTERS_IF_VH
`define PIPELINE_REGISTERS_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface pipeline_registers_if;
    // import types
    import cpu_types_pkg::*;

    // IF/ID Register Block
    word_t ifid_instr_in, ifid_instr_out;
    word_t ifid_pc_in, ifid_pc_out;
    word_t ifid_pc4_in, ifid_pc4_out;
    logic ifid_enable, ifid_flush;

    // ID/EX Register Block
    word_t idex_instr_in, idex_instr_out;
    funct_t idex_r_opcode_in, idex_r_opcode_out;
    logic idex_r_type_in, idex_r_type_out;
    word_t idex_shamt_in, idex_shamt_out;
    logic idex_ALUsrc_in, idex_ALUsrc_out;
    aluop_t idex_aluop_in, idex_aluop_out;
    logic idex_dREN_in, idex_dREN_out;
    logic idex_dWEN_in, idex_dWEN_out;
    logic [1:0] idex_branch_in, idex_branch_out;
    logic [1:0] idex_jump_in, idex_jump_out;
    logic idex_MemtoReg_in, idex_MemtoReg_out;
    logic idex_RegWrite_in, idex_RegWrite_out;
    word_t idex_ExtImm16_in, idex_ExtImm16_out;
    word_t idex_pc_in, idex_pc_out;
    word_t idex_pc4_in, idex_pc4_out;
    word_t idex_jraddr_in, idex_jraddr_out;
    word_t idex_rdat1_in, idex_rdat1_out;
    word_t idex_rdat2_in, idex_rdat2_out;
    regbits_t idex_rs_in, idex_rs_out;
    regbits_t idex_rt_in, idex_rt_out;
    regbits_t idex_wsel_in, idex_wsel_out;
    logic idex_halt_in, idex_halt_out;
    logic idex_i_type_in, idex_i_type_out;
    logic idex_enable, idex_flush;

    // EX/MEM Register Block
    word_t exmem_instr_in, exmem_instr_out; //debugger
    word_t exmem_port_o_in, exmem_port_o_out;
    word_t exmem_rdat2_in, exmem_rdat2_out;
    word_t exmem_pcn_in, exmem_pcn_out;
    logic exmem_dREN_in, exmem_dREN_out;
    logic exmem_dWEN_in, exmem_dWEN_out;
    logic exmem_MemtoReg_in, exmem_MemtoReg_out;
    logic exmem_RegWrite_in, exmem_RegWrite_out;
    regbits_t exmem_wsel_in, exmem_wsel_out;
    logic exmem_halt_in, exmem_halt_out;
    logic [1:0] exmem_jump_in, exmem_jump_out;
    logic exmem_enable, exmem_flush;

    // MEM/WB Register Block
    word_t memwb_instr_in, memwb_instr_out; //debugger
    word_t memwb_data_in, memwb_data_out;
    word_t memwb_port_o_in, memwb_port_o_out;
    word_t memwb_pcn_in, memwb_pcn_out;
    logic memwb_MemtoReg_in, memwb_MemtoReg_out;
    logic memwb_RegWrite_in, memwb_RegWrite_out;
    regbits_t memwb_wsel_in, memwb_wsel_out;
    logic memwb_halt_in, memwb_halt_out;
    logic [1:0] memwb_jump_in, memwb_jump_out;
    logic memwb_enable, memwb_flush;

    modport pr (
      // ifid input/output
      input ifid_instr_in, ifid_pc_in, ifid_pc4_in, ifid_enable, ifid_flush,
      output ifid_instr_out, ifid_pc_out, ifid_pc4_out,
      // idex input/output
      input idex_instr_in, idex_r_opcode_in, idex_r_type_in, idex_shamt_in,
        idex_ALUsrc_in, idex_aluop_in, idex_dREN_in, idex_dWEN_in, idex_branch_in,
        idex_jump_in, idex_MemtoReg_in, idex_RegWrite_in, idex_ExtImm16_in, idex_pc_in,
        idex_pc4_in, idex_jraddr_in, idex_rdat1_in, idex_rdat2_in, idex_rs_in,
        idex_rt_in, idex_wsel_in, idex_halt_in, idex_enable, idex_flush,
        idex_i_type_in,
      output idex_instr_out, idex_r_opcode_out, idex_r_type_out, idex_shamt_out,
        idex_ALUsrc_out, idex_aluop_out, idex_dREN_out, idex_dWEN_out, idex_branch_out,
        idex_jump_out, idex_MemtoReg_out, idex_RegWrite_out, idex_ExtImm16_out,
        idex_pc_out, idex_pc4_out, idex_jraddr_out, idex_rdat1_out, idex_rdat2_out,
        idex_rs_out, idex_rt_out, idex_wsel_out, idex_halt_out, idex_i_type_out,
      // exmem input/output
      input exmem_pcn_in, exmem_port_o_in, exmem_rdat2_in, exmem_dREN_in, exmem_dWEN_in,
        exmem_jump_in, exmem_MemtoReg_in, exmem_wsel_in, exmem_halt_in, exmem_enable, exmem_flush,
        exmem_instr_in,
      output exmem_pcn_out, exmem_port_o_out, exmem_rdat2_out, exmem_dREN_out, exmem_dWEN_out,
        exmem_jump_out, exmem_MemtoReg_out, exmem_wsel_out, exmem_halt_out,
        exmem_instr_out,
      // memwb input/output
      input memwb_data_in, memwb_port_o_in, memwb_MemtoReg_in,
        memwb_RegWrite_in, memwb_wsel_in, memwb_halt_in, memwb_jump_in,
        memwb_pcn_in, memwb_enable, memwb_flush, memwb_instr_in,
      output memwb_data_out, memwb_port_o_out, memwb_MemtoReg_out,
        memwb_RegWrite_out, memwb_wsel_out, memwb_halt_out, memwb_jump_out,
        memwb_pcn_out, memwb_instr_out
    );

  endinterface

`endif //PIPELINE_REGISTERS_IF_VH
