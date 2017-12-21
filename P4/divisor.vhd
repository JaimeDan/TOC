----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- Jesaguirre JaimeDan
-- Create Date:    16:24:09 11/29/2013 
-- Design Name: 
-- Module Name:    divisor - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.MATH_REAL.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity maquina_divisor is
generic (N: Integer:= 16; M: Integer:= 8);--N,M
port (
	divisor: in std_logic_vector(M-1 downto 0);
	dividendo: in std_logic_vector(N-1 downto 0);
	inicio, clk, reset: in std_logic;
	ready: out std_logic;
	cociente: out std_logic_vector(N-1 downto 0)); 
end maquina_divisor;

architecture Behavioral of maquina_divisor is
--ESTADOS
type estados is (estado_inicial, estado1, estado2, espera1, izquierda, derecha, fin);
signal estado_act, estado_sig: estados;
signal rdndo, rdsor, auxrdndo, auxrdsor: std_logic_vector(N downto 0);--, rc, rk 
signal rk, auxrk: std_logic_vector(integer(CEIL(LOG2(real(N-M))))-1 downto 0);
signal rc, auxrc: std_logic_vector(N-1 downto 0);
begin
	process(clk)
		begin	
		if reset='1' then
			estado_act<=estado_inicial;
			rdndo <= (others => '0');
			rdsor <= (others => '0');
			rc <= (others => '0');
			rk <= (others => '0');
		elsif clk'event and clk='1' then
			estado_act<=estado_sig;
			rdndo <= auxrdndo;
			rdsor <= auxrdsor;
			rk <= auxrk;
			rc <= auxrc;
		end if;
	end process;

division: process (inicio, rdndo, rc, rk, rdsor, estado_act)
begin
case estado_act is

	when estado_inicial =>
		ready <= '1';
		auxrdndo <= rdndo;
		auxrdsor <= rdsor;
		auxrk <= rk;
		auxrc <= rc;
		if inicio = '0' then estado_sig <= estado_inicial;
		else estado_sig <= estado1;
		
		end if;
	when estado1 =>
		auxrdndo <= '0' & dividendo;
		auxrdsor <= '0' & divisor & (conv_std_logic_vector(0,N-M));
		auxrc <= (others => '0');
		auxrk <= (others => '0');
		ready <= '0';
		estado_sig <= estado2;

	when estado2 =>
		auxrdndo <= rdndo - rdsor;
		
		auxrdsor <= rdsor;
		auxrk <= rk;
		auxrc <= rc;
		estado_sig <= espera1;
		ready <= '0';

	when espera1 =>
		estado_sig <= espera1;
		auxrdndo <= rdndo;
		auxrdsor <= rdsor;
		auxrk <= rk +1;
		auxrc <= rc;
		if rdndo(N) = '1' then 
			estado_sig <= izquierda;
		else estado_sig <= derecha;
		end if;
		ready <= '0';
		
	when izquierda =>
		auxrc <= rc(n-2 downto 0) & '0';
		auxrdndo <= rdndo + rdsor;
		auxrk <= rk;
		auxrdsor <= rdsor;

		estado_sig <= fin;
		ready <= '0';
	
	when derecha =>
		auxrc <= rc(n-2 downto 0) & '1';
		auxrk <= rk;			
		auxrdndo <= rdndo;
		auxrdsor <= rdsor;

		
		estado_sig <= fin;
		ready <= '0';
		
	when fin =>
		auxrdsor <= '0' & rdsor(N downto 1);

		
		auxrdndo <= rdndo;
		auxrc <= rc;
		auxrk <= rk;
		
	if rk <= N-M then estado_sig <= estado2;
		else estado_sig <= estado_inicial;
	END IF;
		ready <= '0';
		
	end case;
		
end process;
	cociente <= rc;
end Behavioral;