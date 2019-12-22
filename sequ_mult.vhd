library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity sequ_mult is	
generic(WIDTH : integer := 8);
port(
	clk, reset : in std_logic;
	start : in std_logic;
	a_in, b_in : in unsigned(WIDTH-1 downto 0);
	ready : out std_logic;
	p : out unsigned(2*WIDTH-1 downto 0));	
end sequ_mult;
architecture rtl of sequ_mult is
	type state_type is (idle, ab0, load, op);
	signal state_reg, state_next : state_type;
	signal a_is_0, b_is_0, count_0 : std_logic;
	signal n_reg, n_next : unsigned(WIDTH-1 downto 0);
	signal a_reg, a_next : unsigned(WIDTH-1 downto 0);		
	signal r_reg, r_next : unsigned(2*WIDTH-1 downto 0);
	signal adder_out : unsigned(2*WIDTH-1 downto 0);
	signal sub_out : unsigned(WIDTH-1 downto 0);
begin
-----------control path : state register----------------
process(clk, reset)
begin
    if reset = '1' then
        state_reg <= idle;
    elsif clk'event and clk='1' then
        state_reg <= state_next;
    end if;
end process;
-----------control path : output logic ---------- 
ready <= '1' when state_reg = idle else '0';
-----------control path : next logic/output logic ----------
process(state_reg, start, a_is_0, b_is_0, start, count_0)
begin
	case state_reg is
		when idle =>
			if start = '1' then
				if a_is_0='1' or b_is_0='1' then
					state_next <= ab0;
				else
					state_next <= load;
				end if;
			else
				state_next <= idle;
			end if;
		when ab0 =>	state_next <= idle;
		when load =>	state_next <= op;
		when op =>
			if count_0 = '1' then
				state_next <= idle;
			else
				state_next <= op;
			end if;
	end case;
end process;
--------------data path ----------------- 		
process(clk, reset)
begin
    if reset = '1' then
        a_reg <= (others => '0');
        n_reg <= (others => '0');		
        r_reg <= (others => '0');		
    elsif clk'event and clk = '1' then
        a_reg <= a_next;
        n_reg <= n_next;			
        r_reg <= r_next;	
    end if;
end process;
-----------data path: function unit---------- 
adder_out <= ("00000000" & a_reg) + r_reg;
sub_out <= n_reg - 1;
-----------data path: routing multiplexer---------- 	
process(state_reg, a_reg, n_reg, r_reg, a_in, b_in, adder_out, sub_out)
begin
    case state_reg is
        when idle =>
            a_next <= a_reg;
            n_next <= n_reg;
            r_next <= r_reg;		
        when ab0 =>
            a_next <= a_in;
            n_next <= b_in;
            r_next <= (others => '0');	
        when load =>
            a_next <= a_in;
            n_next <= b_in;
            r_next <= (others => '0');		
        when op =>
            a_next <= a_reg;
            n_next <= sub_out;
            r_next <= adder_out;
    end case;
end process;
-----------data path: status---------- 			
a_is_0 <= '1' when a_in = "00000000" else '0';
b_is_0 <= '1' when b_in = "00000000" else '0';
count_0 <= '1' when n_next = "00000000" else '0';

p <= r_reg;
end rtl;

architecture rtl2 of sequ_mult is
	type state_type is (idle, op);
	signal state_reg, state_next : state_type;
	signal n_reg, n_next : unsigned(WIDTH-1 downto 0);
	signal a_reg, a_next : unsigned(WIDTH-1 downto 0);		
	signal r_reg, r_next : unsigned(2*WIDTH-1 downto 0);
begin
---------state and data register----------------
	process(clk,  reset)
	begin
		if reset = '1' then
			state_reg <= idle;
			a_reg <= (others => '0');
			n_reg <= (others => '0');
			r_reg <= (others => '0');			
		elsif clk'event and clk = '1' then
			state_reg <= state_next;
			a_reg <= a_next;
			n_reg <= n_next;
			r_reg <= r_next;			
		end if;
	end process;
----------combinational logic--------------------
process(start, state_reg, a_reg, n_reg, r_reg, a_in, b_in)
begin
	a_next <= a_reg;	n_next <= n_reg;
	r_next <= r_reg;	ready <= '0';
	case state_reg is
		when idle =>
			if start = '1' then
				a_next <= a_in;	n_next <= b_in;
				r_next <= (others => '0');
				if a_in = "00000000" or b_in = "00000000" then
					state_next <= idle;
				else
					state_next <= op;
				end if;
			end if;
			ready <= '1';
		when op =>
			n_next <= n_reg - 1;
			r_next <= r_reg + ("00000000" & a_reg);
			if n_next = "00000000" then
				state_next <= idle;
			else
				state_next <= op;
			end if;
	end case;
end process;
p <= r_reg;
end rtl2;

configuration con of sequ_mult is
	for rtl
	end for;
end con;