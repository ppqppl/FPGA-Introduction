# (C) 2001-2018 Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files from any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License Subscription 
# Agreement, Intel FPGA IP License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Intel and sold by 
# Intel or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


set dut_parameters [list]
set is_qsys_edition [list]

# RUN_SCRIPT_PARAMETERS
set variant_name ethernet
set dut_device_family "CYCLONEIVE"
lappend is_qsys_edition "QSYS_STANDARD"
lappend dut_parameters "--component-param=core_variation=MAC_ONLY"
lappend dut_parameters "--component-param=ifGMII=MII_GMII"
lappend dut_parameters "--component-param=use_mac_clken=false"
lappend dut_parameters "--component-param=enable_use_internal_fifo=true"
lappend dut_parameters "--component-param=enable_ecc=false"
lappend dut_parameters "--component-param=max_channels=1"
lappend dut_parameters "--component-param=use_misc_ports=true"
lappend dut_parameters "--component-param=transceiver_type=NONE"
lappend dut_parameters "--component-param=enable_hd_logic=true"
lappend dut_parameters "--component-param=enable_gmii_loopback=false"
lappend dut_parameters "--component-param=enable_sup_addr=false"
lappend dut_parameters "--component-param=stat_cnt_ena=false"
lappend dut_parameters "--component-param=ext_stat_cnt_ena=false"
lappend dut_parameters "--component-param=ena_hash=false"
lappend dut_parameters "--component-param=enable_shift16=true"
lappend dut_parameters "--component-param=enable_mac_flow_ctrl=false"
lappend dut_parameters "--component-param=enable_mac_vlan=false"
lappend dut_parameters "--component-param=enable_magic_detect=false"
lappend dut_parameters "--component-param=useMDIO=true"
lappend dut_parameters "--component-param=mdio_clk_div=40"
lappend dut_parameters "--component-param=enable_ena=32"
lappend dut_parameters "--component-param=eg_addr=11"
lappend dut_parameters "--component-param=ing_addr=11"
lappend dut_parameters "--component-param=phy_identifier=0"
lappend dut_parameters "--component-param=enable_sgmii=false"
lappend dut_parameters "--component-param=export_pwrdn=false"
lappend dut_parameters "--component-param=enable_alt_reconfig=false"
lappend dut_parameters "--component-param=starting_channel_number=0"
lappend dut_parameters "--component-param=phyip_pll_type=CMU"
lappend dut_parameters "--component-param=phyip_pll_base_data_rate=1250 Mbps"
lappend dut_parameters "--component-param=phyip_en_synce_support=false"
lappend dut_parameters "--component-param=phyip_pma_bonding_mode=x1"
lappend dut_parameters "--component-param=nf_phyip_rcfg_enable=false"
lappend dut_parameters "--component-param=XCVR_RCFG_JTAG_ENABLE=0"
lappend dut_parameters "--component-param=XCVR_SET_CAPABILITY_REG_ENABLE=0"
lappend dut_parameters "--component-param=XCVR_SET_USER_IDENTIFIER=0"
lappend dut_parameters "--component-param=XCVR_SET_CSR_SOFT_LOGIC_ENABLE=0"
lappend dut_parameters "--component-param=XCVR_SET_PRBS_SOFT_LOGIC_ENABLE=0"
lappend dut_parameters "--component-param=enable_timestamping=false"
lappend dut_parameters "--component-param=enable_ptp_1step=false"
lappend dut_parameters "--component-param=tstamp_fp_width=4"


if {[is_project_open]} {
	set project_name $::quartus(project)
	if {[string compare $project_name "generate_sim"] != 0} {
		post_message -type error "Invalid project \"$project_name\""
		post_message -type error "In order to generate the simulation model,"
		post_message -type error "please close the current project \"$project_name\""
		post_message -type error "and open the project \"generate_sim\""
		return 1
	}
}
set arg_list [list]
puts "Generating VHDL simulation model"
set output_dir [file join testbench_vhdl ${variant_name}_sim]

if { [string match "QSYS_PRO" $is_qsys_edition] } {
    lappend arg_list "--family=$dut_device_family"
    lappend arg_list "--output-name=${variant_name}"
    lappend arg_list "--output-directory=$output_dir"
	
    catch {eval [concat [list exec "ip-deploy" --component-name=altera_eth_tse] $arg_list $dut_parameters]} temp
	puts $temp
    catch {eval [concat [list exec "qsys-generate" --simulation=VHDL] "${output_dir}/${variant_name}.ip"]} temp
	puts $temp
} else { 

    set spd_filename [file join $output_dir ${variant_name}.spd]

    lappend arg_list "--file-set=SIM_VHDL"
    lappend arg_list "--system-info=DEVICE_FAMILY=$dut_device_family"
    lappend arg_list "--output-name=${variant_name}"
    lappend arg_list "--output-dir=$output_dir"
    lappend arg_list "--report-file=spd:$spd_filename"

    set qdir $::env(QUARTUS_ROOTDIR)
    catch {eval [concat [list exec "$qdir/sopc_builder/bin/ip-generate" --component-name=altera_eth_tse] $arg_list $dut_parameters]} temp
    puts $temp

    catch {eval [list exec "$qdir/sopc_builder/bin/ip-make-simscript" --spd=${spd_filename} --output-directory=$output_dir]} temp
    puts $temp
}
