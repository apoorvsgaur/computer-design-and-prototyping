/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif.tb);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(
    input logic CLK,
    output logic nRST,
    register_file_if.tb io
    );
    parameter PERIOD = 10;

    initial begin
        io.WEN = 1;
        io.wsel = 0;
        io.rsel1 = 0;
        io.rsel2 = 0;
        io.wdat = 15;
        nRST = 1;

        #(PERIOD)
        $display ("TEST 1 - WRITE 15 TO REG 0");
        assert (io.rdat1 == 0) $display ("GOOD VALUE at addr 0 - rsel1 - %d",
        io.rdat1);
          else $display ("BAD VALUE at addr 0 - rsel1 - %d", io.rdat1);
        assert (io.rdat2 == 0) $display ("GOOD VALUE at addr 0 - rsel2 - %d",
        io.rdat2);
          else $display ("BAD VALUE at addr 0 - rsel2 - %d", io.rdat2);

        io.WEN = 1;
        io.wsel = 2;
        io.rsel1 = 0;
        io.rsel2 = 2;
        io.wdat = 15;
        nRST = 1;

        #(PERIOD)
        $display ("TEST 2 - WRITE 15 TO REG 2");
        assert (io.rdat1 == 0) $display ("GOOD VALUE at addr 0 - rsel1 - %d",
        io.rdat1);
          else $display ("BAD VALUE at addr 0 - rsel1 - %d", io.rdat1);
        assert (io.rdat2 == 15) $display ("GOOD VALUE at addr 2 - rsel2 - %d",
        io.rdat2);
          else $display ("BAD VALUE at addr 2 - rsel2 - %d", io.rdat2);

        io.WEN = 1;
        io.wsel = 2;
        io.rsel1 = 0;
        io.rsel2 = 2;
        io.wdat = 15;
        nRST = 0;

        #(PERIOD)
        $display ("TEST 3 - WRITE 15 TO REG 2 - nRST ACTIVE");
        assert (io.rdat1 == 0) $display ("GOOD VALUE at addr 0 - rsel1 - %d",
        io.rdat1);
          else $display ("BAD VALUE at addr 0 - rsel1 - %d", io.rdat1);
        assert (io.rdat2 == 0) $display ("GOOD VALUE at addr 2 - rsel2 - %d",
        io.rdat2);
          else $display ("BAD VALUE at addr 2 - rsel2 - %d", io.rdat2);

        io.WEN = 0;
        io.wsel = 0;
        io.rsel1 = 0;
        io.rsel2 = 0;
        io.wdat = 0;
        nRST = 1;

        #(PERIOD)
        $display ("TEST 4 - READ REG 0");
        assert (io.rdat1 == 0) $display ("GOOD VALUE at addr 0 - rsel1 - %d",
        io.rdat1);
          else $display ("BAD VALUE at addr 0 - rsel1 - %d", io.rdat1);
        assert (io.rdat2 == 0) $display ("GOOD VALUE at addr 0 - rsel2 - %d",
        io.rdat2);
          else $display ("BAD VALUE at addr 0 - rsel2 - %d", io.rdat2);
    end
endprogram
