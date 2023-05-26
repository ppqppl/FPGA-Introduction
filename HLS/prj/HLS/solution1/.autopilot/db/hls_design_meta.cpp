#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_start", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_done", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_idle", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_ready", 1, hls_out, -1, "", "", 1),
	Port_Property("led_o_V", 1, hls_out, 0, "ap_ovld", "out_data", 1),
	Port_Property("led_o_V_ap_vld", 1, hls_out, 0, "ap_ovld", "out_vld", 1),
	Port_Property("led_i_V", 1, hls_in, 1, "ap_vld", "in_data", 1),
	Port_Property("led_i_V_ap_vld", 1, hls_in, 1, "ap_vld", "in_vld", 1),
};
const char* HLS_Design_Meta::dut_name = "flash_led";
