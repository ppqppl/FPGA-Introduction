############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
############################################################
open_project HLS
set_top flash_led
add_files HLS/code/HLS_HelloWorld.cpp
add_files HLS/code/HLS_HelloWorld.h
add_files -tb HLS/code/HLS_HelloWorld_tb.cpp
open_solution "solution1"
set_part {xc7z020clg400-2} -tool vivado
create_clock -period 10 -name default
config_export -format ip_catalog -rtl verilog
#source "./HLS/solution1/directives.tcl"
csim_design -clean -O
csynth_design
cosim_design -trace_level all -tool modelsim
export_design -rtl verilog -format ip_catalog
