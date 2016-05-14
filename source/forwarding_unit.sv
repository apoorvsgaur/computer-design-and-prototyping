/*
  Forwarding Unit
*/

// interface include
`include "forwarding_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module forwarding_unit (
  forwarding_unit_if fuif
);

  always_comb begin
    fuif.fwenb_a = 0;
    fuif.fwenb_b = 0;

    // Forward for port_a from EX/MEM (priority)
    if (fuif.exmem_RegWrite_out & (fuif.exmem_wsel_out != 0) &
       (fuif.exmem_wsel_out == fuif.idex_rs_out)) begin
      fuif.fwenb_a = 1; // pull port_o from exmem
    // Forward for port_a from MEM/WB
    end else if (fuif.memwb_RegWrite_out & (fuif.memwb_wsel_out != 0) &
                (fuif.memwb_wsel_out == fuif.idex_rs_out)) begin
      fuif.fwenb_a = 2; // pull wdat from memwb
    end

    // Forward for port_b from EX/MEM (priority)
    if (fuif.exmem_RegWrite_out & (fuif.exmem_wsel_out != 0) &
       (fuif.exmem_wsel_out == fuif.idex_rt_out)) begin
      fuif.fwenb_b = 1; // pull port_o from exmem
    end else if (fuif.memwb_RegWrite_out & (fuif.memwb_wsel_out != 0) &
                (!fuif.i_type) & (fuif.memwb_wsel_out == fuif.idex_rt_out)) begin
      fuif.fwenb_b = 2; // pull wdat from memwb
    end
  end

endmodule
