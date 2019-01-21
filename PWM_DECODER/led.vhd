library ieee;
use ieee.std_logic_1164.all;

entity LED is
	port (
		DATA : in std_logic_vector(13 downto 0);
		LEDD1 : out std_logic_vector(6 downto 0);
		LEDD2 : out std_logic_vector(6 downto 0);
		LEDD3 : out std_logic_vector(6 downto 0);
		LEDD4 : out std_logic_vector(6 downto 0);
		LEDD5 : out std_logic_vector(6 downto 0);
		LEDD6 : out std_logic_vector(6 downto 0)
	);
end LED;

architecture RTL of LED is
	component LEDDEC is
		port (
			DATA : in std_logic_vector(3 downto 0);
			LEDOUT : out std_logic_vector(6 downto 0)
		);
	end component;

	component DATA_PARSER is
		port (
			DATA : in std_logic_vector(13 downto 0);
			D1 : out std_logic_vector(3 downto 0);
			D2 : out std_logic_vector(3 downto 0);
			D3 : out std_logic_vector(3 downto 0);
			D4 : out std_logic_vector(3 downto 0);
			D5 : out std_logic_vector(3 downto 0);
			D6 : out std_logic_vector(3 downto 0)
		);
	end component;

	signal TD1 : std_logic_vector(3 downto 0);
	signal TD2 : std_logic_vector(3 downto 0);
	signal TD3 : std_logic_vector(3 downto 0);
	signal TD4 : std_logic_vector(3 downto 0);
	signal TD5 : std_logic_vector(3 downto 0);
	signal TD6 : std_logic_vector(3 downto 0);

begin
	U1 : LEDDEC port map(
		DATA => TD1, LEDOUT => LEDD1
	);

	U2 : LEDDEC port map(
		DATA => TD2, LEDOUT => LEDD2
	);

	U3 : LEDDEC port map(
		DATA => TD3, LEDOUT => LEDD3
	);

	U4 : LEDDEC port map(
		DATA => TD4, LEDOUT => LEDD4
	);

	U5 : LEDDEC port map(
		DATA => TD5, LEDOUT => LEDD5
	);

	U6 : LEDDEC port map(
		DATA => TD6, LEDOUT => LEDD6
	);

	U7 : DATA_PARSER port map(
		DATA => DATA, D1 => TD1, D2 => TD2, D3 => TD3, D4 => TD4, D5 => TD5, D6 => TD6
	);

end RTL;