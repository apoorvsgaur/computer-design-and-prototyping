onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -group CIF0 /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/iwait
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/dwait
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/iREN
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/dREN
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/dWEN
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/iload
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/dload
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/dstore
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/iaddr
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/daddr
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/ccwait
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/ccinv
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/ccwrite
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/cctrans
add wave -noupdate -group CIF1 /system_tb/DUT/CPU/cif1/ccsnoopaddr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/CLK
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/nRST
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/pc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/pcn
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/branch_addr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/jaddr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/pc4
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/wdat
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/PCsrc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/mem_pc_enable
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/dpif/halt
add wave -noupdate -expand -group DP0 -expand /system_tb/DUT/CPU/DP0/RF/registers
add wave -noupdate -expand -group DP0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/exmem_wsel_out
add wave -noupdate -expand -group DP0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/memwb_wsel_out
add wave -noupdate -expand -group DP0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/idex_rs_out
add wave -noupdate -expand -group DP0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/idex_rt_out
add wave -noupdate -expand -group DP0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/exmem_RegWrite_out
add wave -noupdate -expand -group DP0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/memwb_RegWrite_out
add wave -noupdate -expand -group DP0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/i_type
add wave -noupdate -expand -group DP0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/fwenb_a
add wave -noupdate -expand -group DP0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/fwenb_b
add wave -noupdate -expand -group DP0 -group ALU0 /system_tb/DUT/CPU/DP0/aif/port_a
add wave -noupdate -expand -group DP0 -group ALU0 /system_tb/DUT/CPU/DP0/aif/port_b
add wave -noupdate -expand -group DP0 -group ALU0 /system_tb/DUT/CPU/DP0/aif/port_o
add wave -noupdate -expand -group DP0 -group ALU0 /system_tb/DUT/CPU/DP0/aif/opcode
add wave -noupdate -expand -group DP0 -group ALU0 /system_tb/DUT/CPU/DP0/aif/neg_flag
add wave -noupdate -expand -group DP0 -group ALU0 /system_tb/DUT/CPU/DP0/aif/of_flag
add wave -noupdate -expand -group DP0 -group ALU0 /system_tb/DUT/CPU/DP0/aif/z_flag
add wave -noupdate -expand -group DP0 -group ALU0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/exmem_wsel_out
add wave -noupdate -expand -group DP0 -group ALU0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/memwb_wsel_out
add wave -noupdate -expand -group DP0 -group ALU0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/idex_rs_out
add wave -noupdate -expand -group DP0 -group ALU0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/idex_rt_out
add wave -noupdate -expand -group DP0 -group ALU0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/exmem_RegWrite_out
add wave -noupdate -expand -group DP0 -group ALU0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/memwb_RegWrite_out
add wave -noupdate -expand -group DP0 -group ALU0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/i_type
add wave -noupdate -expand -group DP0 -group ALU0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/fwenb_a
add wave -noupdate -expand -group DP0 -group ALU0 -group {(Core 1) Forwarding Unit} /system_tb/DUT/CPU/DP0/fuif/fwenb_b
add wave -noupdate -expand -group DP0 -expand -group INSTRUCTIONS0 /system_tb/DUT/CPU/DP0/prif/ifid_instr_out
add wave -noupdate -expand -group DP0 -expand -group INSTRUCTIONS0 /system_tb/DUT/CPU/DP0/prif/idex_instr_out
add wave -noupdate -expand -group DP0 -expand -group INSTRUCTIONS0 /system_tb/DUT/CPU/DP0/prif/exmem_instr_out
add wave -noupdate -expand -group DP0 -expand -group INSTRUCTIONS0 /system_tb/DUT/CPU/DP0/prif/memwb_instr_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IFID0 /system_tb/DUT/CPU/DP0/prif/ifid_instr_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IFID0 /system_tb/DUT/CPU/DP0/prif/ifid_instr_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IFID0 /system_tb/DUT/CPU/DP0/prif/ifid_pc_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IFID0 /system_tb/DUT/CPU/DP0/prif/ifid_pc_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IFID0 /system_tb/DUT/CPU/DP0/prif/ifid_pc4_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IFID0 /system_tb/DUT/CPU/DP0/prif/ifid_pc4_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IFID0 /system_tb/DUT/CPU/DP0/prif/ifid_enable
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IFID0 /system_tb/DUT/CPU/DP0/prif/ifid_flush
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_instr_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_instr_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_r_opcode_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_r_opcode_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_r_type_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_r_type_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_shamt_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_shamt_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_ALUsrc_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_ALUsrc_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_aluop_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_aluop_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_dREN_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_dREN_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_dWEN_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_dWEN_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_branch_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_branch_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_jump_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_jump_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_MemtoReg_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_MemtoReg_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_RegWrite_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_RegWrite_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_ExtImm16_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_ExtImm16_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_pc_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_pc_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_pc4_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_pc4_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_jraddr_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_jraddr_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_rdat1_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_rdat1_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_rdat2_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_rdat2_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_rs_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_rs_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_rt_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_rt_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_wsel_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_wsel_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_halt_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_halt_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_i_type_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_i_type_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_enable
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group IDEX0 /system_tb/DUT/CPU/DP0/prif/idex_flush
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_instr_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_instr_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_port_o_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_port_o_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_rdat2_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_rdat2_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_pcn_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_pcn_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_dREN_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_dREN_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_dWEN_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_dWEN_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_MemtoReg_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_MemtoReg_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_RegWrite_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_RegWrite_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_wsel_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_wsel_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_halt_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_halt_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_jump_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_jump_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_enable
add wave -noupdate -expand -group DP0 -group PIPELINE0 -expand -group EXMEM0 /system_tb/DUT/CPU/DP0/prif/exmem_flush
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_instr_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_instr_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_data_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_data_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_port_o_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_port_o_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_pcn_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_pcn_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_MemtoReg_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_MemtoReg_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_RegWrite_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_RegWrite_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_wsel_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_wsel_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_halt_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_halt_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_jump_in
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_jump_out
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_enable
add wave -noupdate -expand -group DP0 -group PIPELINE0 -group MEMWB0 /system_tb/DUT/CPU/DP0/prif/memwb_flush
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/halt
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/ihit
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/imemREN
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/imemload
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/imemaddr
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/dhit
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/datomic
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/dmemREN
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/dmemWEN
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/flushed
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/dmemload
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/dmemstore
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) dpif} /system_tb/DUT/CPU/DP1/dpif/dmemaddr
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/CLK
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/nRST
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/pc
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/pcn
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/branch_addr
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/jaddr
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/pc4
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/wdat
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/PCsrc
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/mem_pc_enable
add wave -noupdate -group {(Core 2)Datapath} /system_tb/DUT/CPU/DP1/dpif/halt
add wave -noupdate -group {(Core 2)Datapath} -expand /system_tb/DUT/CPU/DP1/RF/registers
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/r_opcode
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/opcode
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/aluop
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/RegDst
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/dREN
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/MemtoReg
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/dWEN
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/ALUsrc
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/RegWrite
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/ExtOp
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/back_pad
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/r_type
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/halt
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/i_type
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/datomic
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/branch
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/jump
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/instr
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Control Unit} /system_tb/DUT/CPU/DP1/CU/cuif/shamt
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Register File} /system_tb/DUT/CPU/DP1/rfif/WEN
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Register File} /system_tb/DUT/CPU/DP1/rfif/wsel
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Register File} /system_tb/DUT/CPU/DP1/rfif/rsel1
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Register File} /system_tb/DUT/CPU/DP1/rfif/rsel2
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Register File} /system_tb/DUT/CPU/DP1/rfif/wdat
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Register File} /system_tb/DUT/CPU/DP1/rfif/rdat1
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Register File} /system_tb/DUT/CPU/DP1/rfif/rdat2
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Forwarding Unit} /system_tb/DUT/CPU/DP1/fuif/exmem_wsel_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Forwarding Unit} /system_tb/DUT/CPU/DP1/fuif/memwb_wsel_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Forwarding Unit} /system_tb/DUT/CPU/DP1/fuif/idex_rs_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Forwarding Unit} /system_tb/DUT/CPU/DP1/fuif/idex_rt_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Forwarding Unit} /system_tb/DUT/CPU/DP1/fuif/exmem_RegWrite_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Forwarding Unit} /system_tb/DUT/CPU/DP1/fuif/memwb_RegWrite_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Forwarding Unit} /system_tb/DUT/CPU/DP1/fuif/i_type
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Forwarding Unit} /system_tb/DUT/CPU/DP1/fuif/fwenb_a
add wave -noupdate -group {(Core 2)Datapath} -group {(Core 2) Forwarding Unit} /system_tb/DUT/CPU/DP1/fuif/fwenb_b
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) ALU} /system_tb/DUT/CPU/DP1/aif/port_a
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) ALU} /system_tb/DUT/CPU/DP1/aif/port_b
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) ALU} /system_tb/DUT/CPU/DP1/aif/port_o
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) ALU} /system_tb/DUT/CPU/DP1/aif/opcode
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) ALU} /system_tb/DUT/CPU/DP1/aif/neg_flag
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) ALU} /system_tb/DUT/CPU/DP1/aif/of_flag
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) ALU} /system_tb/DUT/CPU/DP1/aif/z_flag
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Instructions} /system_tb/DUT/CPU/DP1/prif/ifid_instr_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Instructions} /system_tb/DUT/CPU/DP1/prif/idex_instr_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Instructions} /system_tb/DUT/CPU/DP1/prif/exmem_instr_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Instructions} /system_tb/DUT/CPU/DP1/prif/memwb_instr_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IFID1 /system_tb/DUT/CPU/DP1/prif/ifid_instr_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IFID1 /system_tb/DUT/CPU/DP1/prif/ifid_instr_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IFID1 /system_tb/DUT/CPU/DP1/prif/ifid_pc_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IFID1 /system_tb/DUT/CPU/DP1/prif/ifid_pc_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IFID1 /system_tb/DUT/CPU/DP1/prif/ifid_pc4_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IFID1 /system_tb/DUT/CPU/DP1/prif/ifid_pc4_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IFID1 /system_tb/DUT/CPU/DP1/prif/ifid_enable
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IFID1 /system_tb/DUT/CPU/DP1/prif/ifid_flush
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_instr_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_instr_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_r_opcode_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_r_opcode_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_r_type_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_r_type_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_shamt_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_shamt_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_ALUsrc_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_ALUsrc_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_aluop_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_aluop_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_dREN_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_dREN_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_dWEN_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_dWEN_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_branch_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_branch_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_jump_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_jump_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_MemtoReg_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_MemtoReg_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_RegWrite_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_RegWrite_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_ExtImm16_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_ExtImm16_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_pc_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_pc_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_pc4_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_pc4_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_jraddr_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_jraddr_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_rdat1_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_rdat1_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_rdat2_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_rdat2_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_rs_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_rs_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_rt_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_rt_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_wsel_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_wsel_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_halt_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_halt_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_i_type_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_i_type_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_enable
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group IDEX1 /system_tb/DUT/CPU/DP1/prif/idex_flush
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_instr_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_instr_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_port_o_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_port_o_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_rdat2_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_rdat2_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_pcn_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_pcn_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_dREN_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_dREN_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_dWEN_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_dWEN_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_MemtoReg_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_MemtoReg_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_RegWrite_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_RegWrite_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_wsel_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_wsel_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_halt_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_halt_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_jump_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_jump_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_enable
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group EXMEM1 /system_tb/DUT/CPU/DP1/prif/exmem_flush
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_instr_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_instr_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_data_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_data_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_port_o_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_port_o_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_pcn_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_pcn_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_MemtoReg_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_MemtoReg_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_RegWrite_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_RegWrite_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_wsel_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_wsel_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_halt_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_halt_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_jump_in
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_jump_out
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_enable
add wave -noupdate -group {(Core 2)Datapath} -group {(Core2) Pipeline} -group MEMWB1 /system_tb/DUT/CPU/DP1/prif/memwb_flush
add wave -noupdate -expand -group CM0 -group ICACHE /system_tb/DUT/CPU/CM0/iif/pc
add wave -noupdate -expand -group CM0 -group ICACHE /system_tb/DUT/CPU/CM0/iif/way_0
add wave -noupdate -expand -group CM0 -group ICACHE /system_tb/DUT/CPU/CM0/iif/next_way_0
add wave -noupdate -expand -group CM0 -group ICACHE /system_tb/DUT/CPU/CM0/ICACHE/current_state
add wave -noupdate -expand -group CM0 -group ICACHE /system_tb/DUT/CPU/CM0/ICACHE/next_state
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -expand -group CM0 -group DCIF0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/dif/link_register
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/dif/next_link_register
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/dif/next_valid_lr
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/dif/valid_lr
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/DP0/prif/exmem_datomic_out
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/DP0/prif/exmem_dWEN_out
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/DP0/prif/exmem_dREN_out
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/DP0/dpif/dmemload
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/dif/daddr
add wave -noupdate -expand -group CM0 -expand -group DCACHE -expand -subitemconfig {{/system_tb/DUT/CPU/CM0/dif/way_0[1]} -expand} /system_tb/DUT/CPU/CM0/dif/way_0
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/dif/way_1
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/dif/next_way_0
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/dif/next_way_1
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/least_recently_used
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/hit_counter
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/next_least_recently_used
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/next_hit_counter
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/traverse_caches
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/next_traverse_caches
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/way_0_dhit
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/way_1_dhit
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/dmiss
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/next_sw_miss_flag
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/sw_miss_flag
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/snoopaddr
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/current_state
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -expand -group CM0 -expand -group DCACHE /system_tb/DUT/CPU/CM0/DCACHE/dcif/flushed
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/dif/link_register
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/DP1/dpif/dmemload
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/dif/next_link_register
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/dif/valid_lr
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/dif/next_valid_lr
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/DP1/prif/exmem_datomic_out
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/DP1/prif/exmem_dWEN_out
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/DP1/prif/exmem_dREN_out
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/dif/daddr
add wave -noupdate -group CM1 -expand -group DCACHE1 -expand -subitemconfig {{/system_tb/DUT/CPU/CM1/dif/way_0[2]} -expand {/system_tb/DUT/CPU/CM1/dif/way_0[0]} -expand} /system_tb/DUT/CPU/CM1/dif/way_0
add wave -noupdate -group CM1 -expand -group DCACHE1 -expand /system_tb/DUT/CPU/CM1/dif/way_1
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/dif/next_way_0
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/dif/next_way_1
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/least_recently_used
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/hit_counter
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_least_recently_used
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_hit_counter
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/traverse_caches
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_traverse_caches
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/way_0_dhit
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/way_1_dhit
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/dmiss
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_sw_miss_flag
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/sw_miss_flag
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopaddr
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/current_state
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/dcif/flushed
add wave -noupdate -group CM1 -expand -group DCACHE1 /system_tb/DUT/CPU/DP1/prif/exmem_dWEN_out
add wave -noupdate -group CM1 -group ICACHE1 /system_tb/DUT/CPU/CM1/iif/pc
add wave -noupdate -group CM1 -group ICACHE1 -expand /system_tb/DUT/CPU/CM1/iif/way_0
add wave -noupdate -group CM1 -group ICACHE1 /system_tb/DUT/CPU/CM1/iif/next_way_0
add wave -noupdate -group CM1 -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/current_state
add wave -noupdate -group CM1 -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/next_state
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/iwait
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/dwait
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/iREN
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/dREN
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/dWEN
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/iload
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/dload
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/dstore
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/iaddr
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/daddr
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/ccwait
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/ccinv
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/ccwrite
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/cctrans
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/ccif/ccsnoopaddr
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/next_N
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/current_N
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/previous_S
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/current_S
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/next_S
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/next_ccsnoopaddr
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/current_ccsnoopaddr
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/temp_snoopaddr
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/current_state
add wave -noupdate -group {Memory Controller (CC)} /system_tb/DUT/CPU/CC/next_state
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -divider {SYSTEM - MULTICORE LVL SIGNALS}
add wave -noupdate /system_tb/PROG/syif/halt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 7} {2000000 ps} 1} {{Cursor 2} {3640000 ps} 1}
quietly wave cursor active 2
configure wave -namecolwidth 191
configure wave -valuecolwidth 91
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
WaveRestoreZoom {0 ps} {7746199 ps}
