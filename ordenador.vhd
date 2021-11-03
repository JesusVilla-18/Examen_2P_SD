LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ordenador IS
	PORT(
			Pass, CLK, Resetn, Enable	:	IN			STD_LOGIC; 
			EA, EB							:	IN			STD_LOGIC_VECTOR(7 DOWNTO 0);
			SA, SB							:	BUFFER	STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END ordenador;

ARCHITECTURE Behav OF ordenador IS
SIGNAL menorAbs, menorRel, mayor	: STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
SIGNAL cont, cont2					: STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
BEGIN
	PROCESS (CLK, Pass, EA, EB, Resetn, Enable, menorAbs, menorRel, mayor)
	BEGIN
		IF (Resetn='0') THEN
			cont <= "00";
			menorAbs <= (OTHERS => '0');
			menorRel <= (OTHERS => '0');
			mayor <= (OTHERS => '0');
		ELSIF (CLK'EVENT AND CLK='1' AND Enable='1') THEN 
			IF Pass='0' THEN
				IF (cont = "00") THEN
					cont <= "01";
					IF(EA<EB) THEN
						menorRel <= EA;
						mayor <= EB;
					ELSE
						menorRel <= EB;
						mayor <= EA;
					END IF;
				ELSIF (cont = "01") THEN
					cont <= "11";
					IF (EA<menorRel) THEN
						menorAbs <= EA;
					ELSE 
						menorAbs <= menorRel;
						IF (EA<mayor) THEN
							menorRel <= EA;
						ELSE
							menorRel <= mayor;
							mayor <= EA;
						END IF;
					END IF;
				END IF;
			END IF;
		ELSE
			menorAbs <= menorAbs;
			menorRel <= menorRel;
			mayor <= mayor;
		END IF;
	END PROCESS;
	
	PROCESS (cont, CLK, Resetn, Enable)
	BEGIN
		IF (Resetn = '0') THEN
			cont2 <= "00";
			SA <= (OTHERS => '0');
			SB <= (OTHERS => '0');
		ELSIF (CLK'EVENT AND CLK='1' AND Enable='1') THEN
			IF cont="11" THEN
				CASE cont2 IS
				WHEN "00" => 
					cont2 <= "01";
					SA <= menorAbs;
					SB <= (OTHERS => '0');
				WHEN "01" =>
					cont2 <= "10";
					SA <= menorRel;
					SB <= (OTHERS => '0');
				WHEN "10" =>
					cont2 <= "11";
					SA <= mayor;
					SB <= (OTHERS => '0');
				WHEN OTHERS =>
					SA <= (OTHERS => '0');
					SB <= (OTHERS => '0');
				END CASE;
			ELSE
				SA <= (OTHERS => '0');
			END IF;
			IF (Pass='1')THEN
				SB <= EA;
			END IF;
		END IF;
	END PROCESS;
END Behav;