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


library ieee ;
use     ieee.std_logic_1164.all ;
use     ieee.std_logic_arith.all ;
use     ieee.std_logic_unsigned.all ;

entity NF_PHYIP_RESET_MODEL is
   port (
      clk                  :in std_logic;
      reset                :in std_logic;

      tx_serial_clk        :out std_logic_vector (0 downto 0);
      tx_analogreset       :out std_logic_vector (0 downto 0);
      tx_digitalreset      :out std_logic_vector (0 downto 0);
      tx_ready             :out std_logic;

      rx_analogreset       :out std_logic_vector (0 downto 0);
      rx_digitalreset      :out std_logic_vector (0 downto 0);
      rx_ready             :out std_logic;

      tx_cal_busy          :in std_logic_vector (0 downto 0);
      rx_is_lockedtodata   :in std_logic_vector (0 downto 0);
      rx_cal_busy          :in std_logic_vector (0 downto 0)
   );
end NF_PHYIP_RESET_MODEL;

architecture behave of NF_PHYIP_RESET_MODEL is
   signal clk_1250MHz               :std_logic_vector (0 downto 0);
   signal tx_digital_reset_count    :std_logic_vector (31 downto 0);
   signal rx_digital_reset_count    :std_logic_vector (31 downto 0);
   signal tx_ready_count            :std_logic_vector (31 downto 0);
   signal rx_ready_count            :std_logic_vector (31 downto 0);

   signal tx_analogreset_int        :std_logic_vector (0 downto 0);
   signal rx_analogreset_int        :std_logic_vector (0 downto 0);
   signal tx_digitalreset_int        :std_logic_vector (0 downto 0);
   signal rx_digitalreset_int        :std_logic_vector (0 downto 0);
begin

   -- 1250 MHz TX serial clock
   process
   begin
      clk_1250MHz (0) <= '1' ;
      wait for 400 ps;
      clk_1250MHz (0) <= '0' ;
      wait for 400 ps ;
   end process ;

   tx_serial_clk <= clk_1250MHz;

   -- TX digital reset duration
   process (clk, tx_analogreset_int)
   begin
      if (tx_analogreset_int(0) = '1') then
         tx_digital_reset_count <= conv_std_logic_vector (625, 32); -- 5000ns
      elsif (clk = '1') and (clk 'event) then
         if (tx_digital_reset_count /= 0) and (tx_cal_busy(0) = '0') then
            tx_digital_reset_count <= tx_digital_reset_count - 1;
         end if;
      end if;
   end process;

   -- RX digital reset duration
   process (clk, rx_analogreset_int)
   begin
      if (rx_analogreset_int(0) = '1') then
         rx_digital_reset_count <= conv_std_logic_vector (500, 32); -- 4000ns
      elsif (clk = '1') and (clk 'event) then
         if (rx_digital_reset_count /= 0) and (rx_cal_busy(0) = '0') and (rx_is_lockedtodata(0) = '1') then
            rx_digital_reset_count <= rx_digital_reset_count - 1;
         end if;
      end if;
   end process;

   -- TX ready duration
   process (clk, reset)
   begin
      if (reset = '1') then
         tx_ready_count <= conv_std_logic_vector (10, 32); -- 80ns
      elsif (clk = '1') and (clk 'event) then
         if (tx_digitalreset_int(0) = '0') and (tx_ready_count /= 0) then
            tx_ready_count <= tx_ready_count - 1;
         end if;
      end if;
   end process;

   -- RX ready duration
   process (clk, reset)
   begin
      if (reset = '1') then
         rx_ready_count <= conv_std_logic_vector (10, 32); -- 80ns
      elsif (clk = '1') and (clk 'event) then
         if (rx_digitalreset_int(0) = '0') and (rx_ready_count /= 0) then
            rx_ready_count <= rx_ready_count - 1;
         end if;
      end if;
   end process;

   -- TX and RX analog reset
   process (clk, reset)
   begin
      if (reset = '1') then
         tx_analogreset_int(0) <= '1';
         rx_analogreset_int(0) <= '1';
      elsif (clk = '1') and (clk 'event) then
         tx_analogreset_int(0) <= '0';
         rx_analogreset_int(0) <= '0';
      end if;
   end process;

   tx_analogreset(0) <= tx_analogreset_int(0);
   rx_analogreset(0) <= rx_analogreset_int(0);

   -- TX digital reset
   process (clk, reset)
   begin
      if (reset = '1') then
         tx_digitalreset_int(0) <= '1';
      elsif (clk = '1') and (clk 'event) then
         if (tx_digital_reset_count = 0) then
            tx_digitalreset_int(0) <= '0';
         end if;
      end if;
   end process;

   -- RX digital reset
   process (clk, reset)
   begin
      if (reset = '1') then
         rx_digitalreset_int(0) <= '1';
      elsif (clk = '1') and (clk 'event) then
         if (rx_digital_reset_count = 0) then
            rx_digitalreset_int(0) <= '0';
         end if;
      end if;
   end process;

   tx_digitalreset(0) <= tx_digitalreset_int(0);
   rx_digitalreset(0) <= rx_digitalreset_int(0);

   process (tx_ready_count, rx_ready_count)
   begin
      if (tx_ready_count = 0) then
         tx_ready <= '1';
      else
         tx_ready <= '0';
      end if;

      if (rx_ready_count = 0) then
         rx_ready <= '1';
      else
         rx_ready <= '0';
      end if;
   end process;

end behave;
