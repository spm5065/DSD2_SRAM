----------------------------------------------------------------------------------
-- Company: RIT
-- Engineer: Prof. Cliver
-- 
-- Create Date: Summer Time
-- Design Name: vending_machine
-- Module Name: seven_seg_disp - Behavioral 
-- Project Name: 561_vend_mach
-- Target Devices: Spartan 3E FPGA
-- Tool versions: 8.2
-- Description: Accepts two 7 bit seven_segment_display codes and displays
--   them on the Digilent BASYS board. The board has 4 displays with the following
--   specs: common anode, shared cathodes that must be multiplexed.
--
-- Dependencies: 
--
-- Revision: 1
-- Revision 0.01 - File Created
-- Additional Comments: Feel free to change any names or code.
--	Refer to the Digilent manual for more details.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARItH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity seven_seg_disp is
    Port ( hund_disp_n  : in  STD_LOGIC_VECTOR (6 downto 0);
	        tens_disp_n  : in  STD_LOGIC_VECTOR (6 downto 0);
           ones_disp_n  : in  STD_LOGIC_VECTOR (6 downto 0);
			  thou_disp_n	: in	STD_LOGIC_VECTOR (6 downto 0);
	        clk          : in  STD_LOGIC; -- digilent board generated clock
			  reset_n      : in  STD_LOGIC; -- switch input
			  unused_anode : out STD_LOGIC; -- unused an3
			  hund_anode   : out STD_LOGIC; -- digilent an2
	        tens_anode   : out STD_LOGIC; -- digilent an3
	        ones_anode   : out STD_LOGIC; -- digilent an4
			  CAn,CBn,CCn,CDn,CEn,CFn,CGn : out STD_LOGIC); -- digilent cathode - used for all displays
end seven_seg_disp;

architecture Behavioral of seven_seg_disp is
-- clock can be set at 25, 50 or 100MHz clock
-- this counter rolls over when max value is achieved
-- if 25MHz  / 3FFFF(hex) it becomes 95.4Hz or 1.05ms, within 1 - 16ms spec.
-- each seven segment display is on for part of the period
	constant max_cnt_size : integer := 19; --19
	signal counter : STD_LOGIC_VECTOR (max_cnt_size-1 downto 0);
begin
  

  
  mux_disp: process (clk) begin
	 if (clk'event and clk = '1') then
 	   if (reset_n = '0') then
	       ones_anode <= '1';
	       tens_anode <= '1';
			 hund_anode <= '1';
		    CAn <= '1';
		    CBn <= '1';
		    CCn <= '1';
		    CDn <= '1';
		    CEn <= '1';
		    CFn <= '1';
		    CGn <= '1';
      else
			case counter(max_cnt_size-1 downto max_cnt_size-2) is
			  when "00" =>	-- display ones
				 ones_anode <= '0';
				 tens_anode <= '1';
				 hund_anode <= '1';
				 unused_anode <= '1';
				 CAn <= ones_disp_n(6);
				 CBn <= ones_disp_n(5);
				 CCn <= ones_disp_n(4);
				 CDn <= ones_disp_n(3);
				 CEn <= ones_disp_n(2);
				 CFn <= ones_disp_n(1);
				 CGn <= ones_disp_n(0);
			  when "01" => -- display tens
				 ones_anode <= '1';
				 tens_anode <= '0';
				 hund_anode <= '1';
				 unused_anode <= '1';
				 CAn <= tens_disp_n(6);
				 CBn <= tens_disp_n(5);
				 CCn <= tens_disp_n(4);
				 CDn <= tens_disp_n(3);
				 CEn <= tens_disp_n(2);
				 CFn <= tens_disp_n(1);
				 CGn <= tens_disp_n(0);
			  when "10" => -- display hundreds
				 ones_anode <= '1';
				 tens_anode <= '1';
				 hund_anode <= '0';
				 unused_anode <= '1';
				 CAn <= hund_disp_n(6);
				 CBn <= hund_disp_n(5);
				 CCn <= hund_disp_n(4);
				 CDn <= hund_disp_n(3);
				 CEn <= hund_disp_n(2);
				 CFn <= hund_disp_n(1);
				 CGn <= hund_disp_n(0);
			  when "11" => -- Thousands/Fourthbit
				 ones_anode <= '1';
				 tens_anode <= '1';
				 hund_anode <= '1';
				 unused_anode <= '0';
				 CAn <= thou_disp_n(6);
				 CBn <= thou_disp_n(5);
				 CCn <= thou_disp_n(4);
				 CDn <= thou_disp_n(3);
				 CEn <= thou_disp_n(2);
				 CFn <= thou_disp_n(1);
				 CGn <= thou_disp_n(0);
			  
			  when others => -- blank display
				 ones_anode <= '1';
				 tens_anode <= '1';
				 hund_anode <= '1';
				 unused_anode <= '1';
				 CAn <= '1';
				 CBn <= '1';
				 CCn <= '1';
				 CDn <= '1';
				 CEn <= '1';
				 CFn <= '1';
				 CGn <= '1';
			end case;
	   end if;
	 end if;
  end process mux_disp;

  div_down_cntr : process (clk) begin
	 if (clk'event and clk = '1') then
	   if (reset_n = '0') then
	     counter <= (OTHERS => '0');
	   else
	     counter <= counter + '1';
	   end if;
	 end if;
  end process div_down_cntr;

end Behavioral;

