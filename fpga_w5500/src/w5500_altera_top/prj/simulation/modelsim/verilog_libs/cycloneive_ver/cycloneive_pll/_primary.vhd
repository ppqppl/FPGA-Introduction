library verilog;
use verilog.vl_types.all;
entity cycloneive_pll is
    generic(
        operation_mode  : string  := "normal";
        pll_type        : string  := "auto";
        compensate_clock: string  := "clock0";
        inclk0_input_frequency: integer := 0;
        inclk1_input_frequency: integer := 0;
        self_reset_on_loss_lock: string  := "off";
        switch_over_type: string  := "auto";
        switch_over_counter: integer := 1;
        enable_switch_over_counter: string  := "off";
        bandwidth       : integer := 0;
        bandwidth_type  : string  := "auto";
        use_dc_coupling : string  := "false";
        lock_high       : integer := 0;
        lock_low        : integer := 0;
        lock_window_ui  : string  := "0.05";
        test_bypass_lock_detect: string  := "off";
        clk0_output_frequency: integer := 0;
        clk0_multiply_by: integer := 0;
        clk0_divide_by  : integer := 0;
        clk0_phase_shift: string  := "0";
        clk0_duty_cycle : integer := 50;
        clk1_output_frequency: integer := 0;
        clk1_multiply_by: integer := 0;
        clk1_divide_by  : integer := 0;
        clk1_phase_shift: string  := "0";
        clk1_duty_cycle : integer := 50;
        clk2_output_frequency: integer := 0;
        clk2_multiply_by: integer := 0;
        clk2_divide_by  : integer := 0;
        clk2_phase_shift: string  := "0";
        clk2_duty_cycle : integer := 50;
        clk3_output_frequency: integer := 0;
        clk3_multiply_by: integer := 0;
        clk3_divide_by  : integer := 0;
        clk3_phase_shift: string  := "0";
        clk3_duty_cycle : integer := 50;
        clk4_output_frequency: integer := 0;
        clk4_multiply_by: integer := 0;
        clk4_divide_by  : integer := 0;
        clk4_phase_shift: string  := "0";
        clk4_duty_cycle : integer := 50;
        pfd_min         : integer := 0;
        pfd_max         : integer := 0;
        vco_min         : integer := 0;
        vco_max         : integer := 0;
        vco_center      : integer := 0;
        m_initial       : integer := 1;
        m               : integer := 0;
        n               : integer := 1;
        c0_high         : integer := 1;
        c0_low          : integer := 1;
        c0_initial      : integer := 1;
        c0_mode         : string  := "bypass";
        c0_ph           : integer := 0;
        c1_high         : integer := 1;
        c1_low          : integer := 1;
        c1_initial      : integer := 1;
        c1_mode         : string  := "bypass";
        c1_ph           : integer := 0;
        c2_high         : integer := 1;
        c2_low          : integer := 1;
        c2_initial      : integer := 1;
        c2_mode         : string  := "bypass";
        c2_ph           : integer := 0;
        c3_high         : integer := 1;
        c3_low          : integer := 1;
        c3_initial      : integer := 1;
        c3_mode         : string  := "bypass";
        c3_ph           : integer := 0;
        c4_high         : integer := 1;
        c4_low          : integer := 1;
        c4_initial      : integer := 1;
        c4_mode         : string  := "bypass";
        c4_ph           : integer := 0;
        m_ph            : integer := 0;
        clk0_counter    : string  := "unused";
        clk1_counter    : string  := "unused";
        clk2_counter    : string  := "unused";
        clk3_counter    : string  := "unused";
        clk4_counter    : string  := "unused";
        c1_use_casc_in  : string  := "off";
        c2_use_casc_in  : string  := "off";
        c3_use_casc_in  : string  := "off";
        c4_use_casc_in  : string  := "off";
        m_test_source   : integer := -1;
        c0_test_source  : integer := -1;
        c1_test_source  : integer := -1;
        c2_test_source  : integer := -1;
        c3_test_source  : integer := -1;
        c4_test_source  : integer := -1;
        vco_multiply_by : integer := 0;
        vco_divide_by   : integer := 0;
        vco_post_scale  : integer := 1;
        vco_frequency_control: string  := "auto";
        vco_phase_shift_step: integer := 0;
        charge_pump_current: integer := 10;
        loop_filter_r   : string  := "1.0";
        loop_filter_c   : integer := 0;
        pll_compensation_delay: integer := 0;
        simulation_type : string  := "functional";
        lpm_type        : string  := "cycloneive_pll";
        down_spread     : string  := "0.0";
        lock_c          : integer := 4;
        sim_gate_lock_device_behavior: string  := "off";
        clk0_phase_shift_num: integer := 0;
        clk1_phase_shift_num: integer := 0;
        clk2_phase_shift_num: integer := 0;
        clk3_phase_shift_num: integer := 0;
        clk4_phase_shift_num: integer := 0;
        family_name     : string  := "Cycloneive";
        clk0_use_even_counter_mode: string  := "off";
        clk1_use_even_counter_mode: string  := "off";
        clk2_use_even_counter_mode: string  := "off";
        clk3_use_even_counter_mode: string  := "off";
        clk4_use_even_counter_mode: string  := "off";
        clk0_use_even_counter_value: string  := "off";
        clk1_use_even_counter_value: string  := "off";
        clk2_use_even_counter_value: string  := "off";
        clk3_use_even_counter_value: string  := "off";
        clk4_use_even_counter_value: string  := "off";
        init_block_reset_a_count: integer := 1;
        init_block_reset_b_count: integer := 1;
        phase_counter_select_width: integer := 3;
        lock_window     : integer := 5;
        inclk0_freq     : vl_notype;
        inclk1_freq     : vl_notype;
        charge_pump_current_bits: integer := 0;
        lock_window_ui_bits: integer := 0;
        loop_filter_c_bits: integer := 0;
        loop_filter_r_bits: integer := 0;
        test_counter_c0_delay_chain_bits: integer := 0;
        test_counter_c1_delay_chain_bits: integer := 0;
        test_counter_c2_delay_chain_bits: integer := 0;
        test_counter_c3_delay_chain_bits: integer := 0;
        test_counter_c4_delay_chain_bits: integer := 0;
        test_counter_c5_delay_chain_bits: integer := 0;
        test_counter_m_delay_chain_bits: integer := 0;
        test_counter_n_delay_chain_bits: integer := 0;
        test_feedback_comp_delay_chain_bits: integer := 0;
        test_input_comp_delay_chain_bits: integer := 0;
        test_volt_reg_output_mode_bits: integer := 0;
        test_volt_reg_output_voltage_bits: integer := 0;
        test_volt_reg_test_mode: string  := "false";
        vco_range_detector_high_bits: integer := -1;
        vco_range_detector_low_bits: integer := -1;
        scan_chain_mif_file: string  := "";
        auto_settings   : string  := "true";
        SCAN_CHAIN      : integer := 144;
        GPP_SCAN_CHAIN  : integer := 234;
        FAST_SCAN_CHAIN : integer := 180;
        num_phase_taps  : integer := 8
    );
    port(
        inclk           : in     vl_logic_vector(1 downto 0);
        fbin            : in     vl_logic;
        fbout           : out    vl_logic;
        clkswitch       : in     vl_logic;
        areset          : in     vl_logic;
        pfdena          : in     vl_logic;
        scanclk         : in     vl_logic;
        scandata        : in     vl_logic;
        scanclkena      : in     vl_logic;
        configupdate    : in     vl_logic;
        clk             : out    vl_logic_vector(4 downto 0);
        phasecounterselect: in     vl_logic_vector;
        phaseupdown     : in     vl_logic;
        phasestep       : in     vl_logic;
        clkbad          : out    vl_logic_vector(1 downto 0);
        activeclock     : out    vl_logic;
        locked          : out    vl_logic;
        scandataout     : out    vl_logic;
        scandone        : out    vl_logic;
        phasedone       : out    vl_logic;
        vcooverrange    : out    vl_logic;
        vcounderrange   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of operation_mode : constant is 1;
    attribute mti_svvh_generic_type of pll_type : constant is 1;
    attribute mti_svvh_generic_type of compensate_clock : constant is 1;
    attribute mti_svvh_generic_type of inclk0_input_frequency : constant is 1;
    attribute mti_svvh_generic_type of inclk1_input_frequency : constant is 1;
    attribute mti_svvh_generic_type of self_reset_on_loss_lock : constant is 1;
    attribute mti_svvh_generic_type of switch_over_type : constant is 1;
    attribute mti_svvh_generic_type of switch_over_counter : constant is 1;
    attribute mti_svvh_generic_type of enable_switch_over_counter : constant is 1;
    attribute mti_svvh_generic_type of bandwidth : constant is 1;
    attribute mti_svvh_generic_type of bandwidth_type : constant is 1;
    attribute mti_svvh_generic_type of use_dc_coupling : constant is 1;
    attribute mti_svvh_generic_type of lock_high : constant is 1;
    attribute mti_svvh_generic_type of lock_low : constant is 1;
    attribute mti_svvh_generic_type of lock_window_ui : constant is 1;
    attribute mti_svvh_generic_type of test_bypass_lock_detect : constant is 1;
    attribute mti_svvh_generic_type of clk0_output_frequency : constant is 1;
    attribute mti_svvh_generic_type of clk0_multiply_by : constant is 1;
    attribute mti_svvh_generic_type of clk0_divide_by : constant is 1;
    attribute mti_svvh_generic_type of clk0_phase_shift : constant is 1;
    attribute mti_svvh_generic_type of clk0_duty_cycle : constant is 1;
    attribute mti_svvh_generic_type of clk1_output_frequency : constant is 1;
    attribute mti_svvh_generic_type of clk1_multiply_by : constant is 1;
    attribute mti_svvh_generic_type of clk1_divide_by : constant is 1;
    attribute mti_svvh_generic_type of clk1_phase_shift : constant is 1;
    attribute mti_svvh_generic_type of clk1_duty_cycle : constant is 1;
    attribute mti_svvh_generic_type of clk2_output_frequency : constant is 1;
    attribute mti_svvh_generic_type of clk2_multiply_by : constant is 1;
    attribute mti_svvh_generic_type of clk2_divide_by : constant is 1;
    attribute mti_svvh_generic_type of clk2_phase_shift : constant is 1;
    attribute mti_svvh_generic_type of clk2_duty_cycle : constant is 1;
    attribute mti_svvh_generic_type of clk3_output_frequency : constant is 1;
    attribute mti_svvh_generic_type of clk3_multiply_by : constant is 1;
    attribute mti_svvh_generic_type of clk3_divide_by : constant is 1;
    attribute mti_svvh_generic_type of clk3_phase_shift : constant is 1;
    attribute mti_svvh_generic_type of clk3_duty_cycle : constant is 1;
    attribute mti_svvh_generic_type of clk4_output_frequency : constant is 1;
    attribute mti_svvh_generic_type of clk4_multiply_by : constant is 1;
    attribute mti_svvh_generic_type of clk4_divide_by : constant is 1;
    attribute mti_svvh_generic_type of clk4_phase_shift : constant is 1;
    attribute mti_svvh_generic_type of clk4_duty_cycle : constant is 1;
    attribute mti_svvh_generic_type of pfd_min : constant is 1;
    attribute mti_svvh_generic_type of pfd_max : constant is 1;
    attribute mti_svvh_generic_type of vco_min : constant is 1;
    attribute mti_svvh_generic_type of vco_max : constant is 1;
    attribute mti_svvh_generic_type of vco_center : constant is 1;
    attribute mti_svvh_generic_type of m_initial : constant is 1;
    attribute mti_svvh_generic_type of m : constant is 1;
    attribute mti_svvh_generic_type of n : constant is 1;
    attribute mti_svvh_generic_type of c0_high : constant is 1;
    attribute mti_svvh_generic_type of c0_low : constant is 1;
    attribute mti_svvh_generic_type of c0_initial : constant is 1;
    attribute mti_svvh_generic_type of c0_mode : constant is 1;
    attribute mti_svvh_generic_type of c0_ph : constant is 1;
    attribute mti_svvh_generic_type of c1_high : constant is 1;
    attribute mti_svvh_generic_type of c1_low : constant is 1;
    attribute mti_svvh_generic_type of c1_initial : constant is 1;
    attribute mti_svvh_generic_type of c1_mode : constant is 1;
    attribute mti_svvh_generic_type of c1_ph : constant is 1;
    attribute mti_svvh_generic_type of c2_high : constant is 1;
    attribute mti_svvh_generic_type of c2_low : constant is 1;
    attribute mti_svvh_generic_type of c2_initial : constant is 1;
    attribute mti_svvh_generic_type of c2_mode : constant is 1;
    attribute mti_svvh_generic_type of c2_ph : constant is 1;
    attribute mti_svvh_generic_type of c3_high : constant is 1;
    attribute mti_svvh_generic_type of c3_low : constant is 1;
    attribute mti_svvh_generic_type of c3_initial : constant is 1;
    attribute mti_svvh_generic_type of c3_mode : constant is 1;
    attribute mti_svvh_generic_type of c3_ph : constant is 1;
    attribute mti_svvh_generic_type of c4_high : constant is 1;
    attribute mti_svvh_generic_type of c4_low : constant is 1;
    attribute mti_svvh_generic_type of c4_initial : constant is 1;
    attribute mti_svvh_generic_type of c4_mode : constant is 1;
    attribute mti_svvh_generic_type of c4_ph : constant is 1;
    attribute mti_svvh_generic_type of m_ph : constant is 1;
    attribute mti_svvh_generic_type of clk0_counter : constant is 1;
    attribute mti_svvh_generic_type of clk1_counter : constant is 1;
    attribute mti_svvh_generic_type of clk2_counter : constant is 1;
    attribute mti_svvh_generic_type of clk3_counter : constant is 1;
    attribute mti_svvh_generic_type of clk4_counter : constant is 1;
    attribute mti_svvh_generic_type of c1_use_casc_in : constant is 1;
    attribute mti_svvh_generic_type of c2_use_casc_in : constant is 1;
    attribute mti_svvh_generic_type of c3_use_casc_in : constant is 1;
    attribute mti_svvh_generic_type of c4_use_casc_in : constant is 1;
    attribute mti_svvh_generic_type of m_test_source : constant is 1;
    attribute mti_svvh_generic_type of c0_test_source : constant is 1;
    attribute mti_svvh_generic_type of c1_test_source : constant is 1;
    attribute mti_svvh_generic_type of c2_test_source : constant is 1;
    attribute mti_svvh_generic_type of c3_test_source : constant is 1;
    attribute mti_svvh_generic_type of c4_test_source : constant is 1;
    attribute mti_svvh_generic_type of vco_multiply_by : constant is 1;
    attribute mti_svvh_generic_type of vco_divide_by : constant is 1;
    attribute mti_svvh_generic_type of vco_post_scale : constant is 1;
    attribute mti_svvh_generic_type of vco_frequency_control : constant is 1;
    attribute mti_svvh_generic_type of vco_phase_shift_step : constant is 1;
    attribute mti_svvh_generic_type of charge_pump_current : constant is 1;
    attribute mti_svvh_generic_type of loop_filter_r : constant is 1;
    attribute mti_svvh_generic_type of loop_filter_c : constant is 1;
    attribute mti_svvh_generic_type of pll_compensation_delay : constant is 1;
    attribute mti_svvh_generic_type of simulation_type : constant is 1;
    attribute mti_svvh_generic_type of lpm_type : constant is 1;
    attribute mti_svvh_generic_type of down_spread : constant is 1;
    attribute mti_svvh_generic_type of lock_c : constant is 1;
    attribute mti_svvh_generic_type of sim_gate_lock_device_behavior : constant is 1;
    attribute mti_svvh_generic_type of clk0_phase_shift_num : constant is 1;
    attribute mti_svvh_generic_type of clk1_phase_shift_num : constant is 1;
    attribute mti_svvh_generic_type of clk2_phase_shift_num : constant is 1;
    attribute mti_svvh_generic_type of clk3_phase_shift_num : constant is 1;
    attribute mti_svvh_generic_type of clk4_phase_shift_num : constant is 1;
    attribute mti_svvh_generic_type of family_name : constant is 1;
    attribute mti_svvh_generic_type of clk0_use_even_counter_mode : constant is 1;
    attribute mti_svvh_generic_type of clk1_use_even_counter_mode : constant is 1;
    attribute mti_svvh_generic_type of clk2_use_even_counter_mode : constant is 1;
    attribute mti_svvh_generic_type of clk3_use_even_counter_mode : constant is 1;
    attribute mti_svvh_generic_type of clk4_use_even_counter_mode : constant is 1;
    attribute mti_svvh_generic_type of clk0_use_even_counter_value : constant is 1;
    attribute mti_svvh_generic_type of clk1_use_even_counter_value : constant is 1;
    attribute mti_svvh_generic_type of clk2_use_even_counter_value : constant is 1;
    attribute mti_svvh_generic_type of clk3_use_even_counter_value : constant is 1;
    attribute mti_svvh_generic_type of clk4_use_even_counter_value : constant is 1;
    attribute mti_svvh_generic_type of init_block_reset_a_count : constant is 1;
    attribute mti_svvh_generic_type of init_block_reset_b_count : constant is 1;
    attribute mti_svvh_generic_type of phase_counter_select_width : constant is 1;
    attribute mti_svvh_generic_type of lock_window : constant is 1;
    attribute mti_svvh_generic_type of inclk0_freq : constant is 3;
    attribute mti_svvh_generic_type of inclk1_freq : constant is 3;
    attribute mti_svvh_generic_type of charge_pump_current_bits : constant is 1;
    attribute mti_svvh_generic_type of lock_window_ui_bits : constant is 1;
    attribute mti_svvh_generic_type of loop_filter_c_bits : constant is 1;
    attribute mti_svvh_generic_type of loop_filter_r_bits : constant is 1;
    attribute mti_svvh_generic_type of test_counter_c0_delay_chain_bits : constant is 1;
    attribute mti_svvh_generic_type of test_counter_c1_delay_chain_bits : constant is 1;
    attribute mti_svvh_generic_type of test_counter_c2_delay_chain_bits : constant is 1;
    attribute mti_svvh_generic_type of test_counter_c3_delay_chain_bits : constant is 1;
    attribute mti_svvh_generic_type of test_counter_c4_delay_chain_bits : constant is 1;
    attribute mti_svvh_generic_type of test_counter_c5_delay_chain_bits : constant is 1;
    attribute mti_svvh_generic_type of test_counter_m_delay_chain_bits : constant is 1;
    attribute mti_svvh_generic_type of test_counter_n_delay_chain_bits : constant is 1;
    attribute mti_svvh_generic_type of test_feedback_comp_delay_chain_bits : constant is 1;
    attribute mti_svvh_generic_type of test_input_comp_delay_chain_bits : constant is 1;
    attribute mti_svvh_generic_type of test_volt_reg_output_mode_bits : constant is 1;
    attribute mti_svvh_generic_type of test_volt_reg_output_voltage_bits : constant is 1;
    attribute mti_svvh_generic_type of test_volt_reg_test_mode : constant is 1;
    attribute mti_svvh_generic_type of vco_range_detector_high_bits : constant is 1;
    attribute mti_svvh_generic_type of vco_range_detector_low_bits : constant is 1;
    attribute mti_svvh_generic_type of scan_chain_mif_file : constant is 1;
    attribute mti_svvh_generic_type of auto_settings : constant is 1;
    attribute mti_svvh_generic_type of SCAN_CHAIN : constant is 1;
    attribute mti_svvh_generic_type of GPP_SCAN_CHAIN : constant is 1;
    attribute mti_svvh_generic_type of FAST_SCAN_CHAIN : constant is 1;
    attribute mti_svvh_generic_type of num_phase_taps : constant is 1;
end cycloneive_pll;
