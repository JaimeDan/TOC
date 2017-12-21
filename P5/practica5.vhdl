----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:21:03 12/13/2013 
-- Design Name: 
-- Module Name:    practica5 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity practica5 is
generic (n: Integer:= 32);

	port (	rst: in std_logic;
				clk: in std_logic;
				inicio: in std_logic;
				fin: out std_logic;
				direccion: in std_logic_vector(4 downto 0);
				dato_debug: out std_logic_vector(3 downto 0)
			);
			
	
end practica5;

architecture Behavioral of practica5 is
component rams_2p is
    port (clk : in std_logic;
          we : in std_logic;
          addr1 : in std_logic_vector(4 downto 0);
          addr2 : in std_logic_vector(4 downto 0);
          di : in std_logic_vector(3 downto 0);
          do1 : out std_logic_vector(3 downto 0);
          do2 : out std_logic_vector(3 downto 0)
	);
end component;
--ESTADOS

type estados is (inicial, inij, comp2, cond, intercambio, aumj, aumi, final, ultimo, escribej, espera, esperai);
signal estado_act, estado_sig: estados;
signal dirj, dirj2: std_logic_vector(4 downto 0);
signal i, j: std_logic_vector(4 downto 0);
signal we, ireset, jreset, ienable, jenable: std_logic;
signal di, dinaux: std_logic_vector(3 downto 0);
signal do1, do2, dato1, dato2, dato1aux, dato2aux: std_logic_vector(3 downto 0);

begin
	--dirj <= j;
	with estado_act select 
		dirj <= direccion when final,
					direccion when ultimo,
					j when others;
	dirj2 <= j+"00001";
	
	conecta : rams_2p  port map (
			 clk => clk,
          we => we,
          addr1 => dirj,
          addr2 => dirj2,
          di => di,
          do1 =>do1,
          do2 => do2
        );
		  
	contadori : process(i, ireset, ienable, clk, rst)
	begin 
	if rst = '1' or ireset = '1' then 
		i <= "00000";
		else 
			if rising_edge(clk) and ienable = '1' then 
				i <= conv_std_logic_vector(unsigned(i) + 1, 5);
			end if;
		end if;
	end process;
	
	contadorj : process(j, jreset, jenable, clk, rst)
	begin 
	if rst = '1' or jreset = '1' then 
		j <= "00000";
		else 
			if rising_edge(clk) and jenable = '1' then 
				j <= conv_std_logic_vector(unsigned(j) + 1, 5);
			end if;
		end if;
	end process;
	

process(clk, rst)
		begin
		if rst='1' then
			estado_act<=inicial;
			--i <= (others => '0');
			--j  <= (others => '0');
			dato1 <= (others => '0');
			dato2 <= (others => '0');
			di  <= (others => '0');
			--dato1<= (others => '0');
			--dato2 <= (others => '0');
		elsif clk'event and clk='1' then
			estado_act<=estado_sig;
			dato1 <= dato1aux;
			dato2 <= dato2aux;
			--i <= auxi;
			--j <= auxj;
			di <= dinaux;
		end if;
	end process;

burbuja: process(dato1, dato2, di, inicio, do1, do2, dirj, 	estado_act, i, j)
begin

	fin <= '0';
	we <= '0';
	dato1aux <= dato1;
	dato2aux <= dato2;
	dato_debug <= (others => '0');
	dinaux <= di;
	jreset <= '0';
	ireset <= '0';
	ienable <= '0';
	jenable <= '0';
	
case estado_act is
	
	

	when inicial =>
		ireset <= '1';
		fin <= '0';
		estado_sig <= inij;
		
	when inij =>
		ienable <= '0';
		ireset <= '0';
		jreset <= '1';
		--estado_sig <= comp2;
		estado_sig <= espera;
	when espera =>
		we <= '0';
		estado_sig <= comp2;
	
	when comp2 =>
		jreset <= '0';	
		jenable <= '0';
		
		dato1aux <= do1;
		dato2aux <= do2;
		if conv_integer(UNSIGNED(j)) <= n - 2 then 
			estado_sig <= cond;
		else estado_sig <= aumi;
		end if;
			
	when cond =>
		dinaux <= dato2;
		if dato1 <= dato2 then --Mem(j) <= Mem(j+1)
			estado_sig <= intercambio;
			else estado_sig <= aumj;
		end if;

	when intercambio =>
		dinaux <= dato1;
		we <= '1';		
		jenable <='1';
		estado_sig <= escribej;
	
	when escribej =>
		jenable <= '0';
		we <= '1';
		estado_sig <= espera;
	
	when aumj =>
		jenable <= '1';
		estado_sig <= espera;
	
	when aumi =>
		ienable <= '1';
		estado_sig <= esperai;
		
	when esperai =>
		ienable <= '0';
--		estado_sig <= comp1;
		if conv_integer(UNSIGNED(i)) = 0 then
			estado_sig <= ultimo;
		else estado_sig <= inij;
		end if;
		
	when ultimo =>
		estado_sig <= final;
	when final =>
		ienable <= '0';

		fin <= '1';
		if inicio = '1' then
			estado_sig <= inicial;
		else estado_sig <= final;
		end if;

	end case;
	
	case estado_act is
		when final	=> dato_debug <= do1;
		when others => dato_debug <= (others => '0');		
		end case;
end process;

end Behavioral;