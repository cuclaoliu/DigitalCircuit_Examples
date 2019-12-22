library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mypack.all;

entity cnt24 is
	port(
		clk		: in std_logic;
		en		: in std_logic;
		cnth	: out BCD;
		cntl	: out BCD;
		cout	: out std_logic
	);
end entity;

ARCHITECTURE rtl OF cnt24 IS
  SIGNAL cnth_int, cntl_int : BCD;
  COMPONENT bcdcnt IS GENERIC(MAX : NATURAL := 10);
  PORT( clk : IN STD_LOGIC;
	    en	: IN STD_LOGIC := '1';
            rst : IN STD_LOGIC := '0';		
	    q: OUT BCD;
            cout : OUT STD_LOGIC);
  END COMPONENT;
  SIGNAL rst, cntl_cout: STD_LOGIC;
BEGIN
  one_digit : bcdcnt
    PORT MAP(clk => clk, en => en,
      rst=> rst, q => cntl_int, cout => cntl_cout);
  ten_digit : bcdcnt
    PORT MAP(clk, cntl_cout AND en, rst, cnth_int);

  rst <= '1' WHEN cnth_int=2 AND cntl_int=3 ELSE '0';
  cout <= rst;
  cnth <= cnth_int;
  cntl <= cntl_int;
END rtl;