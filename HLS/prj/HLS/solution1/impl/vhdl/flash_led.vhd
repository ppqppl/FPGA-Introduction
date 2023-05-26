-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2018.3
-- Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity flash_led is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    led_o_V : OUT STD_LOGIC_VECTOR (0 downto 0);
    led_o_V_ap_vld : OUT STD_LOGIC;
    led_i_V : IN STD_LOGIC_VECTOR (0 downto 0);
    led_i_V_ap_vld : IN STD_LOGIC );
end;


architecture behav of flash_led is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "flash_led,hls_ip_2018_3,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7z020clg400-2,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=1.967750,HLS_SYN_LAT=100000001,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=32,HLS_SYN_LUT=70,HLS_VERSION=2018_3}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (1 downto 0) := "10";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv27_0 : STD_LOGIC_VECTOR (26 downto 0) := "000000000000000000000000000";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv27_5F5E100 : STD_LOGIC_VECTOR (26 downto 0) := "101111101011110000100000000";
    constant ap_const_lv27_1 : STD_LOGIC_VECTOR (26 downto 0) := "000000000000000000000000001";
    constant ap_const_lv27_5F5E0FE : STD_LOGIC_VECTOR (26 downto 0) := "101111101011110000011111110";
    constant ap_const_boolean_1 : BOOLEAN := true;

    signal ap_CS_fsm : STD_LOGIC_VECTOR (1 downto 0) := "01";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal led_i_V_preg : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal led_i_V_in_sig : STD_LOGIC_VECTOR (0 downto 0);
    signal led_i_V_ap_vld_preg : STD_LOGIC := '0';
    signal led_i_V_ap_vld_in_sig : STD_LOGIC;
    signal led_i_V_blk_n : STD_LOGIC;
    signal r_V_fu_62_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal r_V_reg_86 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state1 : BOOLEAN;
    signal i_V_fu_74_p2 : STD_LOGIC_VECTOR (26 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal t_V_reg_51 : STD_LOGIC_VECTOR (26 downto 0);
    signal exitcond_fu_68_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_fu_80_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (1 downto 0);


begin




    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    led_i_V_ap_vld_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                led_i_V_ap_vld_preg <= ap_const_logic_0;
            else
                if (((exitcond_fu_68_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                    led_i_V_ap_vld_preg <= ap_const_logic_0;
                elsif ((not(((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) and (led_i_V_ap_vld = ap_const_logic_1))) then 
                    led_i_V_ap_vld_preg <= led_i_V_ap_vld;
                end if; 
            end if;
        end if;
    end process;


    led_i_V_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                led_i_V_preg <= ap_const_lv1_0;
            else
                if ((not(((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) and (led_i_V_ap_vld = ap_const_logic_1))) then 
                    led_i_V_preg <= led_i_V;
                end if; 
            end if;
        end if;
    end process;


    t_V_reg_51_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((exitcond_fu_68_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                t_V_reg_51 <= i_V_fu_74_p2;
            elsif ((not(((ap_start = ap_const_logic_0) or (led_i_V_ap_vld_in_sig = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                t_V_reg_51 <= ap_const_lv27_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not(((ap_start = ap_const_logic_0) or (led_i_V_ap_vld_in_sig = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                r_V_reg_86 <= r_V_fu_62_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, led_i_V_ap_vld_in_sig, ap_CS_fsm_state2, exitcond_fu_68_p2)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_start = ap_const_logic_0) or (led_i_V_ap_vld_in_sig = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((exitcond_fu_68_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state2;
                end if;
            when others =>  
                ap_NS_fsm <= "XX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);

    ap_block_state1_assign_proc : process(ap_start, led_i_V_ap_vld_in_sig)
    begin
                ap_block_state1 <= ((ap_start = ap_const_logic_0) or (led_i_V_ap_vld_in_sig = ap_const_logic_0));
    end process;


    ap_done_assign_proc : process(ap_CS_fsm_state2, exitcond_fu_68_p2)
    begin
        if (((exitcond_fu_68_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state2, exitcond_fu_68_p2)
    begin
        if (((exitcond_fu_68_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    exitcond_fu_68_p2 <= "1" when (t_V_reg_51 = ap_const_lv27_5F5E100) else "0";
    i_V_fu_74_p2 <= std_logic_vector(unsigned(t_V_reg_51) + unsigned(ap_const_lv27_1));

    led_i_V_ap_vld_in_sig_assign_proc : process(led_i_V_ap_vld, led_i_V_ap_vld_preg)
    begin
        if ((led_i_V_ap_vld = ap_const_logic_1)) then 
            led_i_V_ap_vld_in_sig <= led_i_V_ap_vld;
        else 
            led_i_V_ap_vld_in_sig <= led_i_V_ap_vld_preg;
        end if; 
    end process;


    led_i_V_blk_n_assign_proc : process(ap_start, ap_CS_fsm_state1, led_i_V_ap_vld)
    begin
        if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            led_i_V_blk_n <= led_i_V_ap_vld;
        else 
            led_i_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    led_i_V_in_sig_assign_proc : process(led_i_V, led_i_V_preg, led_i_V_ap_vld)
    begin
        if ((led_i_V_ap_vld = ap_const_logic_1)) then 
            led_i_V_in_sig <= led_i_V;
        else 
            led_i_V_in_sig <= led_i_V_preg;
        end if; 
    end process;

    led_o_V <= r_V_reg_86;

    led_o_V_ap_vld_assign_proc : process(ap_CS_fsm_state2, exitcond_fu_68_p2, tmp_fu_80_p2)
    begin
        if (((tmp_fu_80_p2 = ap_const_lv1_1) and (exitcond_fu_68_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            led_o_V_ap_vld <= ap_const_logic_1;
        else 
            led_o_V_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    r_V_fu_62_p2 <= (led_i_V_in_sig xor ap_const_lv1_1);
    tmp_fu_80_p2 <= "1" when (t_V_reg_51 = ap_const_lv27_5F5E0FE) else "0";
end behav;
