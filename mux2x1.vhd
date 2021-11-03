LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux2x1 IS
	PORT(
			I0, I1 			: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			S					: IN STD_LOGIC;
			Y					: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END mux2x1;

ARCHITECTURE FuncLogic OF mux2x1 IS
BEGIN
	WITH S SELECT Y <= 
		I0 WHEN '0',
		I1 WHEN OTHERS;
END FuncLogic;
		