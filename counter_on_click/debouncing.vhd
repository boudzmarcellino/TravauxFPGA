
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity debouncing is
    generic(counter_size  :  integer :=20);                                                   --counter size (20 bits gives 10.5ms with 100MHz clock)
    port(
		signal clk : in std_logic;                                                            --input clock
		signal btn : in std_logic;                                                            --input signal to be debounced
		signal res  : out std_logic
		);                                                                                    --debounced signal
end debouncing;

architecture debouncing of debouncing is
     signal flipflops   : in std_logic_vector(1 downto 0);                                    --input flip flops
	 signal counter_set : in std_logic;                                                       --sync reset to zero
     signal counter_out : out std_logic_vector(counter_size downto 0) := (others => '0');     --counter output
begin
    counter_set <= flipflops(0) xor flipflops(1);                                             --determine when to start/reset counter 
  	process(clk)
  	begin
	if(clk'EVENT and clk = '1') then
		flipflops(0) <= btn;
		flipflops(1) <= flipflops(0);		
		if(counter_set = '1') then                 					-                          --reset counter because input is changing
			counter_out <= (others => '0');
		elsif(counter_out(counter_size) = '0') then 	                                       --stable input time is not yet met
			counter_out <= counter_out + 1;
		else                                        								           --stable input time is met
	       		res <= flipflops(1);
        end if;    
       	end if;
    end process;
end architecture debouncing;
