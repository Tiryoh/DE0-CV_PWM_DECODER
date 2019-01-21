library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CLKDOWN is
	port (
		CLK : in std_logic;
		RST_N : in std_logic;
		DOWN_CLK : out std_logic
	);
end CLKDOWN;

architecture RTL of CLKDOWN is
	constant MAXCOUNT : std_logic_vector(25 downto 0)
	--:= "10111110101111000010000000"; -- for 50MHz, count 1000msec
	--:= "00000001111010000100100000"; -- for 50MHz, count 10msec
	:= "00000000000001001110001000"; -- for 50MHz, count 0.1msec
	--:= "00000000000000000000000100"; -- for simulation
	constant ZEROCOUNT : std_logic_vector(25 downto 0)
	:= "00000000000000000000000000";
	signal COUNT : std_logic_vector(25 downto 0) := MAXCOUNT;
	signal CLKOUT : std_logic;

begin --RTL
	process (CLK, RST_N, COUNT, CLKOUT) begin
		if (RST_N = '0') then
			COUNT <= MAXCOUNT;
		elsif (CLK' event and CLK = '1') then
			if (COUNT = ZEROCOUNT) then
				COUNT <= MAXCOUNT;
				CLKOUT <= '1';
			else
				COUNT <= COUNT - 1;
				CLKOUT <= '0';
			end if;
		end if;
		DOWN_CLK <= CLKOUT;
	end process;
end RTL;