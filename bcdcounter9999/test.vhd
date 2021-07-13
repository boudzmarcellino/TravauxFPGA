library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_unsigned.all;

entity test is
--  Port ( );
end test;

architecture test of test is
    component displayer
    Port 
    (
        signal clk : in std_logic ;
        signal rst : in std_logic ;
        signal dp_in : in std_logic_vector(3 downto 0);
        signal sortie : out std_logic_vector(3 downto 0);
        signal com : out std_logic_vector (3 downto 0)
     );
     end component displayer; 
     signal clock : std_logic:='0';
     signal rst : std_logic:='0';
     signal dp : std_logic_vector(3 downto 0) :=(others=>'0');
begin
    display9999 : displayer port map(clk=>clock, rst=>rst, dp_in=>dp);
    process
    begin
       clock <= not(clock);
       dp <=dp +'1';
       wait for 10 ns;   
    end process;
end architecture test;

configuration config of test is
    for test
        for display9999 : displayer use entity work.displayer(displayer); end for;
    end for;
end configuration config;