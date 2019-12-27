LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY dff_clrn IS
    PORT ( d     : IN STD_LOGIC;-- Data input
	    clrn  : IN STD_LOGIC; -- Asynchronous reset
        clk   : IN STD_LOGIC;-- Clock input
        q     : OUT STD_LOGIC );
           -- data output
END ENTITY;
ARCHITECTURE rtl OF dff_clrn IS
BEGIN
    PROCESS (clk,clrn)
    BEGIN
        IF clrn = '0' THEN q <= '0';
        ELSIF rising_edge(clk) THEN
          q <= d;
        END IF;
    END PROCESS;
END ARCHITECTURE;
