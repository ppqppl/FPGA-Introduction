// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat May 13 14:33:11 2023
// Host        : ppqppl running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ flash_led_0_stub.v
// Design      : flash_led_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "flash_led,Vivado 2018.3" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(led_o_V_ap_vld, led_i_V_ap_vld, ap_clk, ap_rst, 
  ap_start, ap_done, ap_idle, ap_ready, led_o_V, led_i_V)
/* synthesis syn_black_box black_box_pad_pin="led_o_V_ap_vld,led_i_V_ap_vld,ap_clk,ap_rst,ap_start,ap_done,ap_idle,ap_ready,led_o_V[0:0],led_i_V[0:0]" */;
  output led_o_V_ap_vld;
  input led_i_V_ap_vld;
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  output [0:0]led_o_V;
  input [0:0]led_i_V;
endmodule
