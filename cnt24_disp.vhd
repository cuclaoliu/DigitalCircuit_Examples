LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.MYPACK.ALL;

ENTITY cnt24_disp IS
	PORT(
	clk		: IN STD_LOGIC;
	en		: IN STD_LOGIC;
	HEX1	: OUT SSD;
	HEX0	: OUT SSD;
	LEDH	: OUT BCD;
	LEDL	: OUT BCD;
	cout	: OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE str OF cnt24_disp IS
	COMPONENT cnt24 IS 	port(
			clk		: in std_logic;
			en		: in std_logic;
			cout	: out std_logic;
			cnth	: out BCD;
			cntl	: out BCD);
	end COMPONENT;
	COMPONENT bcdto7segp is port(
		n: IN BCD;
	  leds: OUT SSD);
	END COMPONENT;
	
	SIGNAL sec_h, sec_l : BCD;
BEGIN

	LEDH <= sec_h;
	LEDL <= sec_l;
	cnt_second	: cnt24 PORT MAP(
						clk => clk,
						en => en,
						cout => cout,
						cnth => sec_h,
						cntl => sec_l);

	h_47		: bcdto7segp PORT MAP(
						n => sec_h,
						leds => HEX1);
	l_47		: bcdto7segp PORT MAP(
						n => sec_l,
						leds => HEX0);
		
END str;