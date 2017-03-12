----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:19:42 05/07/2014 
-- Design Name: 
-- Module Name:    SRAM_MEM - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SRAM_MEM is
    Port ( Address : in  STD_LOGIC_VECTOR (2 downto 0);
           Data : inout  STD_LOGIC_VECTOR (3 downto 0);
           WriteEnable : in  STD_LOGIC;
           OutEnable : in  STD_LOGIC;
           AddressOffset : in  STD_LOGIC_VECTOR (1 downto 0);
			  DataADDRESS: out  STD_LOGIC_VECTOR (3 downto 0));
end SRAM_MEM;

architecture Behavioral of SRAM_MEM is
type MemArray is array(0 to 15) of std_logic_vector(3 downto 0);
signal Memory : MemArray := ("0000","0001","0010","0011","0100","0101","0110","0111","1000","1001","1010","1011","1100","1101","1110","1111");--(others => "0110")
signal addressSel : integer := 0;
begin
		
		addressSel <= 	to_integer(unsigned(Address) + unsigned(AddressOffset)) when ((unsigned(Address) + unsigned(AddressOffset))<16) else
						to_integer(unsigned(Address) + unsigned(AddressOffset) - 15);
	
	iguess:process
	begin
		for i in 0 to 15 loop
			if WriteEnable = '1' then
				if i = addressSel then
					Memory(i) <= Data;
				else
					Memory(i) <= Memory(i);
				end if;
			else
				Memory(i) <= Memory(i);
			end if;
		end loop;
	end process;	



	Data <= 	"ZZZZ" when(OutEnable = '0') else
				Memory(addressSel);-- when (OutEnable = '1');
	DataADDRESS <= Memory(addressSel);
	

end Behavioral;

