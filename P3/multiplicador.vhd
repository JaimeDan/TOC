----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- Jesús Aguirre Pemán y Jaime Dan Porras
-- Create Date:    17:57:50 11/08/2013 
-- Design Name: 
-- Module Name:    multiplicador - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplicador is
	generic (N: integer := 4);
	port (a, x: in std_logic_vector(N-1 downto 0);
	p: out std_logic_vector((2*N)-1 downto 0)); 
end multiplicador;



architecture Behavioral of multiplicador is
shared variable bcd2  : std_logic_vector(11 downto 0) := (others => '0');
shared variable i : integer:=0;
type matriz is array (0 to N-1) of std_logic_vector(2*N-1 downto 0); 

signal bcd : std_logic_vector((2*N)-1 downto 0);
signal suma, acarreo, mult : matriz;

component celda is
	port (suma_i, acarreo_i, mult: in std_logic;
			acarreo_o, suma_o: out std_logic);
end component; 

begin

Filas: for i in 0 to N-2 generate
	Columnas: for j in 0 to 2*N-2 generate
		celdaNormal: celda port map(suma(i)(j), acarreo(i)(j), mult(i)(j), 
			acarreo(i+1)(j+1), suma(i+1)(j));
	end generate Columnas;--columnas
end generate Filas;--filas

UltimaFila: for j in 0 to (2*N) - 2 generate
	celdaNormal: celda  port map(suma(N-1)(j), acarreo(N-1)(j), mult(N-1)(j), mult(N-1)(j+1), p(j));
p(2*N-1) <= mult(N-1)(2*N-1);
end generate;
--SUMA
	gensum: for j in 0 to 2*N - 1 generate--N-2
			cerosuma1: if j>=N generate	
			suma(0)(j)<='0';
			end generate cerosuma1;
			cerosuma2: if j<N generate
				suma(0)(j)<=a(j) and x(0);
			end generate cerosuma2;
	end generate gensum;


--ACARREO

	generate1: for j in 0 to 2*N-1 generate --posible generate
		acarreo(0)(j) <='0';
	end generate generate1;
	generate2: for j in 1 to N-1 generate
		acarreo(j)(0) <='0';
	end generate generate2;

--MULT
	gen1: for j in 0 to 2*N-1 generate
		gen2: for i in 0 to N-2 generate
			multip: if j>i and j<=i+N and i< N-1 generate 
				mult(i)(j) <= x(i+1) and a(j-i-1);
				end generate multip;
			zeros: if j <= i or j > i + N  generate 
			mult(i)(j) <= '0'; --las celdas no se utilizan
			end generate zeros;
		end generate gen2;
	end generate gen1;

	mult(N-1)(0) <='0';



--
--hola:process(a, x):
--	for i in 0 to 7 loop  
--	bcd2(11 downto 1) := bcd2(10 downto 0); 
--	bcd2(0) := bint(7);
--	p(7 downto 1) := p(6 downto 0);
--	p(0) :='0';
--
--if(i < 7 and bcd(3 downto 0) > "0100") then 
--	bcd2(3 downto 0) := bcd2(3 downto 0) + "0011";
--end if;
--
--if(i < 7 and bcd(7 downto 4) > "0100") then 
--	bcd2(7 downto 4) := bcd2(7 downto 4) + "0011";
--end if;
--
--if(i < 7 and bcd(11 downto 8) > "0100") then  
--	bcd2(11 downto 8) := bcd2(11 downto 8) + "0011";
--end if;
--
--end loop;
--return bcd;
--end to_bcd;
--end bcd;
--end process;
--			
	
	end Behavioral;