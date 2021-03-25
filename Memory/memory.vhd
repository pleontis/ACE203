library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memory is
    Port ( CLK : in  STD_LOGIC;
           Push : in  STD_LOGIC;
           Pop : in  STD_LOGIC;
           RST : in STD_LOGIC;
			  NumberIN : in  STD_LOGIC_VECTOR (3 downto 0);
           NumberOUT : out  STD_LOGIC_VECTOR (3 downto 0);
           Empty : out  STD_LOGIC;
           Full : out  STD_LOGIC;
           AlmostEmpty : out  STD_LOGIC;
           AlmostFull : out  STD_LOGIC);
end memory;

architecture Behavioral of memory is
	signal tempAddress: STD_LOGIC_VECTOR(3 downto 0);
	signal writeEnable: STD_LOGIC_VECTOR(0 downto 0);
	
	component check is port(
			  CLK : in  STD_LOGIC;
			  RST : in STD_LOGIC;	
           Push : in  STD_LOGIC;
           Pop : in  STD_LOGIC;
           Empty : out  STD_LOGIC;
           Full : out  STD_LOGIC;
           AlmostEmpty : out  STD_LOGIC;
           AlmostFull : out  STD_LOGIC;
			  Address : out STD_LOGIC_VECTOR(3 downto 0);
			  writ : out STD_LOGIC_VECTOR(0 downto 0)
	 );
	 end component;
	 
	 component MyMemory is port(
			clka : in STD_LOGIC;
			wea : in STD_LOGIC_VECTOR(0 downto 0);
			addra : in STD_LOGIC_VECTOR(3 downto 0);
			dina : in STD_LOGIC_VECTOR(3 downto 0);
			douta : out STD_LOGIC_VECTOR(3 downto 0)
);
end component;

attribute box_type : string; 
attribute box_type of MyMemory : component is "black_box";
		
begin
	fsm: check port map(
				CLK => CLK,
				RST => RST,
				Push => Push,
				Pop => Pop,
				Empty=> Empty, 
				Full=>Full,
				AlmostEmpty=>AlmostEmpty,
				AlmostFull=>AlmostFull,
				Address=>tempAddress,
				writ=>writeEnable
	);
	memory_stack : MyMemory port map
	(
		clka => CLK,
		wea => writeEnable,
		addra => tempAddress,
		dina => NumberIN,
		douta=> NumberOUT 
	);

end Behavioral;

