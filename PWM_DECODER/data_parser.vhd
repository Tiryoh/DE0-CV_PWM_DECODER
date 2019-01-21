library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity DATA_PARSER is
	port (
		DATA : in std_logic_vector(13 downto 0);
		D1 : out std_logic_vector(3 downto 0);
		D2 : out std_logic_vector(3 downto 0);
		D3 : out std_logic_vector(3 downto 0);
		D4 : out std_logic_vector(3 downto 0);
		D5 : out std_logic_vector(3 downto 0);
		D6 : out std_logic_vector(3 downto 0)
	);
end DATA_PARSER;

architecture RTL of DATA_PARSER is
	signal TD1 : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD2 : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD2_A : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD2_B : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD3 : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD3_A : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD3_B : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD4 : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD4_A : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD4_B : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD5 : std_logic_vector(13 downto 0) := "11111111111111";
	signal TD6 : std_logic_vector(13 downto 0) := "11111111111111";
begin --RTL
	process (DATA, TD1, TD2, TD2_A, TD2_B, TD3, TD3_A, TD3_B, TD4, TD4_A, TD4_B, TD5, TD6) begin
		TD2_A <= "11111111111111";
		TD3_A <= "11111111111111";
		TD4_A <= "11111111111111";
		-- 0(0b0) to 9(0b1001)
		TD1 <= DATA and "00000000001111";
		-- TD1 <= DATA(3 downto 0);

		-- 10(0b1010) to 99(0b1100011)
		TD2 <= DATA and "00000001111111";
		-- TD2 <= DATA(6 downto 0);

		-- 100(0b1100100) to 999(0b1111100111)
		TD3 <= DATA and "00001111111111";
		-- TD3 <= DATA(9 downto 0);

		-- 1000(0b1111101000) to 9999(0b10011100001111)
		TD4 <= DATA and "11111111111111";
		-- TD4 <= DATA(13 downto 0);

		-- TD1
		if (TD1 > "1001") then
			D1 <= "1001";
		else
			D1 <= TD1(3 downto 0);
		end if;
		-- TD2
		if (TD2 >= "1100100") then
			-- TD2_A <= TD2 - "1100100";
            -- TD2_B <= TD2 - TD2_A;
            TD2_B <= TD2 - "1100100";
		else
			TD2_B <= TD2;
		end if;
		if (TD2_B < "1010") then
			D2 <= "0000"; --0
		elsif (TD2_B >= "1010" and TD2_B < "10100") then -- 10-19
			D2 <= "0001"; --1
		elsif (TD2_B >= "10100" and TD2_B < "11110") then -- 20-29
			D2 <= "0010"; --2
		elsif (TD2_B >= "11110" and TD2_B < "101000") then -- 30-39
			D2 <= "0011"; --3
		elsif (TD2_B >= "101000" and TD2_B < "110010") then -- 40-49
			D2 <= "0100"; --4
		elsif (TD2_B >= "110010" and TD2_B < "111100") then -- 50-59
			D2 <= "0101"; --5
		elsif (TD2_B >= "111100" and TD2_B < "1000110") then -- 60-69
			D2 <= "0110"; --6
		elsif (TD2_B >= "1000110" and TD2_B < "1010000") then -- 70-79
			D2 <= "0111"; --7
		elsif (TD2_B >= "1010000" and TD2_B < "1011010") then -- 80-89
			D2 <= "1000"; --8
		elsif (TD2_B >= "1011010" and TD2_B < "1100100") then -- 90-99
			D2 <= "1001"; --9
		else
			D2 <= "1111"; --none
		end if;
		--TD3
		if (TD3 >= "1111101000") then
			-- TD3_A <= TD3 - "1111101000";
			-- TD3_B <= TD3 - TD3_A;
			TD3_B <= TD3 - "1111101000";
		else
			TD3_B <= TD3;
		end if;
		if (TD3_B < "1100100") then
			D3 <= "0000"; --0
		elsif (TD3_B >= "1100100" and TD3_B < "11001000") then -- 100-199
			D3 <= "0001"; --1
		elsif (TD3_B >= "11001000" and TD3_B < "100101100") then -- 200-299
			D3 <= "0010"; --2
		elsif (TD3_B >= "100101100" and TD3_B < "110010000") then -- 300-399
			D3 <= "0011"; --3
		elsif (TD3_B >= "110010000" and TD3_B < "111110100") then -- 400-499
			D3 <= "0100"; --4
		elsif (TD3_B >= "111110100" and TD3_B < "1001011000") then -- 500-599
			D3 <= "0101"; --5
		elsif (TD3_B >= "1001011000" and TD3_B < "1010111100") then -- 600-699
			D3 <= "0110"; --6
		elsif (TD3_B >= "1010111100" and TD3_B < "1100100000") then -- 700-799
			D3 <= "0111"; --7
		elsif (TD3_B >= "1100100000" and TD3_B < "1110000100") then -- 800-899
			D3 <= "1000"; --8
		elsif (TD3_B >= "1110000100" and TD3_B < "1111101000") then -- 900-999
			D3 <= "1001"; --9
		else
			D3 <= "1111"; --none
		end if;
		--TD4
		if (TD4 >= "10011100001111") then
			-- TD4_A <= TD4 - "10011100001111";
			-- TD4_B <= TD4 - TD4_A;
			TD4_B <= TD4 - "10011100001111";
		else
			TD4_B <= TD4;
		end if;
		if (TD4_B < "1111101000") then
			D4 <= "0000"; --0
		elsif (TD4_B >= "1111101000" and TD4_B < "11111010000") then -- 1000-1999
			D4 <= "0001"; --1
		elsif (TD4_B >= "11111010000" and TD4_B < "101110111000") then -- 20-29
			D4 <= "0010"; --2
		elsif (TD4_B >= "101110111000" and TD4_B < "111110100000") then -- 30-39
			D4 <= "0011"; --3
		elsif (TD4_B >= "111110100000" and TD4_B < "1001110001000") then -- 40-49
			D4 <= "0100"; --4
		elsif (TD4_B >= "1001110001000" and TD4_B < "1011101110000") then -- 50-59
			D4 <= "0101"; --5
		elsif (TD4_B >= "1011101110000" and TD4_B < "1101101011000") then -- 60-69
			D4 <= "0110"; --6
		elsif (TD4_B >= "1101101011000" and TD4_B < "1111101000000") then -- 70-79
			D4 <= "0111"; --7
		elsif (TD4_B >= "1111101000000" and TD4_B < "10001100101000") then -- 80-89
			D4 <= "1000"; --8
		elsif (TD4_B >= "10001100101000" and TD4_B < "1111101000") then -- 90-99
			D4 <= "1001"; --9
		else
			D4 <= "1111"; --none
		end if;
		D5 <= "1111";
		D6 <= "1111";

	end process;
end RTL;