----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:57:35 10/15/2013 
-- Design Name: 
-- Module Name:    teclado - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conversor is
port (a, x: in std_logic_vector(3 downto 0);
			       displayd : out std_logic_vector (6 downto 0);
					 displayi : out std_logic_vector (6 downto 0));
					 
end conversor;

architecture Behavioral of conversor is
--#displayd 7-segmentos 
--#
--#                S0
--#                ---
--#         S5  |       |s1
--#                 S6
--#                ---
--#         S4  |       |S2
--#
--#                ---
--#                S3


--#displayd 7-segmentos de la placa superior

--net displayd(0) loc=R10;
--net displayd(1) loc=P10;
--net displayd(2) loc=M11;
--NET displayd(3) loc=M6;
--NET displayd(4) loc=N6;
--NET displayd(5) loc=T7;
--NET displayd(6) loc=R7;
component multiplicador is
	port (a, x: in std_logic_vector(3 downto 0);
	p: out std_logic_vector(7 downto 0)); 
end component;

signal p : std_logic_vector (7 downto 0);
begin

var: multiplicador port map (a,x, p);


process (p)

begin
--p <= rout;
--rdesp: registro port map(PS2CLK, reset, PS2DATA, rout);
--numeros del 0 al 9

--1
if p = 1 or p = 11 or p = 21 or p = 31 or p = 41 or p = 51 or p = 61 or p = 71 or p = 81 or p = 91 then 
        displayd(0) <= '0';
        displayd(1) <= '1';
        displayd(2) <= '1';
        displayd(3) <= '0';
        displayd(4) <= '0';
        displayd(5) <= '0';
        displayd(6) <= '0';
        
--      2
elsif p = 2 or p = 12 or p = 22 or p = 32 or p = 42 or p = 52 or p = 62 or p = 72 or p = 82 or p = 92 then 

        displayd(0) <= '1';
        displayd(1) <= '1';
        displayd(6) <= '1';
        displayd(4) <= '1';
        displayd(3) <= '1';
        displayd(2) <= '0';
        displayd(5) <= '0';

--      3
elsif p = 3 or p = 13 or p = 23 or p = 33 or p = 43 or p = 53 or p = 63 or p = 73 or p = 83 or p = 93 then 
        displayd(0) <= '1';
        displayd(1) <= '1';
        displayd(6) <= '1';
        displayd(2) <= '1';
        displayd(3) <= '1';
        displayd(4) <= '0';
        displayd(5) <= '0';
--      4
elsif p = 4 or p = 14 or p = 24 or p = 34 or p = 44 or p = 54 or p = 64 or p = 74 or p = 84 or p = 94 then 
        displayd(0) <= '0';
        displayd(1) <= '1';
        displayd(2) <= '1';      
        displayd(3) <= '0';
        displayd(4) <= '0';              
        displayd(5) <= '1';
        displayd(6) <= '1';

--      5
elsif p = 5 or p = 15 or p = 25 or p = 35 or p = 45 or p = 55 or p = 65 or p = 75 or p = 85 or p = 95 then 
        displayd(0) <= '1';
        displayd(1) <= '0';
        displayd(2) <= '1';
        displayd(3) <= '1';
        displayd(4) <= '0';
        displayd(5) <= '1';
        displayd(6) <= '1';

--      6
elsif p = 6 or p = 16 or p = 26 or p = 36 or p = 46 or p = 56  or p = 66  or p = 76  or p = 86  or p = 96  then 
        displayd(0) <= '1';
        displayd(1) <= '0';
        displayd(2) <= '1';
        displayd(3) <= '1';
        displayd(4) <= '1';
        displayd(5) <= '1';
        displayd(6) <= '1';

--      7
elsif p = 7 or p = 17 or p = 27 or p = 37 or p = 47 or p = 57  or p = 67  or p = 77  or p = 87  or p = 97  then 
        displayd(0) <= '1';
        displayd(1) <= '1';
        displayd(2) <= '1';
        displayd(3) <= '0';
        displayd(4) <= '0';
        displayd(5) <= '0';
        displayd(6) <= '0';

--      8
elsif p = 8 or p = 18 or p = 28 or p = 38 or p = 48 or p = 58  or p = 68  or p = 78  or p = 88  or p = 98  then 
         displayd(0) <= '1';
        displayd(1) <= '1';
        displayd(2) <= '1';
        displayd(3) <= '1';
        displayd(4) <= '1';
        displayd(5) <= '1';
        displayd(6) <= '1';
--      9
elsif p = 9 or p = 19 or p = 29 or p = 39 or p = 49 or p = 59  or p = 69  or p = 79  or p = 89  or p = 99  then 
         displayd(0) <= '1';
        displayd(1) <= '1';
        displayd(2) <= '1';
        displayd(3) <= '1';
        displayd(4) <= '0';
        displayd(5) <= '1';
        displayd(6) <= '1';
