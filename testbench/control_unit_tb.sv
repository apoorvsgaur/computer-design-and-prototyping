// interface
`include "control_unit_if.vh"

// types
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped timing needs this??
`timescale 1 ns / 1 ns

module control_unit_tb;
  // clock period
  parameter PERIOD = 20;

  // signals
  logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  control_unit_if cuif();

  // test program
  test PROG (cuif.tb);

  // dut
  control_unit DUT (cuif);

endmodule

program test (control_unit_if.tb cuif);

  parameter PERIOD = 20;

  initial begin
    cuif.instr = 32'h0000;
    #(PERIOD)
    $display ("TEST 1 : SLL INSTRUCTION");
    assert (cuif.r_opcode == SLL) $display ("GOOD INSTR");
      else $display ("BAD INSTR - %b", cuif.r_opcode);
    cuif.instr = 32'h00ff;
    #(PERIOD)
    $display ("TEST 2 : BAD INSTRUCTION");
    assert (cuif.opcode == HALT) $display ("GOOD? INSTR");
      else $display ("BAD INSTR - %b", cuif.opcode);
    assert (cuif.r_type == 0) $display ("GOOD - NOT RTYPE");
      else $display ("BAD - RTYPE");
  end
endprogram
