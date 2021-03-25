
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.numeric_std.ALL;

entity check is
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
end check;

architecture Behavioral of check is
type state is (doNothing, pushStack, popStack);
signal stack_action:state;
signal tempAddress : STD_LOGIC_VECTOR(3 downto 0);
begin
	process
	begin
		wait until CLK' event and CLK='1';
		IF RST='1' then 
			stack_action<=doNothing;
			tempAddress<="0000";
			empty<='1';
			AlmostEmpty<='0';
			AlmostFull<='0';
			Full<='0';
			writ(0) <='0';
		else
			case stack_action is
				when doNothing=>
					writ(0) <= '0';
					If Push='1' and Pop='0' then
						if tempAddress=10 then 
							Full<='1';
							AlmostFull<='0';
							Empty<='0';
							AlmostEmpty<='0';
						elsif tempAddress<=2 then 
							tempAddress <=tempAddress+1;
							AlmostFull<='0';
							AlmostEmpty<='1';
							Empty<='0';
							Full<='0';
							stack_action<= pushStack;
						elsif tempAddress>=8 then
							tempAddress <=tempAddress+1;
							AlmostFull<='1';
							AlmostEmpty<='0';
							Empty<='0';
							Full<='0';
							stack_action<= pushStack;	
						else	
							tempAddress <=tempAddress+1;
							AlmostFull<='0';
							AlmostEmpty<='0';
							Empty<='0';
							Full<='0';
							stack_action<= pushStack;	
						end if;
					elsif Pop='1' and Push='0' then
						if tempAddress=0 then
							AlmostFull<='0';
							AlmostEmpty<='0';	
							Empty<='1';
							Full<='0';
						elsif tempAddress>=9 then
							AlmostFull<='1';
							AlmostEmpty<='0';	
							Empty<='0';
							Full<='0';
							stack_action<=popStack;
						elsif tempAddress<=3 then
							AlmostFull<='0';
							AlmostEmpty<='1';	
							Empty<='0';
							Full<='0';
							stack_action<=popStack;
						else
							AlmostFull<='0';
							AlmostEmpty<='0';	
							Empty<='0';
							Full<='0';
							stack_action<=popStack;
						end if;
					end If;
					
				when pushStack=>
					writ(0) <='1';
					stack_action<=doNothing;
				when popStack=>
					tempAddress<=tempAddress-1;
					writ(0) <='0';
					stack_action<=doNothing;
			end case;
		end IF;
	end process;
	Address<=tempAddress;
end Behavioral;

