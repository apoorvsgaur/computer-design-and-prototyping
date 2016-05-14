onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/syif/halt
add wave -noupdate /system_tb/DUT/syif/WEN
add wave -noupdate /system_tb/DUT/syif/REN
add wave -noupdate /system_tb/DUT/syif/addr
add wave -noupdate -divider {PC LOGIC}
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/pc_enable
add wave -noupdate /system_tb/DUT/CPU/DP/pc
add wave -noupdate /system_tb/DUT/CPU/DP/pcn
add wave -noupdate /system_tb/DUT/CPU/DP/PCsrc
add wave -noupdate /system_tb/DUT/CPU/DP/branch_addr
add wave -noupdate /system_tb/DUT/CPU/DP/jraddr
add wave -noupdate /system_tb/DUT/CPU/DP/jaddr
add wave -noupdate -divider {I/D LOGIC}
add wave -noupdate /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/r_instr
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aif/z_flag
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aif/port_a
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aif/port_b
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aif/port_o
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aif/opcode
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[1]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[4]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[5]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[6]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[7]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[8]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[9]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[10]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[15]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[16]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[17]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[18]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[19]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[20]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[24]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[25]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[29]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[30]}
add wave -noupdate -group regs {/system_tb/DUT/CPU/DP/RF/registers[31]}
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
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/branch
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/jump
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/r_opcode
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/aluop
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/ALUsrc
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/RegWrite
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/back_pad
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/r_type
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/dcif/dmemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {273857233 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 116
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
WaveRestoreZoom {273783001 ps} {274505529 ps}
