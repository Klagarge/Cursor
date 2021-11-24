onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /divider_tb/reset
add wave -noupdate -format Logic /divider_tb/clock
add wave -noupdate -format Logic /divider_tb/testmode
add wave -noupdate -format Logic /divider_tb/enlow
add wave -noupdate -format Logic /divider_tb/enpwm
add wave -noupdate -format Logic /divider_tb/start
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {5250 us}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2

run 10 ms
