-- (C) 2001-2018 Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions and other 
-- software and tools, and its AMPP partner logic functions, and any output 
-- files from any of the foregoing (including device programming or simulation 
-- files), and any associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License Subscription 
-- Agreement, Intel FPGA IP License Agreement, or other applicable 
-- license agreement, including, without limitation, that your use is for the 
-- sole purpose of programming logic devices manufactured by Intel and sold by 
-- Intel or its authorized distributors.  Please refer to the applicable 
-- agreement for further details.


-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------
--
-- Revision Control Information
--
-- $RCSfile: timing_adapter_32.vhd,v $
-- $Source: /ipbu/cvs/sio/projects/TriSpeedEthernet/src/testbench/models/vhdl/ethernet_model/gen/timing_adapter_32.vhd,v $
--
-- $Revision: #1 $
-- $Date: 2018/07/18 $
-- Check in by : $Author: psgswbuild $
-- Author      : SKNg
--
-- Project     : Triple Speed Ethernet - 10/100/1000 MAC
--
-- Description : Simulation Only
--
-- AVALON STREAMING TIMING ADAPTER FOR 32BIT IMPLEMENTATION

-- 
-- ALTERA Confidential and Proprietary
-- Copyright 2006 (c) Altera Corporation
-- All rights reserved
--
-- -------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity timing_adapter_32 is
port 
(
   -- Interface: clk
   clk               : in  std_logic;
   reset             : in  std_logic;
   -- Interface: in
   in_ready          : out std_logic;
   in_valid          : in  std_logic;
   in_data           : in  std_logic_vector (31 downto 0);
   in_startofpacket  : in  std_logic;
   in_endofpacket    : in  std_logic;
   in_empty          : in  std_logic_vector (1 downto 0);
   in_error          : in  std_logic;
   -- Interface: out
   out_ready         : in  std_logic;
   out_valid         : out std_logic;
   out_data          : out std_logic_vector (31 downto 0);
   out_startofpacket : out std_logic;
   out_endofpacket   : out std_logic;
   out_empty         : out std_logic_vector (1 downto 0);
   out_error         : out std_logic
);
end timing_adapter_32;

architecture behav of timing_adapter_32 is
   -- Component declaration
   component timing_adapter_fifo_32
   generic 
   (
      DEPTH       : integer := 8;
      DATA_WIDTH  : integer := 37;
      ADDR_WIDTH  : integer := 3
   );
   port
   (
      fill_level  : out std_logic_vector(3 downto 0);
      
      -- Interface: clock
      clk         : in  std_logic;
      reset       : in  std_logic;
      -- Interface: data_in
      in_ready    : out std_logic;
      in_valid    : in  std_logic;
      in_data     : in  std_logic_vector (36 downto 0);
      -- Interface: data_out
      out_ready   : in  std_logic;
      out_valid   : out std_logic;
      out_data    : out std_logic_vector (36 downto 0)
   );
   end component;

   -- ---------------------------------------------------------------------
   --| Signal Declarations
   -- ---------------------------------------------------------------------
   signal in_payload    : std_logic_vector(36 downto 0);
   signal out_payload   : std_logic_vector(36 downto 0);
   signal in_ready_wire : std_logic;
   signal out_valid_wire: std_logic;
   signal fifo_fill     : std_logic_vector(3 downto 0);
   signal ready         : std_logic;

begin
   -- ---------------------------------------------------------------------
   --| Payload Mapping
   -- ---------------------------------------------------------------------
   process (in_data, in_startofpacket, in_endofpacket, in_empty, in_error, out_payload) 
   begin
      in_payload <= in_data & in_startofpacket & in_endofpacket & in_empty & in_error;

      out_data             <= out_payload(36 downto 5);
      out_startofpacket    <= out_payload(4);
      out_endofpacket      <= out_payload(3);
      out_empty            <= out_payload(2 downto 1);
      out_error            <= out_payload(0);
   end process;

   -- ---------------------------------------------------------------------
   --| FIFO
   -- ---------------------------------------------------------------------
   timing_adapter_fifo: timing_adapter_fifo_32
   port map
   ( 
      clk         => clk,
      reset       => reset,
      in_ready    => open,
      in_valid    => in_valid,
      in_data     => in_payload,
      out_ready   => ready,
      out_valid   => out_valid_wire,
      out_data    => out_payload,
      fill_level  => fifo_fill
   );

   -- ---------------------------------------------------------------------
   --| Ready & valid signals.
   -- ---------------------------------------------------------------------
   process (fifo_fill, out_valid_wire, out_ready)
   begin
      if (fifo_fill < 3) then
        in_ready <= '1';
      else
        in_ready <= '0';
      end if;

      out_valid <= out_valid_wire;
      ready <= out_ready;
   end process;
end behav;
