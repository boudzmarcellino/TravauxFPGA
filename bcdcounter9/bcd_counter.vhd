
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity bcd_counter is
    Port 
    (
        signal clk : in std_logic;
        signal rst : in std_logic;
        signal com : out std_logic;
        signal bcd : out std_logic_vector(6 downto 0)
    );
end bcd_counter;

architecture bcd_counter of bcd_counter is
    component counter is
        port
        (
            signal clk : in std_logic;
            signal rst : in std_logic;
            signal binary_number : out std_logic_vector(3 downto 0)
        );
    end component counter;

    component coder is
        port
        (
            signal binary_number : in std_logic_vector(3 downto 0);
            signal com : out std_logic;
            signal bcd : out std_logic_vector(6 downto 0)   
        );
    end component coder;
    
    signal number : std_logic_vector(3 downto 0);
begin
    compteur : counter port map(clk=>clk,rst=>rst, binary_number=>number);
    codeur : coder port map(binary_number =>number,com=>com, bcd=>bcd);

end architecture bcd_counter;

configuration conf of bcd_counter is
    for bcd_counter
        for compteur : counter use entity work.counter(counter); end for;
        for codeur : coder use entity work.coder(coder); end for;
    end for;
end configuration conf;