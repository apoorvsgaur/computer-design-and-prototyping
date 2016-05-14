/*
  Apoorv Sanjay Gaur
  apoorvsgaur@gmail.com

  all types used to make life easier.
*/

`ifndef PIPELINE_REGISTERS_PKG_VH
`define PIPELINE_REGISTERS_PKG_VH

`include "cpu_types_pkg.vh"

package pipeline_registers_pkg;
  import cpu_types_pkg::*;

  typedef struct packed {
  	logic flush;
  	logic enable;
  	word_t instruct, pc, npc;
  } if_id;

  typedef struct packed {
  	funct_t r_opcode;
    aluop_t aluop;
  	word_t shamt, instr, extImm16, pc, npc, jraddr, rdat1, rdat2;
    regbits_t rs, rt, wsel;
    logic [1:0] branch, jump;
    logic r_type, ALUSrc, dREN, dWEN, MemToReg, RegWrite, flush, enable;
  } id_ex;

  typedef struct packed {

  } ex_mem;

   typedef struct packed {

  } mem_wb;