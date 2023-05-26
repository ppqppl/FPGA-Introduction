transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/CLOCK/SRC {D:/code-file/FPGA/CLOCK/SRC/TIME_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/CLOCK/SRC {D:/code-file/FPGA/CLOCK/SRC/SEG_driver.v}
vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/CLOCK/SRC {D:/code-file/FPGA/CLOCK/SRC/CLOCK.v}

vlog -vlog01compat -work work +incdir+D:/code-file/FPGA/CLOCK/PRJ/../TB {D:/code-file/FPGA/CLOCK/PRJ/../TB/TB_CLOCK.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TB_CLOCK

add wave *
view structure
view signals
run -all
