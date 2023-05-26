vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../ipstatic/hdl/verilog/flash_led.v" \
"../../../../HLS_HelloWorld.srcs/sources_1/ip/flash_led_0/sim/flash_led_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

