/*
  Hazard Detection Interface
*/

`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;

  regbits_t idex_rt_out, ifid_rt_out, ifid_rs_out;
  logic idex_dREN_out, idex_dWEN_out;
  logic [1:0] PCsrc;
  logic pc_enable, flush, ifid_pause, exmem_enable;

  modport hu (
    input ifid_rt_out, ifid_rs_out, idex_rt_out, idex_dREN_out, PCsrc,
          idex_dWEN_out,
    output pc_enable, flush, ifid_pause, exmem_enable
  );

  modport tb (
    input pc_enable, flush, ifid_pause, exmem_enable,
    output ifid_rt_out, ifid_rs_out, idex_rt_out, idex_dREN_out, PCsrc,
           idex_dWEN_out
  );

endinterface

`endif //HAZARD_UNIT_IF_VH
