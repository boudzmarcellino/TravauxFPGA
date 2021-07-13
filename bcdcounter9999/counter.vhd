library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity counter is 
    generic 
    (
        second :  std_logic_vector:=b"11110100001001000000" ;--x"5f50ff";                                   -- N equivalent binaire du nombe de pulsation pour atteindre la seconde par rapport a l'horloge externe
        for_second : integer := 22                                               -- nombre de bits pour compter jusqu'a la seconde
    );
    
    Port 
    ( 
        clk : in  std_logic;                                                      -- signal d'horloge externe
        rst : in  std_logic;                                                      -- remise a zero
        binary_number : out  std_logic_vector (3 downto 0)
    );
end counter;

architecture counter_internal_clock of counter is
    signal one_sec_counter: std_logic_vector(for_second downto 0):=(others=>'0'); -- compteur de front montant de l'horloge externe
    signal one_sec_en: std_logic:='0';                                                 -- Bit de detection de la seconde
    signal number: std_logic_vector(3 downto 0) :="0000";
begin
    process(clk,rst)                                                        	  -- Processus de detection de la seconde
    begin
        if rst='1' then 
            one_sec_counter <= (others=>'0');
        elsif rising_edge(clk) then
            if (one_sec_counter=second) then 
                one_sec_counter <= (others=>'0');                                  -- for each rising edge when  counter in 1 seconde is max assign 0 to himself
            else 
                one_sec_counter <= one_sec_counter +'1';                           -- else add 1 bit 
            end if;
        end if;
    end process;
    one_sec_en <= '1' when one_sec_counter=second else '0';
	   
	process(clk,rst,one_sec_en,number)                                                                -- Process about bcd behavioral on n the time and detecting second 	                                                                  
		begin
            if rst='1' then
                number<=(others=>'0');                                                 -- bcd code set 0 on rst pressing
            elsif rising_edge(clk) then
                if one_sec_en='1' then                                              -- when 1 secone acciomplished 
                    if number="1001" then                                              -- if bcd =1001 thus 10
                        number<=(others=>'0');                                         -- set it at 0
                        else
                        number<=number + '1';                                              -- else add 1 bit to bcd
                    end if;
                end if;
            end if;
            binary_number<=number;
    end process;		
end architecture counter_internal_clock;

architecture counter_external_clock of counter is
    signal number: std_logic_vector(3 downto 0) :="0000";
begin
	process(clk,rst)                                                            -- Process about bcd behavioral on n the time and detecting second 	                                                                  
		begin
            if rst='1' then
                number<=(others=>'0');                                         -- bcd code set 0 on rst pressing
            elsif rising_edge(clk) then
                if clk='1' then                                                 -- when 1 secone acciomplished 
                    if number="1001" then                                        -- if bcd =1001 thus 10
                        number<=(others=>'0');                                       -- set it at 0
                        else
                        number<=number +'1';                                              -- else add 1 bit to bcd
                    end if;
                end if;
            end if;
            binary_number<=number;
    end process;		
end architecture counter_external_clock;
