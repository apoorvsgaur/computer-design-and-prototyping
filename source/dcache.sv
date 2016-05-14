/*
  D-cache Source File
*/

`include "cpu_types_pkg.vh"
`include "dcache_if.vh"
import cpu_types_pkg::*;

module dcache (
  input logic CLK,
  input logic nRST,
  datapath_cache_if.dcache dcif,
  dcache_if dif,
  caches_if.dcache cif
);

logic [15:0] least_recently_used;
logic [31:0] hit_counter;

logic [15:0] next_least_recently_used;
logic [31:0] next_hit_counter;


logic [4:0] traverse_caches;
logic [4:0] next_traverse_caches;

logic way_0_dhit, way_1_dhit;

logic dmiss;

typedef enum bit [3:0] {IDLE_AKA_COMPARE_TAG, WRITE_BACK_LOWER_DATA, WRITE_BACK_UPPER_DATA, STORE_LOWER_DATA, STORE_UPPER_DATA, SET_HIT_COUNTER, FLUSH_DIRTY_TO_RAM, ACTUAL_HALT} statevalue;
statevalue current_state;
statevalue next_state;

assign dif.daddr = dcachef_t'(dcif.dmemaddr); //'sublime_text_exception_comment
assign dcif.dhit = (way_0_dhit | way_1_dhit);

always_ff @(posedge CLK, negedge nRST) begin
      if (nRST == 0) begin
        current_state <= IDLE_AKA_COMPARE_TAG;
        dif.way_0 <= '{default:0}; //'sublime_text_exception_comment
        dif.way_1 <= '{default:0};
        least_recently_used <= '{default:0};
        traverse_caches <= 0;
        //hit_counter <= 0;
      end 
      else  begin
        dif.way_0 <= dif.next_way_0;
        dif.way_1 <= dif.next_way_1;
        least_recently_used <= next_least_recently_used;
        traverse_caches <= next_traverse_caches;
        current_state <= next_state;
        //hit_counter <= next_hit_counter;
      end
    end

always_ff @(posedge CLK, negedge nRST) //@(posedge dcif.dhit, posedge dmiss, negedge nRST)
begin
    if (nRST == 0) 
    begin
        hit_counter <= 0;
    end
    else if (dcif.dhit | dmiss)
    begin
        hit_counter <= next_hit_counter;
    end
end



