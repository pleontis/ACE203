library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Control : out  STD_LOGIC_VECTOR (2 downto 0));
end fsm;

architecture Behavioral of fsm is
	type state is (S0,S1,S2,S3,S4);
	signal FSM_STATE: state;
	signal CTEMP :STD_LOGIC_VECTOR(2 DOWNTO 0);
begin
	PROCESS
	BEGIN
		WAIT UNTIL CLK' EVENT AND CLK='1';
		if RST='0' then --Reset is enabled when the signal RST is 0 
			FSM_STATE<=S0;
			CTEMP<="000";
		else 
			case FSM_state IS
				WHEN S0=>
					IF (A='1' AND B ='0') THEN
						FSM_STATE<=S1;
						CTEMP<="001";
					ELSIF (A='0' AND B ='1') THEN
						FSM_STATE<=S4;
						CTEMP<="100";
					ELSE
						FSM_STATE<=S0;
						CTEMP<="000";
					END IF;	
				WHEN S1=>
					IF (A='1' AND B ='0') THEN
						FSM_STATE<=S2;
						CTEMP<="010";
					ELSIF (A='0' AND B ='1') THEN
						FSM_STATE<=S0;
						CTEMP<="000";
					ELSE
						FSM_STATE<=S1;
						CTEMP<="001";
					END IF;		
				WHEN S2=>
					IF (A='1' AND B ='0') THEN
						FSM_STATE<=S3;
						CTEMP<="011";
					ELSIF (A='0' AND B ='1') THEN
						FSM_STATE<=S1;
						CTEMP<="001";
					ELSE
						FSM_STATE<=S2;
						CTEMP<="010";	
					END IF;		
				WHEN S3=>
					IF (A='1' AND B ='0') THEN
						FSM_STATE<=S4;
						CTEMP<="100";
					ELSIF (A='0' AND B ='1') THEN
						FSM_STATE<=S2;
						CTEMP<="010";
					ELSE
						FSM_STATE<=S3;
						CTEMP<="011";
					END IF;			
				WHEN S4=>
					IF (A='1' AND B ='0') THEN
						FSM_STATE<=S0;
						CTEMP<="000";
					ELSIF (A='0' AND B ='1') THEN
						FSM_STATE<=S3;
						CTEMP<="011";
					ELSE
						FSM_STATE<=S4;
						CTEMP<="100";
					END IF;				
			END CASE;	
		END IF;
		END PROCESS;
		Control <=CTEMP;
end Behavioral;

