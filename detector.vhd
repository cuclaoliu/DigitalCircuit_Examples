library ieee;
use ieee.std_logic_1164.all;

entity detector is
	port(clk,aclr,x	: in std_logic;
	  z	: out std_logic);
end;

architecture behave of detector is
  type state_type is (STATE0, STATE1, STATE2, STATE3,
                  STATE4, STATE5, STATE6, STATE7);
	signal current_state, next_state	: state_type;
begin
  ns: process(current_state, x)
  begin
    case current_state is
      when STATE0 => 
        if x='1' then next_state <= STATE1;
        else next_state <= STATE0;
        end if;
      when STATE1 =>
        if x='1' then next_state <= STATE2;
        else next_state <= STATE0;
        end if;
      when STATE2 =>
        if x='0' then next_state <= STATE3;
        else next_state <= STATE2;
        end if;
      when STATE3 =>
        if x='0' then next_state <= STATE4;
        else next_state <= STATE1;
        end if;
      when STATE4 =>
        if x='1' then next_state <= STATE5;
        else next_state <= STATE0;
        end if;
      when STATE5 =>
        if x='0' then next_state<= STATE6;
        else next_state <= STATE2;
        end if;
      when STATE6 =>
        if x='1' then next_state <= STATE7;
        else next_state <= STATE0;
        end if;
      when STATE7 =>
        if x='0' then next_state <= STATE0;
        else next_state <= STATE2;
        end if;
      end case;
  end process;

  z <= '1' when current_state = STATE7 else '0';

  cs: process(clk,aclr)
  begin
    if aclr='1' then
      current_state <= STATE0;
    elsif clk'event and clk='1' then
      current_state <= next_state;
    end if;
  end process;
end behave;