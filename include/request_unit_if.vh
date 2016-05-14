/*
  Katie Bauschka
  ECE 437

  Request Unit Interface File
*/

`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic dREN_i, dWEN_i, dREN_o, dWEN_o, dhit, ihit, pc_enable;
  //iREN will be directly tied to 1 to the caches interface

  modport ru (
    input dREN_i, dWEN_i, dhit, ihit,
    output dREN_o, dWEN_o, pc_enable
  );

  modport tb (
    input dREN_o, dWEN_o, pc_enable,
    output dREN_i, dWEN_i, dhit, ihit
  );
endinterface

`endif //REQUEST_UNIT_IF_VH
