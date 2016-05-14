/*
  Hazard Unit Testbench
*/

// interface include
`include  "hazard_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped thing??
`timescale 1 ns / 1 ns

module hazard_unit_tb;
  // clock period
  parameter PERIOD = 20;

  // signals
  logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  hazard_unit_if huif();

  // test program
  test PROG (huif.tb);

  // dut
  hazard_unit DUT (huif);

endmodule

program test (hazard_unit_if.tb huif);

  parameter PERIOD = 20;

  initial begin
    huif.ifid_rt_out = 2;
    huif.ifid_rs_out = 1;
    huif.idex_rt_out = 2;
    huif.idex_dREN_out = 1;
    huif.PCsrc = 0;

    #(PERIOD)

    $display ("Test 1 : LW Hazard Detection");
    assert (huif.pc_enable == 0) $display ("Good PC paused");
      else $display ("Bad PC NOT paused");
    assert (huif.ifid_pause == 1) $display ("Good IFID paused");
      else $display ("Bad IFID NOT paused");

/////////////////////////////////////////////////

    huif.ifid_rt_out = 2;
    huif.ifid_rs_out = 3;
    huif.idex_rt_out = 4;
    huif.idex_dREN_out = 0;
    huif.PCsrc = 1;

    #(PERIOD)

    $display ("Test 2 : Branch Hazard Detection");
    assert (huif.flush == 1) $display ("Good flush");
      else $display ("Bad Flush");
  end
endprogram