always_comb begin
    next_state = current_state;
    way_0_dhit = 0;
    way_1_dhit = 0;
    cif.dREN = 0;
    cif.dWEN = 0;
    cif.daddr = 0;
    next_hit_counter = hit_counter;
    next_least_recently_used = least_recently_used;
    dif.next_way_0 = dif.way_0;
    dif.next_way_1 = dif.way_1;
    dcif.dmemload = 0;
    cif.dstore = 0;
    next_traverse_caches = traverse_caches;
    dcif.flushed = 0;
    dmiss = 0;

    case (current_state)
        IDLE_AKA_COMPARE_TAG:
        begin
          //Load-word hit on way_0
          if ((dif.way_0[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_0[dif.daddr.idx].valid && dcif.dmemREN) //AND VALID BIT
          begin
              way_0_dhit = 1;
              if (dif.daddr.blkoff == 0)
              begin
                dcif.dmemload = dif.way_0[dif.daddr.idx].lower_d_data;
              end
              else if (dif.daddr.blkoff == 1)
              begin
                dcif.dmemload = dif.way_0[dif.daddr.idx].upper_d_data;
              end
              next_least_recently_used[dif.daddr.idx] = 1;
              next_hit_counter = hit_counter + 32'd1;
              cif.dREN = 0;
              cif.dWEN = 0;
          end
          //Load-word hit on way_1
          else if ((dif.way_1[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_1[dif.daddr.idx].valid && dcif.dmemREN) //AND VALID BIT
          begin
              way_1_dhit = 1;
              if (dif.daddr.blkoff == 0)
              begin
                dcif.dmemload = dif.way_1[dif.daddr.idx].lower_d_data;
              end
              else if (dif.daddr.blkoff == 1)
              begin
                dcif.dmemload = dif.way_1[dif.daddr.idx].upper_d_data;
              end
              next_least_recently_used[dif.daddr.idx] = 0;
              next_hit_counter = hit_counter + 32'd1;
              cif.dREN = 0;
              cif.dWEN = 0;
          end
          //Store-word hit on way_0
          else if ((dif.way_0[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_0[dif.daddr.idx].valid && dcif.dmemWEN)
          begin
              way_0_dhit = 1;
              if (dif.daddr.blkoff == 0)
              begin
                dif.next_way_0[dif.daddr.idx].lower_d_data = dcif.dmemstore;
              end
              else if (dif.daddr.blkoff == 1)
              begin
                dif.next_way_0[dif.daddr.idx].upper_d_data = dcif.dmemstore;
              end
              dif.next_way_0[dif.daddr.idx].dirty = 1;
              next_least_recently_used[dif.daddr.idx] = 1;
              next_hit_counter = hit_counter + 32'd1;
              cif.dREN = 0;
              cif.dWEN = 0;
          end
          //Store-word hit on way_1
          else if ((dif.way_1[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_1[dif.daddr.idx].valid && dcif.dmemWEN)
          begin
              way_1_dhit = 1;
              if (dif.daddr.blkoff == 0)
              begin
                dif.next_way_1[dif.daddr.idx].lower_d_data = dcif.dmemstore;
              end
              else if (dif.daddr.blkoff == 1)
              begin
                dif.next_way_1[dif.daddr.idx].upper_d_data = dcif.dmemstore;
              end
              dif.next_way_1[dif.daddr.idx].dirty = 1;
              next_least_recently_used[dif.daddr.idx] = 0;
              next_hit_counter = hit_counter + 32'd1;
              cif.dREN = 0;
              cif.dWEN = 0;
          end
          //Load-word miss and store-word miss
          else if (dcif.dmemREN || dcif.dmemWEN)
          begin
            next_hit_counter = hit_counter - 32'd1;  
            dmiss = 1;    
            if (next_least_recently_used[dif.daddr.idx] == 0 && dif.next_way_0[dif.daddr.idx].dirty == 1)
            begin
                next_state = WRITE_BACK_LOWER_DATA;
            end
            else if (next_least_recently_used[dif.daddr.idx] == 1 && dif.next_way_1[dif.daddr.idx].dirty == 1)
            begin
                next_state = WRITE_BACK_LOWER_DATA;
            end
            else
            begin
               next_state = STORE_LOWER_DATA;
            end
          end
          else if (dcif.halt == 1)
          begin
              next_state = FLUSH_DIRTY_TO_RAM;
          end
        end
        WRITE_BACK_LOWER_DATA:
        begin
          cif.dWEN = 1;
          if (least_recently_used[dif.daddr.idx] == 0 && !dcif.halt) //if the least recently used is way_0
          begin
              cif.daddr = {dif.way_0[dif.daddr.idx].tag, dif.daddr.idx, 3'b000};
              cif.dstore = dif.way_0[dif.daddr.idx].lower_d_data;
              dif.next_way_0[dif.daddr.idx].dirty = 0;
              if(cif.dwait == 0)
              begin
                next_state = WRITE_BACK_UPPER_DATA;
              end
          end
          else if (least_recently_used[dif.daddr.idx] == 1 && !dcif.halt)//if the least recently used is way_1
          begin
              cif.daddr = {dif.way_1[dif.daddr.idx].tag, dif.daddr.idx, 3'b000};
              cif.dstore = dif.way_1[dif.daddr.idx].lower_d_data;
              dif.next_way_1[dif.daddr.idx].dirty = 0;
              if(cif.dwait == 0)
              begin
                next_state = WRITE_BACK_UPPER_DATA;
              end
          end
          else
          begin
            if ((traverse_caches ) < 8)
            begin
              cif.daddr = {dif.way_0[traverse_caches].tag, (traverse_caches[2:0]), 3'b000};
              cif.dstore = dif.way_0[traverse_caches].lower_d_data;
              dif.next_way_0[traverse_caches].dirty = 0;
            end
            else
            begin
                cif.daddr = {dif.way_1[traverse_caches % 8].tag, (traverse_caches[2:0] ), 3'b000};
                cif.dstore = dif.way_1[traverse_caches % 8].lower_d_data;
                dif.next_way_0[traverse_caches].dirty = 0;
            end
            if(cif.dwait == 0)
            begin
                next_state = WRITE_BACK_UPPER_DATA;
            end
          end
        end
        WRITE_BACK_UPPER_DATA:
        begin
          cif.dWEN = 1;
          if (least_recently_used[dif.daddr.idx] == 0 && !dcif.halt) //if the least recently used is way_0
          begin
              cif.daddr = {dif.way_0[dif.daddr.idx].tag, dif.daddr.idx, 3'b100};
              cif.dstore = dif.way_0[dif.daddr.idx].upper_d_data;
              dif.next_way_0[dif.daddr.idx].dirty = 0;
              if(cif.dwait == 0)
              begin
                next_state = STORE_LOWER_DATA;
              end
          end
          else if (least_recently_used[dif.daddr.idx] == 1 && !dcif.halt)//if the least recently used is way_1
          begin
                cif.daddr = {dif.way_1[dif.daddr.idx].tag, dif.daddr.idx, 3'b100};
                cif.dstore = dif.way_1[dif.daddr.idx].upper_d_data;
                dif.next_way_1[dif.daddr.idx].dirty = 0;
              if(cif.dwait == 0)
              begin
                next_state = STORE_LOWER_DATA;
              end
          end
          else
          begin
            if (traverse_caches < 8)
            begin
              cif.daddr = {dif.next_way_0[traverse_caches % 8].tag, (traverse_caches[2:0]), 3'b100};
              cif.dstore = dif.next_way_0[traverse_caches % 8].upper_d_data;
              dif.next_way_0[traverse_caches[2:0]].dirty = 0;
            end
            else
            begin
                cif.daddr = {dif.next_way_1[traverse_caches % 8].tag, (traverse_caches[2:0]), 3'b100};
                cif.dstore = dif.next_way_1[traverse_caches % 8].upper_d_data;
                dif.next_way_0[traverse_caches[2:0]].dirty = 0;
            end
            if(cif.dwait == 0)
            begin
                next_traverse_caches = traverse_caches + 1;
                next_state = FLUSH_DIRTY_TO_RAM;
            end
          end
        end
        STORE_LOWER_DATA:
        begin
          //Load-word miss storing into cache
          cif.dREN = 1;
          if (dif.daddr.blkoff == 1) begin
            cif.daddr = dcif.dmemaddr - 4;
          end else begin
            cif.daddr = dcif.dmemaddr;
          end
          if(least_recently_used[dif.daddr.idx] == 0)
          begin
              if(cif.dwait == 0)
              begin
                dif.next_way_0[dif.daddr.idx].lower_d_data = cif.dload;
                dif.next_way_0[dif.daddr.idx].tag = dif.daddr.tag;
                next_state = STORE_UPPER_DATA;
              end
          end
          else
          begin
              if(cif.dwait == 0)
              begin
                dif.next_way_1[dif.daddr.idx].lower_d_data = cif.dload;
                dif.next_way_1[dif.daddr.idx].tag = dif.daddr.tag;
                next_state = STORE_UPPER_DATA;
              end
          end
        end
        STORE_UPPER_DATA:
        begin
          cif.dREN = 1;
          if (dif.daddr.blkoff == 1) begin
            cif.daddr = dcif.dmemaddr;
          end else begin          
            cif.daddr = dcif.dmemaddr + 32'd4;
          end
          if(least_recently_used[dif.daddr.idx] == 0)
          begin
              if(cif.dwait == 0)
              begin
                dif.next_way_0[dif.daddr.idx].upper_d_data = cif.dload;
                dif.next_way_0[dif.daddr.idx].tag = dif.daddr.tag;
                dif.next_way_0[dif.daddr.idx].valid = 1;
                next_state = IDLE_AKA_COMPARE_TAG;                
              end
          end
          else
          begin
              if(cif.dwait == 0)
              begin
                dif.next_way_1[dif.daddr.idx].upper_d_data = cif.dload;
                dif.next_way_1[dif.daddr.idx].tag = dif.daddr.tag;
                dif.next_way_1[dif.daddr.idx].valid = 1;
                next_state = IDLE_AKA_COMPARE_TAG;               
              end
          end
        end
        FLUSH_DIRTY_TO_RAM:
        begin
          if (traverse_caches < 8)
          begin
              if(dif.next_way_0[traverse_caches].dirty == 1)
              begin
                //next_traverse_caches = traverse_caches + 1;
                next_state = WRITE_BACK_LOWER_DATA;
              end
              else
              begin
                   next_traverse_caches = traverse_caches + 1;
              end
          end
          else if (traverse_caches >= 8 && traverse_caches < 16)
          begin
              if(dif.next_way_1[traverse_caches % 8].dirty == 1)
              begin
                //next_traverse_caches = traverse_caches + 1;
                next_state = WRITE_BACK_LOWER_DATA;
              end
              else
              begin
                   next_traverse_caches = traverse_caches + 1;
              end
          end
          else
          if (traverse_caches == 16)
          begin
            next_state = SET_HIT_COUNTER;
          end
        end
        SET_HIT_COUNTER:
        begin
            cif.dWEN = 1;
            cif.dstore = hit_counter;
            cif.daddr = 32'h3100;
            if(cif.dwait == 0)
            begin
              next_state = ACTUAL_HALT;
            end
        end
        ACTUAL_HALT:
        begin
          dcif.flushed = 1;
          next_state = ACTUAL_HALT;
        end
    endcase
  end
endmodule





