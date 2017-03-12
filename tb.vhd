--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:17:04 05/13/2014
-- Design Name:   
-- Module Name:   C:/Users/spm5065/Desktop/SRAM/tb.vhd
-- Project Name:  SRAM
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: WrapperforOne
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
 
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WrapperforOne
    PORT(
         Clk : IN  std_logic;
         Address : IN  std_logic_vector(2 downto 0);
         WriteData : IN  std_logic_vector(3 downto 0);
         BUS_ID : IN  std_logic;
         Reset : IN  std_logic;
         RW : IN  std_logic;
         Ready : IN  std_logic;
         Burst : IN  std_logic;
         TestReadData : OUT  std_logic_vector(3 downto 0);
         CA : OUT  std_logic;
         CB : OUT  std_logic;
         CC : OUT  std_logic;
         CD : OUT  std_logic;
         CE : OUT  std_logic;
         CF : OUT  std_logic;
         CG : OUT  std_logic;
         AN0 : OUT  std_logic;
         AN1 : OUT  std_logic;
         AN2 : OUT  std_logic;
         AN3 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Address : std_logic_vector(2 downto 0) := (others => '0');
   signal WriteData : std_logic_vector(3 downto 0) := (others => '0');
   signal BUS_ID : std_logic := '0';
   signal Reset : std_logic := '0';
   signal RW : std_logic := '0';
   signal Ready : std_logic := '0';
   signal Burst : std_logic := '0';

 	--Outputs
   signal TestReadData : std_logic_vector(3 downto 0);
   signal CA : std_logic;
   signal CB : std_logic;
   signal CC : std_logic;
   signal CD : std_logic;
   signal CE : std_logic;
   signal CF : std_logic;
   signal CG : std_logic;
   signal AN0 : std_logic;
   signal AN1 : std_logic;
   signal AN2 : std_logic;
   signal AN3 : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WrapperforOne PORT MAP (
          Clk => Clk,
          Address => Address,
          WriteData => WriteData,
          BUS_ID => BUS_ID,
          Reset => Reset,
          RW => RW,
          Ready => Ready,
          Burst => Burst,
          TestReadData => TestReadData,
          CA => CA,
          CB => CB,
          CC => CC,
          CD => CD,
          CE => CE,
          CF => CF,
          CG => CG,
          AN0 => AN0,
          AN1 => AN1,
          AN2 => AN2,
          AN3 => AN3
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Reset <= '1';
		Address<= "000";
		RW<='1';
		wait for 11 ns;
		Reset <= '0';		
		wait for 11 ns;
		Ready <= '1';
		BUS_ID <= '0';
		WriteData <= "0000";
		Reset<='0';
		Burst <= '0';
		wait for Clk_period*2;
		Ready <= '0';
		wait for Clk_period*10;
		RW <= '0';
		WriteData <= "1110";
		Reset <= '1';
		wait for 10 ns;
		Reset <= '0';
		wait for 13 ns;
		Ready<='1';
		wait for Clk_period*8;
		Ready <= '0';
		RW <= '1';
		
		wait for Clk_period*2;
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
		Burst <= '1';
		Ready <= '1';
		wait for Clk_period*10;
		Ready <= '0';
		wait for Clk_period*10;
      -- insert stimulus here 

      wait;
   end process;

END;
