/*
  Katie Bauschka
  ECE 437

  Request Unit Testbench
*/

// interface
`include "request_unit_if.vh"

// types
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped timing needs this??
`timescale 1 ns / 1 ns

module request_unit_tb;
  // clock period
  parameter PERIOD = 20;

  // signals
  logic CLK = 1, nRST = 1;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  request_unit_if ruif();

  // test program
  test PROG (ruif.tb, CLK, nRST);

  // dut
  request_unit DUT (ruif, CLK, nRST);

endmodule

program test (request_unit_if.tb ruif,
              input logic CLK,
              output logic nRST
);

  parameter PERIOD = 20;

  initial begin
    nRST = 0;
    #(PERIOD)
    nRST = 1;
    #(PERIOD)

    $display ("TEST 1 : dREN");
    ruif.dREN_i = 1;
    ruif.dWEN_i = 0;
    ruif.dhit = 0;
    ruif.ihit = 0;
    #(PERIOD)
    assert (ruif.dREN_o == 1) $display ("dREN was set correctly");
      else $display ("dREN was NOT set correctly");
    ruif.dhit = 1;
    #(PERIOD)
    assert (ruif.dREN_o == 0) $display ("dREN was deasserted correctly");
      else $display ("dREN was NOT deasserted correctly");

    $display ("TEST 2 : dWEN");
    ruif.dREN_i = 0;
    ruif.dWEN_i = 1;
    ruif.dhit = 0;
    ruif.ihit = 0;
    #(PERIOD)
    assert (ruif.dWEN_o == 1) $display ("dWEN was set correctly");
      else $display ("dWEN was NOT set correctly");
    ruif.dhit = 1;
    #(PERIOD)
    assert (ruif.dWEN_o == 0) $display ("dWEN was deasserted correctly");
      else $display ("dWEN was NOT deasserted correctly");

    $display ("TEST 3 : ihit and pc_enable");
    ruif.dREN_i = 0;
    ruif.dWEN_i = 0;
    ruif.dhit = 0;
    ruif.ihit = 1;
    #(PERIOD)
    assert (ruif.pc_enable == 1) $display ("pc_enable was asserted correctly");
      else $display ("pc_enable was NOT asserted correctly");
  end
endprogram
