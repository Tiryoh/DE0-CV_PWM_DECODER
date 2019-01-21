library ieee;
use ieee.std_logic_1164.all;

entity LEDDEC is
	port (
		DATA : in std_logic_vector(3 downto 0);
		LEDOUT : out std_logic_vector(6 downto 0)
	);
end LEDDEC;

architecture RTL of LEDDEC is
begin --RTL
	process (DATA) begin
		case DATA is
			when "0000" => LEDOUT <= "1000000"; --0
			when "0001" => LEDOUT <= "1111001"; --1
			when "0010" => LEDOUT <= "0100100"; --2
			when "0011" => LEDOUT <= "0110000"; --3
			when "0100" => LEDOUT <= "0011001"; --4
			when "0101" => LEDOUT <= "0010010"; --5
			when "0110" => LEDOUT <= "0000010"; --6
			when "0111" => LEDOUT <= "1111000"; --7
			when "1000" => LEDOUT <= "0000000"; --8
			when "1001" => LEDOUT <= "0010000"; --9
			when "1111" => LEDOUT <= "1111111"; --none
			when others => LEDOUT <= "1000000"; --0
		end case;
	end process;
end RTL;