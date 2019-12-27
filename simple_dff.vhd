LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY simple_dff IS
  PORT(d,clk: IN STD_LOGIC; 
		    q: OUT STD_LOGIC);
END simple_dff;
ARCHITECTURE one OF simple_dff IS
BEGIN
  PROCESS(clk)
  BEGIN
    IF clk'EVENT AND clk='1' THEN  --时钟上升沿触发
       q<=d;
    END IF;
  END PROCESS;
END one;
