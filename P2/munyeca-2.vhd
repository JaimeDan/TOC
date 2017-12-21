----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- Jesús Aguirre Pemán, Jaime Dan Porras Rhee
-- Create Date:    12:09:20 10/15/2013 
-- Design Name: 
-- Module Name:    munyeca - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity munyeca is
	port (reloj, rst, R, C: in std_logic; G, L: out std_logic);
end munyeca;

architecture Behavioral of munyeca is

component contador is
	port(clk, reset, as: in std_logic; cuenta: out std_logic_vector(3 downto 0));
end component;

type ESTADOS is (dormida, asustada, tranquila, habla);
signal ESTADO, SIG_ESTADO: ESTADOS;
--signal suma : std_logic;
signal reset_cont : std_logic;
signal cuenta: std_logic_vector(3 downto 0);

begin
	cont: contador port map(reloj, reset_cont, '1', cuenta);
	
SINCRONO: process(reloj,rst)
begin
		if rst ='1' then
			ESTADO<= tranquila;
			
		elsif reloj'event and reloj='1' then
			ESTADO<= SIG_ESTADO;
		end if;
end process;

COMBINACIONAL: process(ESTADO, C, R, cuenta)
begin

		case ESTADO is
		when tranquila =>
		reset_cont <= '1';
			G<='0';
			L<='0';
			if (C= '0' and R = '1') then
				SIG_ESTADO <= habla;
			elsif (C= '1' and R='0') then
				SIG_ESTADO <= dormida;
			else  SIG_ESTADO <= tranquila;
			end if;
			
		when habla =>
			reset_cont <= '1';
			L <='0';
			G <= '1';
			if (C='1') then 
				SIG_ESTADO <= dormida;
				
			else SIG_ESTADO <= habla;
			end if;
			
		when dormida =>
				reset_cont <= '0';

				G<='0';
				L<='0';
				if (R='1') then 
					SIG_ESTADO <= asustada;
					
				elsif (cuenta = "0100") then --al empezar en 0, contaremos hasta 4
					SIG_ESTADO <= tranquila;
											
				else	
							SIG_ESTADO <= dormida;
				end if;
			
		when asustada => --(asustada)
			reset_cont <= '1';
			G<='0';
			L <= '1';
			if (C='1' and R='0') then
				SIG_ESTADO <= dormida;
			elsif (C='0' and R='0') then 
				SIG_ESTADO <= tranquila;
			else SIG_ESTADO <= asustada;
			
			end if;
		end case;

end process COMBINACIONAL;

end Behavioral;

