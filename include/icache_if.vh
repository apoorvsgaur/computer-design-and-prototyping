/*
  I-Cache Interface File
*/

`ifndef ICACHE_IF_VH
`define ICACHE_IF_VH

`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface icache_if;

  icachef_t pc;

  typedef struct packed {
    logic valid;
    logic [25:0] tag;
    word_t i_data;
  } icache_block;

  icache_block [15:0] way_0;
  icache_block [15:0] next_way_0;

  modport icache (
    input pc,
    output way_0
  );

  modport tb (
    input way_0,
    output pc
  );

endinterface

`endif //ICACHE_IF_VH
