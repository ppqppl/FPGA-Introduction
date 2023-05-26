transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/CODE/Quartus-18/vga_protocol/src {D:/CODE/Quartus-18/vga_protocol/src/data_generate.v}
vlog -vlog01compat -work work +incdir+D:/CODE/Quartus-18/vga_protocol/src {D:/CODE/Quartus-18/vga_protocol/src/vga_protocol_top.v}
vlog -vlog01compat -work work +incdir+D:/CODE/Quartus-18/vga_protocol/src {D:/CODE/Quartus-18/vga_protocol/src/counter25M.v}
vlog -vlog01compat -work work +incdir+D:/CODE/Quartus-18/vga_protocol/ip {D:/CODE/Quartus-18/vga_protocol/ip/rom.v}
vlog -vlog01compat -work work +incdir+D:/CODE/Quartus-18/vga_protocol/src {D:/CODE/Quartus-18/vga_protocol/src/vga_contro.v}
vlog -vlog01compat -work work +incdir+D:/CODE/Quartus-18/vga_protocol/src {D:/CODE/Quartus-18/vga_protocol/src/vga_param.v}

vlog -vlog01compat -work work +incdir+D:/CODE/Quartus-18/vga_protocol/prj/../src {D:/CODE/Quartus-18/vga_protocol/prj/../src/vga_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  vga_tb

add wave *
view structure
view signals
run -all
