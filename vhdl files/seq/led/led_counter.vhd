library ieee;
use ieee.std_logic_1164.all;

entity led_counter is
	port (
		clk, reset: in std_logic;
		Q_out: out std_logic_vector (6 downto 0)
	);
end entity;

architecture behavior of led_counter is
  signal counter_value : std_logic_vector (3 downto 0);
begin
  LED: entity work.led_decoder port map (clk, counter_value, Q_out);
  COUNT: entity work.counter port map (clk, reset, counter_value);
end architecture;