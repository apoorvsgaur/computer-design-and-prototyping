// mapped needs this
`include "alu_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if aluif ();
  // test program
  test PROG (aluif.tb);
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\io.port_a (aluif.port_a),
    .\io.port_b (aluif.port_b),
    .\io.port_o (aluif.port_o),
    .\io.neg_flag (aluif.neg_flag),
    .\io.of_flag (aluif.of_flag),
    .\io.z_flag (aluif.z_flag),
    .\io.opcode (aluif.opcode)
  );
`endif

endmodule

program test(
    alu_if.tb io
    );
    parameter PERIOD = 10;

    initial begin
        // ADDITION TEST CASES
        io.port_a = 14;
        io.port_b = 14;
        io.opcode = ALU_ADD;
        #(PERIOD)
        $display ("TEST 1 - GOOD ADD A(14), B(14)");
        assert (io.neg_flag == 1) $display ("BAD NEG_FLAG - SHOULD BE OFF");
          else $display ("GOOD NEG_FLAG - OFF");
        assert (io.of_flag == 1) $display ("BAD OF_FLAG - SHOULD BE OFF");
          else $display ("GOOD OF_FLAG - OFF");
        assert (io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert (io.port_o != 28) $display ("BAD VALUE at port_o - result %d", $signed(io.port_o));
          else $display ("GOOD VALUE at port_o - %d", $signed(io.port_o));
        io.port_a = 2147483647;
        io.port_b = 1;
        io.opcode = ALU_ADD;
        #(PERIOD)
        $display ("TEST 2 - BAD ADD A(2147483647), B(1)");
        assert (io.neg_flag == 0) $display ("BAD NEG_FLAG - SHOULD BE ON");
          else $display ("GOOD NEG_FLAG - ON");
        assert (io.of_flag == 0) $display ("BAD OF_FLAG - SHOULD BE ON");
          else $display ("GOOD OF_FLAG - ON");
        assert (io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert (io.port_o != -2147483648) $display ("BAD VALUE at port_o - %d", $signed(io.port_o));
          else $display ("GOOD VALUE at port_o - %d", $signed(io.port_o));
        io.port_a = -32;
        io.port_b = 4;
        io.opcode = ALU_ADD;
        #(PERIOD)
        $display ("TEST 3 - GOOD ADD A(-32), B(4)");
        assert (io.neg_flag == 0) $display ("BAD NEG_FLAG - SHOULD BE ON");
          else $display ("GOOD NEG_FLAG - ON");
        assert (io.of_flag == 1) $display ("BAD OF_FLAG - SHOULD BE OFF");
          else $display ("GOOD OF_FLAG - OFF");
        assert (io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert (io.port_o != -28) $display ("BAD VALUE at port_o - %d", $signed(io.port_o));
          else $display ("GOOD VALUE at port_o - %d", $signed(io.port_o));   

        // SUBTRACTION TEST CASES
        io.port_a = 4;
        io.port_b = 32;
        io.opcode = ALU_SUB;
        #(PERIOD)
        $display ("TEST 4 - GOOD SUB A(4), B(32)");
        assert (io.neg_flag == 0) $display ("BAD NEG_FLAG - SHOULD BE ON");
          else $display ("GOOD NEG_FLAG - ON");
        assert (io.of_flag == 1) $display ("BAD OF_FLAG - SHOULD BE OFF");
          else $display ("GOOD OF_FLAG - OFF");
        assert (io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert (io.port_o != -28) $display ("BAD VALUE at port_o - %d", $signed(io.port_o));
          else $display ("GOOD VALUE at port_o - %d", $signed(io.port_o));     
        io.port_a = 4;
        io.port_b = 4;
        io.opcode = ALU_SUB;
        #(PERIOD)
        $display ("TEST 4 - GOOD SUB A(4), B(4)");
        assert (io.neg_flag == 1) $display ("BAD NEG_FLAG - SHOULD BE OFF");
          else $display ("GOOD NEG_FLAG - OFF");
        assert (io.of_flag == 1) $display ("BAD OF_FLAG - SHOULD BE OFF");
          else $display ("GOOD OF_FLAG - OFF");
        assert (io.z_flag == 0) $display ("BAD Z_FLAG - SHOULD BE ON");
          else $display ("GOOD Z_FLAG - ON");
        assert (io.port_o != 0) $display ("BAD VALUE at port_o - %d", $signed(io.port_o));
          else $display ("GOOD VALUE at port_o - %d", $signed(io.port_o));
        io.port_a = -2147483648;
        io.port_b = 1;
        io.opcode = ALU_SUB;
        #(PERIOD)
        $display ("TEST 4 - BAD SUB A(-2147483648), B(1)");
        assert (io.neg_flag == 1) $display ("BAD NEG_FLAG - SHOULD BE OFF");
          else $display ("GOOD NEG_FLAG - OFF");
        assert (io.of_flag == 0) $display ("BAD OF_FLAG - SHOULD BE ON");
          else $display ("GOOD OF_FLAG - ON");
        assert (io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert (io.port_o != 2147483647) $display ("BAD VALUE at port_o - %d", $signed(io.port_o));
          else $display ("GOOD VALUE at port_o - %d", $signed(io.port_o));

        // LOGICAL SHIFT TEST CASES
        io.port_a = 32'b01010101010101010101010101010101;
        io.port_b = 1;
        io.opcode = ALU_SLL;
        #(PERIOD)
        $display ("TEST 5 - LLS");
        assert(io.neg_flag == 0) $display ("BAD NEG_FLAG - SHOULD BE ON");
          else $display ("GOOD NEG_FLAG - ON");
        assert(io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert(io.port_o != 32'b10101010101010101010101010101010) $display ("BAD VALUE at port_o - %b", io.port_o);
          else $display ("GOOD VALUE at port_o - %d", io.port_o);
        io.port_a = 32'b01010101010101010101010101010101;
        io.port_b = 128;
        io.opcode = ALU_SLL;
        #(PERIOD)
        $display ("TEST 5 - LLS");
        assert(io.neg_flag == 1) $display ("BAD NEG_FLAG - SHOULD BE OFF");
          else $display ("GOOD NEG_FLAG - OFF");
        assert(io.z_flag == 0) $display ("BAD Z_FLAG - SHOULD BE ON");
          else $display ("GOOD Z_FLAG - ON");
        assert(io.port_o != 32'b00000000000000000000000000000000) $display ("BAD VALUE at port_o - %b", io.port_o);
          else $display ("GOOD VALUE at port_o - %d", io.port_o);
        io.port_a = 32'b10101010101010101010101010101010;
        io.port_b = 1;
        io.opcode = ALU_SRL;
        #(PERIOD)
        $display ("TEST 6 - LRS");
        assert(io.neg_flag == 1) $display ("BAD NEG_FLAG - SHOULD BE ON");
          else $display ("GOOD NEG_FLAG - OFF");
        assert(io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert(io.port_o != 32'b01010101010101010101010101010101) $display ("BAD VALUE at port_o - %b", io.port_o);
          else $display ("GOOD VALUE at port_o - %d", io.port_o);

        // AND TEST CASES
        io.port_a = 32'b00000000000000001111111111111111;
        io.port_b = 32'b00000000000000000101010101010101;
        io.opcode = ALU_AND;
        #(PERIOD)
        $display ("TEST 7 - AND");
        assert(io.neg_flag == 0) $display ("BAD NEG_FLAG - SHOULD BE ON");
          else $display ("GOOD NEG_FLAG - ON");
        assert(io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert(io.port_o != 32'b00000000000000000101010101010101) $display ("BAD VALUE at port_o - %b", io.port_o);
          else $display ("GOOD VALUE at port_o - %b", io.port_o);

        // OR TEST CASES
        io.port_a = 32'b00000000000000001111111111111111;
        io.port_b = 32'b10101010101010100000000000000000;
        io.opcode = ALU_OR;
        #(PERIOD)
        $display ("TEST 8 - OR");
        assert(io.neg_flag == 0) $display ("BAD NEG_FLAG - SHOULD BE ON");
          else $display ("GOOD NEG_FLAG - ON");
        assert(io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert(io.port_o != 32'b10101010101010101111111111111111) $display ("BAD VALUE at port_o - %b", io.port_o);
          else $display ("GOOD VALUE at port_o - %b", io.port_o);

        // XOR TEST CASES
        io.port_a = 32'b00000000000000001111111111111111;
        io.port_b = 32'b10101010101010101111111111111111;
        io.opcode = ALU_XOR;
        #(PERIOD)
        $display ("TEST 8 - XOR");
        assert(io.neg_flag == 0) $display ("BAD NEG_FLAG - SHOULD BE ON");
          else $display ("GOOD NEG_FLAG - ON");
        assert(io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert(io.port_o != 32'b10101010101010100000000000000000) $display ("BAD VALUE at port_o - %b", io.port_o);
          else $display ("GOOD VALUE at port_o - %b", io.port_o);

        // NOR TEST CASES
        io.port_a = 32'b00000000000000001111111111111111;
        io.port_b = 32'b10101010101010100000000000000000;
        io.opcode = ALU_NOR;
        #(PERIOD)
        $display ("TEST 8 - NOR");
        assert(io.neg_flag == 1) $display ("BAD NEG_FLAG - SHOULD BE OFF");
          else $display ("GOOD NEG_FLAG - OFF");
        assert(io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert(io.port_o != 32'b01010101010101010000000000000000) $display ("BAD VALUE at port_o - %b", io.port_o);
          else $display ("GOOD VALUE at port_o - %b", io.port_o);

        // LESS THAN (SIGNED) TEST CASES
        io.port_a = -32;
        io.port_b = 32;
        io.opcode = ALU_SLT;
        #(PERIOD)
        $display ("TEST 8 - OR");
        assert(io.neg_flag == 1) $display ("BAD NEG_FLAG - SHOULD BE OFF");
          else $display ("GOOD NEG_FLAG - OFF");
        assert(io.z_flag == 1) $display ("BAD Z_FLAG - SHOULD BE OFF");
          else $display ("GOOD Z_FLAG - OFF");
        assert(io.port_o != 1) $display ("BAD VALUE at port_o - %d", io.port_o);
          else $display ("GOOD VALUE at port_o - %d", io.port_o);

        // LESS THAN (UNSIGNED) TEST CASES
        io.port_a = -32;
        io.port_b = 32;
        io.opcode = ALU_SLTU;
        #(PERIOD)
        $display ("TEST 8 - OR");
        assert(io.neg_flag == 1) $display ("BAD NEG_FLAG - SHOULD BE OFF");
          else $display ("GOOD NEG_FLAG - OFF");
        assert(io.z_flag == 0) $display ("BAD Z_FLAG - SHOULD BE ON");
          else $display ("GOOD Z_FLAG - ON");
        assert(io.port_o != 0) $display ("BAD VALUE at port_o - %d", io.port_o);
          else $display ("GOOD VALUE at port_o - %d", io.port_o);
    end
endprogram
