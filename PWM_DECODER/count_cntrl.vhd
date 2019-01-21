library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity COUNT_CNTRL is
	port (
		CLK : in std_logic;
		RST_N : in std_logic;
		PULSE : in std_logic;
		SWSTATUS : in std_logic;
		COUNT_ENABLE : out std_logic_vector(1 downto 0);
		DEBUG_PIN1 : out std_logic;
		DEBUG_PIN2 : out std_logic
	);
end COUNT_CNTRL;

architecture RTL of COUNT_CNTRL is
	signal TCOUNT_ENABLE : std_logic_vector(1 downto 0) := "00";

begin --RTL
	process (CLK, RST_N, PULSE, TCOUNT_ENABLE, SWSTATUS) begin
		if (RST_N = '0') then
			TCOUNT_ENABLE <= "00";
			DEBUG_PIN1 <= '1';
			DEBUG_PIN2 <= '1';
		elsif (CLK' event and CLK = '1') then
			if (PULSE = '1') then
				DEBUG_PIN1 <= '1';
				if (SWSTATUS = '1') then
					TCOUNT_ENABLE <= "11";
					DEBUG_PIN2 <= '1';
				elsif (SWSTATUS = '0') then
					TCOUNT_ENABLE <= "01";
					DEBUG_PIN2 <= '0';
				end if;
			elsif (PULSE = '0') then
				DEBUG_PIN1 <= '0';
				if (SWSTATUS = '1') then
					TCOUNT_ENABLE <= "10";
					DEBUG_PIN2 <= '1';
				elsif (SWSTATUS = '0') then
					TCOUNT_ENABLE <= "00";
					DEBUG_PIN2 <= '0';
				end if;
			end if;
		end if;
		COUNT_ENABLE <= TCOUNT_ENABLE;
	end process;

end RTL;