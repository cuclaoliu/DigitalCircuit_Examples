LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY mux41 IS
    PORT (
        a, b, c, d : IN STD_LOGIC;
        sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        q : OUT STD_LOGIC);
END mux41;
ARCHITECTURE arc_when OF mux41 IS
BEGIN
    WITH sel SELECT q <=
        a WHEN "00",
        b WHEN "01",
        c WHEN "10",
        d WHEN OTHERS;--"11"
END arc_when;
ARCHITECTURE arc_case OF mux41 IS
BEGIN
    PROCESS(a, b, sel)
    BEGIN
        CASE sel IS
            WHEN "00" => q <= a;
            WHEN "01" => q <= b;
            WHEN "10" => q <= c;
            WHEN OTHERS => q <= a;--"00"
        END CASE;    
    END PROCESS;
END arc_case;