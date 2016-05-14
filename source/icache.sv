/*
  I-cache Source File
*/

`include "cpu_types_pkg.vh"
`include "icache_if.vh"

import cpu_types_pkg::*;

module icache (
  input logic CLK,
  input logic nRST,
  icache_if iif,
  datapath_cache_if.icache dcif,
  caches_if.icache cif
);

    typedef enum bit [1:0] {IDLE_AKA_COMPARE_TAG, LOAD_INSTR} statevalue;
    statevalue current_state;
    statevalue next_state;

    always_ff @(posedge CLK, negedge nRST) begin
      if (nRST == 0) begin
        iif.way_0 <= '{default:0};
        current_state <= IDLE_AKA_COMPARE_TAG;
      end else if (dcif.ihit == 0) begin
        iif.way_0 <= iif.next_way_0;
        current_state <= next_state;
      end
    end

    assign iif.pc = icachef_t'(dcif.imemaddr);

    always_comb begin
//        iif.pc = icachef_t'(dcif.imemaddr);
        next_state = current_state;
        dcif.ihit = 0;
        dcif.imemload = 0;
        cif.iREN = 0;
        cif.iaddr = 0;
        iif.next_way_0 = iif.way_0;
        case (current_state)
          IDLE_AKA_COMPARE_TAG : begin
            if (dcif.imemREN && (iif.next_way_0[iif.pc.idx].tag == iif.pc.tag) && iif.next_way_0[iif.pc.idx].valid) begin
              dcif.ihit = 1;
              dcif.imemload = iif.way_0[iif.pc.idx].i_data;
            end else if (dcif.imemREN) begin
              next_state = LOAD_INSTR;
            end
          end
          LOAD_INSTR : begin
              dcif.ihit = 0;
              cif.iREN = dcif.imemREN;
              cif.iaddr = dcif.imemaddr;

            if (cif.iwait == 0) begin
                iif.next_way_0[iif.pc.idx].tag = iif.pc.tag;
                iif.next_way_0[iif.pc.idx].i_data = cif.iload;
                iif.next_way_0[iif.pc.idx].valid = 1;
                next_state = IDLE_AKA_COMPARE_TAG;
            end
          end
        endcase
      end
endmodule
