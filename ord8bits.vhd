LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.circuits_package.all;

ENTITY ord8bits IS
	PORT(
			CLK, Start				:	IN			STD_LOGIC;
			Data						:	IN			STD_LOGIC_VECTOR(7 DOWNTO 0);
			Output					:	BUFFER	STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END ord8bits;

ARCHITECTURE Behav OF ord8bits IS
SIGNAL PA, PB, Mux1, Mux2, OA, OB						:	STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL WE, RAE, RBE, OPass, OE, EOutput, S0, S1		:	STD_LOGIC;
SIGNAL WA, RAA, RBA											:	STD_LOGIC_VECTOR(1 DOWNTO 0);
TYPE State_Type IS (E0, E1, E2, E3, EI, E4, EI2, E5, E6, E7, E8, E9, E10, EF);
SIGNAL y_present, y_next : State_Type;
BEGIN
	mux8_1:  mux2x1 		PORT MAP (Mux2, Data, S0, Mux1);
	regfile: reg_File 	PORT MAP (CLK, WE, RAE, RBE, WA, RAA, RBA, Mux1, PA, PB);
	orden:	ordenador	PORT MAP (OPass, CLK, '1', OE, PA, PB, OA, OB);	
	mux8_2:  mux2x1 		PORT MAP (OB, OA, S1, Mux2);

	
	PROCESS (y_present, Start)
	BEGIN
		CASE y_present IS
			WHEN E0 =>
				IF Start='0' THEN 
					y_next <= E0;
				ELSE 
					y_next <= E1;
				END IF;
			WHEN E1 =>
				y_next <= E2;
			WHEN E2 =>
				y_next <= E3;
			WHEN E3 =>
				y_next <= EI;
			WHEN EI =>
				y_next <= E4;
			WHEN E4 =>
				y_next <= EI2;
			WHEN EI2 =>
				y_next <= E5;
			WHEN E5 =>
				y_next <= E6;
			WHEN E6 =>
				y_next <= E7;
			WHEN E7 =>
				y_next <= E8;
			WHEN E8 =>
				y_next <= E9;
			WHEN E9 =>
				y_next <= E10;
			WHEN E10 =>
				y_next <= EF;
			WHEN EF =>
				y_next <= E0;
		END CASE;
	END PROCESS;
	
	PROCESS (CLK, y_present)
	BEGIN
		IF (CLK'Event AND CLK='1') THEN
			y_present <= y_next;
		ELSE
			y_present <= y_present;
		END IF;
	END PROCESS;
	
	PROCESS (y_present)
	BEGIN
		CASE y_present IS
			WHEN E0 =>
				S0 <= '1';
				S1 <= '1';
				OPass <= '0';
				OE <= '0';
				WE <= '0';
				WA <= "00";
				RAE <= '0';
				RBE <= '0';
				RAA <= "00";
				RBA <= "00";
				EOutput <= '0';
			WHEN E1 =>
				S0 <= '1';
				S1 <= '1';
				OPass <= '0';
				OE <= '0';
				WE <= '1';
				WA <= "00";
				RAE <= '0';
				RBE <= '0';
				RAA <= "00";
				RBA <= "00";
				EOutput <= '0';
			WHEN E2 =>
				S0 <= '1';
				S1 <= '1';
				OPass <= '0';
				OE <= '0';
				WE <= '1';
				WA <= "01";
				RAE <= '0';
				RBE <= '0';
				RAA <= "00";
				RBA <= "00";
				EOutput <= '0';
			WHEN E3 =>
				S0 <= '1';
				S1 <= '1';
				OPass <= '0';
				OE <= '0';
				WE <= '1';
				WA <= "10";
				RAE <= '1';
				RBE <= '1';
				RAA <= "00";
				RBA <= "01";
				EOutput <= '0';
			WHEN EI =>
				S0 <= '1';
				S1 <= '1';
				OPass <= '0';
				OE <= '1';
				WE <= '0';
				WA <= "00";
				RAE <= '1';
				RBE <= '0';
				RAA <= "10";
				RBA <= "00";
				EOutput <= '0';
			WHEN E4 =>
				S0 <= '1';
				S1 <= '1';
				OPass <= '0';
				OE <= '1';
				WE <= '0';
				WA <= "00";
				RAE <= '0';
				RBE <= '0';
				RAA <= "00";
				RBA <= "00";
				EOutput <= '0';
			WHEN EI2 =>
				S0 <= '1';
				S1 <= '1';
				OPass <= '0';
				OE <= '1';
				WE <= '0';
				WA <= "00";
				RAE <= '0';
				RBE <= '0';
				RAA <= "00";
				RBA <= "00";
				EOutput <= '0';
			WHEN E5 =>
				S0 <= '0';
				S1 <= '1';
				OPass <= '0';
				OE <= '1';
				WE <= '1';
				WA <= "00";
				RAE <= '0';
				RBE <= '0';
				RAA <= "00";
				RBA <= "00";
				EOutput <= '0';
			WHEN E6 =>
				S0 <= '0';
				S1 <= '1';
				OE <= '1';
				OPass <= '0';
				WE <= '1';
				WA <= "01";
				RAE <= '0';
				RBE <= '0';
				RAA <= "00";
				RBA <= "00";
				EOutput <= '0';
			WHEN E7 =>
				S0 <= '0';
				S1 <= '1';
				OE <= '1';
				OPass <= '0';
				WE <= '1';
				WA <= "10";
				RAE <= '1';
				RBE <= '0';
				RAA <= "00";
				RBA <= "00";
				EOutput <= '0';
			WHEN E8 =>
				S0 <= '0';
				S1 <= '0';
				OE <= '1';
				OPass <= '1';
				WE <= '0';
				WA <= "00";
				RAE <= '1';
				RBE <= '0';
				RAA <= "01";
				RBA <= "00";
				EOutput <= '0';
			WHEN E9 =>
				S0 <= '0';
				S1 <= '0';
				OE <= '1';
				OPass <= '1';
				WE <= '0';
				WA <= "00";
				RAE <= '1';
				RBE <= '0';
				RAA <= "10";
				RBA <= "00";
				EOutput <= '1';
			WHEN E10 =>
				S0 <= '0';
				S1 <= '0';
				OE <= '1';
				OPass <= '1';
				WE <= '0';
				WA <= "00";
				RAE <= '0';
				RBE <= '0';
				RAA <= "00";
				RBA <= "00";
				EOutput <= '1';
			WHEN EF =>
				S0 <= '0';
				S1 <= '0';
				OE <= '1';
				OPass <= '1';
				WE <= '0';
				WA <= "00";
				RAE <= '0';
				RBE <= '0';
				RAA <= "00";
				RBA <= "00";
				EOutput <= '1';
		END CASE;
	END PROCESS;
	
	PROCESS (EOutput, CLK)
	BEGIN
		IF EOutput = '0' THEN
			Output <= (OTHERS => '0');
		ELSE 
			Output <= Mux2;
		END IF;
	END PROCESS;
END Behav;