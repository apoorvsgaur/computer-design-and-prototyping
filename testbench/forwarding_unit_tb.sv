/*
  Forwarding Unit Testbench
*/

// interface include
`include "forwarding_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped thing??
`timescale 1 ns / 1 ns

module forwarding_unit_tb;
  // clock period
  parameter PERIOD = 20;

  // signals
  logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  forwarding_unit_if fuif();

  // test program
  test PROG (fuif.tb);

  // dut
  forwarding_unit DUT (fuif);

endmodule

program test (forwarding_unit_if.tb fuif);

  parameter PERIOD = 20;

  initial begin
    fuif.exmem_wsel_out = 2;
    fuif.memwb_wsel_out = 3;
    fuif.exmem_RegWrite_out = 1;
    fuif.memwb_RegWrite_out = 0;
    fuif.idex_rs_out = 2;
    fuif.idex_rt_out = 4;

    #(PERIOD)

    $display ("TEST 1 : Forward Rs from MEM");
    assert (fuif.fwenb_a == 1) $display ("Good FW");
      else $display ("Bad FW");

/////////////////////////////////////////////////

    fuif.exmem_wsel_out = 2;
    fuif.memwb_wsel_out = 3;
    fuif.exmem_RegWrite_out = 0;
    fuif.memwb_RegWrite_out = 1;
    fuif.idex_rs_out = 3;
    fuif.idex_rt_out = 4;

    #(PERIOD)

    $display ("TEST 2 : Forward Rs from WB");
    assert (fuif.fwenb_a == 2) $display ("Good FW");
      else $display ("Bad FW");

/////////////////////////////////////////////////

    fuif.exmem_wsel_out = 2;
    fuif.memwb_wsel_out = 3;
    fuif.exmem_RegWrite_out = 1;
    fuif.memwb_RegWrite_out = 0;
    fuif.idex_rs_out = 4;
    fuif.idex_rt_out = 2;

    #(PERIOD)

    $display ("TEST 3 : Forward Rt from MEM");
    assert (fuif.fwenb_b == 1) $display ("Good FW");
      else $display ("Bad FW");

/////////////////////////////////////////////////

    fuif.exmem_wsel_out = 2;
    fuif.memwb_wsel_out = 3;
    fuif.exmem_RegWrite_out = 0;
    fuif.memwb_RegWrite_out = 1;
    fuif.idex_rs_out = 4;
    fuif.idex_rt_out = 3;

    #(PERIOD)

    $display ("TEST 4 : Forward Rt from WB");
    assert (fuif.fwenb_b == 2) $display ("Good FW");
      else $display ("Bad FW");

/////////////////////////////////////////////////

    fuif.exmem_wsel_out = 2;
    fuif.memwb_wsel_out = 2;
    fuif.exmem_RegWrite_out = 1;
    fuif.memwb_RegWrite_out = 1;
    fuif.idex_rs_out = 2;
    fuif.idex_rt_out = 4;

    #(PERIOD)

    $display ("TEST 5 : Forward Rt from MEM (not WB)");
    assert (fuif.fwenb_a == 1) $display ("Good FW");
      else $display ("Bad FW");

/////////////////////////////////////////////////

    fuif.exmem_wsel_out = 2;
    fuif.memwb_wsel_out = 2;
    fuif.exmem_RegWrite_out = 1;
    fuif.memwb_RegWrite_out = 1;
    fuif.idex_rs_out = 4;
    fuif.idex_rt_out = 2;

    #(PERIOD)

    $display ("TEST 6 : Forward Rs from MEM (not WB)");
    assert (fuif.fwenb_b == 1) $display ("Good FW");
      else $display ("Bad FW");

  end
endprogram
