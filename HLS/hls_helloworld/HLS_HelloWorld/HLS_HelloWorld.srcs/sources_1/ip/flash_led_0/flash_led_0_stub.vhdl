-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sat May 13 14:33:12 2023
-- Host        : ppqppl running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/code-file/FPGA/HLS/hls_helloworld/HLS_HelloWorld/HLS_HelloWorld.srcs/sources_1/ip/flash_led_0/flash_led_0_stub.vhdl
-- Design      : flash_led_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flash_led_0 is
  Port ( 
    led_o_V_ap_vld : out STD_LOGIC;
    led_i_V_ap_vld : in STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    led_o_V : out STD_LOGIC_VECTOR ( 0 to 0 );
    led_i_V : in STD_LOGIC_VECTOR ( 0 to 0 )
  );

end flash_led_0;

architecture stub of flash_led_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "led_o_V_ap_vld,led_i_V_ap_vld,ap_clk,ap_rst,ap_start,ap_done,ap_idle,ap_ready,led_o_V[0:0],led_i_V[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "flash_led,Vivado 2018.3";
begin
end;
