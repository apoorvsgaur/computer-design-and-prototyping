onerror {resume}
quietly virtual function -install /system_tb/DUT/CPU/DP -env /system_tb/PROG/#INITIAL#104 { &{/system_tb/DUT/CPU/DP/dpif/dhit, /system_tb/DUT/CPU/DP/dpif/datomic, /system_tb/DUT/CPU/DP/dpif/dmemREN, /system_tb/DUT/CPU/DP/dpif/dmemWEN, /system_tb/DUT/CPU/DP/dpif/flushed, /system_tb/DUT/CPU/DP/aluopcode/zero }} RAM
quietly virtual function -install /system_tb/PROG/syif -env /system_tb/PROG/syif { &{/system_tb/PROG/syif/tbCTRL, /system_tb/PROG/syif/halt, /system_tb/PROG/syif/WEN, /system_tb/PROG/syif/REN, /system_tb/PROG/syif/addr, /system_tb/PROG/syif/store, /system_tb/PROG/syif/load }} System_Top_Level
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Top_Level /system_tb/syif/tbCTRL
add wave -noupdate -group Top_Level /system_tb/syif/halt
add wave -noupdate -group Top_Level /system_tb/syif/WEN
add wave -noupdate -group Top_Level /system_tb/syif/REN
add wave -noupdate -group Top_Level /system_tb/syif/addr
add wave -noupdate -group Top_Level /system_tb/syif/store
add wave -noupdate -group Top_Level /system_tb/syif/load
add wave -noupdate -group RAM /system_tb/DUT/prif/ramREN
add wave -noupdate -group RAM /system_tb/DUT/prif/ramWEN
add wave -noupdate -group RAM /system_tb/DUT/prif/ramaddr
add wave -noupdate -group RAM /system_tb/DUT/prif/ramstore
add wave -noupdate -group RAM /system_tb/DUT/prif/ramload
add wave -noupdate -group RAM /system_tb/DUT/prif/ramstate
add wave -noupdate -group RAM /system_tb/DUT/prif/memREN
add wave -noupdate -group RAM /system_tb/DUT/prif/memWEN
add wave -noupdate -group RAM /system_tb/DUT/prif/memaddr
add wave -noupdate -group RAM /system_tb/DUT/prif/memstore
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/datomic
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/flushed
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -group DataPath_Cache_IF /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/CPUS
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -group Cache_Control_IF /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group Datapath_Top_Level /system_tb/DUT/CPU/DP/PC
add wave -noupdate -group Datapath_Top_Level /system_tb/DUT/CPU/DP/next_PC
add wave -noupdate -group Datapath_Top_Level /system_tb/DUT/CPU/DP/store_wdat
add wave -noupdate -group Datapath_Top_Level /system_tb/DUT/CPU/DP/extended_value
add wave -noupdate -group ALU_Signals /system_tb/DUT/CPU/DP/aluopcode/negative
add wave -noupdate -group ALU_Signals /system_tb/DUT/CPU/DP/aluopcode/overflow
add wave -noupdate -group ALU_Signals /system_tb/DUT/CPU/DP/aluopcode/zero
add wave -noupdate -group ALU_Signals /system_tb/DUT/CPU/DP/aluopcode/aluop
add wave -noupdate -group ALU_Signals /system_tb/DUT/CPU/DP/aluopcode/port_a
add wave -noupdate -group ALU_Signals /system_tb/DUT/CPU/DP/aluopcode/port_b
add wave -noupdate -group ALU_Signals /system_tb/DUT/CPU/DP/aluopcode/output_port
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/instruct
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/PC
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/jump_address
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/lui_data
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/PC_Output
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/zero
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/iREN
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/RegWrite
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/sign_extend
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/pc_enable
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/ALU_Source
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/dataToReg
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/rs
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/rt
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/rd
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/immediate
add wave -noupdate -group Control_Unit /system_tb/DUT/CPU/DP/cuif/ALUop
add wave -noupdate -group Register_File /system_tb/DUT/CPU/DP/REGISTERS/registers
add wave -noupdate -group Register_File /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group Register_File /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group Register_File /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group Register_File /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group Register_File /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group Register_File /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group Register_File /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -group Request_Unit /system_tb/DUT/CPU/DP/ruif/iHit
add wave -noupdate -group Request_Unit /system_tb/DUT/CPU/DP/ruif/dHit
add wave -noupdate -group Request_Unit /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate -group Request_Unit /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate -group Request_Unit /system_tb/DUT/CPU/DP/ruif/dWEN_cuif
add wave -noupdate -group Request_Unit /system_tb/DUT/CPU/DP/ruif/dREN_cuif
add wave -noupdate -group Caches /system_tb/DUT/CPU/CM/CLK
add wave -noupdate -group Caches /system_tb/DUT/CPU/CM/nRST
add wave -noupdate -group Caches /system_tb/DUT/CPU/CM/instr
add wave -noupdate -group Caches /system_tb/DUT/CPU/CM/daddr
add wave -noupdate /system_tb/DUT/CPU/DP/CONTROL_UNIT/type_instruct
add wave -noupdate /system_tb/DUT/CPU/DP/CONTROL_UNIT/r_type_instruct
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {366 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {1414506917 ps}
