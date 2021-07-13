
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity lecteur is
  Port 
  (
        signal sw : in std_logic_vector(7 downto 0);
        signal hex0: out std_logic_vector(3 downto 0); 
        signal hex1: out std_logic_vector(3 downto 0);
        signal hex2: out std_logic_vector(3 downto 0); 
        signal hex3: out std_logic_vector(3 downto 0)
   );
end entity lecteur;

architecture lecteur of lecteur is
    signal sum : std_logic_vector (7 downto 0);
begin
    hex0 <= std_logic_vector(sw(3 downto 0));
    hex1 <= std_logic_vector(sw(7 downto 4)); 
   sum <= std_logic_vector(unsigned("0000"&sw(7 downto 4)) + unsigned("0000"&sw(3 downto 0)));
   hex2 <= std_logic_vector(sum(3 downto 0));
   hex3 <= std_logic_vector(sum(7 downto 4));
end lecteur;