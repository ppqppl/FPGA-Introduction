transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {d:/intelfpga/18.1/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {d:/intelfpga/18.1/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {d:/intelfpga/18.1/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {d:/intelfpga/18.1/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {d:/intelfpga/18.1/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cycloneive_ver
vmap cycloneive_ver ./verilog_libs/cycloneive_ver
vlog -vlog01compat -work cycloneive_ver {d:/intelfpga/18.1/quartus/eda/sim_lib/cycloneive_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA_Study/A_A_JD/HC_SR04/rtl {D:/FPGA_Study/A_A_JD/HC_SR04/rtl/seg_driver.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_Study/A_A_JD/HC_SR04/rtl {D:/FPGA_Study/A_A_JD/HC_SR04/rtl/HC_SR04_TOP.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_Study/A_A_JD/HC_SR04/rtl {D:/FPGA_Study/A_A_JD/HC_SR04/rtl/hc_sr_trig.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_Study/A_A_JD/HC_SR04/rtl {D:/FPGA_Study/A_A_JD/HC_SR04/rtl/hc_sr_echo.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_Study/A_A_JD/HC_SR04/rtl {D:/FPGA_Study/A_A_JD/HC_SR04/rtl/hc_sr_driver.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_Study/A_A_JD/HC_SR04/rtl {D:/FPGA_Study/A_A_JD/HC_SR04/rtl/clk_div.v}

vlog -vlog01compat -work work +incdir+D:/FPGA_Study/A_A_JD/HC_SR04/prj/../tb {D:/FPGA_Study/A_A_JD/HC_SR04/prj/../tb/tb_hc_sr.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_hc_sr

do wave.do
run -all
