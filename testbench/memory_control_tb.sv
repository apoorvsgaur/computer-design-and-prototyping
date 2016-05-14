// interface
`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

// types
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;
  // clock period
  parameter PERIOD = 20;

  // signals
  logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  caches_if cif0();
  caches_if cif1();
  datapath_cache_if dcif();
  cache_control_if #(.CPUS(1)) ccif(cif0, cif1);
  cpu_ram_if crif();

  assign crif.ramaddr = ccif.ramaddr;
  assign crif.ramstore = ccif.ramstore;
  assign crif.ramREN = ccif.ramREN;
  assign crif.ramWEN = ccif.ramWEN;
  assign ccif.ramload = crif.ramload;
  assign ccif.ramstate = crif.ramstate;

  // test program
  test PROG (CLK, nRST, cif0);

  // dut
  memory_control DUT (CLK, nRST, ccif);
  ram RAM (CLK, nRST, crif);

endmodule

program test( input logic CLK, output logic nRST, caches_if cif0);
  // import word type
  import cpu_types_pkg::word_t;

  // number of cycles
  int unsigned cycles = 0;

  initial begin
    nRST = 0;
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);

    //WRITE DATA TEST
    data_write(32'h00ff, 0);

    //READ DATA TEST
    data_read(0);

    //READ INSTR TEST
    instr_read(0);

    //PRIORITY OF dWEN OVER dREN TEST
    priority_dWEN_dREN;

    //PRIORITY OF dREN OVER iREN TEST
    priority_dREN_iREN;

    //do_nothing;
    dump_memory;
  end

  task automatic priority_dREN_iREN();
    cif0.dREN = 1;
    cif0.dWEN = 0;
    cif0.daddr = 0;
    cif0.dstore = 0;
    cif0.iREN = 1;
    cif0.iaddr = 0;
    @(posedge CLK);
    @(posedge CLK);
    assert (cif0.iload == 0)
      else $display ("iload value was not default of 0");
  endtask

  task automatic priority_dWEN_dREN();
    cif0.dREN = 1;
    cif0.dWEN = 1;
    cif0.daddr = 0;
    cif0.dstore = 32'hff00;
    cif0.iREN = 0;
    cif0.iaddr = 0;
    @(posedge CLK);
    @(posedge CLK);
    assert (cif0.dload == 0)
      else $display ("dload value was not default of 0");
  endtask

  task automatic data_write(word_t value, word_t addr);
    cif0.dREN = 0;
    cif0.dWEN = 1;
    cif0.daddr = addr;
    cif0.dstore = value;
    cif0.iREN = 0;
    cif0.iaddr = 0;
    @(posedge CLK);
    @(posedge CLK);
  endtask

  task automatic data_read(word_t addr);
    cif0.dREN = 1;
    cif0.dWEN = 0;
    cif0.daddr = addr;
    cif0.iREN = 0;
    cif0.iaddr = 0;
    @(posedge CLK);
    @(posedge CLK);
    assert (cif0.dload == 32'h00ff)
      else $display ("value at address was NOT correct - %d", cif0.dload);
  endtask

  task automatic instr_read(word_t addr);
    cif0.dREN = 0;
    cif0.dWEN = 0;
    cif0.daddr = 0;
    cif0.dstore = 0;
    cif0.iREN = 1;
    cif0.iaddr = 0;
    @(posedge CLK);
    @(posedge CLK);
    assert (cif0.iload == 32'h00ff)
      else $display ("value at address was NOT correct - %d", cif0.iload);
  endtask

  task automatic do_nothing();
    cif0.dREN = 0;
    cif0.dWEN = 0;
    cif0.daddr = 0;
    cif0.dstore = 0;
    cif0.iREN = 0;
    cif0.iaddr = 0;
    @(posedge CLK);
    @(posedge CLK);
  endtask

  task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for

    if (memfd)
    begin
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask
endprogram
