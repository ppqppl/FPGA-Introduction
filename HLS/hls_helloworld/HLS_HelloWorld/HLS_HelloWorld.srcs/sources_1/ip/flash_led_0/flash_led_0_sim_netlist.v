// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat May 13 14:33:12 2023
// Host        : ppqppl running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/code-file/FPGA/HLS/hls_helloworld/HLS_HelloWorld/HLS_HelloWorld.srcs/sources_1/ip/flash_led_0/flash_led_0_sim_netlist.v
// Design      : flash_led_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "flash_led_0,flash_led,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "HLS" *) 
(* X_CORE_INFO = "flash_led,Vivado 2018.3" *) (* hls_module = "yes" *) 
(* NotValidForBitStream *)
module flash_led_0
   (led_o_V_ap_vld,
    led_i_V_ap_vld,
    ap_clk,
    ap_rst,
    ap_start,
    ap_done,
    ap_idle,
    ap_ready,
    led_o_V,
    led_i_V);
  output led_o_V_ap_vld;
  input led_i_V_ap_vld;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_RESET ap_rst, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input ap_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst, POLARITY ACTIVE_HIGH, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {RST {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, INSERT_VIP 0" *) input ap_rst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl start" *) input ap_start;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl done" *) output ap_done;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl idle" *) output ap_idle;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ready" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_ctrl, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {start {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} done {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} idle {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} ready {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}" *) output ap_ready;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 led_o_V DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME led_o_V, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}" *) output [0:0]led_o_V;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 led_i_V DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME led_i_V, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}" *) input [0:0]led_i_V;

  wire ap_clk;
  wire ap_done;
  wire ap_idle;
  wire ap_ready;
  wire ap_rst;
  wire ap_start;
  wire [0:0]led_i_V;
  wire led_i_V_ap_vld;
  wire [0:0]led_o_V;
  wire led_o_V_ap_vld;

  (* ap_ST_fsm_state1 = "2'b01" *) 
  (* ap_ST_fsm_state2 = "2'b10" *) 
  flash_led_0_flash_led inst
       (.ap_clk(ap_clk),
        .ap_done(ap_done),
        .ap_idle(ap_idle),
        .ap_ready(ap_ready),
        .ap_rst(ap_rst),
        .ap_start(ap_start),
        .led_i_V(led_i_V),
        .led_i_V_ap_vld(led_i_V_ap_vld),
        .led_o_V(led_o_V),
        .led_o_V_ap_vld(led_o_V_ap_vld));
endmodule

