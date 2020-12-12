library ieee;
use ieee.std_logic_1164.all;

entity dff_dlatch is
	port(
	CLK, D		:	in		std_logic;
	Q, Q1		:	out		std_logic
	);
end;

architecture arc of dff_dlatch is
	component dlatch_sr is
		port(
		C, D	:	in		std_logic;
		Q		:	out		std_logic
		);
	end	component;
	signal Q_INT, CLK_BAR: std_logic;
begin

	CLK_BAR <= not CLK after 1ns;
	Q1 <= Q_INT;
	
	dlatch_master : dlatch_sr 
	port map(
		C => CLK,
		D => D,
		Q => Q_INT
	);
	
	dlatch_slave : dlatch_sr 
	port map(
		C => CLK_BAR,
		D => Q_INT,
		Q =>Q
	);
	
end;
