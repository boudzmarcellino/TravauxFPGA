library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity mux is
    generic
    (
        N : integer :=22;
        stamp : std_logic_vector :="11110100001001000000"
    );
    Port 
    (
        signal clk : in std_logic;
        signal in0 : in std_logic_vector(3 downto 0);
        signal in1 : in std_logic_vector(3 downto 0);
        signal in2 : in std_logic_vector(3 downto 0);
        signal in3 : in std_logic_vector(3 downto 0);
        signal dp_in: in std_logic_vector(3 downto 0);            
        signal sortie : out std_logic_vector(3 downto 0); 
        signal dp_out : out std_logic;                           
        signal com : out std_logic_vector(3 downto 0)              
    );
end entity mux;
architecture mux of mux is
     signal count_stamp:std_logic_vector(N-1 downto 0):=(others=>'0');
     signal count :std_logic;
     signal sel: std_logic_vector(1 downto 0);
     begin
        process(clk)
        begin
            if(rising_edge(clk)) then
                if(count_stamp = stamp) then 
                    count_stamp <= (others=>'0');  
                else
                    count_stamp<=count_stamp +'1';
                end if;
            end if;
        end process;
        sel <= std_logic_vector(count_stamp(N-1 downto N-2));
        process(sel, in0, in1, in2, in3)
        begin
            case sel is
                when "00" => sortie <= in0; com<="1110"; dp_out <= dp_in(0);
                when "01" => sortie <= in1; com<="1101"; dp_out <= dp_in(1);
                when "10" => sortie <= in2; com<="1011"; dp_out <= dp_in(2);
                when others => sortie <= in3; com<="0111"; dp_out <= dp_in(3);                            
            end case;
        end process;
end architecture mux;
