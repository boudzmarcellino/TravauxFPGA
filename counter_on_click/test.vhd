library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
end entity test;

architecture test of test is
    signal clk : std_logic :='0'; 
    signal btn : std_logic;
    signal res : std_logic_vector(7 downto 0);
    component click_counter is
        port
        (
            signal clk : in std_logic;
            signal btn : in std_logic;
            signal res : out std_logic_vector(7 downto 0)
        ); 
    end component click_counter;
    
    begin
    clk <= not(clk) after 10 ns;
    debounce : click_counter port map(clk=>clk,btn => btn, res=>res);  
    process
    begin
        btn <='1'; 
        btn <= '0' after 20 ms;
        btn <='1'; 
        wait for 30 ms;
    end process;     
end architecture test;

configuration config of test is
    for test
        for debounce : click_counter use entity work.click_counter(click_counter); end for;
    end for;
end configuration config;