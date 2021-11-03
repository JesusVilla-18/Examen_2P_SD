LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY reg_File IS
	PORT(
			CLK, WE, RAE, RBE		:	IN		STD_LOGIC;
			WA, RAA, RBA			:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);	
			D							:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
			PORTA, PORTB			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END reg_File;

ARCHITECTURE Behav OF reg_File IS
SUBTYPE reg IS STD_LOGIC_VECTOR(7 DOWNTO 0);
TYPE regArray IS array(0 TO 3) OF reg;
SIGNAL RF	:	regArray;
BEGIN
	WRITE: PROCESS(CLK, WE, D)
			 BEGIN
				IF (CLK'event AND CLK='1' AND WE='1') THEN
					RF(CONV_INTEGER(WA)) <= D;
				END IF;
			 END PROCESS;
	READA: PROCESS(CLK, RAE, RAA)
			 BEGIN
				IF(CLK'event AND CLK='1') THEN
					IF RAE='1' THEN
						PORTA <= RF(CONV_INTEGER(RAA));
					ELSE 
						PORTA <= (OTHERS => '0');
					END IF;
				END IF;
			 END PROCESS;
	READB: PROCESS(CLK, RBE, RBA)
			  BEGIN
				IF(CLK'event AND CLK='1') THEN
					IF RBE='1' THEN
						PORTB <= RF(CONV_INTEGER(RBA));
					ELSE 
						PORTB <= (OTHERS => '0');
					END IF;
				END IF;
			  END PROCESS;
END Behav;