library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

library STD;
use STD.textio.all;

entity tb_mux_4to1 is
end entity;

architecture bench of tb_mux_4to1 is

  component mux_4to1
    port (
      ABCD_in: in std_logic_vector(3 downto 0);
      Sel_in: in std_logic_vector(1 downto 0);
      Q_out: out std_logic
    );
  end component;

  signal ACBD_tb_in: std_logic_vector(3 downto 0);
  signal Sel_tb_in: std_logic_vector(1 downto 0);
  signal Q_tb_in: std_logic;

begin
  DUT: mux_4to1 port map(ABCD_in => ACBD_tb_in, Sel_in => Sel_tb_in, Q_out => Q_tb_in);
  process
    file Fin : text open read_mode is "mux_4to1_tests.txt";

    variable current_read_line   : line;
    variable current_read_field1 : std_logic_vector(0 to 3);
    variable current_read_field2 : std_logic_vector(0 to 1);
    variable current_read_field3 : std_logic;

  begin
    while (not endFile(Fin)) loop

      readline(Fin, current_read_line);
      read(current_read_line, current_read_field1);
      read(current_read_line, current_read_field2);
      read(current_read_line, current_read_field3);

      ACBD_tb_in <= current_read_field1;
      Sel_tb_in  <= current_read_field2;
      wait for 50 ns;

      assert(Q_tb_in = current_read_field3);

    end loop;
    wait;
  end process;
end architecture;