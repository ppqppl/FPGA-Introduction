vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../ipstatic/hdl/verilog/flash_led.v" \
"../../../../HLS_HelloWorld.srcs/sources_1/ip/flash_led_0/sim/flash_led_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

