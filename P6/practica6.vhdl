----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:40:07 01/10/2014 
-- Design Name: 
-- Module Name:    practica6 - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity practica6 is
   port( clk: in std_logic; 
         read_enable: in std_logic;
         key: in std_logic_vector(4 downto 0);
         error: out std_logic;
         data_out: out std_logic_vector(15 downto 0)
   ); 
end practica6;

architecture Behavioral of practica6 is

   signal keycomb: std_logic_vector(5 downto 0);
   signal addr: std_logic_vector(4 downto 0);

type ram_type is array (31 downto 0) of std_logic_vector (15 downto 0);
type array2 is array (31 downto 0) of std_logic_vector (4 downto 0);
    signal RAM : ram_type:=(X"001A",X"002B",X"003C",X"004D",X"005E",X"006F",
    X"0071",X"0082",X"0093",X"00AA",X"F104",X"F115",X"F12A",
	 X"F13A",X"F146",X"F157",X"F168",X"F179",X"F180",X"F19A",X"F1AA",X"F1BA",
    X"F1CA",X"F1DA",X"F1EA",X"F1FA",X"FAAA",X"FBBA",X"FCCA",X"FDDA",X"FEEA",X"FFFE");
    
    signal KEY_RAM: array2 := (
         "10001","10001",                                   --30-31
         "10001","10001","10001","10001","10001","10001",   --24-29
         "10001","10001","10001","10001","10001","10001",   --18-23
         "10001","10001","10001","10001","10001","10001",   --12-17
         "10001","10001","10001","10001","10001","10001",   --6 -11
         "10001","00100","00111","11100","01010","10101");  --0 - 5
begin

   --Utilizando with select 
   --VERSION 1
--   addr <= keycomb(4 downto 0);
--   error <= keycomb(5) and read_enable;
--   with key select 
--   keycomb <=  "000000" when "10101",
--            "000001" when "01010",
--            "000010" when "11100",
--            "000011" when "00111",
--            "000100" when "00100",
--            "000101" when "10001",
--            "100000" when others;

   --Utilizando el array de keys
   --VERSION 2
   
   combinacion: process(key)
      begin
         for i in 0 to 31 loop
            if key = KEY_RAM(i) then
               addr <= conv_std_logic_vector(i,5);
               error <= '0';
               exit;
            else error <= '1';
               
            end if;
         end loop;
   end process;
   
   
   
 --PROCESS DEL CLK PARA LEER LA RAM   
    puerto: process (clk)
    begin
      
        if rising_edge(clk) then
            if read_enable = '1' then
               data_out <= RAM(conv_integer(addr));
            else data_out <= (others=>'0');
            end if;
      
      end if;
    end process puerto;

   
end Behavioral;