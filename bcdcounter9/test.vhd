
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity test is
end test;

architecture test of test is
    
    signal clk : std_logic :='0';
    signal rst : std_logic;

    
    component bcd_counter is
    Port 
    (
        signal clk : in std_logic;
        signal rst :in std_logic;
        signal com : out std_logic;
        signal bcd : out std_logic_vector(6 downto 0)
    );
    end component bcd_counter;

    begin
    disp : bcd_counter port map(clk=>clk, rst=>rst);
    
    process
    begin
    clk <= not(clk); 
    wait for 0.01 us;
    end process;
end architecture test;

configuration config of test is
    for test
    for disp :bcd_counter use entity work.bcd_counter(bcd_counter); end for;
    end for;
end configuration config;
