
library iee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity click_counter is
    port
    (
        signal clk, btn : in std_logic;
        signal res : out std_logic_vector(7 downto 0 )
    );
end entity click_counter;

architecture click_counter of click_counter is
    component debouncing is
        port
        (
            signal clk, btn : in std_logic;
            signal res : out std_logic
        ); 
    end component debouncing;
    
    component counter is 
        port
        (
            signal clk, counter_in: in std_logic;
            signal res : out std_logic_vector(7 downto 0) 
        );
    end component counter;
    
    signal filtre_to_counter : std_logic;    
    begin
    debouncing_circuit : debouncing port map(clk=>clk, btn => btn, res=>filtre_to_counter);   
    counter_circuit : counter port map(clk=>clk, counter_in=>filtre_to_counter, res=>res);      
end architecture click_counter;

configuration conf of click_counter is
    for click_counter
        for debouncing_circuit : debouncing use entity work.debouncing(debouncing); end for;
        for counter_circuit : counter use entity work.counter(counter);end for;
    end for;
end configuration conf;
