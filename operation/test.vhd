library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity test is
end test;

architecture test of test is
component operation is
    port(
      signal clk: in std_logic;
      signal sw: in std_logic_vector(7 downto 0);
      signal dp_in: in std_logic_vector(3 downto 0);
      signal sseg: out std_logic_vector(7 downto 0);
      signal com : out std_logic_vector(3 downto 0)
      );
end component operation;
signal clk : std_logic:='0';
signal sw :std_logic_vector(7 downto 0):=(others=>'0');
signal dp :std_logic_vector(3 downto 0):=(others=>'0'); 
begin
op :operation port map(clk=>clk, sw=>sw, dp_in =>dp);
process
begin
    clk<=not(clk);
    sw<=sw+'1';
    dp<=dp +'1';
    wait for 10ns;  
end process;
end architecture test;
configuration config of test is
    for test
        for op :operation use entity work.operation(operation);end for;  
    end for;
end configuration config;