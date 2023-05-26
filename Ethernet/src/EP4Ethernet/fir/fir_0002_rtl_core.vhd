-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 17.0 (Release Build #595)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2017 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from fir_0002_rtl_core
-- VHDL created on Thu May 20 15:15:59 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity fir_0002_rtl_core is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(15 downto 0);  -- sfix16
        xOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        xOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        xOut_0 : out std_logic_vector(38 downto 0);  -- sfix39
        clk : in std_logic;
        areset : in std_logic
    );
end fir_0002_rtl_core;

architecture normal of fir_0002_rtl_core is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_q : STD_LOGIC_VECTOR (15 downto 0);
    signal d_in0_m0_wi0_wo0_assign_id1_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_count : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_run_preEnaQ : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_out : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_enableQ : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_ctrl : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_memread_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_compute_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_16_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_17_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_inner_q : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_inner_i : SIGNED (5 downto 0);
    attribute preserve : boolean;
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count0_inner_i : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count0_q : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_i : UNSIGNED (4 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count0_i : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count1_lutreg_q : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_i : UNSIGNED (4 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count1_i : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count1_eq : std_logic;
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count1_eq : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_a : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_b : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_o : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_q : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_ra2_count1_lutreg_q : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_ra2_add_0_0_a : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_ra2_add_0_0_b : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_ra2_add_0_0_o : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_ra2_add_0_0_q : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_we2_seq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we2_seq_eq : std_logic;
    signal u0_m0_wo0_wi0_r0_wa0_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_wa0_i : UNSIGNED (4 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_wa0_i : signal is true;
    signal u0_m0_wo0_wi0_r0_wa2_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_wa2_i : UNSIGNED (4 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_wa2_i : signal is true;
    signal u0_m0_wo0_wi0_r0_memr0_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr0_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_memr2_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr2_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_memr2_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_memr2_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_memr2_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_memr2_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_ca1_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_ca1_i : UNSIGNED (4 downto 0);
    attribute preserve of u0_m0_wo0_ca1_i : signal is true;
    signal u0_m0_wo0_ca1_eq : std_logic;
    attribute preserve of u0_m0_wo0_ca1_eq : signal is true;
    signal u0_m0_wo0_cm0_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_cm1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_sym_add0_a : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_sym_add0_b : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_sym_add0_o : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_sym_add0_q : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_symSuppress_1_seq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_symSuppress_1_seq_eq : std_logic;
    signal u0_m0_wo0_sym_add1_a : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_sym_add1_b : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_sym_add1_i : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_sym_add1_o : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_sym_add1_q : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_b0 : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_s1 : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_b0 : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_s1 : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_0_q : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_mtree_add0_0_a : STD_LOGIC_VECTOR (33 downto 0);
    signal u0_m0_wo0_mtree_add0_0_b : STD_LOGIC_VECTOR (33 downto 0);
    signal u0_m0_wo0_mtree_add0_0_o : STD_LOGIC_VECTOR (33 downto 0);
    signal u0_m0_wo0_mtree_add0_0_q : STD_LOGIC_VECTOR (33 downto 0);
    signal u0_m0_wo0_aseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_aseq_eq : std_logic;
    signal u0_m0_wo0_accum_a : STD_LOGIC_VECTOR (38 downto 0);
    signal u0_m0_wo0_accum_b : STD_LOGIC_VECTOR (38 downto 0);
    signal u0_m0_wo0_accum_i : STD_LOGIC_VECTOR (38 downto 0);
    signal u0_m0_wo0_accum_o : STD_LOGIC_VECTOR (38 downto 0);
    signal u0_m0_wo0_accum_q : STD_LOGIC_VECTOR (38 downto 0);
    signal u0_m0_wo0_oseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_eq : std_logic;
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr1_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_rdcnt_q : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_rdcnt_i : UNSIGNED (8 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr1_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq : std_logic;
    attribute preserve of u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr1_wraddr_q : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_last_q : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_run_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_gated_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_cmp_b : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_lut_q : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_ra2_count1_lut_q : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_resize_in : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_resize_b : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_ra2_resize_in : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_ra2_resize_b : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_join1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_wi0_r0_split1_b : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_split1_c : STD_LOGIC_VECTOR (15 downto 0);

begin


    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- u0_m0_wo0_run(ENABLEGENERATOR,13)@10 + 2
    u0_m0_wo0_run_ctrl <= u0_m0_wo0_run_out & xIn_v & u0_m0_wo0_run_enableQ;
    u0_m0_wo0_run_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_run_enable_c : SIGNED(5 downto 0);
        variable u0_m0_wo0_run_inc : SIGNED(1 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_run_q <= "0";
            u0_m0_wo0_run_enable_c := TO_SIGNED(19, 6);
            u0_m0_wo0_run_enableQ <= "0";
            u0_m0_wo0_run_count <= "00";
            u0_m0_wo0_run_inc := (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_run_out = "1") THEN
                IF (u0_m0_wo0_run_enable_c(5) = '1') THEN
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c - (-20);
                ELSE
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c + (-1);
                END IF;
                u0_m0_wo0_run_enableQ <= STD_LOGIC_VECTOR(u0_m0_wo0_run_enable_c(5 downto 5));
            ELSE
                u0_m0_wo0_run_enableQ <= "0";
            END IF;
            CASE (u0_m0_wo0_run_ctrl) IS
                WHEN "000" | "001" => u0_m0_wo0_run_inc := "00";
                WHEN "010" | "011" => u0_m0_wo0_run_inc := "11";
                WHEN "100" => u0_m0_wo0_run_inc := "00";
                WHEN "101" => u0_m0_wo0_run_inc := "01";
                WHEN "110" => u0_m0_wo0_run_inc := "11";
                WHEN "111" => u0_m0_wo0_run_inc := "00";
                WHEN OTHERS => 
            END CASE;
            u0_m0_wo0_run_count <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_run_count) + SIGNED(u0_m0_wo0_run_inc));
            u0_m0_wo0_run_q <= u0_m0_wo0_run_out;
        END IF;
    END PROCESS;
    u0_m0_wo0_run_preEnaQ <= u0_m0_wo0_run_count(1 downto 1);
    u0_m0_wo0_run_out <= u0_m0_wo0_run_preEnaQ and VCC_q;

    -- u0_m0_wo0_memread(DELAY,14)@12
    u0_m0_wo0_memread : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_run_q, xout => u0_m0_wo0_memread_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_compute(DELAY,16)@12
    u0_m0_wo0_compute : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => u0_m0_wo0_compute_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_13(DELAY,68)@12 + 1
    d_u0_m0_wo0_compute_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_compute_q, xout => d_u0_m0_wo0_compute_q_13_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_16(DELAY,69)@13 + 3
    d_u0_m0_wo0_compute_q_16 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_13_q, xout => d_u0_m0_wo0_compute_q_16_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_aseq(SEQUENCE,55)@16 + 1
    u0_m0_wo0_aseq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_aseq_c : SIGNED(6 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_aseq_c := "0000000";
            u0_m0_wo0_aseq_q <= "0";
            u0_m0_wo0_aseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_16_q = "1") THEN
                IF (u0_m0_wo0_aseq_c = "0000000") THEN
                    u0_m0_wo0_aseq_eq <= '1';
                ELSE
                    u0_m0_wo0_aseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_aseq_eq = '1') THEN
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c + 20;
                ELSE
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c - 1;
                END IF;
                u0_m0_wo0_aseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_aseq_c(6 downto 6));
            END IF;
        END IF;
    END PROCESS;

    -- d_u0_m0_wo0_compute_q_17(DELAY,70)@16 + 1
    d_u0_m0_wo0_compute_q_17 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_16_q, xout => d_u0_m0_wo0_compute_q_17_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr1_notEnable(LOGICAL,77)@13
    u0_m0_wo0_wi0_r0_delayr1_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr1_nor(LOGICAL,78)@13
    u0_m0_wo0_wi0_r0_delayr1_nor_q <= not (u0_m0_wo0_wi0_r0_delayr1_notEnable_q or u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr1_mem_last(CONSTANT,74)
    u0_m0_wo0_wi0_r0_delayr1_mem_last_q <= "0110110110";

    -- u0_m0_wo0_wi0_r0_delayr1_cmp(LOGICAL,75)@13
    u0_m0_wo0_wi0_r0_delayr1_cmp_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_delayr1_rdcnt_q);
    u0_m0_wo0_wi0_r0_delayr1_cmp_q <= "1" WHEN u0_m0_wo0_wi0_r0_delayr1_mem_last_q = u0_m0_wo0_wi0_r0_delayr1_cmp_b ELSE "0";

    -- u0_m0_wo0_wi0_r0_delayr1_cmpReg(REG,76)@13 + 1
    u0_m0_wo0_wi0_r0_delayr1_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr1_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr1_cmpReg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr1_sticky_ena(REG,79)@13 + 1
    u0_m0_wo0_wi0_r0_delayr1_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr1_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr1_enaAnd(LOGICAL,80)@13
    u0_m0_wo0_wi0_r0_delayr1_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr1_rdcnt(COUNTER,72)@13 + 1
    -- low=0, high=439, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr1_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr1_rdcnt_i <= TO_UNSIGNED(0, 9);
            u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                IF (u0_m0_wo0_wi0_r0_delayr1_rdcnt_i = TO_UNSIGNED(438, 9)) THEN
                    u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq <= '1';
                ELSE
                    u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq <= '0';
                END IF;
                IF (u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq = '1') THEN
                    u0_m0_wo0_wi0_r0_delayr1_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr1_rdcnt_i + 73;
                ELSE
                    u0_m0_wo0_wi0_r0_delayr1_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr1_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr1_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr1_rdcnt_i, 9)));

    -- u0_m0_wo0_wi0_r0_ra0_count1(COUNTER,24)@12
    -- low=0, high=20, step=1, init=1
    u0_m0_wo0_wi0_r0_ra0_count1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count1_i <= TO_UNSIGNED(1, 5);
            u0_m0_wo0_wi0_r0_ra0_count1_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                IF (u0_m0_wo0_wi0_r0_ra0_count1_i = TO_UNSIGNED(19, 5)) THEN
                    u0_m0_wo0_wi0_r0_ra0_count1_eq <= '1';
                ELSE
                    u0_m0_wo0_wi0_r0_ra0_count1_eq <= '0';
                END IF;
                IF (u0_m0_wo0_wi0_r0_ra0_count1_eq = '1') THEN
                    u0_m0_wo0_wi0_r0_ra0_count1_i <= u0_m0_wo0_wi0_r0_ra0_count1_i + 12;
                ELSE
                    u0_m0_wo0_wi0_r0_ra0_count1_i <= u0_m0_wo0_wi0_r0_ra0_count1_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_count1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra0_count1_i, 5)));

    -- u0_m0_wo0_wi0_r0_ra2_count1_lut(LOOKUP,30)@12
    u0_m0_wo0_wi0_r0_ra2_count1_lut_combproc: PROCESS (u0_m0_wo0_wi0_r0_ra0_count1_q)
    BEGIN
        -- Begin reserved scope level
        CASE (u0_m0_wo0_wi0_r0_ra0_count1_q) IS
            WHEN "00000" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "001010";
            WHEN "00001" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "001001";
            WHEN "00010" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "001000";
            WHEN "00011" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "000111";
            WHEN "00100" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "000110";
            WHEN "00101" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "000101";
            WHEN "00110" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "000100";
            WHEN "00111" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "000011";
            WHEN "01000" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "000010";
            WHEN "01001" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "000001";
            WHEN "01010" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "000000";
            WHEN "01011" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "011111";
            WHEN "01100" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "011110";
            WHEN "01101" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "011101";
            WHEN "01110" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "011100";
            WHEN "01111" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "011011";
            WHEN "10000" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "011010";
            WHEN "10001" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "011001";
            WHEN "10010" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "011000";
            WHEN "10011" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "010111";
            WHEN "10100" => u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= "010110";
            WHEN OTHERS => -- unreachable
                           u0_m0_wo0_wi0_r0_ra2_count1_lut_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra2_count1_lutreg(REG,31)@12
    u0_m0_wo0_wi0_r0_ra2_count1_lutreg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra2_count1_lutreg_q <= "001010";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra2_count1_lutreg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra2_count1_lut_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra0_count0_inner(COUNTER,19)@12
    -- low=-1, high=19, step=-1, init=19
    u0_m0_wo0_wi0_r0_ra0_count0_inner_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count0_inner_i <= TO_SIGNED(19, 6);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                IF (u0_m0_wo0_wi0_r0_ra0_count0_inner_i(5 downto 5) = "1") THEN
                    u0_m0_wo0_wi0_r0_ra0_count0_inner_i <= u0_m0_wo0_wi0_r0_ra0_count0_inner_i - 44;
                ELSE
                    u0_m0_wo0_wi0_r0_ra0_count0_inner_i <= u0_m0_wo0_wi0_r0_ra0_count0_inner_i - 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_count0_inner_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra0_count0_inner_i, 6)));

    -- u0_m0_wo0_wi0_r0_ra0_count0_run(LOGICAL,20)@12
    u0_m0_wo0_wi0_r0_ra0_count0_run_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_count0_inner_q(5 downto 5));

    -- u0_m0_wo0_wi0_r0_ra0_count0(COUNTER,21)@12
    -- low=0, high=31, step=1, init=0
    u0_m0_wo0_wi0_r0_ra0_count0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count0_i <= TO_UNSIGNED(0, 5);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1" and u0_m0_wo0_wi0_r0_ra0_count0_run_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra0_count0_i <= u0_m0_wo0_wi0_r0_ra0_count0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_count0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra0_count0_i, 6)));

    -- u0_m0_wo0_wi0_r0_ra2_add_0_0(ADD,33)@12 + 1
    u0_m0_wo0_wi0_r0_ra2_add_0_0_a <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_ra0_count0_q);
    u0_m0_wo0_wi0_r0_ra2_add_0_0_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_ra2_count1_lutreg_q);
    u0_m0_wo0_wi0_r0_ra2_add_0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra2_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_ra2_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(u0_m0_wo0_wi0_r0_ra2_add_0_0_a) + UNSIGNED(u0_m0_wo0_wi0_r0_ra2_add_0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra2_add_0_0_q <= u0_m0_wo0_wi0_r0_ra2_add_0_0_o(6 downto 0);

    -- u0_m0_wo0_wi0_r0_ra2_resize(BITSELECT,34)@13
    u0_m0_wo0_wi0_r0_ra2_resize_in <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra2_add_0_0_q(4 downto 0));
    u0_m0_wo0_wi0_r0_ra2_resize_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra2_resize_in(4 downto 0));

    -- u0_m0_wo0_wi0_r0_we2_seq(SEQUENCE,35)@12 + 1
    u0_m0_wo0_wi0_r0_we2_seq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_wi0_r0_we2_seq_c : SIGNED(6 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_we2_seq_c := "0000011";
            u0_m0_wo0_wi0_r0_we2_seq_q <= "0";
            u0_m0_wo0_wi0_r0_we2_seq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_wi0_r0_we2_seq_c = "0000000") THEN
                    u0_m0_wo0_wi0_r0_we2_seq_eq <= '1';
                ELSE
                    u0_m0_wo0_wi0_r0_we2_seq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_wi0_r0_we2_seq_eq = '1') THEN
                    u0_m0_wo0_wi0_r0_we2_seq_c := u0_m0_wo0_wi0_r0_we2_seq_c + 20;
                ELSE
                    u0_m0_wo0_wi0_r0_we2_seq_c := u0_m0_wo0_wi0_r0_we2_seq_c - 1;
                END IF;
                u0_m0_wo0_wi0_r0_we2_seq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_we2_seq_c(6 downto 6));
            ELSE
                u0_m0_wo0_wi0_r0_we2_seq_q <= "0";
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_wa2(COUNTER,37)@13
    -- low=0, high=31, step=1, init=11
    u0_m0_wo0_wi0_r0_wa2_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_wa2_i <= TO_UNSIGNED(11, 5);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_we2_seq_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa2_i <= u0_m0_wo0_wi0_r0_wa2_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_wa2_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_wa2_i, 5)));

    -- u0_m0_wo0_wi0_r0_memr2(DUALMEM,39)@13
    u0_m0_wo0_wi0_r0_memr2_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_split1_b);
    u0_m0_wo0_wi0_r0_memr2_aa <= u0_m0_wo0_wi0_r0_wa2_q;
    u0_m0_wo0_wi0_r0_memr2_ab <= u0_m0_wo0_wi0_r0_ra2_resize_b;
    u0_m0_wo0_wi0_r0_memr2_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 5,
        numwords_a => 32,
        width_b => 16,
        widthad_b => 5,
        numwords_b => 32,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone IV E"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr2_aa,
        data_a => u0_m0_wo0_wi0_r0_memr2_ia,
        wren_a => u0_m0_wo0_wi0_r0_we2_seq_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr2_ab,
        q_b => u0_m0_wo0_wi0_r0_memr2_iq
    );
    u0_m0_wo0_wi0_r0_memr2_q <= u0_m0_wo0_wi0_r0_memr2_iq(15 downto 0);

    -- u0_m0_wo0_wi0_r0_join1(BITJOIN,40)@13
    u0_m0_wo0_wi0_r0_join1_q <= u0_m0_wo0_wi0_r0_memr2_q & u0_m0_wo0_wi0_r0_memr0_q;

    -- u0_m0_wo0_wi0_r0_delayr1_wraddr(REG,73)@13 + 1
    u0_m0_wo0_wi0_r0_delayr1_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr1_wraddr_q <= "110110111";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr1_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr1_mem(DUALMEM,71)@13 + 2
    u0_m0_wo0_wi0_r0_delayr1_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join1_q);
    u0_m0_wo0_wi0_r0_delayr1_mem_aa <= u0_m0_wo0_wi0_r0_delayr1_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr1_mem_ab <= u0_m0_wo0_wi0_r0_delayr1_rdcnt_q;
    u0_m0_wo0_wi0_r0_delayr1_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr1_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 440,
        width_b => 32,
        widthad_b => 9,
        numwords_b => 440,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone IV E"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr1_enaAnd_q(0),
        clocken0 => d_u0_m0_wo0_compute_q_13_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr1_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr1_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr1_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr1_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr1_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr1_mem_q <= u0_m0_wo0_wi0_r0_delayr1_mem_iq(31 downto 0);

    -- u0_m0_wo0_wi0_r0_split1(BITSELECT,41)@13
    u0_m0_wo0_wi0_r0_split1_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_mem_q(15 downto 0));
    u0_m0_wo0_wi0_r0_split1_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_mem_q(31 downto 16));

    -- u0_m0_wo0_wi0_r0_ra0_count1_lut(LOOKUP,22)@12
    u0_m0_wo0_wi0_r0_ra0_count1_lut_combproc: PROCESS (u0_m0_wo0_wi0_r0_ra0_count1_q)
    BEGIN
        -- Begin reserved scope level
        CASE (u0_m0_wo0_wi0_r0_ra0_count1_q) IS
            WHEN "00000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "010101";
            WHEN "00001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "010110";
            WHEN "00010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "010111";
            WHEN "00011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "011000";
            WHEN "00100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "011001";
            WHEN "00101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "011010";
            WHEN "00110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "011011";
            WHEN "00111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "011100";
            WHEN "01000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "011101";
            WHEN "01001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "011110";
            WHEN "01010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "011111";
            WHEN "01011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "000000";
            WHEN "01100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "000001";
            WHEN "01101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "000010";
            WHEN "01110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "000011";
            WHEN "01111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "000100";
            WHEN "10000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "000101";
            WHEN "10001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "000110";
            WHEN "10010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "000111";
            WHEN "10011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "001000";
            WHEN "10100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "001001";
            WHEN OTHERS => -- unreachable
                           u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra0_count1_lutreg(REG,23)@12
    u0_m0_wo0_wi0_r0_ra0_count1_lutreg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count1_lutreg_q <= "010101";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra0_count1_lutreg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_count1_lut_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra0_add_0_0(ADD,25)@12 + 1
    u0_m0_wo0_wi0_r0_ra0_add_0_0_a <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_ra0_count0_q);
    u0_m0_wo0_wi0_r0_ra0_add_0_0_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_ra0_count1_lutreg_q);
    u0_m0_wo0_wi0_r0_ra0_add_0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(u0_m0_wo0_wi0_r0_ra0_add_0_0_a) + UNSIGNED(u0_m0_wo0_wi0_r0_ra0_add_0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_add_0_0_q <= u0_m0_wo0_wi0_r0_ra0_add_0_0_o(6 downto 0);

    -- u0_m0_wo0_wi0_r0_ra0_resize(BITSELECT,26)@13
    u0_m0_wo0_wi0_r0_ra0_resize_in <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_add_0_0_q(4 downto 0));
    u0_m0_wo0_wi0_r0_ra0_resize_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_resize_in(4 downto 0));

    -- d_xIn_0_13(DELAY,65)@10 + 3
    d_xIn_0_13 : dspba_delay
    GENERIC MAP ( width => 16, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => xIn_0, xout => d_xIn_0_13_q, clk => clk, aclr => areset );

    -- d_in0_m0_wi0_wo0_assign_id1_q_13(DELAY,66)@10 + 3
    d_in0_m0_wi0_wo0_assign_id1_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => xIn_v, xout => d_in0_m0_wi0_wo0_assign_id1_q_13_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_wa0(COUNTER,36)@13
    -- low=0, high=31, step=1, init=9
    u0_m0_wo0_wi0_r0_wa0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_wa0_i <= TO_UNSIGNED(9, 5);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_in0_m0_wi0_wo0_assign_id1_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa0_i <= u0_m0_wo0_wi0_r0_wa0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_wa0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_wa0_i, 5)));

    -- u0_m0_wo0_wi0_r0_memr0(DUALMEM,38)@13
    u0_m0_wo0_wi0_r0_memr0_ia <= STD_LOGIC_VECTOR(d_xIn_0_13_q);
    u0_m0_wo0_wi0_r0_memr0_aa <= u0_m0_wo0_wi0_r0_wa0_q;
    u0_m0_wo0_wi0_r0_memr0_ab <= u0_m0_wo0_wi0_r0_ra0_resize_b;
    u0_m0_wo0_wi0_r0_memr0_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 5,
        numwords_a => 32,
        width_b => 16,
        widthad_b => 5,
        numwords_b => 32,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone IV E"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr0_aa,
        data_a => u0_m0_wo0_wi0_r0_memr0_ia,
        wren_a => d_in0_m0_wi0_wo0_assign_id1_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr0_ab,
        q_b => u0_m0_wo0_wi0_r0_memr0_iq
    );
    u0_m0_wo0_wi0_r0_memr0_q <= u0_m0_wo0_wi0_r0_memr0_iq(15 downto 0);

    -- u0_m0_wo0_sym_add0(ADD,49)@13 + 1
    u0_m0_wo0_sym_add0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => u0_m0_wo0_wi0_r0_memr0_q(15)) & u0_m0_wo0_wi0_r0_memr0_q));
    u0_m0_wo0_sym_add0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => u0_m0_wo0_wi0_r0_split1_c(15)) & u0_m0_wo0_wi0_r0_split1_c));
    u0_m0_wo0_sym_add0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_sym_add0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_sym_add0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_sym_add0_a) + SIGNED(u0_m0_wo0_sym_add0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_sym_add0_q <= u0_m0_wo0_sym_add0_o(16 downto 0);

    -- u0_m0_wo0_ca1(COUNTER,43)@13
    -- low=0, high=20, step=1, init=0
    u0_m0_wo0_ca1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_ca1_i <= TO_UNSIGNED(0, 5);
            u0_m0_wo0_ca1_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                IF (u0_m0_wo0_ca1_i = TO_UNSIGNED(19, 5)) THEN
                    u0_m0_wo0_ca1_eq <= '1';
                ELSE
                    u0_m0_wo0_ca1_eq <= '0';
                END IF;
                IF (u0_m0_wo0_ca1_eq = '1') THEN
                    u0_m0_wo0_ca1_i <= u0_m0_wo0_ca1_i + 12;
                ELSE
                    u0_m0_wo0_ca1_i <= u0_m0_wo0_ca1_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_ca1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_ca1_i, 5)));

    -- u0_m0_wo0_cm0(LOOKUP,47)@13 + 1
    u0_m0_wo0_cm0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cm0_q <= "0000000000000000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (u0_m0_wo0_ca1_q) IS
                WHEN "00000" => u0_m0_wo0_cm0_q <= "0000000000000000";
                WHEN "00001" => u0_m0_wo0_cm0_q <= "0000001000110011";
                WHEN "00010" => u0_m0_wo0_cm0_q <= "0000001101101010";
                WHEN "00011" => u0_m0_wo0_cm0_q <= "0000001011100010";
                WHEN "00100" => u0_m0_wo0_cm0_q <= "0000000011111011";
                WHEN "00101" => u0_m0_wo0_cm0_q <= "1111111011100111";
                WHEN "00110" => u0_m0_wo0_cm0_q <= "1111110111001111";
                WHEN "00111" => u0_m0_wo0_cm0_q <= "1111111000010001";
                WHEN "01000" => u0_m0_wo0_cm0_q <= "1111111100100010";
                WHEN "01001" => u0_m0_wo0_cm0_q <= "0000000000010011";
                WHEN "01010" => u0_m0_wo0_cm0_q <= "0000000001001000";
                WHEN "01011" => u0_m0_wo0_cm0_q <= "1111111111100010";
                WHEN "01100" => u0_m0_wo0_cm0_q <= "1111111110000101";
                WHEN "01101" => u0_m0_wo0_cm0_q <= "1111111111000011";
                WHEN "01110" => u0_m0_wo0_cm0_q <= "0000000010011111";
                WHEN "01111" => u0_m0_wo0_cm0_q <= "0000000110000101";
                WHEN "10000" => u0_m0_wo0_cm0_q <= "0000000111000000";
                WHEN "10001" => u0_m0_wo0_cm0_q <= "0000000100000100";
                WHEN "10010" => u0_m0_wo0_cm0_q <= "1111111110110001";
                WHEN "10011" => u0_m0_wo0_cm0_q <= "1111111010001100";
                WHEN "10100" => u0_m0_wo0_cm0_q <= "1111111000111010";
                WHEN OTHERS => -- unreachable
                               u0_m0_wo0_cm0_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_mtree_mult1_1(MULT,52)@14 + 2
    u0_m0_wo0_mtree_mult1_1_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm0_q);
    u0_m0_wo0_mtree_mult1_1_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_sym_add0_q);
    u0_m0_wo0_mtree_mult1_1_reset <= areset;
    u0_m0_wo0_mtree_mult1_1_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 16,
        lpm_widthb => 17,
        lpm_widthp => 33,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_1_a0,
        datab => u0_m0_wo0_mtree_mult1_1_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_1_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_1_s1
    );
    u0_m0_wo0_mtree_mult1_1_q <= u0_m0_wo0_mtree_mult1_1_s1;

    -- u0_m0_wo0_symSuppress_1_seq(SEQUENCE,50)@12 + 1
    u0_m0_wo0_symSuppress_1_seq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_symSuppress_1_seq_c : SIGNED(6 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_symSuppress_1_seq_c := "0000001";
            u0_m0_wo0_symSuppress_1_seq_q <= "0";
            u0_m0_wo0_symSuppress_1_seq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_symSuppress_1_seq_c = "0000000") THEN
                    u0_m0_wo0_symSuppress_1_seq_eq <= '1';
                ELSE
                    u0_m0_wo0_symSuppress_1_seq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_symSuppress_1_seq_eq = '1') THEN
                    u0_m0_wo0_symSuppress_1_seq_c := u0_m0_wo0_symSuppress_1_seq_c + 20;
                ELSE
                    u0_m0_wo0_symSuppress_1_seq_c := u0_m0_wo0_symSuppress_1_seq_c - 1;
                END IF;
                u0_m0_wo0_symSuppress_1_seq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_symSuppress_1_seq_c(6 downto 6));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_sym_add1(ADD,51)@13 + 1
    u0_m0_wo0_sym_add1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => u0_m0_wo0_wi0_r0_split1_b(15)) & u0_m0_wo0_wi0_r0_split1_b));
    u0_m0_wo0_sym_add1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => u0_m0_wo0_wi0_r0_memr2_q(15)) & u0_m0_wo0_wi0_r0_memr2_q));
    u0_m0_wo0_sym_add1_i <= u0_m0_wo0_sym_add1_a;
    u0_m0_wo0_sym_add1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_sym_add1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_symSuppress_1_seq_q = "1") THEN
                u0_m0_wo0_sym_add1_o <= u0_m0_wo0_sym_add1_i;
            ELSE
                u0_m0_wo0_sym_add1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_sym_add1_a) + SIGNED(u0_m0_wo0_sym_add1_b));
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_sym_add1_q <= u0_m0_wo0_sym_add1_o(16 downto 0);

    -- u0_m0_wo0_cm1(LOOKUP,48)@13 + 1
    u0_m0_wo0_cm1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cm1_q <= "0000000000000000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (u0_m0_wo0_ca1_q) IS
                WHEN "00000" => u0_m0_wo0_cm1_q <= "0000000000000000";
                WHEN "00001" => u0_m0_wo0_cm1_q <= "0001000000110110";
                WHEN "00010" => u0_m0_wo0_cm1_q <= "0000110000111110";
                WHEN "00011" => u0_m0_wo0_cm1_q <= "0000001001110111";
                WHEN "00100" => u0_m0_wo0_cm1_q <= "1111100000001101";
                WHEN "00101" => u0_m0_wo0_cm1_q <= "1111001000111111";
                WHEN "00110" => u0_m0_wo0_cm1_q <= "1111001110000001";
                WHEN "00111" => u0_m0_wo0_cm1_q <= "1111101001011011";
                WHEN "01000" => u0_m0_wo0_cm1_q <= "0000001010011110";
                WHEN "01001" => u0_m0_wo0_cm1_q <= "0000011111111110";
                WHEN "01010" => u0_m0_wo0_cm1_q <= "0000100001110101";
                WHEN "01011" => u0_m0_wo0_cm1_q <= "0000010011111100";
                WHEN "01100" => u0_m0_wo0_cm1_q <= "0000000001110001";
                WHEN "01101" => u0_m0_wo0_cm1_q <= "1111110110001001";
                WHEN "01110" => u0_m0_wo0_cm1_q <= "1111110100111101";
                WHEN "01111" => u0_m0_wo0_cm1_q <= "1111111010011010";
                WHEN "10000" => u0_m0_wo0_cm1_q <= "1111111111011000";
                WHEN "10001" => u0_m0_wo0_cm1_q <= "1111111111001111";
                WHEN "10010" => u0_m0_wo0_cm1_q <= "1111111010111001";
                WHEN "10011" => u0_m0_wo0_cm1_q <= "1111110111001111";
                WHEN "10100" => u0_m0_wo0_cm1_q <= "1111111000110011";
                WHEN OTHERS => -- unreachable
                               u0_m0_wo0_cm1_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_mtree_mult1_0(MULT,53)@14 + 2
    u0_m0_wo0_mtree_mult1_0_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm1_q);
    u0_m0_wo0_mtree_mult1_0_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_sym_add1_q);
    u0_m0_wo0_mtree_mult1_0_reset <= areset;
    u0_m0_wo0_mtree_mult1_0_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 16,
        lpm_widthb => 17,
        lpm_widthp => 33,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_0_a0,
        datab => u0_m0_wo0_mtree_mult1_0_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_0_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_0_s1
    );
    u0_m0_wo0_mtree_mult1_0_q <= u0_m0_wo0_mtree_mult1_0_s1;

    -- u0_m0_wo0_mtree_add0_0(ADD,54)@16 + 1
    u0_m0_wo0_mtree_add0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => u0_m0_wo0_mtree_mult1_0_q(32)) & u0_m0_wo0_mtree_mult1_0_q));
    u0_m0_wo0_mtree_add0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => u0_m0_wo0_mtree_mult1_1_q(32)) & u0_m0_wo0_mtree_mult1_1_q));
    u0_m0_wo0_mtree_add0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_0_a) + SIGNED(u0_m0_wo0_mtree_add0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_0_q <= u0_m0_wo0_mtree_add0_0_o(33 downto 0);

    -- u0_m0_wo0_accum(ADD,56)@17 + 1
    u0_m0_wo0_accum_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 34 => u0_m0_wo0_mtree_add0_0_q(33)) & u0_m0_wo0_mtree_add0_0_q));
    u0_m0_wo0_accum_b <= STD_LOGIC_VECTOR(u0_m0_wo0_accum_q);
    u0_m0_wo0_accum_i <= u0_m0_wo0_accum_a;
    u0_m0_wo0_accum_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_accum_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_17_q = "1") THEN
                IF (u0_m0_wo0_aseq_q = "1") THEN
                    u0_m0_wo0_accum_o <= u0_m0_wo0_accum_i;
                ELSE
                    u0_m0_wo0_accum_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_accum_a) + SIGNED(u0_m0_wo0_accum_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_accum_q <= u0_m0_wo0_accum_o(38 downto 0);

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- u0_m0_wo0_oseq(SEQUENCE,57)@16 + 1
    u0_m0_wo0_oseq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_oseq_c : SIGNED(6 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_c := "0010100";
            u0_m0_wo0_oseq_q <= "0";
            u0_m0_wo0_oseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_16_q = "1") THEN
                IF (u0_m0_wo0_oseq_c = "0000000") THEN
                    u0_m0_wo0_oseq_eq <= '1';
                ELSE
                    u0_m0_wo0_oseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_oseq_eq = '1') THEN
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c + 20;
                ELSE
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c - 1;
                END IF;
                u0_m0_wo0_oseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_c(6 downto 6));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_oseq_gated(LOGICAL,58)@17
    u0_m0_wo0_oseq_gated_q <= u0_m0_wo0_oseq_q and d_u0_m0_wo0_compute_q_17_q;

    -- u0_m0_wo0_oseq_gated_reg(REG,59)@17 + 1
    u0_m0_wo0_oseq_gated_reg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_q);
        END IF;
    END PROCESS;

    -- xOut(PORTOUT,64)@18 + 1
    xOut_v <= u0_m0_wo0_oseq_gated_reg_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_accum_q;

END normal;