(* ORIG_REF_NAME = "flash_led" *) (* ap_ST_fsm_state1 = "2'b01" *) (* ap_ST_fsm_state2 = "2'b10" *) 
(* hls_module = "yes" *) 
module flash_led_0_flash_led
   (ap_clk,
    ap_rst,
    ap_start,
    ap_done,
    ap_idle,
    ap_ready,
    led_o_V,
    led_o_V_ap_vld,
    led_i_V,
    led_i_V_ap_vld);
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  output [0:0]led_o_V;
  output led_o_V_ap_vld;
  input [0:0]led_i_V;
  input led_i_V_ap_vld;

  wire \ap_CS_fsm[0]_i_1_n_0 ;
  wire \ap_CS_fsm[1]_i_1_n_0 ;
  wire \ap_CS_fsm[1]_i_2_n_0 ;
  wire \ap_CS_fsm_reg_n_0_[0] ;
  wire ap_CS_fsm_state2;
  wire ap_NS_fsm1;
  wire ap_clk;
  wire ap_done;
  wire ap_idle;
  wire ap_ready_INST_0_i_1_n_0;
  wire ap_ready_INST_0_i_2_n_0;
  wire ap_ready_INST_0_i_3_n_0;
  wire ap_ready_INST_0_i_4_n_0;
  wire ap_ready_INST_0_i_5_n_0;
  wire ap_ready_INST_0_i_6_n_0;
  wire ap_ready_INST_0_i_7_n_0;
  wire ap_ready_INST_0_i_8_n_0;
  wire ap_rst;
  wire ap_start;
  wire [0:0]led_i_V;
  wire led_i_V_ap_vld;
  wire led_i_V_ap_vld_preg;
  wire led_i_V_ap_vld_preg_i_1_n_0;
  wire led_i_V_ap_vld_preg_i_2_n_0;
  wire led_i_V_preg;
  wire \led_i_V_preg[0]_i_1_n_0 ;
  wire [0:0]led_o_V;
  wire led_o_V_ap_vld;
  wire led_o_V_ap_vld_INST_0_i_1_n_0;
  wire \r_V_reg_86[0]_i_1_n_0 ;
  wire t_V_reg_51;
  wire t_V_reg_510;
  wire \t_V_reg_51[0]_i_4_n_0 ;
  wire [26:0]t_V_reg_51_reg;
  wire \t_V_reg_51_reg[0]_i_3_n_0 ;
  wire \t_V_reg_51_reg[0]_i_3_n_1 ;
  wire \t_V_reg_51_reg[0]_i_3_n_2 ;
  wire \t_V_reg_51_reg[0]_i_3_n_3 ;
  wire \t_V_reg_51_reg[0]_i_3_n_4 ;
  wire \t_V_reg_51_reg[0]_i_3_n_5 ;
  wire \t_V_reg_51_reg[0]_i_3_n_6 ;
  wire \t_V_reg_51_reg[0]_i_3_n_7 ;
  wire \t_V_reg_51_reg[12]_i_1_n_0 ;
  wire \t_V_reg_51_reg[12]_i_1_n_1 ;
  wire \t_V_reg_51_reg[12]_i_1_n_2 ;
  wire \t_V_reg_51_reg[12]_i_1_n_3 ;
  wire \t_V_reg_51_reg[12]_i_1_n_4 ;
  wire \t_V_reg_51_reg[12]_i_1_n_5 ;
  wire \t_V_reg_51_reg[12]_i_1_n_6 ;
  wire \t_V_reg_51_reg[12]_i_1_n_7 ;
  wire \t_V_reg_51_reg[16]_i_1_n_0 ;
  wire \t_V_reg_51_reg[16]_i_1_n_1 ;
  wire \t_V_reg_51_reg[16]_i_1_n_2 ;
  wire \t_V_reg_51_reg[16]_i_1_n_3 ;
  wire \t_V_reg_51_reg[16]_i_1_n_4 ;
  wire \t_V_reg_51_reg[16]_i_1_n_5 ;
  wire \t_V_reg_51_reg[16]_i_1_n_6 ;
  wire \t_V_reg_51_reg[16]_i_1_n_7 ;
  wire \t_V_reg_51_reg[20]_i_1_n_0 ;
  wire \t_V_reg_51_reg[20]_i_1_n_1 ;
  wire \t_V_reg_51_reg[20]_i_1_n_2 ;
  wire \t_V_reg_51_reg[20]_i_1_n_3 ;
  wire \t_V_reg_51_reg[20]_i_1_n_4 ;
  wire \t_V_reg_51_reg[20]_i_1_n_5 ;
  wire \t_V_reg_51_reg[20]_i_1_n_6 ;
  wire \t_V_reg_51_reg[20]_i_1_n_7 ;
  wire \t_V_reg_51_reg[24]_i_1_n_2 ;
  wire \t_V_reg_51_reg[24]_i_1_n_3 ;
  wire \t_V_reg_51_reg[24]_i_1_n_5 ;
  wire \t_V_reg_51_reg[24]_i_1_n_6 ;
  wire \t_V_reg_51_reg[24]_i_1_n_7 ;
  wire \t_V_reg_51_reg[4]_i_1_n_0 ;
  wire \t_V_reg_51_reg[4]_i_1_n_1 ;
  wire \t_V_reg_51_reg[4]_i_1_n_2 ;
  wire \t_V_reg_51_reg[4]_i_1_n_3 ;
  wire \t_V_reg_51_reg[4]_i_1_n_4 ;
  wire \t_V_reg_51_reg[4]_i_1_n_5 ;
  wire \t_V_reg_51_reg[4]_i_1_n_6 ;
  wire \t_V_reg_51_reg[4]_i_1_n_7 ;
  wire \t_V_reg_51_reg[8]_i_1_n_0 ;
  wire \t_V_reg_51_reg[8]_i_1_n_1 ;
  wire \t_V_reg_51_reg[8]_i_1_n_2 ;
  wire \t_V_reg_51_reg[8]_i_1_n_3 ;
  wire \t_V_reg_51_reg[8]_i_1_n_4 ;
  wire \t_V_reg_51_reg[8]_i_1_n_5 ;
  wire \t_V_reg_51_reg[8]_i_1_n_6 ;
  wire \t_V_reg_51_reg[8]_i_1_n_7 ;
  wire [3:2]\NLW_t_V_reg_51_reg[24]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_t_V_reg_51_reg[24]_i_1_O_UNCONNECTED ;

  assign ap_ready = ap_done;
  LUT6 #(
    .INIT(64'hFFFFFFFF888B8888)) 
    \ap_CS_fsm[0]_i_1 
       (.I0(\ap_CS_fsm[1]_i_2_n_0 ),
        .I1(\ap_CS_fsm_reg_n_0_[0] ),
        .I2(ap_ready_INST_0_i_2_n_0),
        .I3(ap_ready_INST_0_i_1_n_0),
        .I4(ap_CS_fsm_state2),
        .I5(ap_rst),
        .O(\ap_CS_fsm[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000FDFFFD)) 
    \ap_CS_fsm[1]_i_1 
       (.I0(ap_CS_fsm_state2),
        .I1(ap_ready_INST_0_i_1_n_0),
        .I2(ap_ready_INST_0_i_2_n_0),
        .I3(\ap_CS_fsm_reg_n_0_[0] ),
        .I4(\ap_CS_fsm[1]_i_2_n_0 ),
        .I5(ap_rst),
        .O(\ap_CS_fsm[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h1F)) 
    \ap_CS_fsm[1]_i_2 
       (.I0(led_i_V_ap_vld),
        .I1(led_i_V_ap_vld_preg),
        .I2(ap_start),
        .O(\ap_CS_fsm[1]_i_2_n_0 ));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b1)) 
    \ap_CS_fsm_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\ap_CS_fsm[0]_i_1_n_0 ),
        .Q(\ap_CS_fsm_reg_n_0_[0] ),
        .R(1'b0));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\ap_CS_fsm[1]_i_1_n_0 ),
        .Q(ap_CS_fsm_state2),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    ap_idle_INST_0
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_start),
        .O(ap_idle));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h02)) 
    ap_ready_INST_0
       (.I0(ap_CS_fsm_state2),
        .I1(ap_ready_INST_0_i_1_n_0),
        .I2(ap_ready_INST_0_i_2_n_0),
        .O(ap_done));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    ap_ready_INST_0_i_1
       (.I0(t_V_reg_51_reg[3]),
        .I1(t_V_reg_51_reg[4]),
        .I2(t_V_reg_51_reg[1]),
        .I3(t_V_reg_51_reg[2]),
        .I4(ap_ready_INST_0_i_3_n_0),
        .O(ap_ready_INST_0_i_1_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    ap_ready_INST_0_i_2
       (.I0(ap_ready_INST_0_i_4_n_0),
        .I1(ap_ready_INST_0_i_5_n_0),
        .I2(ap_ready_INST_0_i_6_n_0),
        .I3(ap_ready_INST_0_i_7_n_0),
        .I4(ap_ready_INST_0_i_8_n_0),
        .O(ap_ready_INST_0_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFEF)) 
    ap_ready_INST_0_i_3
       (.I0(t_V_reg_51_reg[6]),
        .I1(t_V_reg_51_reg[5]),
        .I2(t_V_reg_51_reg[8]),
        .I3(t_V_reg_51_reg[7]),
        .O(ap_ready_INST_0_i_3_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    ap_ready_INST_0_i_4
       (.I0(t_V_reg_51_reg[10]),
        .I1(t_V_reg_51_reg[9]),
        .I2(t_V_reg_51_reg[12]),
        .I3(t_V_reg_51_reg[11]),
        .O(ap_ready_INST_0_i_4_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    ap_ready_INST_0_i_5
       (.I0(t_V_reg_51_reg[22]),
        .I1(t_V_reg_51_reg[21]),
        .I2(t_V_reg_51_reg[24]),
        .I3(t_V_reg_51_reg[23]),
        .O(ap_ready_INST_0_i_5_n_0));
  LUT3 #(
    .INIT(8'hFD)) 
    ap_ready_INST_0_i_6
       (.I0(t_V_reg_51_reg[26]),
        .I1(t_V_reg_51_reg[25]),
        .I2(t_V_reg_51_reg[0]),
        .O(ap_ready_INST_0_i_6_n_0));
  LUT4 #(
    .INIT(16'hFFDF)) 
    ap_ready_INST_0_i_7
       (.I0(t_V_reg_51_reg[18]),
        .I1(t_V_reg_51_reg[17]),
        .I2(t_V_reg_51_reg[20]),
        .I3(t_V_reg_51_reg[19]),
        .O(ap_ready_INST_0_i_7_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    ap_ready_INST_0_i_8
       (.I0(t_V_reg_51_reg[14]),
        .I1(t_V_reg_51_reg[13]),
        .I2(t_V_reg_51_reg[16]),
        .I3(t_V_reg_51_reg[15]),
        .O(ap_ready_INST_0_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hFD00)) 
    led_i_V_ap_vld_preg_i_1
       (.I0(ap_CS_fsm_state2),
        .I1(ap_ready_INST_0_i_1_n_0),
        .I2(ap_ready_INST_0_i_2_n_0),
        .I3(led_i_V_ap_vld_preg_i_2_n_0),
        .O(led_i_V_ap_vld_preg_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h0000EAEE)) 
    led_i_V_ap_vld_preg_i_2
       (.I0(led_i_V_ap_vld_preg),
        .I1(led_i_V_ap_vld),
        .I2(ap_start),
        .I3(\ap_CS_fsm_reg_n_0_[0] ),
        .I4(ap_rst),
        .O(led_i_V_ap_vld_preg_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    led_i_V_ap_vld_preg_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(led_i_V_ap_vld_preg_i_1_n_0),
        .Q(led_i_V_ap_vld_preg),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h00000000EAEE2A22)) 
    \led_i_V_preg[0]_i_1 
       (.I0(led_i_V_preg),
        .I1(led_i_V_ap_vld),
        .I2(ap_start),
        .I3(\ap_CS_fsm_reg_n_0_[0] ),
        .I4(led_i_V),
        .I5(ap_rst),
        .O(\led_i_V_preg[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \led_i_V_preg_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\led_i_V_preg[0]_i_1_n_0 ),
        .Q(led_i_V_preg),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00008000)) 
    led_o_V_ap_vld_INST_0
       (.I0(led_o_V_ap_vld_INST_0_i_1_n_0),
        .I1(t_V_reg_51_reg[2]),
        .I2(t_V_reg_51_reg[1]),
        .I3(ap_CS_fsm_state2),
        .I4(ap_ready_INST_0_i_2_n_0),
        .O(led_o_V_ap_vld));
  LUT6 #(
    .INIT(64'h0000800000000000)) 
    led_o_V_ap_vld_INST_0_i_1
       (.I0(t_V_reg_51_reg[5]),
        .I1(t_V_reg_51_reg[6]),
        .I2(t_V_reg_51_reg[3]),
        .I3(t_V_reg_51_reg[4]),
        .I4(t_V_reg_51_reg[8]),
        .I5(t_V_reg_51_reg[7]),
        .O(led_o_V_ap_vld_INST_0_i_1_n_0));
  LUT5 #(
    .INIT(32'h47FF4700)) 
    \r_V_reg_86[0]_i_1 
       (.I0(led_i_V),
        .I1(led_i_V_ap_vld),
        .I2(led_i_V_preg),
        .I3(ap_NS_fsm1),
        .I4(led_o_V),
        .O(\r_V_reg_86[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h8880)) 
    \r_V_reg_86[0]_i_2 
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_start),
        .I2(led_i_V_ap_vld_preg),
        .I3(led_i_V_ap_vld),
        .O(ap_NS_fsm1));
  FDRE \r_V_reg_86_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\r_V_reg_86[0]_i_1_n_0 ),
        .Q(led_o_V),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h222A)) 
    \t_V_reg_51[0]_i_1 
       (.I0(ap_NS_fsm1),
        .I1(ap_CS_fsm_state2),
        .I2(ap_ready_INST_0_i_1_n_0),
        .I3(ap_ready_INST_0_i_2_n_0),
        .O(t_V_reg_51));
  LUT3 #(
    .INIT(8'hA8)) 
    \t_V_reg_51[0]_i_2 
       (.I0(ap_CS_fsm_state2),
        .I1(ap_ready_INST_0_i_1_n_0),
        .I2(ap_ready_INST_0_i_2_n_0),
        .O(t_V_reg_510));
  LUT1 #(
    .INIT(2'h1)) 
    \t_V_reg_51[0]_i_4 
       (.I0(t_V_reg_51_reg[0]),
        .O(\t_V_reg_51[0]_i_4_n_0 ));
  FDRE \t_V_reg_51_reg[0] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[0]_i_3_n_7 ),
        .Q(t_V_reg_51_reg[0]),
        .R(t_V_reg_51));
  CARRY4 \t_V_reg_51_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\t_V_reg_51_reg[0]_i_3_n_0 ,\t_V_reg_51_reg[0]_i_3_n_1 ,\t_V_reg_51_reg[0]_i_3_n_2 ,\t_V_reg_51_reg[0]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\t_V_reg_51_reg[0]_i_3_n_4 ,\t_V_reg_51_reg[0]_i_3_n_5 ,\t_V_reg_51_reg[0]_i_3_n_6 ,\t_V_reg_51_reg[0]_i_3_n_7 }),
        .S({t_V_reg_51_reg[3:1],\t_V_reg_51[0]_i_4_n_0 }));
  FDRE \t_V_reg_51_reg[10] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[8]_i_1_n_5 ),
        .Q(t_V_reg_51_reg[10]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[11] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[8]_i_1_n_4 ),
        .Q(t_V_reg_51_reg[11]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[12] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[12]_i_1_n_7 ),
        .Q(t_V_reg_51_reg[12]),
        .R(t_V_reg_51));
  CARRY4 \t_V_reg_51_reg[12]_i_1 
       (.CI(\t_V_reg_51_reg[8]_i_1_n_0 ),
        .CO({\t_V_reg_51_reg[12]_i_1_n_0 ,\t_V_reg_51_reg[12]_i_1_n_1 ,\t_V_reg_51_reg[12]_i_1_n_2 ,\t_V_reg_51_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\t_V_reg_51_reg[12]_i_1_n_4 ,\t_V_reg_51_reg[12]_i_1_n_5 ,\t_V_reg_51_reg[12]_i_1_n_6 ,\t_V_reg_51_reg[12]_i_1_n_7 }),
        .S(t_V_reg_51_reg[15:12]));
  FDRE \t_V_reg_51_reg[13] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[12]_i_1_n_6 ),
        .Q(t_V_reg_51_reg[13]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[14] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[12]_i_1_n_5 ),
        .Q(t_V_reg_51_reg[14]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[15] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[12]_i_1_n_4 ),
        .Q(t_V_reg_51_reg[15]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[16] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[16]_i_1_n_7 ),
        .Q(t_V_reg_51_reg[16]),
        .R(t_V_reg_51));
  CARRY4 \t_V_reg_51_reg[16]_i_1 
       (.CI(\t_V_reg_51_reg[12]_i_1_n_0 ),
        .CO({\t_V_reg_51_reg[16]_i_1_n_0 ,\t_V_reg_51_reg[16]_i_1_n_1 ,\t_V_reg_51_reg[16]_i_1_n_2 ,\t_V_reg_51_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\t_V_reg_51_reg[16]_i_1_n_4 ,\t_V_reg_51_reg[16]_i_1_n_5 ,\t_V_reg_51_reg[16]_i_1_n_6 ,\t_V_reg_51_reg[16]_i_1_n_7 }),
        .S(t_V_reg_51_reg[19:16]));
  FDRE \t_V_reg_51_reg[17] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[16]_i_1_n_6 ),
        .Q(t_V_reg_51_reg[17]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[18] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[16]_i_1_n_5 ),
        .Q(t_V_reg_51_reg[18]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[19] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[16]_i_1_n_4 ),
        .Q(t_V_reg_51_reg[19]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[1] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[0]_i_3_n_6 ),
        .Q(t_V_reg_51_reg[1]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[20] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[20]_i_1_n_7 ),
        .Q(t_V_reg_51_reg[20]),
        .R(t_V_reg_51));
  CARRY4 \t_V_reg_51_reg[20]_i_1 
       (.CI(\t_V_reg_51_reg[16]_i_1_n_0 ),
        .CO({\t_V_reg_51_reg[20]_i_1_n_0 ,\t_V_reg_51_reg[20]_i_1_n_1 ,\t_V_reg_51_reg[20]_i_1_n_2 ,\t_V_reg_51_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\t_V_reg_51_reg[20]_i_1_n_4 ,\t_V_reg_51_reg[20]_i_1_n_5 ,\t_V_reg_51_reg[20]_i_1_n_6 ,\t_V_reg_51_reg[20]_i_1_n_7 }),
        .S(t_V_reg_51_reg[23:20]));
  FDRE \t_V_reg_51_reg[21] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[20]_i_1_n_6 ),
        .Q(t_V_reg_51_reg[21]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[22] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[20]_i_1_n_5 ),
        .Q(t_V_reg_51_reg[22]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[23] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[20]_i_1_n_4 ),
        .Q(t_V_reg_51_reg[23]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[24] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[24]_i_1_n_7 ),
        .Q(t_V_reg_51_reg[24]),
        .R(t_V_reg_51));
  CARRY4 \t_V_reg_51_reg[24]_i_1 
       (.CI(\t_V_reg_51_reg[20]_i_1_n_0 ),
        .CO({\NLW_t_V_reg_51_reg[24]_i_1_CO_UNCONNECTED [3:2],\t_V_reg_51_reg[24]_i_1_n_2 ,\t_V_reg_51_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_t_V_reg_51_reg[24]_i_1_O_UNCONNECTED [3],\t_V_reg_51_reg[24]_i_1_n_5 ,\t_V_reg_51_reg[24]_i_1_n_6 ,\t_V_reg_51_reg[24]_i_1_n_7 }),
        .S({1'b0,t_V_reg_51_reg[26:24]}));
  FDRE \t_V_reg_51_reg[25] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[24]_i_1_n_6 ),
        .Q(t_V_reg_51_reg[25]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[26] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[24]_i_1_n_5 ),
        .Q(t_V_reg_51_reg[26]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[2] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[0]_i_3_n_5 ),
        .Q(t_V_reg_51_reg[2]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[3] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[0]_i_3_n_4 ),
        .Q(t_V_reg_51_reg[3]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[4] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[4]_i_1_n_7 ),
        .Q(t_V_reg_51_reg[4]),
        .R(t_V_reg_51));
  CARRY4 \t_V_reg_51_reg[4]_i_1 
       (.CI(\t_V_reg_51_reg[0]_i_3_n_0 ),
        .CO({\t_V_reg_51_reg[4]_i_1_n_0 ,\t_V_reg_51_reg[4]_i_1_n_1 ,\t_V_reg_51_reg[4]_i_1_n_2 ,\t_V_reg_51_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\t_V_reg_51_reg[4]_i_1_n_4 ,\t_V_reg_51_reg[4]_i_1_n_5 ,\t_V_reg_51_reg[4]_i_1_n_6 ,\t_V_reg_51_reg[4]_i_1_n_7 }),
        .S(t_V_reg_51_reg[7:4]));
  FDRE \t_V_reg_51_reg[5] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[4]_i_1_n_6 ),
        .Q(t_V_reg_51_reg[5]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[6] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[4]_i_1_n_5 ),
        .Q(t_V_reg_51_reg[6]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[7] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[4]_i_1_n_4 ),
        .Q(t_V_reg_51_reg[7]),
        .R(t_V_reg_51));
  FDRE \t_V_reg_51_reg[8] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[8]_i_1_n_7 ),
        .Q(t_V_reg_51_reg[8]),
        .R(t_V_reg_51));
  CARRY4 \t_V_reg_51_reg[8]_i_1 
       (.CI(\t_V_reg_51_reg[4]_i_1_n_0 ),
        .CO({\t_V_reg_51_reg[8]_i_1_n_0 ,\t_V_reg_51_reg[8]_i_1_n_1 ,\t_V_reg_51_reg[8]_i_1_n_2 ,\t_V_reg_51_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\t_V_reg_51_reg[8]_i_1_n_4 ,\t_V_reg_51_reg[8]_i_1_n_5 ,\t_V_reg_51_reg[8]_i_1_n_6 ,\t_V_reg_51_reg[8]_i_1_n_7 }),
        .S(t_V_reg_51_reg[11:8]));
  FDRE \t_V_reg_51_reg[9] 
       (.C(ap_clk),
        .CE(t_V_reg_510),
        .D(\t_V_reg_51_reg[8]_i_1_n_6 ),
        .Q(t_V_reg_51_reg[9]),
        .R(t_V_reg_51));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
