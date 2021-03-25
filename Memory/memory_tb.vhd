LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY memory_tb IS
END memory_tb;
 
ARCHITECTURE behavior OF memory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memory
    PORT(
         CLK : IN  std_logic;
         Push : IN  std_logic;
         Pop : IN  std_logic;
         RST : IN  std_logic;
         NumberIN : IN  std_logic_vector(3 downto 0);
         NumberOUT : OUT  std_logic_vector(3 downto 0);
         Empty : OUT  std_logic;
         Full : OUT  std_logic;
         AlmostEmpty : OUT  std_logic;
         AlmostFull : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Push : std_logic := '0';
   signal Pop : std_logic := '0';
   signal RST : std_logic := '0';
   signal NumberIN : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal NumberOUT : std_logic_vector(3 downto 0);
   signal Empty : std_logic;
   signal Full : std_logic;
   signal AlmostEmpty : std_logic;
   signal AlmostFull : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
	 signal stop_the_clock: boolean;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memory PORT MAP (
          CLK => CLK,
          Push => Push,
          Pop => Pop,
          RST => RST,
          NumberIN => NumberIN,
          NumberOUT => NumberOUT,
          Empty => Empty,
          Full => Full,
          AlmostEmpty => AlmostEmpty,
          AlmostFull => AlmostFull
        );

   -- Clock process definitions
   clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after CLK_period / 2;
      wait for CLK_period;
    end loop;
    wait;
  end process;

   stim_proc: process
   begin		
   RST<='1';
	wait for CLK_period*10; --Hold Reset State for 10 periods
	RST<='0';
	NumberIN <= X"1";
	Push<='1';
	wait for CLK_period;
	Push<='0';
	wait for CLK_period*10;--10 periods do Nothing
	NumberIN <= X"2";
	Push<='1';
	wait for CLK_period;
	Push<='0';
	wait for CLK_period*10;--10 periods do Nothing
	NumberIN <= X"3";
	Push<='1';
	wait for CLK_period;
	Push<='0';
	wait for CLK_period*10;--10 periods do Nothing
	NumberIN <= X"4";
	Push<='1';	
	wait for CLK_period;
	Push<='0';
	wait for CLK_period*10;--10 periods do Nothing
	NumberIN <= X"5";
	Push<='1';	
	wait for CLK_period;
	Push<='0';
	wait for CLK_period*10;--10 periods do Nothing
	NumberIN <= X"6";
	Push<='1';	
	wait for CLK_period;
	Push<='0';
	wait for CLK_period*10;--10 periods do Nothing
	
	--Pop numbers out of stack
	Pop<='1';
	wait for CLK_period;
	Pop<='0';
	wait for CLK_period*10;
	Pop<='1';
	wait for CLK_period;
	Pop<='0';
	wait for CLK_period*10;
	stop_the_clock <= true;
	wait;
	end process;
	
END;
