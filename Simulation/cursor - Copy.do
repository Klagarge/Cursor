onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {reset and clock} /cursor_tb/reset
add wave -noupdate -expand -group {reset and clock} /cursor_tb/clock
add wave -noupdate -expand -group {reset and clock} /cursor_tb/testMode
add wave -noupdate -expand -group {Buttons and sensors} /cursor_tb/restart
add wave -noupdate -expand -group {Buttons and sensors} /cursor_tb/go1
add wave -noupdate -expand -group {Buttons and sensors} /cursor_tb/go2
add wave -noupdate -expand -group {Buttons and sensors} /cursor_tb/sensor1
add wave -noupdate -expand -group {Buttons and sensors} /cursor_tb/sensor2
add wave -noupdate -group Encoder /cursor_tb/encoderA
add wave -noupdate -group Encoder /cursor_tb/encoderB
add wave -noupdate -group Encoder /cursor_tb/encoderI
add wave -noupdate -expand -group Internals -format Analog-Step -height 74 -max 255.0 /cursor_tb/I_DUT/Power
add wave -noupdate -expand -group Internals /cursor_tb/I_DUT/RaZ
add wave -noupdate -expand -group Internals /cursor_tb/I_DUT/button
add wave -noupdate -expand -group Internals -radix unsigned -childformat {{/cursor_tb/I_DUT/Position(15) -radix unsigned} {/cursor_tb/I_DUT/Position(14) -radix unsigned} {/cursor_tb/I_DUT/Position(13) -radix unsigned} {/cursor_tb/I_DUT/Position(12) -radix unsigned} {/cursor_tb/I_DUT/Position(11) -radix unsigned} {/cursor_tb/I_DUT/Position(10) -radix unsigned} {/cursor_tb/I_DUT/Position(9) -radix unsigned} {/cursor_tb/I_DUT/Position(8) -radix unsigned} {/cursor_tb/I_DUT/Position(7) -radix unsigned} {/cursor_tb/I_DUT/Position(6) -radix unsigned} {/cursor_tb/I_DUT/Position(5) -radix unsigned} {/cursor_tb/I_DUT/Position(4) -radix unsigned} {/cursor_tb/I_DUT/Position(3) -radix unsigned} {/cursor_tb/I_DUT/Position(2) -radix unsigned} {/cursor_tb/I_DUT/Position(1) -radix unsigned} {/cursor_tb/I_DUT/Position(0) -radix unsigned}} -subitemconfig {/cursor_tb/I_DUT/Position(15) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(14) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(13) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(12) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(11) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(10) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(9) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(8) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(7) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(6) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(5) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(4) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(3) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(2) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(1) {-height 15 -radix unsigned} /cursor_tb/I_DUT/Position(0) {-height 15 -radix unsigned}} /cursor_tb/I_DUT/Position
add wave -noupdate -group {Motor control} /cursor_tb/motorOn
add wave -noupdate -group {Motor control} /cursor_tb/side1
add wave -noupdate -group {Motor control} /cursor_tb/side2
add wave -noupdate /cursor_tb/I_DUT/testOut
add wave -noupdate /cursor_tb/I_DUT/I1/U_0/current_state
add wave -noupdate /cursor_tb/I_DUT/I4/current_state
add wave -noupdate -divider counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2727652488 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 320
configure wave -valuecolwidth 80
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {2727137385 ps} {2729700863 ps}
