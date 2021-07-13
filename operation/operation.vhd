
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity operation is
  Port 
  (
      signal clk: in std_logic;
      signal sw: in std_logic_vector(7 downto 0);
      signal dp_in: in std_logic_vector(3 downto 0);
      signal sseg: out std_logic_vector(7 downto 0);
      signal com : out std_logic_vector(3 downto 0) 
  );
end operation;
architecture operation of operation is
component lecteur is 
  Port 
  (
        signal sw : in std_logic_vector(7 downto 0);
        signal hex0: out std_logic_vector(3 downto 0); 
        signal hex1: out std_logic_vector(3 downto 0);
        signal hex2: out std_logic_vector(3 downto 0); 
        signal hex3: out std_logic_vector(3 downto 0)
   );
  end component lecteur;
  component mux is
      Port 
    (
        signal clk : in std_logic;
        signal in0 : in std_logic_vector(3 downto 0);
        signal in1 : in std_logic_vector(3 downto 0);
        signal in2 : in std_logic_vector(3 downto 0);
        signal in3 : in std_logic_vector(3 downto 0);
        signal dp_in : in std_logic_vector(3 downto 0);
        signal sortie : out std_logic_vector(3 downto 0);
        signal dp_out : out std_logic; 
        signal com : out std_logic_vector(3 downto 0)              
    );
  end component mux;
  component coder is 
    Port 
    ( 
        signal binary_number : in std_logic_vector(3 downto 0);
        signal dp: in std_logic;
        signal sseg: out std_logic_vector(7 downto 0)
    );
  end component coder;
  signal hex0toin0, hex1toin1, hex2toin2, hex3toin3, bin : std_logic_vector(3 downto 0);
  signal dp, point : std_logic;
begin 
--hex0toin0<=hex0 ; hex1toin1<=hex1; hex2toin2<=hex2; hex3toin3<=hex3;
lect : lecteur port map(sw=>sw, hex0=>hex0toin0, hex1=>hex1toin1,hex2=>hex2toin2, hex3=>hex3toin3);
multiplexeur : mux port map(clk=>clk, in0=>hex0toin0, in1=>hex1toin1, in2=>hex2toin2, in3=>hex3toin3, dp_in=>dp_in, dp_out=>dp, sortie=>bin, com=>com); 
bcd : coder port map(binary_number=>bin, dp=>dp,  sseg=>sseg); 
end architecture operation;
configuration conf of operation is
for operation 
    for lect : lecteur use entity work.lecteur(lecteur); end for;
    for multiplexeur :mux use entity work.mux(mux);end for;
    for bcd : coder use entity work.coder(coder); end for;
end for;
end configuration conf;

