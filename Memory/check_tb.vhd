library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity check_tb is
end;

architecture bench of check_tb is

  component check
      Port ( CLK : in  STD_LOGIC;
				 RST : in STD_LOGIC;	
             Push : in  STD_LOGIC;
             Pop : in  STD_LOGIC;
             Empty : out  STD_LOGIC;
             Full : out  STD_LOGIC;
             AlmostEmpty : out  STD_LOGIC;
             AlmostFull : out  STD_LOGIC;
				 Address : out STD_LOGIC_VECTOR(3 downto 0);
				 writ: out  STD_LOGIC_VECTOR(0 downto 0)
  	 );
  end component;
	--Input
  signal CLK: STD_LOGIC:='0';
  signal RST: STD_LOGIC:='0';
  signal Push: STD_LOGIC:='0';
  signal Pop: STD_LOGIC:='0';
  --Output
  signal Empty: STD_LOGIC;
  signal Full: STD_LOGIC;
  signal AlmostEmpty: STD_LOGIC;
  signal AlmostFull: STD_LOGIC;
  signal Address: STD_LOGIC_VECTOR(3 downto 0);
  signal writ: STD_LOGIC_VECTOR(0 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: check port map ( CLK         => CLK,
                        RST         => RST,
                        Push        => Push,
                        Pop         => Pop,
                        Empty       => Empty,
                        Full        => Full,
                        AlmostEmpty => AlmostEmpty,
                        AlmostFull  => AlmostFull,
                        Address     => Address,
                        writ        => writ );

  stimulus: process
  begin
  
	RST<='1';
	wait for  clock_period*10;
	RST<='0';
	wait for clock_period;
	Push<='1';
	wait for clock_period*22;
	Push<='0';
	Pop<='1';
	wait for clock_period*22;
	Pop<='0'; 
	stop_the_clock <= true;
	wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;