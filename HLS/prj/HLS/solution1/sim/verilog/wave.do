set designtopgroup "Design Top Signals"
add wave -group $designtopgroup
set clockgroup "Clock"
add wave -group $designtopgroup -group $clockgroup
add wave -group $designtopgroup -group $clockgroup /apatb_flash_led_top/AESL_inst_flash_led/ap_clk
set resetgroup "Reset"
add wave -group $designtopgroup -group $resetgroup
add wave -group $designtopgroup -group $resetgroup /apatb_flash_led_top/AESL_inst_flash_led/ap_rst
set blocksiggroup "Block-level IO Handshake"
add wave -group $designtopgroup -group $blocksiggroup
add wave -group $designtopgroup -group $blocksiggroup /apatb_flash_led_top/AESL_inst_flash_led/ap_start
add wave -group $designtopgroup -group $blocksiggroup /apatb_flash_led_top/AESL_inst_flash_led/ap_done
add wave -group $designtopgroup -group $blocksiggroup /apatb_flash_led_top/AESL_inst_flash_led/ap_idle
add wave -group $designtopgroup -group $blocksiggroup /apatb_flash_led_top/AESL_inst_flash_led/ap_ready
set cinputgroup "C Inputs"
add wave -group $designtopgroup -group $cinputgroup
set led_i_group led_i(wire)
add wave -group $designtopgroup -group $cinputgroup -group $led_i_group
add wave -group $designtopgroup -group $cinputgroup -group $led_i_group -radix hex /apatb_flash_led_top/AESL_inst_flash_led/led_i_V
add wave -group $designtopgroup -group $cinputgroup -group $led_i_group -color #ffff00 -radix hex /apatb_flash_led_top/AESL_inst_flash_led/led_i_V_ap_vld
set coutputgroup "C Outputs"
add wave -group $designtopgroup -group $coutputgroup
set led_o_group led_o(wire)
add wave -group $designtopgroup -group $coutputgroup -group $led_o_group
add wave -group $designtopgroup -group $coutputgroup -group $led_o_group -radix hex /apatb_flash_led_top/AESL_inst_flash_led/led_o_V
add wave -group $designtopgroup -group $coutputgroup -group $led_o_group -color #ffff00 -radix hex /apatb_flash_led_top/AESL_inst_flash_led/led_o_V_ap_vld
set testbenchgroup "Test Bench Signals"
add wave -group $testbenchgroup
set tbcinputgroup "C Inputs"
add wave -group $testbenchgroup -group $tbcinputgroup
set tb_led_i_group led_i(wire)
add wave -group $testbenchgroup -group $tbcinputgroup -group $tb_led_i_group
add wave -group $testbenchgroup -group $tbcinputgroup -group $tb_led_i_group -radix hex /apatb_flash_led_top/led_i_V
add wave -group $testbenchgroup -group $tbcinputgroup -group $tb_led_i_group -color #ffff00 -radix hex /apatb_flash_led_top/led_i_V_ap_vld
set tbcoutputgroup "C Outputs"
add wave -group $testbenchgroup -group $tbcoutputgroup
set tb_led_o_group led_o(wire)
add wave -group $testbenchgroup -group $tbcoutputgroup -group $tb_led_o_group
add wave -group $testbenchgroup -group $tbcoutputgroup -group $tb_led_o_group -radix hex /apatb_flash_led_top/led_o_V
add wave -group $testbenchgroup -group $tbcoutputgroup -group $tb_led_o_group -color #ffff00 -radix hex /apatb_flash_led_top/led_o_V_ap_vld
set tbinternalsiggroup "Internal Signals"
add wave -group $testbenchgroup -group $tbinternalsiggroup
set tb_simstatus_group "Simulation Status"
add wave -group $testbenchgroup -group $tbinternalsiggroup -group $tb_simstatus_group
add wave -group $testbenchgroup -group $tbinternalsiggroup -group $tb_simstatus_group -radix hex /apatb_flash_led_top/AUTOTB_TRANSACTION_NUM
add wave -group $testbenchgroup -group $tbinternalsiggroup -group $tb_simstatus_group -radix hex /apatb_flash_led_top/ready_cnt
add wave -group $testbenchgroup -group $tbinternalsiggroup -group $tb_simstatus_group -radix hex /apatb_flash_led_top/done_cnt
set tb_portdepth_group "Port Depth"
add wave -group $testbenchgroup -group $tbinternalsiggroup -group $tb_portdepth_group
add wave -group $testbenchgroup -group $tbinternalsiggroup -group $tb_portdepth_group -radix hex /apatb_flash_led_top/LENGTH_led_o_V
add wave -group $testbenchgroup -group $tbinternalsiggroup -group $tb_portdepth_group -radix hex /apatb_flash_led_top/LENGTH_led_i_V
