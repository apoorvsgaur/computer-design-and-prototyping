/*
  Testbench for D-cache
*/

`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "dcache_if.vh"

import cpu_types_pkg::*;

module dcache_tb;

  parameter PERIOD = 10;
  logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dcif ();
  caches_if cif ();
  dcache_if dif ();

  // test program
  test PROG (CLK, nRST, dif.tb, dcif.dcache, cif.dcache);

  // DUT
  dcache DUT (CLK, nRST, dcif, dif, cif);

endmodule

program test (input logic CLK,
              output logic nRST,
              dcache_if.tb dif,
              datapath_cache_if.dcache dcif,
              caches_if.dcache cif
);
  parameter PERIOD = 10;

  initial begin
    nRST = 0;
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);

    dcif.halt = 0;

    // Test 1 : Load-miss: store "beab1" (from the RAM)to way_0[1] with tag 3d'7
    dcif.dmemaddr = 32'b00000000000000000000000111001000;
    dcif.dmemREN = 1;
    cif.dwait = 0;
    @(posedge CLK);
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h000beab1;
    @(posedge CLK);
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h00000000;
    @(posedge CLK);
    assert (dif.way_0[1].lower_d_data == 32'h000beab1) $display ("Valid Test-1 Load-Miss data");
      else $display ("Invalid Test-1 Load-Miss data");
    @(posedge CLK);

    // Test 2 : Load-hit: "beab1" from way_0[1] with tag 3d'7
    dcif.dmemaddr = 32'b00000000000000000000000111001000;
    dcif.dmemREN = 1;
    cif.dwait = 0;
    assert (dcif.dmemload == 32'h000beab1) $display ("Valid Test-2 Load-Hit data");
      else $display ("Invalid Test-2 Load-Hit data");
    @(posedge CLK);

    // Test 3 : Store-miss: "bead1" to way_0[2] with tag 3d'6
    dcif.dmemREN = 0;
    dcif.dmemaddr = 32'b00000000000000000000000110010000;
    dcif.dmemstore = 32'h000bead1;
    dcif.dmemWEN = 1;
    cif.dwait = 0;
    @(posedge CLK);
    cif.dwait = 1;
    @(posedge CLK);
    //dcif.dmemWEN = 1;
    cif.dwait = 0;
    cif.dload = 32'h000feeb1;
    @(posedge CLK);
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h00000000;
    @(posedge CLK);
    @(posedge CLK);
    assert (dif.way_0[2].lower_d_data == 32'h000bead1) $display ("Valid Test-3 Store-Miss data");
      else $display ("Invalid Test-3 Store-Miss data");
    dcif.dmemREN = 0;
    dcif.dmemWEN = 0;
    @(posedge CLK);

    // Test 4: Store-hit: "baab1" to way_0[2] with tag 3d'6 and way_0[2].dirty_bit asserted
    dcif.dmemaddr = 32'b00000000000000000000000110010000;
    dcif.dmemstore = 32'h000baab1;
    dcif.dmemWEN = 1;
    cif.dwait = 0;
    @(posedge CLK);
    dcif.dmemWEN = 0;
    @(posedge CLK);
    assert (dif.way_0[2].lower_d_data == 32'h000baab1) $display ("Valid Test-4 Store-Hit data");
      else $display ("Invalid Test-4 Store-Hit data");
    assert (dif.way_0[2].dirty == 1) $display ("Valid dirty bit");
      else $display ("Invalid dirty bit");
    @(posedge CLK);

    // Test 5 : Load-miss: Store "beef1" and "dead2" to way_1[1] with tag 3d'6
    dcif.dmemaddr = 32'b00000000000000000000000110001000;
    dcif.dmemREN = 1;
    cif.dwait = 0;
    @(posedge CLK);
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h000beef1;
    @(posedge CLK);
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h000dead2;
    @(posedge CLK);
    assert (dif.way_1[1].lower_d_data == 32'h000beef1) $display ("Valid Test-5 Load-Miss L-data");
      else $display ("Invalid Test-5 Load-Miss L-data");
    assert (dif.way_1[1].upper_d_data == 32'h000dead2) $display ("Valid Test-5 Load-Miss U-data");
      else $display ("Invalid Test-5 Load-Miss U-data");
    @(posedge CLK);

    // Test 6 : Store-hit to dirty way_0[1] upper data with "beefcaca"
    dcif.dmemREN = 0;
    dcif.dmemaddr = 32'b00000000000000000000000111001100;
    dcif.dmemstore = 32'hbeefcaca;
    dcif.dmemWEN = 1;
    cif.dwait = 0;
    @(posedge CLK);
    dcif.dmemWEN = 0;
    @(posedge CLK);
    assert (dif.way_0[1].lower_d_data == 32'h000beab1) $display ("Valid Test-6 Store-Hit L-data");
      else $display ("Invalid Test-6 Store-Hit L-data");
    assert (dif.way_0[1].upper_d_data == 32'hbeefcaca) $display ("Valid Test-6 Store-Hit U-data");
      else $display ("Invalid Test-6 Store-Hit U-data");
    assert (dif.way_0[1].dirty == 1) $display ("Valid dirty bit");
      else $display ("Invalid dirty bit");
    @(posedge CLK);

    // Test 7 : Store-hit to dirty way_1[1]
    dcif.dmemREN = 0;
    dcif.dmemaddr = 32'b00000000000000000000000110001100;
    dcif.dmemstore = 32'hbeefcaca;
    dcif.dmemWEN = 1;
    cif.dwait = 0;
    @(posedge CLK);
    dcif.dmemWEN = 0;
    @(posedge CLK);
    assert (dif.way_1[1].lower_d_data == 32'h000beef1) $display ("Valid Test-7 Store-Hit L-data");
      else $display ("Invalid Test-7 Store-Hit L-data");
    assert (dif.way_1[1].upper_d_data == 32'hbeefcaca) $display ("Valid Test-7 Store-Hit U-data");
      else $display ("Invalid Test-7 Store-Hit U-data");
    assert (dif.way_1[1].dirty == 1) $display ("Valid dirty bit");
      else $display ("Invalid dirty bit");
    @(posedge CLK);


    // Test 7 : Load-Miss on way_0[1] with dirty set, new tag is 3d'8
    dcif.dmemaddr = 32'b00000000000000000000001000001000;
    dcif.dmemREN = 1;
    cif.dwait = 0;
    @(posedge CLK); // transition to write-back lower
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    @(posedge CLK); // transition to write-back uppper
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    @(posedge CLK); // transition to load lower
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'hbaccbacc;
    @(posedge CLK); // transition to load upper
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h00dead00;
    @(posedge CLK);
    assert (dif.way_0[1].lower_d_data == 32'hbaccbacc) $display ("Valid Test-8 Load-Miss L-data");
      else $display ("Invalid Test-8 Load-Miss L-data");
    assert (dif.way_0[1].upper_d_data == 32'h00dead00) $display ("Valid Test 8 Load Miss U-data");
      else $display ("Invalid Test-8 Load-Miss U-data");
    @(posedge CLK);
    @(posedge CLK);

    // Test N : Reset
    nRST = 0;
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);

  end
endprogram
