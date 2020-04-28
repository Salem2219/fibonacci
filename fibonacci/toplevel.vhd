library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity toplevel is
    port (clk, rst, start : in std_logic;
    n : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
end toplevel;

architecture rtl of toplevel is
component dp is
    port (clk, rst, wr, i_ld : in std_logic;
    n : in std_logic_vector(3 downto 0);
    x : out std_logic;
    y : out std_logic_vector(7 downto 0));
end component;
component ctrl is
  port(clk,rst, start, x: in std_logic;
       wr, i_ld: out std_logic);
end component;
signal wr, i_ld, x : std_logic;
begin
    datapath : dp port map (clk, rst, wr, i_ld, n, x, y);
    control : ctrl port map (clk, rst, start, x, wr, i_ld);
end rtl;