/*
  Testbench for I-cache
*/

`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "icache_if.vh"

import cpu_types_pkg::*;

module icache_tb;

  parameter PERIOD = 10;
  logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dcif ();
  caches_if cif ();
  icache_if iif ();

  // test program
  test PROG (CLK, nRST, iif.tb, dcif.icache, cif.icache);

  // DUT
  icache DUT (CLK, nRST, iif, dcif, cif);

endmodule

program test (input logic CLK,
              output logic nRST,
              icache_if.tb iif,
              datapath_cache_if.icache dcif,
              caches_if.icache cif
);

  initial begin
    nRST = 0;
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);

    // Test 1 : Load "dead" to idx 0
    dcif.imemaddr = 32'h00000000;
    dcif.imemREN = 1;
    cif.iwait = 0;
    cif.iwait = 1;
    @(posedge CLK);
    cif.iwait = 0;
    cif.iload = 32'h0000dead;
    @(posedge CLK);
    assert (iif.way_0[0].i_data == 32'h0000dead) $display ("valid data");
      else $display ("invalid data");
    @(posedge CLK);

    // Test 2 : Load "beef" to idx 1
    dcif.imemaddr = 32'h00000004;
    dcif.imemREN = 1;
    cif.iwait = 0;
    cif.iwait = 1;
    @(posedge CLK);
    cif.iwait = 0;
    cif.iload = 32'h0000beef;
    @(posedge CLK);
    assert (iif.way_0[1].i_data == 32'h0000beef) $display ("valid data");
      else $display ("invalid data");
    @(posedge CLK);

    // Test 3 : Load "deaf" to idx 2
    dcif.imemaddr = 32'h00000008;
    dcif.imemREN = 1;
    cif.iwait = 0;
    cif.iwait = 1;
    @(posedge CLK);
    cif.iwait = 0;
    cif.iload = 32'h0000deaf;
    @(posedge CLK);
    assert (iif.way_0[2].i_data == 32'h0000deaf) $display ("valid data");
      else $display ("invalid data");
    @(posedge CLK);

    // Test 4 : Hit "dead" in idx 0
    dcif.imemaddr = 32'h00000000;
    dcif.imemREN = 1;
    assert (dcif.ihit == 1) $display ("accurate hit");
      else $display ("invalid miss");
    cif.iwait = 0;
    //@(posedge CLK);
    assert (iif.way_0[0].i_data == 32'h0000dead) $display ("valid data");
      else $display ("invalid data");
    @(posedge CLK);

    // Test 5 : Load "beef to idx 0, but with tag ff's
    dcif.imemaddr = 32'hffffffC0;
    dcif.imemREN = 1;
    cif.iwait = 0;
    cif.iwait = 1;
    @(posedge CLK);
    cif.iwait = 0;
    cif.iload = 32'h0000beef;
    @(posedge CLK);
    assert (iif.way_0[0].i_data == 32'h0000beef) $display ("valid data");
      else $display ("invalid data");
    @(posedge CLK);

    // Test 6 : Reset
    nRST = 0;
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);
  end
endprogram
