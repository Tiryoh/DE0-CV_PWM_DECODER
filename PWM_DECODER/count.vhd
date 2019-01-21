library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity COUNT is
	port (
		CLK : in std_logic;
		RST_N : in std_logic;
		COUNT_ENABLE : in std_logic_vector(1 downto 0);
		RESULT : out std_logic_vector(13 downto 0);
		DEBUG_PIN3 : out std_logic
	);
end COUNT;

architecture RTL of COUNT is
	constant MAXCOUNT : std_logic_vector(13 downto 0)
	:= "10011100001111"; -- for 10kHz, count 999.9msec
	--:= "00000000000100"; -- for simulation
	constant ZEROCOUNT : std_logic_vector(13 downto 0)
	:= "00000000000000";
	signal COUNT : std_logic_vector(13 downto 0) := ZEROCOUNT;
	signal COUNT_DATA : std_logic_vector(13 downto 0) := ZEROCOUNT;
	signal TIMER_ENABLE : std_logic := '0';
	signal PRINT_FLAG : std_logic := '0';

begin --RTL
	process (CLK, RST_N, COUNT_ENABLE, COUNT, COUNT_DATA, TIMER_ENABLE, PRINT_FLAG) begin
		if (RST_N = '0') then
			DEBUG_PIN3 <= '1';
			COUNT <= ZEROCOUNT;
			COUNT_DATA <= ZEROCOUNT;
			TIMER_ENABLE <= '0';

		elsif (CLK' event and CLK = '1') then

			DEBUG_PIN3 <= '0';

			-- 1* パルス幅
			-- 0* 周期

			if (COUNT_ENABLE = "11") then
				DEBUG_PIN3 <= '1';
				if (COUNT /= MAXCOUNT) then
					COUNT <= COUNT + 1;
				end if;
				PRINT_FLAG <= '1';
			elsif (COUNT_ENABLE = "10") then
				if (PRINT_FLAG = '1') then
					COUNT_DATA <= COUNT;
					PRINT_FLAG <= not PRINT_FLAG;
				else
					COUNT <= ZEROCOUNT;
				end if;
			elsif (COUNT_ENABLE = "01") then
				if (TIMER_ENABLE = '0') then
					if (PRINT_FLAG = '1') then
						COUNT_DATA <= COUNT;
						PRINT_FLAG <= not PRINT_FLAG;
					else
						COUNT <= ZEROCOUNT;
						TIMER_ENABLE <= not TIMER_ENABLE;
					end if;
				else
					DEBUG_PIN3 <= '1';
					if (COUNT /= MAXCOUNT) then
						COUNT <= COUNT + 1;
					end if;
				end if;
			elsif (COUNT_ENABLE = "00") then
				DEBUG_PIN3 <= '1';
				if (COUNT /= MAXCOUNT) then
					COUNT <= COUNT + 1;
				end if;
				TIMER_ENABLE <= '0';
				PRINT_FLAG <= '1';
			end if;
		end if;
		RESULT <= COUNT_DATA;
	end process;

end RTL;