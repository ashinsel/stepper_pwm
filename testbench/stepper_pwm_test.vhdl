LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- Testbench entity
entity Stepper_PWM_Test is
end Stepper_PWM_Test;

architecture behavior of Stepper_PWM_Test is
	-- Declare the Unit Under Test
	component Stepper_PWM
		port(
			-- clock
			i_clk:		in	std_logic;
			
			i_prescaler:	in	std_logic_vector(15 downto 0);
			
			-- Reset signal
			i_reset:	in	std_logic;
			
			-- match signals
			i_match_a1:	in	unsigned(9 downto 0);
			i_match_a3:	in	unsigned(9 downto 0);
			i_match_b1:	in	unsigned(9 downto 0);
			i_match_b3:	in	unsigned(9 downto 0);
			
			o_a1:		out	std_logic;
			o_a3:		out	std_logic;
			o_b1:		out	std_logic;
			o_b3:		out	std_logic
			
			--o_counter:	out	natural range 0 to 1000
		);
	end component;
	
	-- Declare inputs, and initialize them
	signal clk:		std_logic			:= '0';
	signal prescaler:	std_logic_vector(15 downto 0)	:= (others => '0');
	signal reset:		std_logic			:= '0';
	signal a1:		std_logic			:= '0';
	signal a3:		std_logic			:= '0';
	signal b1:		std_logic			:= '0';
	signal b3:		std_logic			:= '0';
	signal match_a1:	std_logic_vector(9 downto 0)	:= (others => '0');
	signal match_a3:	std_logic_vector(9 downto 0)	:= "1111101000";--0
	signal match_b1:	std_logic_vector(9 downto 0)	:= "0100000000";
	signal match_b3:	std_logic_vector(9 downto 0)	:= "0010000000";
	--signal counter		natural range 0 to 1000		:= 0;
	
begin
	UUT: Stepper_PWM port map (
		i_clk => clk,
		i_prescaler => prescaler,
		i_reset => reset,
		i_match_a1 => match_a1,
		i_match_a3 => match_a3,
		i_match_b1 => match_b1,
		i_match_b3 => match_b3,
		o_a1 => a1,
		o_a3 => a3,
		o_b1 => b1,
		o_b3 => b3
		--o_counter => counter
	);
	
	-- Clock process
	clk_process : process
	begin
		clk <= '0';
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
	end process;
	
	-- Stimulus process
	stimulus : process
	begin
		wait for 50 ns;
		reset <= '1';
		wait for 3 ns;
		reset <= '0';
		wait;
	end process;
end;