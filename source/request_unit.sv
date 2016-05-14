/*
  Katie Bauschka
  ECE 437

  Request Unit File
*/

// interface include
`include "request_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module request_unit(
  request_unit_if ruif,
  input logic CLK, nRST
);

  assign ruif.pc_enable = ruif.ihit;

  always_ff @ (posedge CLK, negedge nRST) begin
    if (nRST == 0) begin
      ruif.dREN_o <= 0;
      ruif.dWEN_o <= 0;
    end else if (ruif.dhit == 1) begin
      ruif.dREN_o <= 0;
      ruif.dWEN_o <= 0;
    end else if (ruif.ihit == 1) begin
      ruif.dREN_o <= ruif.dREN_i;
      ruif.dWEN_o <= ruif.dWEN_i;
    end
  end

endmodule
