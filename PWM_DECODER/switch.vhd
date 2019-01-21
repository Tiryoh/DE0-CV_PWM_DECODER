library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SWITCH is
	port (
		CLK : in std_logic;
		RST_N : in std_logic;
		MODESW1_N : in std_logic;
		MODESW2_N : in std_logic;
		SWSTATUS : out std_logic
	);
end SWITCH;

architecture RTL of SWITCH is
    signal MODE_STATUS : std_logic := '0';

begin --RTL
	process (CLK, RST_N, MODESW1_N, MODESW2_N, MODE_STATUS) begin
		if (RST_N = '0') then
			MODE_STATUS <= '0';
		elsif (CLK' event and CLK = '1') then
			if (MODESW1_N = '0') then
				MODE_STATUS <= '1';
			elsif (MODESW2_N = '0') then
				MODE_STATUS <= '0';
			end if;
		end if;
		SWSTATUS <= MODE_STATUS;
	end process;

end RTL;