onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/clk_us
add wave -noupdate -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/Rst_n
add wave -noupdate -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/trig
add wave -noupdate -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig} -radix unsigned /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/cnt
add wave -noupdate -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/add_cnt
add wave -noupdate -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_trig/end_cnt
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Clk
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/clk_us
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Rst_n
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/echo
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} -radix unsigned -childformat {{{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[18]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[17]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[16]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[15]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[14]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[13]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[12]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[11]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[10]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[9]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[8]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[7]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[6]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[5]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[4]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[3]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[2]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[1]} -radix unsigned} {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[0]} -radix unsigned}} -subitemconfig {{/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[18]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[17]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[16]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[15]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[14]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[13]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[12]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[11]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[10]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[9]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[8]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[7]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[6]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[5]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[4]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[3]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[2]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[1]} {-height 15 -radix unsigned} {/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o[0]} {-height 15 -radix unsigned}} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/data_o
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/r1_echo
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/r2_echo
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/echo_pos
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/echo_neg
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} -radix unsigned /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/cnt
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/add_cnt
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo} /tb_hc_sr/HC_SR04_TOP/hc_sr_driver/hc_sr_echo/end_cnt
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} /tb_hc_sr/HC_SR04_TOP/seg_driver/clk
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} /tb_hc_sr/HC_SR04_TOP/seg_driver/rst_n
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} -radix unsigned /tb_hc_sr/HC_SR04_TOP/seg_driver/data_in
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} /tb_hc_sr/HC_SR04_TOP/seg_driver/hex1
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} /tb_hc_sr/HC_SR04_TOP/seg_driver/hex2
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} /tb_hc_sr/HC_SR04_TOP/seg_driver/hex3
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} /tb_hc_sr/HC_SR04_TOP/seg_driver/hex4
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} /tb_hc_sr/HC_SR04_TOP/seg_driver/hex5
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} /tb_hc_sr/HC_SR04_TOP/seg_driver/hex6
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} /tb_hc_sr/HC_SR04_TOP/seg_driver/hex7
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} /tb_hc_sr/HC_SR04_TOP/seg_driver/hex8
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} -radix unsigned /tb_hc_sr/HC_SR04_TOP/seg_driver/cm_hund
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} -radix unsigned /tb_hc_sr/HC_SR04_TOP/seg_driver/cm_ten
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} -radix unsigned /tb_hc_sr/HC_SR04_TOP/seg_driver/cm_unit
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} -radix unsigned /tb_hc_sr/HC_SR04_TOP/seg_driver/point_1
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} -radix unsigned /tb_hc_sr/HC_SR04_TOP/seg_driver/point_2
add wave -noupdate -expand -label sim:/tb_hc_sr/HC_SR04_TOP/seg_driver/Group1 -group {Region: sim:/tb_hc_sr/HC_SR04_TOP/seg_driver} -radix unsigned /tb_hc_sr/HC_SR04_TOP/seg_driver/point_3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {2740619011 ps} 0}
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
configure wave -timelineunits us
update
WaveRestoreZoom {2734761883 ps} {2746018117 ps}
