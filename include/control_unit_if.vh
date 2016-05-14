/**************************************
  Katie Bauschka
  ECE 437

  Control Unit Interface file
**************************************/

`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  funct_t r_opcode;
  opcode_t opcode;
  aluop_t aluop;
  logic RegDst, dREN, MemtoReg, dWEN, ALUsrc, RegWrite, ExtOp, back_pad, r_type,
halt, i_type;
  logic [1:0] branch, jump;
  word_t instr, shamt;

  modport cu (
    input instr,
    output r_opcode, opcode, aluop, RegDst, branch, dREN, MemtoReg, dWEN, ALUsrc,
           RegWrite, ExtOp, back_pad, jump, r_type, shamt, halt, i_type
  );

  modport tb (
    input r_opcode, opcode, aluop, RegDst, branch, dREN, MemtoReg, dWEN, ALUsrc,
          RegWrite, ExtOp, back_pad, jump, r_type, shamt, halt, i_type,
    output instr
  );
endinterface

`endif //CONTROL_UNIT_IF_VH
