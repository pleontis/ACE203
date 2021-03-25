library IEEE;	   --Libraries Declaration 
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity circuit_tb is
end;

architecture bench of circuit_tb is

  component circuit	--Module for testing declaration 
      Port ( Clock : in STD_LOGIC;
             RST : in STD_LOGIC;
             Control : in STD_LOGIC_VECTOR (2 downto 0);
             Count : out STD_LOGIC_VECTOR (7 downto 0);
             Overflow : out STD_LOGIC;
             Underflow : out STD_LOGIC;
             Valid : out STD_LOGIC);
  end component;
	--Inputs 
  signal Clock: STD_LOGIC;
  signal RST: STD_LOGIC;
  signal Control: STD_LOGIC_VECTOR (2 downto 0);
	--Outputs 
  signal Count: STD_LOGIC_VECTOR (7 downto 0);
  signal Overflow: STD_LOGIC;
  signal Underflow: STD_LOGIC;
  signal Valid: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin
	 -- Instantiate the Unit Under Test (UUT) 
  uut: circuit port map ( Clock     => Clock,
                          RST       => RST,
                          Control   => Control,
                          Count     => Count,
                          Overflow  => Overflow,
                          Underflow => Underflow,
                          Valid     => Valid );

  stimulus: process
  begin
  
    -- Put initialization code here
    RST <= '1';
    WAIT FOR 100 NS;	--wait for 100ns to see the results
    RST <='0';
	 Control<="100";
    WAIT FOR 20 NS;
	 
	 Control<="000";	--Check for underflow
	 WAIT FOR 10 ns;
    
	 Control<="111"; --Check if underflow is signal stops circuit function
	 WAIT FOR 10 NS;
	 
	 RST <= '1';	--Reinitialize counter 
	 WAIT FOR 10 NS;
	 RST <= '0';
	 Control<="011"; 	
    WAIT FOR 50 NS; --wait for 500ns to see the result
	 
	 Control<="100";
	 WAIT FOR 50 NS;
	 
	 Control<="101";
	 WAIT FOR 50 NS;
	 
	 Control <="111";	--Check for overflow
	 WAIT FOR 200 NS;
	  
    RST <= '1';	--Reinitialize code 
    WAIT FOR 10 ns;
    RST <= '0';
    Control<="010";
	 wait for 10 ns;
	  
	 Control<="110";
	 WAIT FOR 10 NS; --Wait for 10 ns to see the result
	 
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      Clock <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;