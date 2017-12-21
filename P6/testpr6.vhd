--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:35:06 01/10/2014
-- Design Name:   
-- Module Name:   C:/hlocal/practica6/testpr6.vhd
-- Project Name:  practica6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: practica6
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testpr6 IS
END testpr6;
 
ARCHITECTURE behavior OF testpr6 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT practica6
    PORT(
         clk : IN  std_logic;
         read_enable : IN  std_logic;
         key : IN  std_logic_vector(4 downto 0);
         error : OUT  std_logic;
         data_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal read_enable : std_logic := '0';
   signal key : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal error : std_logic;
   signal data_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: practica6 PORT MAP (
          clk => clk,
          read_enable => read_enable,
          key => key,
          error => error,
          data_out => data_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
   
--   "10101",
--   "01010",
--   "11100",
--   "00111",
--   "00100",
--   "10001",
--   
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      

  
      
        read_enable <= '0';
      key <= "00000";
      wait for 100 ns;
      key <= "10101";
      wait for 100 ns;
      key <= "01010";
      wait for 100 ns;
      key <= "00011";
      wait for 100 ns;
      read_enable <= '1';
      wait for 100 ns;
      key <= "10101";
      wait for 100 ns;
      key <= "01010";
      wait for 100 ns;
      key <= "00000";
      wait for 100 ns;
      key <= "11100";
      wait for 100 ns;
      key <= "00001";
      wait for 100 ns;
      key <= "00111";
      wait for 100 ns;
      key <= "10000";

      wait;
   end process;

END;