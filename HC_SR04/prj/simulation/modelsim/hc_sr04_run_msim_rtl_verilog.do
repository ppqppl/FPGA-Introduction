transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/HC_SR04/rtl {D:/code-file/FPGA/HC_SR04/rtl/seg_driver.v}
vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/HC_SR04/rtl {D:/code-file/FPGA/HC_SR04/rtl/HC_SR04_TOP.v}
vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/HC_SR04/rtl {D:/code-file/FPGA/HC_SR04/rtl/hc_sr_trig.v}
vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/HC_SR04/rtl {D:/code-file/FPGA/HC_SR04/rtl/hc_sr_echo.v}
vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/HC_SR04/rtl {D:/code-file/FPGA/HC_SR04/rtl/hc_sr_driver.v}
vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/HC_SR04/rtl {D:/code-file/FPGA/HC_SR04/rtl/clk_div.v}

vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/HC_SR04/prj/../tb {D:/code-file/FPGA/HC_SR04/prj/../tb/tb_hc_sr.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_hc_sr

add wave *
view structure
view signals
run -all
