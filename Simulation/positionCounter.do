onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /positioncounter_tb/reset
add wave -noupdate -format Logic /positioncounter_tb/clock
add wave -noupdate -divider Controls
add wave -noupdate -format Logic /positioncounter_tb/clear
add wave -noupdate -divider Encoder
add wave -noupdate -format Logic /positioncounter_tb/i1/direction
add wave -noupdate -format Analog-Step -height 40 -radix unsigned -scale 0.20000000000000001 /positioncounter_tb/i1/stepcount
add wave -noupdate -format Logic /positioncounter_tb/encodera
add wave -noupdate -format Logic /positioncounter_tb/encoderb
add wave -noupdate -format Logic /positioncounter_tb/encoderi
add wave -noupdate -divider {Position counter}
add wave -noupdate -format Logic /positioncounter_tb/i0/risinga
add wave -noupdate -format Logic /positioncounter_tb/i0/fallinga
add wave -noupdate -format Logic /positioncounter_tb/i0/risingb
add wave -noupdate -format Logic /positioncounter_tb/i0/fallingb
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.10000000000000001 /positioncounter_tb/position
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {52123100 ps}
WaveRestoreZoom {0 ps} {210 us}
configure wave -namecolwidth 198
configure wave -valuecolwidth 52
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
run 200 us