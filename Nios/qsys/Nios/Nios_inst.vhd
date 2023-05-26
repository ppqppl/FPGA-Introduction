	component Nios is
		port (
			clk_clk        : in  std_logic                    := 'X'; -- clk
			out_led_export : out std_logic_vector(7 downto 0);        -- export
			reset_reset_n  : in  std_logic                    := 'X'  -- reset_n
		);
	end component Nios;

	u0 : component Nios
		port map (
			clk_clk        => CONNECTED_TO_clk_clk,        --     clk.clk
			out_led_export => CONNECTED_TO_out_led_export, -- out_led.export
			reset_reset_n  => CONNECTED_TO_reset_reset_n   --   reset.reset_n
		);

