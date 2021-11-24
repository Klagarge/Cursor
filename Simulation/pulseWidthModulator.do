onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /pulsewidthmodulator_tb/reset
add wave -noupdate -format Logic /pulsewidthmodulator_tb/clock
add wave -noupdate -format Literal -radix hexadecimal /pulsewidthmodulator_tb/amplitude
add wave -noupdate -format Logic /pulsewidthmodulator_tb/en
add wave -noupdate -format Analog-Step -height 40 -radix unsigned -scale 0.10000000000000001 /pulsewidthmodulator_tb/i0/counter
add wave -noupdate -format Logic /pulsewidthmodulator_tb/pwm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {2100 us}
configure wave -namecolwidth 200
configure wave -valuecolwidth 50
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2

run 1 ms
