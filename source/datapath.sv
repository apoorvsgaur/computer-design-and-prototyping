/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"
`include "pipeline_registers_if.vh"
`include "forwarding_unit_if.vh"
`include "hazard_unit_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // instantiate unit interfaces
  control_unit_if cuif();
  alu_if aif();
  register_file_if rfif();
  pipeline_registers_if prif();
  forwarding_unit_if fuif();
  hazard_unit_if huif();

  // instantiate units
  control_unit CU(cuif);
  alu ALU(aif);
  register_file RF(CLK, nRST, rfif);
  forwarding_unit FU(fuif);
  hazard_unit HU(huif);

  // pc init
  parameter PC_INIT = 0;

  // extra variables
  word_t pc, pcn, branch_addr, jaddr, pc4, wdat;
  logic [1:0] PCsrc;

  // control unit connections
  assign cuif.instr = prif.ifid_instr_out;

  // datapath connections
  assign dpif.imemREN = 1;
  assign dpif.imemaddr = pc;
  assign dpif.dmemREN = prif.exmem_dREN_out;
  assign dpif.dmemWEN = prif.exmem_dWEN_out;
  assign dpif.dmemstore = prif.exmem_rdat2_out;
  assign dpif.dmemaddr = prif.exmem_port_o_out;

  // register file connections
  assign rfif.rsel1 = prif.ifid_instr_out[25:21];
  assign rfif.rsel2 = prif.ifid_instr_out[20:16];
  assign rfif.WEN = prif.memwb_RegWrite_out; //(cuif.opcode == LW) ? ruif.dhit : (cuif.RegWrite ? ruif.ihit: 0);
  assign rfif.wsel = prif.memwb_wsel_out;

  // forwarding unit connections
  assign fuif.exmem_wsel_out = prif.exmem_wsel_out;
  assign fuif.memwb_wsel_out = prif.memwb_wsel_out;
  assign fuif.exmem_RegWrite_out = prif.exmem_RegWrite_out;
  assign fuif.memwb_RegWrite_out = prif.memwb_RegWrite_out;
  assign fuif.idex_rs_out = prif.idex_rs_out;
  assign fuif.idex_rt_out = prif.idex_rt_out;
  assign fuif.i_type = prif.idex_i_type_out;

  // hazard unit connections
  assign huif.ifid_rt_out = prif.ifid_instr_out[20:16];
  assign huif.ifid_rs_out = prif.ifid_instr_out[25:21];
  assign huif.idex_rt_out = prif.idex_rt_out;
  assign huif.idex_dREN_out = prif.idex_dREN_out;
  assign huif.PCsrc = PCsrc;
  assign huif.idex_dWEN_out = prif.idex_dWEN_out;

  // alu file connections
  assign aif.opcode = prif.idex_aluop_out;

  // set halt
  assign prif.idex_halt_in = cuif.halt;
  always_ff @ (posedge CLK, negedge nRST) begin
    if (nRST == 0) begin
      dpif.halt <= 0;
    end else if (prif.memwb_halt_out == 1) begin
      dpif.halt <= 1;
    end
  end

  // register file wdat mux
  assign rfif.wdat = wdat;
  always_comb begin
    wdat = prif.memwb_port_o_out;

    if (prif.memwb_MemtoReg_out == 1) begin
      wdat = prif.memwb_data_out;; // data
    end else if (prif.memwb_jump_out == 3) begin
      wdat = prif.memwb_pcn_out;
    end
  end

  // register file wsel mux
  always_comb begin
    prif.idex_wsel_in = prif.ifid_instr_out[20:16]; // rt

    if ((cuif.RegDst == 1) && (cuif.jump != 2'b11)) begin
      prif.idex_wsel_in = prif.ifid_instr_out[15:11]; // rd
    end else if ((cuif.RegDst == 1) && (cuif.jump == 2'b11)) begin
      prif.idex_wsel_in = 31; // reg 31
    end
  end

  // alu port_a, port_b extender and mux
  always_comb begin
    // extender
    prif.idex_ExtImm16_in = {{16{prif.ifid_instr_out[15]}}, prif.ifid_instr_out[15:0]};

    if ((cuif.ExtOp == 0) && (cuif.back_pad == 0)) begin // not sign extended
      prif.idex_ExtImm16_in = {16'b0, prif.ifid_instr_out[15:0]};
    end else if (cuif.back_pad == 1) begin // back padded
      prif.idex_ExtImm16_in = {prif.ifid_instr_out[15:0], 16'b0};
    end

    //port_a mux
    aif.port_a = prif.idex_rdat1_out;
    if (fuif.fwenb_a == 1)
    begin
        aif.port_a = prif.exmem_port_o_out;
    end
    else if (fuif.fwenb_a == 2)
    begin
        aif.port_a = wdat;
    end

    // port_b mux
    aif.port_b = prif.idex_rdat2_out;
    prif.exmem_rdat2_in = prif.idex_rdat2_out;

    if ((prif.idex_ALUsrc_out == 1) && (prif.idex_jump_out == 0) && (fuif.fwenb_b == 1)) begin
        aif.port_b = prif.idex_ExtImm16_out;
        prif.exmem_rdat2_in = prif.exmem_port_o_out;
    end else if ((prif.idex_ALUsrc_out == 1) && (prif.idex_jump_out == 0) && (fuif.fwenb_b == 2)) begin
        aif.port_b = prif.idex_ExtImm16_out;
        prif.exmem_rdat2_in = wdat;
    end else if ((prif.idex_ALUsrc_out == 0) && (prif.idex_jump_out == 0) && (fuif.fwenb_b == 2)) begin
        aif.port_b = wdat;
    end else if ((prif.idex_ALUsrc_out == 0) && (prif.idex_jump_out == 0) && (fuif.fwenb_b == 1)) begin
        aif.port_b = prif.exmem_port_o_out;
    end else if ((prif.idex_ALUsrc_out == 1) && (prif.idex_jump_out == 0)) begin
        aif.port_b = prif.idex_ExtImm16_out;
    end else if ((prif.idex_r_type_out == 1) && ((prif.idex_r_opcode_out == SLL) || (prif.idex_r_opcode_out == SRL))) begin
        aif.port_b = prif.idex_shamt_out;
    end
  end

  // pc addr's, zero extenders, shift lefters, concaters, padders, srcers, mux
  always_comb begin
    pc4 = pc + 4;                                                                 // standard +4 increment
    //jraddr assigned above                                                       // JR instruction addr
    branch_addr = ({14'b0, prif.idex_instr_out[15:0], 2'b0} + prif.idex_pc4_out); // branch instruction addr
    jaddr = {prif.idex_pc_out[31:28], prif.idex_instr_out[25:0], 2'b0};           // J(AL) instruction addr

    // default PCsrc
    PCsrc = 0;

    // set PCsrc (comb block ish)
    if ((prif.idex_branch_out == 2'b01) && (aif.z_flag == 0)) begin // pc + 4
      PCsrc = 0;
    end else if ((prif.idex_branch_out == 2'b01) && (aif.z_flag == 1)) begin // branch_addr
      PCsrc = 1;
    end else if ((prif.idex_branch_out == 2'b10) && (aif.z_flag == 0)) begin // branch_addr
      PCsrc = 1;
    end else if ((prif.idex_branch_out == 2'b10) && (aif.z_flag == 1)) begin // branch_addr
      PCsrc = 0;
    end else if (prif.idex_jump_out == 2'b01) begin // jraddr
      PCsrc = 2;
    end else if (prif.idex_jump_out == 2'b10) begin // jaddr
      PCsrc = 3;
    end else if (prif.idex_jump_out == 2'b11) begin // jaddr
      PCsrc = 3;
    end else begin
      PCsrc = 0;
    end

    // mux for pcn
    pcn = pc4;
    if (PCsrc == 1) begin
      pcn = branch_addr;
    end else if (PCsrc == 2) begin
      pcn = prif.idex_jraddr_out;
    end else if (PCsrc == 3) begin
      pcn = jaddr;
    end else begin
      pcn = pc4;
    end
  end

  // ff for pc
  always_ff @ (posedge CLK, negedge nRST) begin
    if (nRST == 0) begin
      pc <= 0;
    end else if ((dpif.ihit == 1) & (huif.pc_enable == 1)) begin
      pc <= pcn;
    end
  end

  // enable logic for pipeline registers
  always_comb begin
    prif.memwb_enable = 0;
    prif.exmem_enable = 0;
    prif.idex_enable = 0;
    prif.ifid_enable = 0;

    prif.memwb_flush = 0;
    prif.exmem_flush = 0;
    prif.idex_flush = 0;
    prif.ifid_flush = 0;

    if (dpif.dhit) begin
      prif.memwb_enable = 1;
      prif.exmem_enable = 1;
      //prif.exmem_flush = 1;
    end else if (dpif.ihit && huif.flush) begin
      prif.memwb_enable = 1;
      prif.exmem_enable = 1;
      prif.idex_flush = 1;
      prif.ifid_flush = 1;
    end else if (dpif.ihit) begin
      prif.memwb_enable = 1;
      prif.exmem_enable = 1;
      prif.idex_enable = 1;
      prif.ifid_enable = 1;
     end
  end

  // IF/ID Registers
  assign prif.ifid_instr_in = dpif.imemload;
  assign prif.ifid_pc_in = pc;
  assign prif.ifid_pc4_in = pc4;

  always_ff @ (posedge CLK, negedge nRST)
  begin: IF_ID
      if (!nRST)
      begin
          prif.ifid_instr_out <= 0;
          prif.ifid_pc_out <= 0;
          prif.ifid_pc4_out <= 0;
      end else if (prif.ifid_flush)
      begin
          prif.ifid_instr_out <= 0;
          prif.ifid_pc_out <= 0;
          prif.ifid_pc4_out <= prif.ifid_pc4_in;
      end
      else if (prif.ifid_enable & !huif.ifid_pause)
      begin
          prif.ifid_instr_out <= prif.ifid_instr_in;
          prif.ifid_pc_out <= prif.ifid_pc_in;
          prif.ifid_pc4_out <= prif.ifid_pc4_in;
      end
  end

  // ID/EX Registers
  assign prif.idex_pc_in = prif.ifid_pc_out;
  assign prif.idex_pc4_in = prif.ifid_pc4_out;
  assign prif.idex_instr_in = prif.ifid_instr_out;
  assign prif.idex_rs_in = prif.ifid_instr_out[25:21];
  assign prif.idex_rt_in = prif.ifid_instr_out[20:16];
  assign prif.idex_r_opcode_in = cuif.r_opcode;
  assign prif.idex_r_type_in = cuif.r_type;
  assign prif.idex_shamt_in = cuif.shamt;
  assign prif.idex_ALUsrc_in = cuif.ALUsrc;
  assign prif.idex_aluop_in = cuif.aluop;
  assign prif.idex_dREN_in = cuif.dREN && ~dpif.dhit;
  assign prif.idex_dWEN_in = cuif.dWEN;
  assign prif.idex_branch_in = cuif.branch;
  assign prif.idex_jump_in = cuif.jump;
  assign prif.idex_MemtoReg_in = cuif.MemtoReg;
  assign prif.idex_RegWrite_in = cuif.RegWrite;
  assign prif.idex_i_type_in = cuif.i_type;
  assign prif.idex_rdat1_in = rfif.rdat1;
  assign prif.idex_rdat2_in = rfif.rdat2;
  assign prif.idex_jraddr_in = rfif.rdat1;

  always_ff @ (posedge CLK, negedge nRST)
  begin: ID_EX
      if (!nRST)
      begin
          prif.idex_instr_out <= 0;
          prif.idex_r_opcode_out <= ADD;
          prif.idex_r_type_out <= 0;
          prif.idex_shamt_out <= 0;
          prif.idex_ALUsrc_out <= 0;
          prif.idex_aluop_out <= ALU_SLL;
          prif.idex_dREN_out <= 0;
          prif.idex_dWEN_out <= 0;
          prif.idex_branch_out <= 0;
          prif.idex_jump_out <= 0;
          prif.idex_MemtoReg_out <= 0;
          prif.idex_RegWrite_out <= 0;
          prif.idex_ExtImm16_out <= 0;
          prif.idex_pc_out <= 0;
          prif.idex_pc4_out <= 0;
          prif.idex_jraddr_out <= 0;
          prif.idex_rdat1_out <= 0;
          prif.idex_rdat2_out <= 0;
          prif.idex_rs_out <= 0;
          prif.idex_rt_out <= 0;
          prif.idex_i_type_out <= 0;
          prif.idex_wsel_out <= 0;
          prif.idex_halt_out <= 0;
      end else if ((prif.idex_flush) | (huif.exmem_enable))
      begin
          prif.idex_instr_out <= 0;
          prif.idex_r_opcode_out <= ADD;
          prif.idex_r_type_out <= 0;
          prif.idex_shamt_out <= 0;
          prif.idex_ALUsrc_out <= 0;
          prif.idex_aluop_out <= ALU_SLL;
          prif.idex_dREN_out <= 0;
          prif.idex_dWEN_out <= 0;
          prif.idex_branch_out <= 0;
          prif.idex_jump_out <= 0;
          prif.idex_MemtoReg_out <= 0;
          prif.idex_RegWrite_out <= 0;
          prif.idex_ExtImm16_out <= 0;
          prif.idex_pc_out <= 0;
          prif.idex_pc4_out <= prif.idex_pc4_in;
          prif.idex_jraddr_out <= 0;
          prif.idex_rdat1_out <= 0;
          prif.idex_rdat2_out <= 0;
          prif.idex_rs_out <= 0;
          prif.idex_rt_out <= 0;
          prif.idex_i_type_out <= 0;
          prif.idex_wsel_out <= 0;
          prif.idex_halt_out <= 0;
      end else if (prif.idex_enable)
      begin
          prif.idex_instr_out <= prif.idex_instr_in;
          prif.idex_r_opcode_out <= prif.idex_r_opcode_in;
          prif.idex_r_type_out <= prif.idex_r_type_in;
          prif.idex_shamt_out <= prif.idex_shamt_in;
          prif.idex_ALUsrc_out <= prif.idex_ALUsrc_in;
          prif.idex_aluop_out <= prif.idex_aluop_in;
          prif.idex_dREN_out <= prif.idex_dREN_in;
          prif.idex_dWEN_out <= prif.idex_dWEN_in;
          prif.idex_branch_out <= prif.idex_branch_in;
          prif.idex_jump_out <= prif.idex_jump_in;
          prif.idex_MemtoReg_out <= prif.idex_MemtoReg_in;
          prif.idex_RegWrite_out <= prif.idex_RegWrite_in;
          prif.idex_ExtImm16_out <= prif.idex_ExtImm16_in;
          prif.idex_pc_out <= prif.idex_pc_in;
          prif.idex_pc4_out <= prif.idex_pc4_in;
          prif.idex_jraddr_out <= prif.idex_jraddr_in;
          prif.idex_rdat1_out <= prif.idex_rdat1_in;
          prif.idex_rdat2_out <= prif.idex_rdat2_in;
          prif.idex_rs_out <= prif.idex_rs_in;
          prif.idex_rt_out <= prif.idex_rt_in;
          prif.idex_i_type_out <= prif.idex_i_type_in;
          prif.idex_wsel_out <= prif.idex_wsel_in;
          prif.idex_halt_out <= prif.idex_halt_in;
      end
  end

  // EX/MEM Registers
  assign prif.exmem_dREN_in = prif.idex_dREN_out;
  assign prif.exmem_dWEN_in = prif.idex_dWEN_out;
  assign prif.exmem_jump_in = prif.idex_jump_out;
  assign prif.exmem_MemtoReg_in = prif.idex_MemtoReg_out;
  assign prif.exmem_RegWrite_in = prif.idex_RegWrite_out;
  assign prif.exmem_wsel_in = prif.idex_wsel_out;
  assign prif.exmem_halt_in = prif.idex_halt_out;
  assign prif.exmem_port_o_in = aif.port_o;
  assign prif.exmem_pcn_in = prif.idex_pc4_out;
  assign prif.exmem_instr_in = prif.idex_instr_out;

  always_ff @ (posedge CLK, negedge nRST)
  begin: EX_MEM
      if (!nRST)
      begin
          prif.exmem_instr_out <= 0;
          prif.exmem_pcn_out <= 0;
          prif.exmem_port_o_out <= 0;
          prif.exmem_rdat2_out <= 0;
          prif.exmem_dREN_out <= 0;
          prif.exmem_dWEN_out <= 0;
          prif.exmem_jump_out <= 0;
          prif.exmem_MemtoReg_out <= 0;
          prif.exmem_RegWrite_out <= 0;
          prif.exmem_wsel_out <= 0;
          prif.exmem_halt_out <= 0;
      end
      else if (prif.exmem_flush)
      begin
          prif.exmem_instr_out <= 0;
          prif.exmem_pcn_out <= prif.exmem_pcn_in;
          prif.exmem_port_o_out <= 0;
          prif.exmem_rdat2_out <= 0;
          prif.exmem_dREN_out <= 0;
          prif.exmem_dWEN_out <= 0;
          prif.exmem_jump_out <= 0;
          prif.exmem_MemtoReg_out <= 0;
          prif.exmem_RegWrite_out <= 0;
          prif.exmem_wsel_out <= 0;
          prif.exmem_halt_out <= 0;
      end
      else if ((prif.exmem_enable) | (huif.exmem_enable))
      begin
          prif.exmem_instr_out <= prif.exmem_instr_in;
          prif.exmem_pcn_out <= prif.exmem_pcn_in;
          prif.exmem_port_o_out <= prif.exmem_port_o_in;
          prif.exmem_rdat2_out <= prif.exmem_rdat2_in;
          prif.exmem_dREN_out <= prif.exmem_dREN_in;
          prif.exmem_dWEN_out <= prif.exmem_dWEN_in;
          prif.exmem_jump_out <= prif.exmem_jump_in;
          prif.exmem_MemtoReg_out <= prif.exmem_MemtoReg_in;
          prif.exmem_RegWrite_out <= prif.exmem_RegWrite_in;
          prif.exmem_wsel_out <= prif.exmem_wsel_in;
          prif.exmem_halt_out <= prif.exmem_halt_in;
      end
  end

  // MEM/WB Registers
  assign prif.memwb_halt_in = prif.exmem_halt_out;
  assign prif.memwb_jump_in = prif.exmem_jump_out;
  assign prif.memwb_pcn_in = prif.exmem_pcn_out;
  assign prif.memwb_port_o_in = prif.exmem_port_o_out;
  assign prif.memwb_MemtoReg_in = prif.exmem_MemtoReg_out;
  assign prif.memwb_RegWrite_in = prif.exmem_RegWrite_out;
  assign prif.memwb_instr_in = prif.exmem_instr_out;
  assign prif.memwb_wsel_in = prif.exmem_wsel_out;
  assign prif.memwb_data_in = dpif.dmemload;

  always_ff @ (posedge CLK, negedge nRST)
  begin: MEM_WB
      if (!nRST)
      begin
          prif.memwb_instr_out <= 0;
          prif.memwb_data_out <= 0;
          prif.memwb_port_o_out <= 0;
          prif.memwb_MemtoReg_out <= 0;
          prif.memwb_RegWrite_out <= 0;
          prif.memwb_wsel_out <= 0;
          prif.memwb_halt_out <= 0;
          prif.memwb_jump_out <= 0;
          prif.memwb_pcn_out <= 0;
      end
    else if (prif.memwb_flush)
      begin
          prif.memwb_instr_out <= 0;
          prif.memwb_data_out <= 0;
          prif.memwb_port_o_out <= 0;
          prif.memwb_MemtoReg_out <= 0;
          prif.memwb_RegWrite_out <= 0;
          prif.memwb_wsel_out <= 0;
          prif.memwb_halt_out <= 0;
          prif.memwb_jump_out <= 0;
          prif.memwb_pcn_out <= 0;
      end
      else if ((prif.memwb_enable) | (huif.exmem_enable))
      begin
          prif.memwb_instr_out <= prif.memwb_instr_in;
          prif.memwb_data_out <= prif.memwb_data_in;
          prif.memwb_port_o_out <= prif.memwb_port_o_in;
          prif.memwb_MemtoReg_out <= prif.memwb_MemtoReg_in;
          prif.memwb_RegWrite_out <= prif.memwb_RegWrite_in;
          prif.memwb_wsel_out <= prif.memwb_wsel_in;
          prif.memwb_halt_out <= prif.memwb_halt_in;
          prif.memwb_jump_out <= prif.memwb_jump_in;
          prif.memwb_pcn_out <= prif.memwb_pcn_in;
      end
  end

endmodule
