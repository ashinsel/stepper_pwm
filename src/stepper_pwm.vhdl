library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stepper_PWM is
    port (
        -- clock
        i_clk:      in  std_logic;

        i_prescaler:    in  std_logic_vector(15 downto 0);

        -- Reset signal
        i_reset:    in  std_logic;

        -- match signals
        i_match_a1: in  unsigned(9 downto 0);
        i_match_a3: in  unsigned(9 downto 0);
        i_match_b1: in  unsigned(9 downto 0);
        i_match_b3: in  unsigned(9 downto 0);

        o_a1:       out std_logic;
        o_a3:       out std_logic;
        o_b1:       out std_logic;
        o_b3:       out std_logic--;

        --o_counter:    out std_logic_vector(9 downto 0)
    );
end Stepper_PWM;

architecture Behavioral of Stepper_PWM is
    signal counter:         unsigned(9 downto 0)    :=(others => '0');
    signal ps_counter:         unsigned(15 downto 0)    :=(others => '0');

begin
    process(i_reset, i_clk) begin
        if ( rising_edge (i_clk) ) then
            if ( i_reset = '1' ) then
                counter <= (others => '0');
                ps_counter <= (others => '0');
            else
                if(ps_counter >= unsigned(i_prescaler)) then
                    ps_counter <= (others => '0');
                    if (counter = 999) then
                        counter <= (others => '0');
                    else
                        counter <= counter + 1;
                    end if;
                else
                    ps_counter <= ps_counter + 1;
                end if;

            end if;
        end if;
    end process;

    --o_counter <= std_logic_vector(counter);
    o_a1 <= '1' when i_match_a1 > counter else '0';
    o_a3 <= '1' when i_match_a3 > counter else '0';
    o_b1 <= '1' when i_match_b1 > counter else '0';
    o_b3 <= '1' when i_match_b3 > counter else '0';
    --o_counter <= counter;
end;
