onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider INPUTS
add wave -noupdate -radix decimal /alu_tb/aluif/port_a
add wave -noupdate -radix decimal /alu_tb/aluif/port_b
add wave -noupdate /alu_tb/aluif/opcode
add wave -noupdate -divider OUTPUTS
add wave -noupdate -radix decimal /alu_tb/aluif/port_o
add wave -noupdate /alu_tb/aluif/neg_flag
add wave -noupdate /alu_tb/aluif/of_flag
add wave -noupdate /alu_tb/aluif/z_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24 ns} 0}
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
WaveRestoreZoom {0 ns} {32 ns}
