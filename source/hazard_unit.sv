/*
  Hazard Detection Unit
*/

// interface include
`include "hazard_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module hazard_unit (
  hazard_unit_if huif
);

  // LW Hazard Detection
  always_comb begin
      huif.pc_enable = 1;
      huif.ifid_pause = 0;
      huif.exmem_enable = 0;
    if (huif.idex_dREN_out) begin
/*    if (huif.idex_dREN_out & ((huif.idex_rt_out == huif.ifid_rt_out) |
       (huif.idex_rt_out == huif.ifid_rs_out))) begin*/
      huif.pc_enable = 0;
      huif.ifid_pause = 1;
      huif.exmem_enable = 1;
    end else if (huif.idex_dWEN_out) begin
      huif.pc_enable = 0;
      huif.ifid_pause = 1;
      huif.exmem_enable = 1;
    end
  end

  // BR/J/JR/JAL Hazard Detection
  always_comb begin
    huif.flush = 0;
    if (huif.PCsrc > 0) begin // PCsrc = 1, 2, or 3 (branch, j(al), jr)
      huif.flush = 1; // flush both ifid and idex
    end
  end
endmodule
