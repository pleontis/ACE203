library IEEE;		--Libraries Declaration
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.ALL;
entity circuit is
    Port ( Clock : in STD_LOGIC; --Signal in and out declarations
           RST : in STD_LOGIC;
           Control : in STD_LOGIC_VECTOR (2 downto 0);	--bus Declaration
           Count : out STD_LOGIC_VECTOR (7 downto 0);		
           Overflow : out STD_LOGIC;
           Underflow : out STD_LOGIC;
           Valid : out STD_LOGIC);
end circuit;

architecture Behavioral of circuit is	--Architecture implementation

signal Qtemp: STD_LOGIC_VECTOR (7 downto 0); --internal signals decarations declarations 
signal Otemp,Utemp,Vtemp: STD_LOGIC;
BEGIN
	PROCESS	
	 BEGIN
    WAIT UNTIL Clock' EVENT AND Clock ='1';
    IF RST='1' then		--Initialize 
       Qtemp<="00000000";
		 Otemp<='0';
		 Utemp<='0';
		 Vtemp<='1';
    else
        iF Vtemp ='1' then
         If Control="000" then
				if Qtemp<5 then
					Qtemp<=Qtemp; 
					Otemp<='0';
					Utemp<='1';
					Vtemp<='0';
				else 
					Qtemp<=Qtemp-5;
				end if;	
			elsif Control="001" then
				if Qtemp<2 then
					Qtemp<=Qtemp; 
					Otemp<='0';
					Utemp<='1';
					Vtemp<='0';
				else 
					Qtemp<=Qtemp-2;
				end if;
			elsif Control="010" then 
				Qtemp<=Qtemp;  
			elsif Control="011" then
            if Qtemp>254 then
					Qtemp<=Qtemp; 
					Otemp<='1';
					Utemp<='0';
					Vtemp<='0';
				else
					Qtemp<=Qtemp+1;
				end if;
			elsif Control="100" then
            if Qtemp>253 then
					Qtemp<=Qtemp; 
					Otemp<='1';
					Utemp<='0';
					Vtemp<='0';
				else
					Qtemp<=Qtemp+2;
				end if;
        elsif Control="101" then
            if Qtemp>250 then
					Qtemp<=Qtemp; 
					Otemp<='1';
					Utemp<='0';
					Vtemp<='0';
				else
					Qtemp<=Qtemp+5;
				end if;
        elsif Control="110" then
            if Qtemp>249 then
					Qtemp<=Qtemp; 
					Otemp<='1';
					Utemp<='0';
					Vtemp<='0';
				else
					Qtemp<=Qtemp+6;
				end if;
        elsif Control="111" then 
            if Qtemp>243 then 
					Qtemp<=Qtemp; 
					Otemp<='1';
					Utemp<='0';
					Vtemp<='0';
				else
					Qtemp<=Qtemp+12;
		 		end if;			
		  end If; 
		 end iF;
		end IF;
	Count<=Qtemp;	--Put the temporary signals to the outputs
	Overflow<=Otemp;
	Underflow<=Utemp;
	Valid<=Vtemp;		
	end PROCESS;
	
end Behavioral;
