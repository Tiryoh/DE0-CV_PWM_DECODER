library ieee;
use ieee.std_logic_1164.all;

entity PWM_DECODER is
	port (
		CLK : in std_logic;
		RST_N : in std_logic;
		MODESW1_N : in std_logic;
		MODESW2_N : in std_logic;
		PULSE : in std_logic;
		LEDD1 : out std_logic_vector(6 downto 0);
		LEDD2 : out std_logic_vector(6 downto 0);
		LEDD3 : out std_logic_vector(6 downto 0);
		LEDD4 : out std_logic_vector(6 downto 0);
		LEDD5 : out std_logic_vector(6 downto 0);
		LEDD6 : out std_logic_vector(6 downto 0);
		DEBUG_PIN1 : out std_logic;
		DEBUG_PIN2 : out std_logic;
		DEBUG_PIN3 : out std_logic
	);
end PWM_DECODER;

architecture RTL of PWM_DECODER is
	component CLKDOWN
		port (
			CLK : in std_logic;
			RST_N : in std_logic;
			DOWN_CLK : out std_logic
		);
	end component;

	component SWITCH is
		port (
			CLK : in std_logic;
			RST_N : in std_logic;
			MODESW1_N : in std_logic;
			MODESW2_N : in std_logic;
			SWSTATUS : out std_logic
		);
	end component;

	component CALC is
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
	end component;

	component LED is
		port (
			DATA : in std_logic_vector(13 downto 0);
			LEDD1 : out std_logic_vector(6 downto 0);
			LEDD2 : out std_logic_vector(6 downto 0);
			LEDD3 : out std_logic_vector(6 downto 0);
			LEDD4 : out std_logic_vector(6 downto 0);
			LEDD5 : out std_logic_vector(6 downto 0);
			LEDD6 : out std_logic_vector(6 downto 0)
		);
	end component;

	signal TDOWN_CLK : std_logic;
	signal TSWSTATUS : std_logic;
	signal TRESULT : std_logic_vector(13 downto 0);

begin
	U1 : LED port map(
		DATA => TRESULT, LEDD1 => LEDD1, LEDD2 => LEDD2, LEDD3 => LEDD3, LEDD4 => LEDD4, LEDD5 => LEDD5, LEDD6 => LEDD6
	);

	U2 : CLKDOWN port map(
		CLK => CLK, RST_N => RST_N, DOWN_CLK => TDOWN_CLK
	);

	U3 : SWITCH port map(
		CLK => CLK, RST_N => RST_N, MODESW1_N => MODESW1_N, MODESW2_N => MODESW2_N, SWSTATUS => TSWSTATUS
	);

	U4 : CALC port map(
		CLK => TDOWN_CLK, RST_N => RST_N, SWSTATUS => TSWSTATUS, PULSE => PULSE, RESULT => TRESULT,
		DEBUG_PIN1 => DEBUG_PIN1, DEBUG_PIN2 => DEBUG_PIN2, DEBUG_PIN3 => DEBUG_PIN3
	);

end RTL;