

library iee;
use ieee.std_lgic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is
    Port 
    ( 
       	clk, counter_in : in  STD_LOGIC;
       	res : out  STD_LOGIC_VECTOR (7 downto 0)       	
   	);
end counter;

architecture counter of counter is
signal click_counter : std_logic_vector(7 downto 0):="00000000";		
	begin				 
		process(clk, counter_in)
		begin 
			if clk'event and clk='1' then
				if counter_in='1' then
					click_counter <= click_counter + '1';
				end if;
			end if;
		end process;	
		res <= click_counter;
end counter;
