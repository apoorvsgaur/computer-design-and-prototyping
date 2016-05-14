/*
  Forwarding Unit Interface
*/

`ifndef FORWARDING_UNIT_IF_VH
`define FORWARDING_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface forwarding_unit_if;
  // import types
  import cpu_types_pkg::*;

  regbits_t exmem_wsel_out, memwb_wsel_out, idex_rs_out, idex_rt_out;
  logic exmem_RegWrite_out, memwb_RegWrite_out, i_type;
  logic [1:0] fwenb_a, fwenb_b;

  modport fu (
    input exmem_wsel_out, memwb_wsel_out, exmem_RegWrite_out,
memwb_RegWrite_out, idex_rs_out, idex_rt_out, i_type,
    output fwenb_a, fwenb_b
  );

  modport tb (
    input fwenb_a, fwenb_b,
    output exmem_wsel_out, memwb_wsel_out, exmem_RegWrite_out,
memwb_RegWrite_out, idex_rs_out, idex_rt_out, i_type
  );

endinterface

`endif //FORWARDING_UNIT_IF_VH
