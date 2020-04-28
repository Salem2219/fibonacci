library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ctrl is
  port(clk,rst, start, x: in std_logic;
       wr, i_ld: out std_logic);
end ctrl;

architecture rtl of ctrl is
  type state_type is (s0,s1,s2,s3);
  signal current_state, next_state: state_type;
begin 
  process(x, start, current_state)
  begin
    case current_state is
	when s0 =>  
	  wr <= '0';
      i_ld <= '0';      
	  next_state <= s1;
	when s1 =>  
      wr <= '0';
      i_ld <= '1';
	  if (start = '1') then 
	    next_state <= s2 ;
	  else
	    next_state <= s1;	
	  end if;
	when s2 => 
      wr <= '0';
      i_ld <= '0';
      if (x = '1') then
	  next_state <= s1;
      else
      next_state <= s3;
      end if;
	when s3 =>  
      wr <= '1';
      i_ld <= '1';
      next_state <= s2;
	end case;
  end process;
  process (rst, clk)
  begin
    if (rst ='1') then
      current_state <= s0;
    elsif (rising_edge(clk)) then
      current_state <= next_state;
    end if;
  end process;
end rtl;