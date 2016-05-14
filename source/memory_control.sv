/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

  // cache_control_if.cc signals
  // input
  // iREN, dREN, dWEN, dstore, iaddr, daddr
  // ramload, ramstate

  // output
  // iwait, dwait, iload, dload
  // ramstore, ramaddr, ramWEN, ramREN


  logic [CPUS-1:0]  iwait, dwait, ramWEN, ramREN;
  word_t [CPUS-1:0] iload, dload;
  word_t ramaddr, ramstore;

  always_comb begin
      iwait = 1;
      dwait = 1;
      ramWEN = 0;
      ramREN = 0;
      iload = 0;
      dload = 0;
      ramaddr = 0;
      ramstore = 0;

    if (ccif.dWEN == 1) begin
      ramaddr = ccif.daddr;
      ramstore = ccif.dstore;
      dwait = ~(ccif.ramstate == ACCESS);
      ramWEN = ccif.dWEN;
    end else if (ccif.dREN == 1) begin
      ramaddr = ccif.daddr;
      dload = ccif.ramload;
      dwait = ~(ccif.ramstate == ACCESS);
      ramREN = ccif.dREN;
    end else if (ccif.iREN == 1) begin
      ramaddr = ccif.iaddr;
      iload = ccif.ramload;
      iwait = ~(ccif.ramstate== ACCESS);
      ramREN = ccif.iREN;
    end
  end

  assign ccif.ramaddr = ramaddr;
  assign ccif.ramstore = ramstore;
  assign ccif.dwait = dwait;
  assign ccif.ramWEN = ramWEN;
  assign ccif.dload = dload;
  assign ccif.ramREN = ramREN;
  assign ccif.iload = iload;
  assign ccif.iwait = iwait;
endmodule
