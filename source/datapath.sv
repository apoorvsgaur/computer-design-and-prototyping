/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"

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
  request_unit_if ruif();
  alu_if aif();
  register_file_if rfif();

  // instantiate units
  control_unit CU(cuif);
  request_unit RU(ruif, CLK, nRST);
  alu ALU(aif);
  register_file RF(CLK, nRST, rfif);

  // pc init
  parameter PC_INIT = 0;

  // extra variables
  r_t r_instr;
  assign r_instr = r_t'(dpif.imemload);
  i_t i_instr;
  assign i_instr = i_t'(dpif.imemload);
  j_t j_instr;
  assign j_instr = j_t'(dpif.imemload);
  word_t ExtImm16;
  word_t pc, pcn, branch_addr, jraddr, jaddr, pc4;
  logic [1:0] PCsrc;

  // reqeust unit connections
  assign ruif.ihit = dpif.ihit;
  assign ruif.dhit = dpif.dhit;
  assign ruif.dWEN_i = cuif.dWEN;
  assign ruif.dREN_i = cuif.dREN;

  // control unit connections
  assign cuif.instr = dpif.imemload;

  // datapath connections
  assign dpif.imemREN = 1;
  assign dpif.imemaddr = pc;
  assign dpif.dmemREN = ruif.dREN_o;
  assign dpif.dmemWEN = ruif.dWEN_o;
  assign dpif.dmemstore = rfif.rdat2;
  assign dpif.dmemaddr = aif.port_o;

  // register file connections
  assign rfif.rsel1 = r_instr.rs;
  assign rfif.rsel2 = r_instr.rt;
  assign rfif.WEN = (cuif.opcode == LW) ? ruif.dhit : (cuif.RegWrite ? ruif.ihit: 0);

  // alu file connections
  assign aif.port_a = rfif.rdat1;
  assign aif.opcode = cuif.aluop;

  // set halt
  always_ff @ (posedge CLK, negedge nRST) begin
    if (nRST == 0) begin
      dpif.halt <= 0;
    end else if ((cuif.opcode == HALT) && (cuif.r_type == 0)) begin
      dpif.halt <= 1;
    end
  end

  // register file wdat mux
  always_comb begin
    rfif.wdat = aif.port_o; // register

    if (cuif.MemtoReg == 1) begin
      rfif.wdat = dpif.dmemload; // data
    end else if (cuif.jump == 2'b11) begin
      rfif.wdat = pc4;
    end
  end

  // register file wsel mux
  always_comb begin
    rfif.wsel = r_instr.rt; // rt

    if ((cuif.RegDst == 1) && (cuif.jump != 2'b11)) begin
      rfif.wsel = r_instr.rd; // rd
    end else if ((cuif.RegDst == 1) && (cuif.jump == 2'b11)) begin
      rfif.wsel = 31; // reg 31
    end
  end

  // alu port_b extender and mux
  always_comb begin
    ExtImm16 = {{16{i_instr.imm[15]}}, i_instr.imm};

    if ((cuif.ExtOp == 0) && (cuif.back_pad == 0)) begin // not sign extended
      ExtImm16 = {16'b0, i_instr.imm};
    end else if (cuif.back_pad == 1) begin // back padded
      ExtImm16 = {i_instr.imm, 16'b0};
    end

    aif.port_b = rfif.rdat2;

    if ((cuif.ALUsrc == 1) && (cuif.jump == 0)) begin
        aif.port_b = ExtImm16;
    end else if ((cuif.r_type == 1) && ((cuif.r_opcode == SLL) || (cuif.r_opcode == SRL))) begin
        aif.port_b = cuif.shamt;
    end
  end

  // pc addr's, zero extenders, shift lefters, concaters, padders, srcers, mux
  always_comb begin
    pc4 = pc + 4;                                     // standard +4 increment
    jraddr = rfif.rdat1;                              // JR instruction addr
    branch_addr = ({14'b0, i_instr.imm, 2'b0} + pc4); // branch instruction addr
    jaddr = {pc[31:28], j_instr.addr, 2'b0};          // J(AL) instruction addr

    // default PCsrc
    PCsrc = 0;

    // set PCsrc (comb block ish)
    if ((cuif.branch == 2'b01) && (aif.z_flag == 0)) begin // pc + 4
      PCsrc = 0;
    end else if ((cuif.branch == 2'b01) && (aif.z_flag == 1)) begin // branch_addr
      PCsrc = 1;
    end else if ((cuif.branch == 2'b10) && (aif.z_flag == 0)) begin // branch_addr
      PCsrc = 1;
    end else if ((cuif.branch == 2'b10) && (aif.z_flag == 1)) begin // branch_addr
      PCsrc = 0;
    end else if (cuif.jump == 2'b01) begin // jraddr
      PCsrc = 2;
    end else if (cuif.jump == 2'b10) begin // jaddr
      PCsrc = 3;
    end else if (cuif.jump == 2'b11) begin // jaddr
      PCsrc = 3;
    end else begin
      PCsrc = 0;
    end

    // default pcn
    pcn = pc;

    // mux for pcn
    if (PCsrc == 1) begin
      pcn = branch_addr;
    end else if (PCsrc == 2) begin
      pcn = jraddr;
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
    end else if (ruif.pc_enable == 1) begin
      pc <= pcn;
    end
  end

endmodule
