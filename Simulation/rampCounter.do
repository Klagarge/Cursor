onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /rampcounter_tb/reset
add wave -noupdate -format Logic /rampcounter_tb/clock
add wave -noupdate -format Logic /rampcounter_tb/en
add wave -noupdate -format Logic /rampcounter_tb/updown
add wave -noupdate -format Logic /rampcounter_tb/start
add wave -noupdate -format Analog-Step -height 40 -radix unsigned -scale 0.10000000000000001 /rampcounter_tb/ramp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {76751300 ps}
WaveRestoreZoom {0 ps} {210 us}
configure wave -namecolwidth 195
configure wave -valuecolwidth 55
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
run 200 us