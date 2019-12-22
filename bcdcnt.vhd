LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.mypack.all;
ENTITY bcdcnt IS
	GENERIC(MAX : NATURAL := 10);
	PORT(
	clk	: IN STD_LOGIC;
	rst	: IN STD_LOGIC := '0';
	en	: IN STD_LOGIC := '1';
	q	: OUT BCD;
	cout: OUT STD_LOGIC);
END ENTITY;
ARCHITECTURE rtl OF bcdcnt IS
	SIGNAL   cnt : BCD := 0;
BEGIN
	q <= cnt;
	PROCESS (clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			IF rst = '1' THEN
				cnt <= 0;
			ELSIF en = '1' THEN
				IF (cnt < MAX-1) THEN
					cnt <= cnt + 1;
				ELSE
					cnt <= 0;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	cout <= '1' WHEN cnt = MAX-1 ELSE '0';
END rtl;