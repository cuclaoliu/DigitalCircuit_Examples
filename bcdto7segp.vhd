LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.MYPACK.ALL;
ENTITY bcdto7segp IS
PORT (n: IN BCD;
	  en: IN STD_LOGIC := '1';
	  leds: OUT SSD);
END bcdto7segp;

ARCHITECTURE rtl1 OF bcdto7segp IS
	constant dim : SSD := "1111111";
	signal leds_int : SSD := dim;
	constant char0 : SSD := "0000001";
	constant char1 : SSD := "1001111";
	constant char2 : SSD := "0010010";
	constant char3 : SSD := "0000110";
	constant char4 : SSD := "1001100";
	constant char5 : SSD := "0100100";
	constant char6 : SSD := "0100000";
	constant char7 : SSD := "0001111";
	constant char8 : SSD := "0000000";
	constant char9 : SSD := "0000100";
BEGIN
	leds <= leds_int when en='1' else dim;
	with n select leds <= 
		char0 when 0,
		char1 when 1,
		char2 when 2,
		char3 when 3,
		char4 when 4,
		char5 when 5,
		char6 when 6,
		char7 when 7,
		char8 when 8,
		char9 when 9,
		dim   when others;
END rtl1;

ARCHITECTURE rtl2 OF bcdto7segp IS
BEGIN
	PROCESS (n, en)
	BEGIN
		IF en='1' THEN
			CASE n IS
				WHEN 0		=>	leds<="0000001";
				WHEN 1		=>	leds<="1001111";
				WHEN 2		=>	leds<="0010010";
				WHEN 3		=>	leds<="0000110";
				WHEN 4		=>	leds<="1001100";
				WHEN 5		=>	leds<="0100100";
				WHEN 6		=>	leds<="0100000";
				WHEN 7		=>	leds<="0001111";
				WHEN 8		=>	leds<="0000000";
				WHEN 9		=>	leds<="0000100";
				WHEN OTHERS	=>	leds<="1111111";
			END CASE;
		ELSE
			leds <= "1111111";
		END IF;
	END PROCESS;
END rtl2;

configuration con of bcdto7segp is
	for rtl1
	end for;
end con;