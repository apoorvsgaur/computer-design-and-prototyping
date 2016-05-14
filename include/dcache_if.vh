/*
  D-Cache Interface File
*/

`ifndef DCACHE_IF_VH
`define DCACHE_IF_VH

`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface dcache_if;

typedef struct packed {
    logic valid;
    logic dirty;
    logic [DTAG_W-1:0] tag;
    word_t upper_d_data; // [63:32] with block offset of 1
    word_t lower_d_data; // [31:0] with block offset of 0
} dcache_block;

  dcachef_t daddr;
  dcache_block [7:0] way_0, way_1;
  dcache_block [7:0] next_way_0, next_way_1;
  
  word_t next_link_register, link_register; 
  logic next_valid_lr, valid_lr;

  //logic snoop_hit; //this is for snooping
                   //if the snoop hits and the data is the lower word - 0
                   //if the snoop hits and the data is the upper word - 1


  modport dcache (
    input daddr,
    output way_0, way_1
  );

  modport tb (
    input way_0, way_1,
    output daddr
  );

endinterface

`endif //DCACHE_IF_VH
