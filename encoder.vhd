LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY encoder IS
PORT(I : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
     Y: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END encoder;
ARCHITECTURE arc_when OF encoder IS
BEGIN
    Y <= "11" WHEN I(3) = '0' ELSE
         "10" WHEN I(2) = '0' ELSE
         "01" WHEN I(1) = '0' ELSE
         "00";
END arc_when;
CONFIGURATION con OF encoder IS
    FOR arc_if
    END FOR;
END con;
ARCHITECTURE arc_if OF encoder IS
BEGIN
    PROCESS(I)
    BEGIN
        IF I(3) = '0' THEN
		Y <= "11";
        ELSIF I(2) = '0' THEN
            Y <= "10";
        ELSIF I(1) = '0' THEN
            Y <= "01";
        ELSE
            Y <= "00";
	  END IF;
    END PROCESS;
END arc_if;
--多重条件适合有优先级的电路