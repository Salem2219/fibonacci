library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dp is
    port (clk, rst, wr, i_ld : in std_logic;
    n : in std_logic_vector(3 downto 0);
    x : out std_logic;
    y : out std_logic_vector(7 downto 0));
end dp;

architecture rtl of dp is
component compgr is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component plus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component minus2 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component minus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component ram is
port(clk, wr : in std_logic;
i, iminus1, iminus2, n : in std_logic_vector(3 downto 0);
y : out std_logic_vector(7 downto 0));
end component;
component reg is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(3 downto 0);
reg_out: out std_logic_vector(3 downto 0));
end component;
component mux is
    port (s : in std_logic;
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
signal iminus1, iminus2, i, iplus1, i_in : std_logic_vector(3 downto 0);
begin
    fib_ram : ram port map (clk, wr, i, iminus1, iminus2, n, y);
    i_mux : mux port map (wr, "0010", iplus1, i_in);
    i_adder : plus1 port map (i, iplus1);
    i_sub1 : minus1 port map (i, iminus1);
    i_sub2 : minus2 port map (i, iminus2);
    i_reg : reg port map (clk, rst, i_ld, i_in, i);
    comp : compgr port map (i, n, x);
end rtl;
    