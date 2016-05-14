onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/syif/halt
add wave -noupdate -divider {PC LOGIC}
add wave -noupdate /system_tb/DUT/CPU/DP/pc
add wave -noupdate /system_tb/DUT/CPU/DP/pcn
add wave -noupdate /system_tb/DUT/CPU/DP/PCsrc
add wave -noupdate /system_tb/DUT/CPU/DP/pc4
add wave -noupdate /system_tb/DUT/CPU/DP/branch_addr
add wave -noupdate -divider {I/D LOGIC}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[1]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[2]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[3]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[4]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[5]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[6]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[7]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[8]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[9]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[10]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[11]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[12]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[13]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[15]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[16]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[17]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[18]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[19]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[20]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[21]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[22]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[24]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[25]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[29]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[30]}
add wave -noupdate -expand -group Registers {/system_tb/DUT/CPU/DP/RF/registers[31]}
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/branch
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/jump
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/i_type
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/r_opcode
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/aluop
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ALUsrc
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/RegWrite
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/back_pad
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/r_type
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/CU/cuif/halt
add wave -noupdate -expand -group rfif -radix unsigned /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -expand -group rfif -radix unsigned /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -expand -group rfif -radix unsigned /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/z_flag
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/port_a
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/port_b
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/port_o
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/opcode
add wave -noupdate -expand -group fuif /system_tb/DUT/CPU/DP/fuif/exmem_wsel_out
add wave -noupdate -expand -group fuif /system_tb/DUT/CPU/DP/fuif/memwb_wsel_out
add wave -noupdate -expand -group fuif /system_tb/DUT/CPU/DP/fuif/idex_rs_out
add wave -noupdate -expand -group fuif /system_tb/DUT/CPU/DP/fuif/idex_rt_out
add wave -noupdate -expand -group fuif /system_tb/DUT/CPU/DP/fuif/exmem_RegWrite_out
add wave -noupdate -expand -group fuif /system_tb/DUT/CPU/DP/fuif/memwb_RegWrite_out
add wave -noupdate -expand -group fuif /system_tb/DUT/CPU/DP/fuif/fwenb_a
add wave -noupdate -expand -group fuif /system_tb/DUT/CPU/DP/fuif/fwenb_b
add wave -noupdate /system_tb/DUT/CPU/DP/fuif/i_type
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/idex_rt_out
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/ifid_rt_out
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/ifid_rs_out
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/idex_dREN_out
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/idex_dWEN_out
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/PCsrc
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/pc_enable
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/flush
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/ifid_pause
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/exmem_enable
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/prif/ifid_instr_out
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/prif/ifid_pc_out
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/prif/ifid_pc4_out
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/prif/ifid_enable
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/prif/ifid_flush
add wave -noupdate -expand -group IDEX -radix binary /system_tb/DUT/CPU/DP/prif/idex_instr_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_i_type_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_r_opcode_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_r_type_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_shamt_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_ALUsrc_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_aluop_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_dREN_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_dWEN_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_branch_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_jump_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_MemtoReg_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_RegWrite_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_ExtImm16_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_pc_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_pc4_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_jraddr_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_rdat1_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_rdat2_out
add wave -noupdate -expand -group IDEX -radix unsigned /system_tb/DUT/CPU/DP/prif/idex_rs_out
add wave -noupdate -expand -group IDEX -radix unsigned /system_tb/DUT/CPU/DP/prif/idex_rt_out
add wave -noupdate -expand -group IDEX -radix unsigned /system_tb/DUT/CPU/DP/prif/idex_wsel_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_halt_out
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_enable
add wave -noupdate -expand -group IDEX /system_tb/DUT/CPU/DP/prif/idex_flush
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_instr_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_port_o_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_rdat2_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_dREN_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_dWEN_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_jump_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_MemtoReg_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_RegWrite_out
add wave -noupdate -group EXMEM -radix unsigned /system_tb/DUT/CPU/DP/prif/exmem_wsel_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_halt_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_pcn_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_enable
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/prif/exmem_flush
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/wdat
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/prif/memwb_instr_out
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/prif/memwb_data_out
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/prif/memwb_port_o_out
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/prif/memwb_MemtoReg_out
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/prif/memwb_RegWrite_out
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/prif/memwb_wsel_out
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/prif/memwb_halt_out
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/prif/memwb_pcn_out
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/prif/memwb_enable
add wave -noupdate -expand -group MEMWB /system_tb/DUT/CPU/DP/prif/memwb_flush
add wave -noupdate /system_tb/CLK
add wave -noupdate -group Instr /system_tb/DUT/CPU/DP/prif/ifid_instr_out
add wave -noupdate -group Instr /system_tb/DUT/CPU/DP/prif/idex_instr_out
add wave -noupdate -group Instr /system_tb/DUT/CPU/DP/prif/exmem_instr_out
add wave -noupdate -group Instr /system_tb/DUT/CPU/DP/prif/memwb_instr_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1936101 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
configure wave -valuecolwidth 84
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1607400 ps} {2453400 ps}