--      0
elsif p = 0 or p = 10 or p = 20 or p = 30 or p = 40 or p = 50  or p = 60  or p = 70 or p = 80  or p = 90  then 
         displayd(0) <= '1';
        displayd(1) <= '1';
        displayd(2) <= '1';
        displayd(3) <= '1';
        displayd(4) <= '1';
        displayd(5) <= '1';
        displayd(6) <= '0';
end if;
--if p <"00001010" and p >= "00000000" then
if p = 0 or p = 1 or p = 2 or p = 3 or p = 4 or p = 5  or p = 6  or p = 7 or p = 8  or p = 9  then  
        displayi(0) <= '1';
        displayi(1) <= '1';
        displayi(2) <= '1';
        displayi(3) <= '1';
        displayi(4) <= '1';
        displayi(5) <= '1';
        displayi(6) <= '0';
--="0000";
		  
		  
		  
--1
--elsif p <"00010100" and p >= "00001011" then
elsif p = 10 or p = 11 or p = 12 or p = 13 or p = 14 or p = 15 or p = 16 or p = 17 or p = 18 or p = 19 then 
        displayi(0) <= '0';
        displayi(1) <= '1';
        displayi(2) <= '1';
        displayi(3) <= '0';
        displayi(4) <= '0';
        displayi(5) <= '0';
        displayi(6) <= '0';
        
--      2
elsif p = 20 or p = 21 or p = 22 or p = 23 or p = 24 or p = 25 or p = 26 or p = 27 or p = 28 or p = 29 then 

        displayi(0) <= '1';
        displayi(1) <= '1';
        displayi(6) <= '1';
        displayi(4) <= '1';
        displayi(3) <= '1';
        displayi(2) <= '0';
        displayi(5) <= '0';

--      3
elsif p = 30 or p = 31 or p = 32 or p = 33 or p = 34 or p = 35 or p = 36 or p = 37 or p = 38 or p = 39 then 
        displayi(0) <= '1';
        displayi(1) <= '1';
        displayi(6) <= '1';
        displayi(2) <= '1';
        displayi(3) <= '1';
        displayi(4) <= '0';
        displayi(5) <= '0';
--      4
elsif p = 40 or p = 41 or p = 42 or p = 43 or p = 44 or p = 45 or p = 46 or p = 47 or p = 48 or p = 49 then 
        displayi(0) <= '0';
        displayi(1) <= '1';
        displayi(2) <= '1';      
        displayi(3) <= '0';
        displayi(4) <= '0';              
        displayi(5) <= '1';
        displayi(6) <= '1';

--      5
elsif p = 50 or p = 51 or p = 52 or p = 53 or p =54 or p = 55 or p = 56 or p = 57 or p =58 or p = 59 then 
        displayi(0) <= '1';
        displayi(1) <= '0';
        displayi(2) <= '1';
        displayi(3) <= '1';
        displayi(4) <= '0';
        displayi(5) <= '1';
        displayi(6) <= '1';

--      6
elsif p = 60 or p = 61 or p = 62 or p = 63 or p = 64 or p = 65  or p = 66  or p = 67  or p = 68  or p = 69 then 
        displayi(0) <= '1';
        displayi(1) <= '0';
        displayi(2) <= '1';
        displayi(3) <= '1';
        displayi(4) <= '1';
        displayi(5) <= '1';
        displayi(6) <= '1';

--      7
elsif p = 70 or p = 71 or p = 72 or p = 73 or p = 74 or p = 75  or p = 76  or p = 77  or p = 78  or p = 79  then 
        displayi(0) <= '1';
        displayi(1) <= '1';
        displayi(2) <= '1';
        displayi(3) <= '0';
        displayi(4) <= '0';
        displayi(5) <= '0';
        displayi(6) <= '0';

--      8
elsif p = 80 or p = 81 or p = 82 or p = 83 or p = 84 or p = 85  or p = 86  or p = 87  or p = 88  or p = 89  then 
         displayi(0) <= '1';
        displayi(1) <= '1';
        displayi(2) <= '1';
        displayi(3) <= '1';
        displayi(4) <= '1';
        displayi(5) <= '1';
        displayi(6) <= '1';
--      9
elsif p = 90 or p = 91 or p = 92 or p = 39 or p = 94 or p = 95  or p = 96  or p = 97  or p = 98  or p = 99  then 
         displayi(0) <= '1';
        displayi(1) <= '1';
        displayi(2) <= '1';
        displayi(3) <= '1';
        displayi(4) <= '0';
        displayi(5) <= '1';
        displayi(6) <= '1';
end if;
end process;
end Behavioral;
