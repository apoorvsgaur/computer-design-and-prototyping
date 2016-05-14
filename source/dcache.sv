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
  caches_if.dcache cif //this is the one with the cc signals
);

logic [7:0] least_recently_used;
logic [31:0] hit_counter;

logic [7:0] next_least_recently_used;
logic [31:0] next_hit_counter;


logic [4:0] traverse_caches;
logic [4:0] next_traverse_caches;

logic way_0_dhit, way_1_dhit;


logic dmiss;
logic next_sw_miss_flag, sw_miss_flag;

dcachef_t snoopaddr;
assign snoopaddr = dcachef_t'(cif.ccsnoopaddr); //'


typedef enum bit [3:0] {IDLE_AKA_COMPARE_TAG, WRITE_BACK_LOWER_DATA, WRITE_BACK_UPPER_DATA,
                        STORE_LOWER_DATA, STORE_UPPER_DATA, SEND_CCWRITE_ON_SC_SNOOP,
                        FLUSH_DIRTY_TO_RAM, ACTUAL_HALT, SNOOP_WB_LOWER, SNOOP_WB_UPPER,
                        ALLOW_INVALIDATE_SNOOP_FOR_SWMISS
                       } statevalue;
statevalue current_state;
statevalue next_state;

assign dif.daddr = dcachef_t'(dcif.dmemaddr); //'sublime_text_exception_comment
assign dcif.dhit = (way_0_dhit | way_1_dhit);

always_ff @(posedge CLK, negedge nRST) begin
      if (nRST == 0) begin
        current_state <= IDLE_AKA_COMPARE_TAG;
        dif.way_0 <= '{default:0}; //'sublime_text_exception_comment
        dif.way_1 <= '{default:0}; //'
        least_recently_used <= '{default:0}; //'
        traverse_caches <= 0;
        sw_miss_flag <= 0;
        dif.valid_lr <= 0;
        dif.link_register <= 0;
      end
      else  begin
        dif.way_0 <= dif.next_way_0;
        dif.way_1 <= dif.next_way_1;
        least_recently_used <= next_least_recently_used;
        traverse_caches <= next_traverse_caches;
        current_state <= next_state;
        sw_miss_flag <= next_sw_miss_flag;
        dif.valid_lr <= dif.next_valid_lr;
        dif.link_register <= dif.next_link_register;
      end
    end

