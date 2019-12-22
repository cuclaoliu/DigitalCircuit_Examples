LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY binary_counter_4bits IS
    PORT(
        clk  :  IN   STD_LOGIC;
        en   :  IN   STD_LOGIC;
        q_out    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
        cout :  OUT  STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF binary_counter_4bits is
	SIGNAL d,q	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    d(0) <= en XOR q(0);
    d(1) <= (en AND q(0)) XOR q(1);
    d(2) <= (en AND q(0) AND q(1)) XOR q(2);
    d(3) <= (en AND q(0) AND q(1) AND q(2)) XOR q(3);

    PROCESS(clk)
    BEGIN
        IF clk'EVENT AND clk='1' THEN
            q(3 DOWNTO 0) <= d(3 DOWNTO 0);
        END IF;
    END PROCESS;

    q_out <= q;
    cout <= en AND q(0) AND q(1) AND q(2) AND q(3);
END rtl;