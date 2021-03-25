LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY fsm_tb IS
END fsm_tb;
 
ARCHITECTURE behavior OF fsm_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fsm
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         A : IN  std_logic;
         B : IN  std_logic;
         Control : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal CLK : std_logic;
   signal RST : std_logic;
   signal A : std_logic;
   signal B : std_logic;

 	--Outputs
   signal Control : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
	signal stop_the_clock: boolean;
	
	BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fsm PORT MAP (
          CLK => CLK,
          RST => RST,
          A => A,
          B => B,
          Control => Control);



   -- Stimulus process
   stimulus: process
   begin		
      -- hold reset state for 100 ns. (10 cycles)
		RST<='0';	
      wait for 100 ns;	--Go through all stages following anticlockwise order
		RST<='1';				
		A<='0';
		B<='1';
      wait for 30 ns;
		A<='1';				
		B<='1';	
		wait for 10 ns;	--Check that it remains at the same state 
		A<='0';
		B<='1';
      wait for 20 ns;	--Current state is 0 and went through all states. 
		A<='1';				
 		B<='0';
		wait for 50 ns;   --Going through all states clockwise
								--Current state is 0 and went throught all states
		A<='1'; 				
 		B<='0';
		wait for 20 ns;	--Going to state 2
		RST <='0';
		wait for 10 ns;   --Checking reset works for a random stage
		  
		stop_the_clock<=true;
		wait;
   end process;
	 -- Clock process definitions
   CLK_process :process
    begin
    while not stop_the_clock loop
      CLK <= '0', '1' after CLK_period/ 2;
      wait for CLK_period;
    end loop;
    wait;
	end process;

END;
