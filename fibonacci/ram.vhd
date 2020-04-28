library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram is
port(clk, wr : in std_logic;
i, iminus1, iminus2, n : in std_logic_vector(3 downto 0);
y : out std_logic_vector(7 downto 0));
end ram;
architecture rtl of ram is
type ram_type is array (0 to 15) of
std_logic_vector(7 downto 0);
signal program: ram_type := (
    "00000000",
    "00000001",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000"

);
signal add, fib1, fib2 : std_logic_vector(7 downto 0);

component adder is
    port (a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
begin
fib1 <= program(conv_integer(unsigned(iminus1)));
fib2 <= program(conv_integer(unsigned(iminus2)));
u : adder port map (fib1, fib2, add);
process(clk)
begin
if (rising_edge(clk)) then
if (wr = '1') then
program(conv_integer(unsigned(i))) <= add;
end if;
end if;
end process;
y <= program(conv_integer(unsigned(n)));
end rtl;