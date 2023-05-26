transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA/code/EP4Ethernet {D:/FPGA/code/EP4Ethernet/ethernet.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/code/EP4Ethernet {D:/FPGA/code/EP4Ethernet/clk125m.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/code/EP4Ethernet {D:/FPGA/code/EP4Ethernet/clk250.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/code/EP4Ethernet/db {D:/FPGA/code/EP4Ethernet/db/clk125m_altpll.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/code/EP4Ethernet/db {D:/FPGA/code/EP4Ethernet/db/clk250_altpll.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/code/EP4Ethernet {D:/FPGA/code/EP4Ethernet/udp_send.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/code/EP4Ethernet {D:/FPGA/code/EP4Ethernet/crc32_d4.v}

