LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE circuits_package IS

COMPONENT mux2x1
	PORT(
			I0, I1 			: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			S					: IN STD_LOGIC;
			Y					: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END COMPONENT;

COMPONENT reg_File
	PORT(
			CLK, WE, RAE, RBE		:	IN		STD_LOGIC;
			WA, RAA, RBA			:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);	
			D							:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
			PORTA, PORTB			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END COMPONENT;

COMPONENT ordenador
	PORT(
			Pass, CLK, Resetn, Enable	:	IN			STD_LOGIC; 
			EA, EB							:	IN			STD_LOGIC_VECTOR(7 DOWNTO 0);
			SA, SB							:	BUFFER	STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END COMPONENT;
END circuits_package;