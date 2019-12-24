library ieee;
use ieee.std_logic_1164.all;

entity cnt24_buffer is
	port(
		clk		: in std_logic;
		en		: in std_logic;
		cnth	: buffer INTEGER RANGE 0 TO 9;
		cntl	: buffer INTEGER RANGE 0 TO 9;
		cout	: out std_logic
	);
end entity;

ARCHITECTURE rtl OF cnt24_buffer IS
  SIGNAL cnth_int, cntl_int : INTEGER RANGE 0 TO 9;
  COMPONENT bcdcnt IS
  PORT( clk : IN STD_LOGIC;
	    en	: IN STD_LOGIC := '1';
            rst : IN STD_LOGIC := '0';		
	    q: buffer INTEGER RANGE 0 TO 9;
            cout : OUT STD_LOGIC);
  END COMPONENT;
  SIGNAL rst, cntl_cout: STD_LOGIC;
BEGIN
  one_digit : bcdcnt
    PORT MAP(clk => clk, en => en,
      rst=> rst, q => cntl, cout => cntl_cout);
  ten_digit : bcdcnt
    PORT MAP(clk, cntl_cout AND en, rst, cnth);

  rst <= '1' WHEN cnth=2 AND cntl=3 ELSE '0';
  cntl <= 5 WHEN cnth=3 ELSE cntl;
  cout <= rst;
END rtl;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY bcdcnt IS
	PORT(
	clk	: IN STD_LOGIC;
	rst	: IN STD_LOGIC := '0';
	en	: IN STD_LOGIC := '1';
	q	: BUFFER INTEGER RANGE 0 TO 9;
	cout: OUT STD_LOGIC);
END ENTITY;
ARCHITECTURE rtl OF bcdcnt IS
BEGIN
	PROCESS (clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			IF rst = '1' THEN
				q <= 0;
			ELSIF en = '1' THEN
				IF (q < 9) THEN
					q <= q + 1;
				ELSE
					q <= 0;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	cout <= '1' WHEN q = 9 ELSE '0';
END rtl;