onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -expand -group {DIF - TOP LEVEL} /dcache_tb/DUT/least_recently_used
add wave -noupdate -expand -group {DIF - TOP LEVEL} /dcache_tb/DUT/hit_counter
add wave -noupdate -expand -group {DIF - TOP LEVEL} /dcache_tb/DUT/next_least_recently_used
add wave -noupdate -expand -group {DIF - TOP LEVEL} /dcache_tb/DUT/next_hit_counter
add wave -noupdate -expand -group {DIF - TOP LEVEL} /dcache_tb/DUT/traverse_caches
add wave -noupdate -expand -group {DIF - TOP LEVEL} /dcache_tb/DUT/way_0_dhit
add wave -noupdate -expand -group {DIF - TOP LEVEL} /dcache_tb/DUT/way_1_dhit
add wave -noupdate -expand -group {DIF - TOP LEVEL} /dcache_tb/DUT/current_state
add wave -noupdate -expand -group {DIF - TOP LEVEL} /dcache_tb/DUT/next_state
add wave -noupdate -expand -group DIF /dcache_tb/dif/daddr
add wave -noupdate -expand -group DIF /dcache_tb/dif/way_0
add wave -noupdate -expand -group DIF /dcache_tb/dif/way_1
add wave -noupdate -expand -group DIF /dcache_tb/dif/next_way_0
add wave -noupdate -expand -group DIF /dcache_tb/dif/next_way_1
add wave -noupdate -expand -group DIF /dcache_tb/dif/halt
add wave -noupdate -expand -group DCIF_DCACHE /dcache_tb/dcif/halt
add wave -noupdate -expand -group DCIF_DCACHE /dcache_tb/dcif/dhit
add wave -noupdate -expand -group DCIF_DCACHE /dcache_tb/dcif/dmemREN
add wave -noupdate -expand -group DCIF_DCACHE /dcache_tb/dcif/dmemWEN
add wave -noupdate -expand -group DCIF_DCACHE /dcache_tb/dcif/flushed
add wave -noupdate -expand -group DCIF_DCACHE /dcache_tb/dcif/dmemload
add wave -noupdate -expand -group DCIF_DCACHE /dcache_tb/dcif/dmemstore
add wave -noupdate -expand -group DCIF_DCACHE /dcache_tb/dcif/dmemaddr
add wave -noupdate -expand -group CIF_DCACHE /dcache_tb/cif/dwait
add wave -noupdate -expand -group CIF_DCACHE /dcache_tb/cif/dREN
add wave -noupdate -expand -group CIF_DCACHE /dcache_tb/cif/dWEN
add wave -noupdate -expand -group CIF_DCACHE /dcache_tb/cif/dload
add wave -noupdate -expand -group CIF_DCACHE /dcache_tb/cif/dstore
add wave -noupdate -expand -group CIF_DCACHE /dcache_tb/cif/daddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {172 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 203
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
WaveRestoreZoom {0 ns} {221 ns}