always_ff @(posedge CLK, negedge nRST)
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
    cif.cctrans = 0;
    cif.ccwrite = 0;
    next_sw_miss_flag = sw_miss_flag;

    dif.next_valid_lr = dif.valid_lr;
    dif.next_link_register = dif.link_register;
    case (current_state)
        IDLE_AKA_COMPARE_TAG:
        begin
          if (cif.ccwait == 1) begin //this cache needs to be snooped
              if ((dif.way_0[snoopaddr.idx].tag == snoopaddr.tag) && dif.way_0[snoopaddr.idx].valid) begin
                  cif.ccwrite = dif.way_0[snoopaddr.idx].dirty;

                  dif.next_way_0[snoopaddr.idx].valid = !cif.ccinv;

                  if (cif.ccinv)
                  begin
                      dif.next_way_0[snoopaddr.idx].dirty = 0;
                      //dif.next_way_0[snoopaddr.idx].tag = 0;
                      //dif.next_way_0[snoopaddr.idx].upper_d_data = 0;
                      //dif.next_way_0[snoopaddr.idx].lower_d_data = 0;
                  end

                  if (cif.ccwrite == 1) begin
                      next_state = SNOOP_WB_LOWER;
                  end
              end else if ((dif.way_1[snoopaddr.idx].tag == snoopaddr.tag) && dif.way_1[snoopaddr.idx].valid) begin
                  cif.ccwrite = dif.way_1[snoopaddr.idx].dirty;
                  dif.next_way_1[snoopaddr.idx].valid = !cif.ccinv;
                  if (cif.ccinv)
                  begin
                      dif.next_way_1[snoopaddr.idx].dirty = 0;
                      //dif.next_way_1[snoopaddr.idx].tag = 0;
                      //dif.next_way_1[snoopaddr.idx].upper_d_data = 0;
                     // dif.next_way_1[snoopaddr.idx].lower_d_data = 0;
                  end

                  if (cif.ccwrite == 1) begin
                      next_state = SNOOP_WB_LOWER;
                  end
              end
              cif.cctrans = 1;

              if((cif.ccsnoopaddr == dif.link_register) && cif.ccinv)
              begin
                 dif.next_valid_lr = 0;
              end
          end

          //Load-word hit on way_0
          else if ((dif.way_0[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_0[dif.daddr.idx].valid && dcif.dmemREN && !dcif.halt)
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

              if(dcif.datomic && dcif.dmemREN)
              begin
                  dif.next_link_register = dcif.dmemaddr;
                  dif.next_valid_lr = 1;
              end
          end

          //Load-word hit on way_1
          else if ((dif.way_1[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_1[dif.daddr.idx].valid && dcif.dmemREN && !dcif.halt)
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

              if(dcif.datomic && dcif.dmemREN)
              begin
                  dif.next_link_register = dcif.dmemaddr;
                  dif.next_valid_lr = 1;
              end
          end

          //Store-word hit on way_0
          else if ((dif.way_0[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_0[dif.daddr.idx].valid && dif.way_0[dif.daddr.idx].dirty && dcif.dmemWEN && !dcif.halt)
          begin
              way_0_dhit = 1;

              // IS IT SC ?
              if(dcif.datomic && dcif.dmemWEN)
              begin
                // YES, NOW IS IT CORRECT ADDR  AND VALID ?
                if((dcif.dmemaddr == dif.link_register) && dif.valid_lr)
                begin
                  // YES, NOW DO STUFF
                  dcif.dmemload = 1;
                  if (dif.daddr.blkoff == 0)
                  begin
                    dif.next_way_0[dif.daddr.idx].lower_d_data = dcif.dmemstore;
                  end
                  else if (dif.daddr.blkoff == 1)
                  begin
                    dif.next_way_0[dif.daddr.idx].upper_d_data = dcif.dmemstore;
                  end

                  next_least_recently_used[dif.daddr.idx] = 1;
                  next_hit_counter = hit_counter + 32'd1;
                  cif.dREN = 0;
                  cif.dWEN = 0;
                end
                else
                begin
                  dcif.dmemload = 0;
                end
              end
              // NO, IT IS NOT SC
              else
              begin
                // DO A STANDARD SW HIT
                if (dif.daddr.blkoff == 0)
                begin
                  dif.next_way_0[dif.daddr.idx].lower_d_data = dcif.dmemstore;
                end
                else if (dif.daddr.blkoff == 1)
                begin
                  dif.next_way_0[dif.daddr.idx].upper_d_data = dcif.dmemstore;
                end

                next_least_recently_used[dif.daddr.idx] = 1;
                next_hit_counter = hit_counter + 32'd1;
                cif.dREN = 0;
                cif.dWEN = 0;
              end

              // IF LINK REGISTER MATCH ON SW/SC, INVALIDATE LOCALLY
              if(dcif.dmemaddr == dif.link_register)
              begin
                  dif.next_valid_lr = 0;
              end
              // I THINK WE NEED TO DO A SNOOP TO INVALIDATE HERE ? ?

          end

          //Store-word hit on way_1
          else if ((dif.way_1[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_1[dif.daddr.idx].valid && dif.way_1[dif.daddr.idx].dirty && dcif.dmemWEN && !dcif.halt) //
          begin
              way_1_dhit = 1;

              // IS IT SC ?
              if(dcif.datomic && dcif.dmemWEN)
              begin
                if((dcif.dmemaddr == dif.link_register) && dif.valid_lr)
                begin
                  dcif.dmemload = 1;
                  if (dif.daddr.blkoff == 0)
                  begin
                    dif.next_way_1[dif.daddr.idx].lower_d_data = dcif.dmemstore;
                  end
                  else if (dif.daddr.blkoff == 1)
                  begin
                    dif.next_way_1[dif.daddr.idx].upper_d_data = dcif.dmemstore;
                  end
                  next_least_recently_used[dif.daddr.idx] = 0;
                  next_hit_counter = hit_counter + 32'd1;
                  cif.dREN = 0;
                  cif.dWEN = 0;
                end
                else
                begin
                  dcif.dmemload = 0;
                end
              end
              else
              begin
                if (dif.daddr.blkoff == 0)
                begin
                  dif.next_way_1[dif.daddr.idx].lower_d_data = dcif.dmemstore;
                end
                else if (dif.daddr.blkoff == 1)
                begin
                  dif.next_way_1[dif.daddr.idx].upper_d_data = dcif.dmemstore;
                end
                next_least_recently_used[dif.daddr.idx] = 0;
                next_hit_counter = hit_counter + 32'd1;
                cif.dREN = 0;
                cif.dWEN = 0;
              end

              if(dcif.dmemaddr == dif.link_register)
              begin
                  dif.next_valid_lr = 0;
              end
          end

          //Load-word miss and store-word miss
          else if ((dcif.dmemREN || dcif.dmemWEN) && !dcif.halt)
          begin
            next_hit_counter = hit_counter - 32'd1;
            dmiss = 1;

            // SC MISS
            if(dcif.datomic && dcif.dmemWEN)
            begin
                    //  IS SC MISS IS TOTALLY VALID ?
                    if((dcif.dmemaddr == dif.link_register) && dif.valid_lr)
                    begin
                        // YES
                        //dcif.dmemload = 1;

                        // WAS IT ONLY A PERMISSIONS MISS ?
                        if((dif.way_0[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_0[dif.daddr.idx].valid && dcif.dmemWEN)
                        begin
                          //way_0_dhit = 1;
                          /*if (dif.daddr.blkoff == 0)
                          begin
                            dif.next_way_0[dif.daddr.idx].lower_d_data = dcif.dmemstore;
                          end
                          else if (dif.daddr.blkoff == 1)
                          begin
                            dif.next_way_0[dif.daddr.idx].upper_d_data = dcif.dmemstore;
                          end
                          if (dif.daddr.blkoff == 1) begin
                            cif.daddr = dcif.dmemaddr - 4;
                          end else begin
                            cif.daddr = dcif.dmemaddr;
                          end
                          dif.next_way_0[dif.daddr.idx].dirty = 1;
                          next_least_recently_used[dif.daddr.idx] = 1;
                          cif.dREN = 1;*/
                          next_state = STORE_LOWER_DATA;
                        end
                        else if ((dif.way_1[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_1[dif.daddr.idx].valid && dcif.dmemWEN) //
                        begin

                          /*if (dif.daddr.blkoff == 0)
                          begin
                            dif.next_way_1[dif.daddr.idx].lower_d_data = dcif.dmemstore;
                          end
                          else if (dif.daddr.blkoff == 1)
                          begin
                            dif.next_way_1[dif.daddr.idx].upper_d_data = dcif.dmemstore;
                          end

                          if (dif.daddr.blkoff == 1) begin
                            cif.daddr = dcif.dmemaddr - 4;
                          end else begin
                            cif.daddr = dcif.dmemaddr;
                          end

                          next_least_recently_used[dif.daddr.idx] = 0;


                          dif.next_way_1[dif.daddr.idx].dirty = 1;
                          cif.dREN = 1;
                          cif.dWEN = 0;*/
                          next_state = STORE_LOWER_DATA;
                        end

                        // Store evicted data
                        else if (next_least_recently_used[dif.daddr.idx] == 0 && dif.next_way_0[dif.daddr.idx].dirty == 1 && dif.next_way_0[dif.daddr.idx].valid == 1)
                        begin
                            next_state = WRITE_BACK_LOWER_DATA;
                        end
                        else if (next_least_recently_used[dif.daddr.idx] == 1 && dif.next_way_1[dif.daddr.idx].dirty == 1 && dif.next_way_1[dif.daddr.idx].valid == 1)

                        begin
                            next_state = WRITE_BACK_LOWER_DATA;
                        end

                        // Read in the new data from memory
                        else
                        begin
                           next_state = STORE_LOWER_DATA;
                        end
                    end
                    else
                    begin
                        way_0_dhit = 1;
                        dcif.dmemload = 0;
                        next_state = IDLE_AKA_COMPARE_TAG;
                        cif.dREN = 0;
                        cif.dWEN = 0;
                    end
            end

            //SW and cache block is in shared state
            else if((dif.way_0[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_0[dif.daddr.idx].valid && dcif.dmemWEN && !dcif.halt)
            begin
              //way_0_dhit = 1;
              /*if (dif.daddr.blkoff == 0)
              begin
                dif.next_way_0[dif.daddr.idx].lower_d_data = dcif.dmemstore;
              end
              else if (dif.daddr.blkoff == 1)
              begin
                dif.next_way_0[dif.daddr.idx].upper_d_data = dcif.dmemstore;
              end

              next_least_recently_used[dif.daddr.idx] = 1;*/

              /*if (dif.daddr.blkoff == 1) begin
                cif.daddr = dcif.dmemaddr - 4;
              end else begin
                cif.daddr = dcif.dmemaddr;
              end*/

                /*cif.dREN = 1;
                dif.next_way_0[dif.daddr.idx].dirty = 1;*/
                next_state = STORE_LOWER_DATA; /////////////////////////////////////

            end
            else if ((dif.way_1[dif.daddr.idx].tag == dif.daddr.tag) && dif.way_1[dif.daddr.idx].valid && dcif.dmemWEN && !dcif.halt) //
            begin
              //way_1_dhit = 1;
              /*if (dif.daddr.blkoff == 0)
              begin
                dif.next_way_1[dif.daddr.idx].lower_d_data = dcif.dmemstore;
              end
              else if (dif.daddr.blkoff == 1)
              begin
                dif.next_way_1[dif.daddr.idx].upper_d_data = dcif.dmemstore;
              end

              next_least_recently_used[dif.daddr.idx] = 0;*/

              /*cif.dWEN = 0;
              if (dif.daddr.blkoff == 1) begin
                cif.daddr = dcif.dmemaddr - 4;
              end else begin
                cif.daddr = dcif.dmemaddr;
              end

                cif.dREN = 1;
                dif.next_way_1[dif.daddr.idx].dirty = 1;*/
                next_state = STORE_LOWER_DATA;

            end

            // Store evicted data
            else if (next_least_recently_used[dif.daddr.idx] == 0 && dif.next_way_0[dif.daddr.idx].dirty == 1 && dif.next_way_0[dif.daddr.idx].valid == 1 && !dcif.halt)
            begin
                next_state = WRITE_BACK_LOWER_DATA;
            end
            else if (next_least_recently_used[dif.daddr.idx] == 1 && dif.next_way_1[dif.daddr.idx].dirty == 1 && dif.next_way_1[dif.daddr.idx].valid == 1 && !dcif.halt)
            begin
                next_state = WRITE_BACK_LOWER_DATA;
            end

            // Read in the new data from memory
            else if (!dcif.halt)
            begin
               next_state = STORE_LOWER_DATA;
            end


            if (dcif.dmemWEN) begin
                next_sw_miss_flag = 1;
            end else begin
                next_sw_miss_flag = 0;
            end
          end

          // the program has halted
          else if (dcif.halt == 1)
          begin
              next_state = FLUSH_DIRTY_TO_RAM;
          end
        end

        ALLOW_INVALIDATE_SNOOP_FOR_SWMISS:
        begin
          cif.ccwrite = 1;
          //cif.dREN = 1;
          cif.cctrans = 0;
          dcif.dmemload = 1;
          //way_1_dhit = 1;
          next_state = IDLE_AKA_COMPARE_TAG;
        end

        SNOOP_WB_LOWER:
        begin
            if (dif.way_0[snoopaddr.idx].tag == snoopaddr.tag) begin
                cif.dstore = dif.way_0[snoopaddr.idx].lower_d_data;
            end else if (dif.way_1[snoopaddr.idx].tag == snoopaddr.tag) begin
                cif.dstore = dif.way_1[snoopaddr.idx].lower_d_data;
            end

            if(snoopaddr == 0)
            begin
              next_state = IDLE_AKA_COMPARE_TAG;
            end
            else if (cif.dwait == 0)
            begin
                  next_state = SNOOP_WB_UPPER;
            end
        end

        SNOOP_WB_UPPER:
        begin
            if (dif.way_0[snoopaddr.idx].tag == snoopaddr.tag) begin
                cif.dstore = dif.way_0[snoopaddr.idx].upper_d_data;
            end else if (dif.way_1[snoopaddr.idx].tag == snoopaddr.tag) begin
                cif.dstore = dif.way_1[snoopaddr.idx].upper_d_data;
            end

            if (cif.dwait == 0) begin
                if (dif.way_0[snoopaddr.idx].tag == snoopaddr.tag) begin
                  dif.next_way_0[snoopaddr.idx].dirty = 0;
                end else if (dif.way_1[snoopaddr.idx].tag == snoopaddr.tag) begin
                  dif.next_way_1[snoopaddr.idx].dirty = 0;
                end
                next_state = IDLE_AKA_COMPARE_TAG;
            end
        end

        WRITE_BACK_LOWER_DATA:
        begin
          cif.dWEN = 1;

          if (cif.ccwait == 1)
          begin
            next_state = IDLE_AKA_COMPARE_TAG;
          end
          else if ((least_recently_used[dif.daddr.idx] == 0) && (!dcif.halt)) //if the least recently used is way_0
          begin
              cif.daddr = {dif.way_0[dif.daddr.idx].tag, dif.daddr.idx, 3'b000};
              cif.dstore = dif.way_0[dif.daddr.idx].lower_d_data;
              //dif.next_way_0[dif.daddr.idx].dirty = 0;
              if(cif.dwait == 0)
              begin
                next_state = WRITE_BACK_UPPER_DATA;
              end
          end
          else if ((least_recently_used[dif.daddr.idx] == 1) && (!dcif.halt))//if the least recently used is way_1
          begin
              cif.daddr = {dif.way_1[dif.daddr.idx].tag, dif.daddr.idx, 3'b000};
              cif.dstore = dif.way_1[dif.daddr.idx].lower_d_data;
              //dif.next_way_1[dif.daddr.idx].dirty = 0;
              if(cif.dwait == 0)
              begin
                next_state = WRITE_BACK_UPPER_DATA;
              end
          end
          else
          begin
            if ((traverse_caches) < 8)
            begin
              cif.daddr = {dif.way_0[traverse_caches].tag, (traverse_caches[2:0]), 3'b000};
              cif.dstore = dif.way_0[traverse_caches].lower_d_data;
              //dif.next_way_0[traverse_caches].dirty = 0;
            end
            else
            begin
                cif.daddr = {dif.way_1[traverse_caches % 8].tag, (traverse_caches[2:0] ), 3'b000};
                cif.dstore = dif.way_1[traverse_caches % 8].lower_d_data;
                //dif.next_way_0[traverse_caches].dirty = 0;
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

          if (cif.ccwait == 1)
          begin
            next_state = IDLE_AKA_COMPARE_TAG;
          end
          else if ((least_recently_used[dif.daddr.idx] == 0) && (!dcif.halt)) //if the least recently used is way_0
          begin
              cif.daddr = {dif.way_0[dif.daddr.idx].tag, dif.daddr.idx, 3'b100};
              cif.dstore = dif.way_0[dif.daddr.idx].upper_d_data;
              dif.next_way_0[dif.daddr.idx].dirty = 0;
              if(cif.dwait == 0)
              begin
                next_state = STORE_LOWER_DATA;
              end
          end
          else if ((least_recently_used[dif.daddr.idx] == 1) && (!dcif.halt))//if the least recently used is way_1
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
          //cif.cctrans = 1;

          if (dif.daddr.blkoff == 1) begin
            cif.daddr = dcif.dmemaddr - 4;
          end else begin
            cif.daddr = dcif.dmemaddr;
          end


          if (sw_miss_flag == 1) begin
              cif.ccwrite = 1;
          end else begin
              cif.ccwrite = 0;
          end

          if (cif.ccwait == 1)
          begin
            next_state = IDLE_AKA_COMPARE_TAG;
          end
          else if (least_recently_used[dif.daddr.idx] == 1 && dif.way_0[dif.daddr.idx].valid)
          begin
              if(cif.dwait == 0)
              begin
                dif.next_way_0[dif.daddr.idx].lower_d_data = cif.dload;
                dif.next_way_0[dif.daddr.idx].tag = dif.daddr.tag;
                next_state = STORE_UPPER_DATA;
              end
          end
          else if (least_recently_used[dif.daddr.idx] == 0 && dif.way_1[dif.daddr.idx].valid)
          begin
              if(cif.dwait == 0)
              begin                
                dif.next_way_1[dif.daddr.idx].lower_d_data = cif.dload;
                dif.next_way_1[dif.daddr.idx].tag = dif.daddr.tag;
                next_state = STORE_UPPER_DATA;
              end
          end
          else if (least_recently_used[dif.daddr.idx] == 0)
          begin
              if(cif.dwait == 0)
              begin
                dif.next_way_0[dif.daddr.idx].lower_d_data = cif.dload;
                dif.next_way_0[dif.daddr.idx].tag = dif.daddr.tag;
                next_state = STORE_UPPER_DATA;
              end
          end
          else if (least_recently_used[dif.daddr.idx] == 1) 
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
          cif.cctrans = 1;

          if (dif.daddr.blkoff == 1) begin
            cif.daddr = dcif.dmemaddr;
          end else begin
            cif.daddr = dcif.dmemaddr + 32'd4;
          end

          if (cif.ccwait == 1)
          begin
            next_state = IDLE_AKA_COMPARE_TAG;
          end
          else if (least_recently_used[dif.daddr.idx] == 1 && dif.way_0[dif.daddr.idx].valid)
          begin
              if(cif.dwait == 0)
              begin
                dif.next_way_0[dif.daddr.idx].upper_d_data = cif.dload;
                dif.next_way_0[dif.daddr.idx].tag = dif.daddr.tag;
                dif.next_way_0[dif.daddr.idx].valid = 1;

                if (sw_miss_flag == 1) begin //sw_miss_flag was 1
                  dif.next_way_0[dif.daddr.idx].dirty = 1;
                end

                next_state = IDLE_AKA_COMPARE_TAG;
              end
          end
          else if (least_recently_used[dif.daddr.idx] == 0 && dif.way_1[dif.daddr.idx].valid)
          begin
              if(cif.dwait == 0)
              begin
                dif.next_way_1[dif.daddr.idx].upper_d_data = cif.dload;
                dif.next_way_1[dif.daddr.idx].tag = dif.daddr.tag;
                dif.next_way_1[dif.daddr.idx].valid = 1;

                if (sw_miss_flag == 1) begin //sw_miss_flag was 1
                  dif.next_way_1[dif.daddr.idx].dirty = 1;
                end

                next_state = IDLE_AKA_COMPARE_TAG;
              end
          end
          else if(least_recently_used[dif.daddr.idx] == 0)
          begin
              if(cif.dwait == 0)
              begin
                dif.next_way_0[dif.daddr.idx].upper_d_data = cif.dload;
                dif.next_way_0[dif.daddr.idx].tag = dif.daddr.tag;
                dif.next_way_0[dif.daddr.idx].valid = 1;

                if (sw_miss_flag == 1) begin //sw_miss_flag was 1
                  dif.next_way_0[dif.daddr.idx].dirty = 1;
                end

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

                if (sw_miss_flag == 1) begin //sw_miss_flag was 1
                  dif.next_way_1[dif.daddr.idx].dirty = 1;
                end

                next_state = IDLE_AKA_COMPARE_TAG;
              end
          end
        end

        FLUSH_DIRTY_TO_RAM:
        begin
          if (cif.ccwait == 1)
          begin
            next_state = IDLE_AKA_COMPARE_TAG;
          end
          else if (traverse_caches < 8)
          begin
              if(dif.next_way_0[traverse_caches].dirty == 1)
              begin
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
                next_state = WRITE_BACK_LOWER_DATA;
              end
              else
              begin
                   next_traverse_caches = traverse_caches + 1;
              end
          end
          else if (traverse_caches == 16)
          begin
            next_state = ACTUAL_HALT;
          end
        end

        ACTUAL_HALT:
        begin
          dcif.flushed = 1;
          next_state = ACTUAL_HALT;
          if (cif.ccwait == 1)
          begin
            next_state = IDLE_AKA_COMPARE_TAG;
          end 
        end
    endcase
  end

/*always_comb
begin: LLSC
  dif.next_valid_lr = dif.valid_lr;
  dif.next_link_register = dif.link_register;
  if(dcif.datomic && dcif.dmemREN)
  begin
      dif.next_link_register = dcif.dmemaddr;
      dif.next_valid_lr = 1;
  end
  if(dcif.dmemWEN)
  begin
    if(dcif.dmemaddr == dif.link_register)
    begin
      dif.next_valid_lr = 0;
    end
  end
  if((cif.ccsnoopaddr == dif.link_register) && cif.ccinv && cif.ccwait)
  begin
     dif.next_valid_lr = 0;
  end
end*/

endmodule
