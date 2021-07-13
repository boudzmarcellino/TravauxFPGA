library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity displayer is
    Port 
    (
        signal clk :in std_logic;
        signal rst : in std_logic :='0';
        signal dp_in : in std_logic_vector(3 downto 0);
        signal sortie : out std_logic_vector(7 downto 0);
        signal com : out  std_logic_vector (3 downto 0)
     );
end displayer;
architecture displayer of displayer is
    component counter is 
        port
        (
		    signal clk : in std_logic;
		    signal rst : in std_logic;
		    signal binary_number : out std_logic_vector(3 downto 0)
		);
    end component counter;
    component mux is
        Port 
	    (	signal clk : in std_logic;
		    signal in0 : in std_logic_vector(3 downto 0);
		    signal in1 : in std_logic_vector(3 downto 0);
		    signal in2 : in std_logic_vector(3 downto 0);
		    signal in3 : in std_logic_vector(3 downto 0);
		    signal dp_in: in std_logic_vector(3 downto 0);            
		    signal sortie : out std_logic_vector(3 downto 0); 
		    signal dp_out : out std_logic;                           
		    signal com : out std_logic_vector(3 downto 0)
        );
    end component mux;
    component coder is
    port
    (
        signal binary_number : in std_logic_vector(3 downto 0);
        signal dp : in std_logic;
        signal sseg : out std_logic_vector(7 downto 0)
    );
	end component coder; 
    signal second_clk : std_logic; signal binary_number1 : std_logic_vector(3 downto 0);
    signal third_clk : std_logic; signal binary_number2 : std_logic_vector(3 downto 0);
    signal four_clk : std_logic; signal binary_number3 : std_logic_vector(3 downto 0);
                                signal binary_number4 : std_logic_vector(3 downto 0);
    signal bin : std_logic_vector(3 downto 0); signal dp : std_logic;
	begin
		first : counter port map(rst=>rst, clk=>clk, binary_number=>binary_number1);
		seconde : counter port map(rst=>rst, clk => second_clk, binary_number=>binary_number2);
		third : counter port map(rst=>rst, clk => third_clk, binary_number=>binary_number3);
		fourth : counter port map(rst=>rst, clk => four_clk, binary_number=>binary_number4);
		multiplexer : mux port map( clk =>clk, in0 =>binary_number1, in1=>binary_number2, in2 =>binary_number3, in3 =>binary_number4, dp_in=>dp_in, sortie=>bin, dp_out=>dp, com=>com);
		bcd : coder port map(binary_number=>bin, dp=>dp, sseg=>sortie);
		second_clk <='1' when binary_number1 = "1001" else '0';
		third_clk <='1' when binary_number2 = "1001" else '0';
		four_clk <='1' when binary_number3 = "1001" else '0';
	end displayer;
	Configuration conf of displayer is
	for displayer
		for first : counter use entity work.counter(counter_internal_clock);end for;
		for seconde : counter use entity work.counter(counter_external_clock);end for;
		for third : counter use entity work.counter(counter_external_clock);end for;
		for fourth : counter use entity work.counter(counter_external_clock);end for;
		for multiplexer : mux use entity work.mux(mux);end for;   
		for bcd : coder use entity work.coder(coder); end for;
	end for;
end configuration conf;
