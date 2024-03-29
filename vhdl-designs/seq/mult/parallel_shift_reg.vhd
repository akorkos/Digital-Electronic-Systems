library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- N-bit Parallel access Shift register:
-- DIR = "LEFT" --> Shift to the left: from LSB to MSB
-- DIR = "RIGHT" --> Shift to the right: from MSB to LSB
-- s_l = 0 --> Shift operation (MSB to LSB)
-- s_l = 1 -> Parallel load
entity parallel_shift_reg is
   	generic (
		N	: INTEGER	:= 4;
	    DIR	: STRING	:= "LEFT"
	);

	port ( 
		clk, reset	: in std_logic;
	    din, E, s_l	: in std_logic; -- din: shiftin input
		D			: in std_logic_vector (N-1 downto 0);
	    Q			: out std_logic_vector (N-1 downto 0);
        shift_out	: out std_logic
	);
end parallel_shift_reg;

architecture Behavioral of parallel_shift_reg is
	signal Qt: std_logic_vector (N-1 downto 0);
begin

a0: assert (DIR = "LEFT" or DIR = "RIGHT")
    report "DIR can only be LEFT or RIGHT" severity error;
	
	process (reset, clk)
	begin
		if reset = '0' then
			Qt <= (others => '0');
		elsif (clk'event and clk = '1') then
			if E = '1' then	
				if s_l = '1' then
					Qt <= D;					
				else
					if DIR = "LEFT" then
						Qt(0) <= din;
						for i in 1 to N-1 loop
							Qt(i) <= Qt(i-1);
						end loop;
					elsif DIR = "RIGHT" then
						Qt(N-1) <= din;
						for i in 0 to N-2 loop
							Qt(i) <= Qt(i+1);
						end loop;
					end if;
				end if;
			end if;
		end if;
		
	end process;

	Q <= Qt;
	
	gl: if DIR = "LEFT" generate
			shift_out <= Qt(N-1);
		end generate;
	gr: if DIR = "RIGHT" generate
			shift_out <= Qt(0);
		end generate;		
end Behavioral;