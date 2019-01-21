library ieee;
use ieee.std_logic_1164.all;

entity CALC is
	port (
		CLK : in std_logic;
		RST_N : in std_logic;
		SWSTATUS : in std_logic;
        PULSE : in std_logic;
        RESULT : out std_logic_vector(13 downto 0);
		DEBUG_PIN1 : out std_logic;
		DEBUG_PIN2 : out std_logic;
		DEBUG_PIN3 : out std_logic
	);
end CALC;

architecture RTL of CALC is
	component COUNT is
		port (
			CLK : in std_logic;
			RST_N : in std_logic;
			COUNT_ENABLE : in std_logic_vector(1 downto 0);
			RESULT : out std_logic_vector(13 downto 0);
			DEBUG_PIN3 : out std_logic
		);
	end component;

	component COUNT_CNTRL is
		port (
			CLK : in std_logic;
			RST_N : in std_logic;
			PULSE : in std_logic;
			SWSTATUS : in std_logic;
			COUNT_ENABLE : out std_logic_vector(1 downto 0);
			DEBUG_PIN1 : out std_logic;
			DEBUG_PIN2 : out std_logic
		);
	end component;

	signal TCOUNT_ENABLE : std_logic_vector(1 downto 0);

begin
	U1 : COUNT_CNTRL port map(
		CLK => CLK, RST_N => RST_N, PULSE => PULSE, SWSTATUS => SWSTATUS, COUNT_ENABLE => TCOUNT_ENABLE, DEBUG_PIN1 => DEBUG_PIN1, DEBUG_PIN2 => DEBUG_PIN2
	);

	U2 : COUNT port map(
		CLK => CLK, RST_N => RST_N, COUNT_ENABLE => TCOUNT_ENABLE, RESULT => RESULT, DEBUG_PIN3 => DEBUG_PIN3
	);

end RTL;