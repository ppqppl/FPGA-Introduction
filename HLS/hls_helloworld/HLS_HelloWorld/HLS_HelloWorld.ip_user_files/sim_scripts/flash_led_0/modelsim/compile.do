vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../ipstatic/hdl/verilog/flash_led.v" \
"../../../../HLS_HelloWorld.srcs/sources_1/ip/flash_led_0/sim/flash_led_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

