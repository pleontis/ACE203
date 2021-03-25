LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MyMemory_tb IS
END MyMemory_tb;
 
ARCHITECTURE behavior OF MyMemory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MyMemory
    PORT(
         clka : IN  std_logic;
         wea : IN  std_logic_vector(0 downto 0);
         addra : IN  std_logic_vector(3 downto 0);
         dina : IN  std_logic_vector(3 downto 0);
         douta : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clka : std_logic := '0';
   signal wea : std_logic_vector(0 downto 0) := (others => '0');
   signal addra : std_logic_vector(3 downto 0) := (others => '0');
   signal dina : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal douta : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clka_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MyMemory PORT MAP (
          clka => clka,
          wea => wea,
          addra => addra,
          dina => dina,
          douta => douta
        );

   -- Clock process definitions
   clka_process :process
   begin
		clka <= '0';
		wait for clka_period/2;
		clka <= '1';
		wait for clka_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	   wait for 100 ns;	
		addra <= X"0";
		wea(0) <= '1';
		dina <= X"F";
		wait for clka_period;
		addra <= X"1";
		dina <= X"B";
		wait for clka_period;
		addra <= X"2";
		dina <= X"7";
		wait for clka_period;
		addra<=X"3";
		dina<=X"9";
		wait for clka_period;
	wait;
   end process;

END;
