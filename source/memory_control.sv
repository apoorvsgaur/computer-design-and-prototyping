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

  logic next_N, current_N;             //N - Not Serviced/Cache that you are getting value from
  logic previous_S, current_S, next_S; //S - Serviced/Cache that you are giving value to

  word_t [CPUS-1:0] next_ccsnoopaddr, current_ccsnoopaddr;

  dcachef_t temp_snoopaddr;
  assign temp_snoopaddr = dcachef_t'(ccif.ccsnoopaddr[current_N]); //'

  typedef enum bit [3:0] {IDLE, SNOOP_WHEN_DREN, READ_LOWER_MEM_TO_CACHE_ON_MISS_FROM_SNOOP,
                          READ_UPPER_MEM_TO_CACHE_ON_MISS_FROM_SNOOP,
                          WRITE_LOWER_CACHE_TO_MEM_ON_HIT_FROM_SNOOP,
                          WRITE_UPPER_CACHE_TO_MEM_ON_HIT_FROM_SNOOP,
                          INSTRUCTION_HANDLING, WRITE_LOWER_TO_EVICT_FROM_MODIFIED_CACHE,
                          WRITE_UPPER_TO_EVICT_FROM_MODIFIED_CACHE
                         } statevalue;
  statevalue current_state;
  statevalue next_state;

  assign ccif.ccsnoopaddr = current_ccsnoopaddr;

  always_ff @(posedge CLK, negedge nRST)
  begin: NEXT_STATE_LOGIC
    if (nRST == 0)
    begin
      current_state <= IDLE;
      previous_S <= 0;
      current_S <= 0;
      current_N <= 0;
      current_ccsnoopaddr[CPUS-1:0] <= '{default:0}; //'
    end
    else
    begin
      current_state <= next_state;
      current_S <= next_S;
      previous_S <= current_S;
      current_N <= next_N;
      current_ccsnoopaddr[0] <= next_ccsnoopaddr[0];
      current_ccsnoopaddr[1] <= next_ccsnoopaddr[1];
    end
  end


  always_comb
  begin: COHERENCE_CONTROLLER
    next_state = current_state;
    next_S = current_S;
    next_N = current_N;
    next_ccsnoopaddr[0] = current_ccsnoopaddr[0];
    next_ccsnoopaddr[1] = current_ccsnoopaddr[1];
    ccif.iwait[0] = 1;
    ccif.iwait[1] = 1;
    ccif.dwait[0] = 1;
    ccif.dwait[1] = 1;
    ccif.ramWEN = 0;
    ccif.ramREN = 0;
    ccif.iload[0] = 0;
    ccif.iload[1] = 0;
    ccif.dload[0] = 0;
    ccif.dload[1] = 0;
    ccif.ramaddr = 0;
    ccif.ramstore = 0;
    ccif.ccinv = 0;
    ccif.ccwait[0] = 0;
    ccif.ccwait[1] = 0;
    casez(current_state)

    IDLE:
    begin
      if(ccif.dWEN[0])
      begin
        next_state = WRITE_LOWER_TO_EVICT_FROM_MODIFIED_CACHE;
        next_S = 0;
        next_N = 1;
      end

      else if (ccif.dWEN[1])
      begin
        next_state = WRITE_LOWER_TO_EVICT_FROM_MODIFIED_CACHE;
        next_S = 1;
        next_N = 0;
      end

      else if (ccif.dREN[0])
      begin
        next_state = SNOOP_WHEN_DREN;
        next_S = 0;
        next_N = 1;
        next_ccsnoopaddr[next_N] = ccif.daddr[next_S];
      end

      else if (ccif.dREN[1])
      begin
        next_state = SNOOP_WHEN_DREN;
        next_S = 1;
        next_N = 0;
        next_ccsnoopaddr[next_N] = ccif.daddr[next_S];
      end

      else if (ccif.iREN[0] || ccif.iREN[1])
      begin
        if ((previous_S == 0) && (ccif.iREN[0] & ccif.iREN[1]))
        begin
          next_S = 1;
        end

        else if ((previous_S == 1) && (ccif.iREN[0] & ccif.iREN[1]))
        begin
          next_S = 0;
        end

        else if(ccif.iREN[0])
        begin
          next_S = 0;
        end

        else if (ccif.iREN[1])
        begin
          next_S = 1;
        end


        next_state = INSTRUCTION_HANDLING;
      end
    end

    INSTRUCTION_HANDLING:
    begin
      ccif.ramaddr = ccif.iaddr[current_S];
      ccif.iload[current_S] = ccif.ramload;
      ccif.iwait[current_S] = ~(ccif.ramstate == ACCESS);
      ccif.ramREN = ccif.iREN[current_S];
      if(ccif.iwait[current_S] == 0)
      begin
        next_state = IDLE;
      end
    end


    SNOOP_WHEN_DREN:
    begin
       ccif.ccwait[current_N] = 1; //Signal to tell the dcache of the not being serviced processor to check if a desired address is in it or not
       ccif.dwait[current_S] = 1; //Signal telling the serviced cache to wait, because the data isn't ready yet.

       if (ccif.ccwrite[current_S] == 1) //ccwrite does two things:
       begin                             //ccwrite in S, I want to write to address, so I'm going to invalid with the same address in the other cache
          ccif.ccinv[current_N] = 1;
       end

       if (ccif.dREN[current_S] == 0) begin
          next_state = IDLE;
       end

       else if(ccif.cctrans[current_N] & ccif.ccwrite[current_N]) //ccwrite in N, I was writing to address, so I'm going to do a cache-to-cache transfer from my cache to S and cache-to-memory writeback
       begin
          next_state = WRITE_LOWER_CACHE_TO_MEM_ON_HIT_FROM_SNOOP; //cctrans enables changes in MSI, specifically I -> S, S -> M, I -> M
       end

       else if (ccif.cctrans[current_N] == 1 & ccif.ccwrite[current_N] == 0)
       begin
          next_state = READ_LOWER_MEM_TO_CACHE_ON_MISS_FROM_SNOOP;
       end

       /*if (ccif.cctrans[current_S] == 0 & ccif.ccwrite[current_S] == 1)
       begin
          next_ccsnoopaddr[current_N] = 0;
       end*/
    end

    READ_LOWER_MEM_TO_CACHE_ON_MISS_FROM_SNOOP:
    begin
        ccif.ramaddr = ccif.daddr[current_S];
        ccif.ramREN = 1;
        ccif.dload[current_S] = ccif.ramload;
        ccif.dwait[current_S] = ~(ccif.ramstate == ACCESS);
        ccif.dwait[current_N] = 1;
        ccif.ccwait[current_N] = 0;
      
        if(ccif.dwait[current_S] == 0)
        begin
          next_state = READ_UPPER_MEM_TO_CACHE_ON_MISS_FROM_SNOOP;
        end

    end

    READ_UPPER_MEM_TO_CACHE_ON_MISS_FROM_SNOOP:
    begin
        ccif.ramaddr = ccif.daddr[current_S];
        ccif.ramREN = 1;
        ccif.dload[current_S] = ccif.ramload;
        ccif.dwait[current_S] = ~(ccif.ramstate == ACCESS);
        ccif.dwait[current_N] = 1;
        if(ccif.dwait[current_S] == 0)
        begin
          next_state = IDLE;
        end
    end

    WRITE_LOWER_CACHE_TO_MEM_ON_HIT_FROM_SNOOP:
    begin
        //  if dcachef_t'(ccif.ccsnoopaddr[current_N]) //'sublime text exception comment
        if (temp_snoopaddr.blkoff == 1) begin //'sublime text exception comment
            ccif.ramaddr = ccif.ccsnoopaddr[current_N] - 4;
        end else begin
            ccif.ramaddr = ccif.ccsnoopaddr[current_N];
        end
       ccif.ramWEN = 1;
       ccif.ramstore = ccif.dstore[current_N];
       ccif.dwait[current_N] = ~(ccif.ramstate == ACCESS);
       ccif.dwait[current_S] = ~(ccif.ramstate == ACCESS);
       ccif.dload[current_S] = ccif.dstore[current_N];
       ccif.ccwait[current_N] = 0;
        if(ccif.dwait[current_N] == 0)
        begin
          next_state = WRITE_UPPER_CACHE_TO_MEM_ON_HIT_FROM_SNOOP;
        end
    end

    WRITE_UPPER_CACHE_TO_MEM_ON_HIT_FROM_SNOOP:
    begin
       if (temp_snoopaddr.blkoff == 1) begin //'sublime text exception comment
            ccif.ramaddr = ccif.ccsnoopaddr[current_N];
       end else begin
            ccif.ramaddr = ccif.ccsnoopaddr[current_N] + 32'd4;
       end
       ccif.ramWEN = 1;
       ccif.ramstore = ccif.dstore[current_N];
       ccif.dwait[current_N] = ~(ccif.ramstate == ACCESS);
       ccif.dwait[current_S] = ~(ccif.ramstate == ACCESS);
       ccif.dload[current_S] = ccif.dstore[current_N];
       ccif.ccwait[current_N] = 0;
       if(ccif.dwait[current_N] == 0)
       begin
          next_state = IDLE;
       end
    end

    WRITE_LOWER_TO_EVICT_FROM_MODIFIED_CACHE:
    begin
      ccif.ramaddr = ccif.daddr[current_S];
      ccif.ramWEN = 1;
      ccif.ramstore = ccif.dstore[current_S];
      ccif.dwait[current_S] = ~(ccif.ramstate == ACCESS);
      if(ccif.dwait[current_S] == 0)
      begin
        next_state = WRITE_UPPER_TO_EVICT_FROM_MODIFIED_CACHE;
      end
    end

    WRITE_UPPER_TO_EVICT_FROM_MODIFIED_CACHE:
    begin
       ccif.ramaddr = ccif.daddr[current_S];
       ccif.ramWEN = 1;
       ccif.ramstore = ccif.dstore[current_S];
       ccif.dwait[current_S] = ~(ccif.ramstate == ACCESS);
       if(ccif.dwait[current_S] == 0)
       begin
          next_ccsnoopaddr[current_N] = ccif.daddr[current_S];
          next_state = IDLE;
       end
    end

    endcase
  end

endmodule
