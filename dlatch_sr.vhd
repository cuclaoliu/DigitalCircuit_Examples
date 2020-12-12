library ieee;
use ieee.std_logic_1164.all;

entity dlatch_sr is
	port(
	C, D	:	in		std_logic;
	Q		:	out		std_logic
	);
end;

architecture arc of dlatch_sr is
	signal S_BAR, R_BAR, Q_BAR, Q_INT : std_logic;
begin
	S_BAR <= not (D and C) after 2ns;
	R_BAR <= not ( not D and C) after 2ns;
	Q <= Q_INT;
	Q_INT <= not (S_BAR and Q_BAR) after 2ns;
	Q_BAR <= not (R_BAR and Q_INT) after 2ns;

end;
