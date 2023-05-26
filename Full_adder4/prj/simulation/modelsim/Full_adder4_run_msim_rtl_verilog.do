transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/Full_adder4/src {D:/code-file/FPGA/Full_adder4/src/Full_adder4.v}

vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/Full_adder4/prj/../tb {D:/code-file/FPGA/Full_adder4/prj/../tb/TB_Full_adder4.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TB_Full_adder4

add wave *
view structure
view signals
run -all
