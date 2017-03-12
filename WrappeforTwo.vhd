----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:31:53 05/14/2014 
-- Design Name: 
-- Module Name:    WrappeforTwo - Behavioral 
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

entity WrapperforTwo is
    Port ( Clk		 : in	 STD_LOGIC;
			  Address : in  STD_LOGIC_VECTOR (2 downto 0);
           WriteData : in  STD_LOGIC_VECTOR (3 downto 0);
           BUS_ID : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           RW : in  STD_LOGIC;
           Ready : in  STD_LOGIC;
           Burst : in  STD_LOGIC;
           TestReadData : out  STD_LOGIC_VECTOR (3 downto 0);
           CA : out  STD_LOGIC;
           CB : out  STD_LOGIC;
           CC : out  STD_LOGIC;
           CD : out  STD_LOGIC;
           CE : out  STD_LOGIC;
           CF : out  STD_LOGIC;
           CG : out  STD_LOGIC;
           AN0 : out  STD_LOGIC;
           AN1 : out  STD_LOGIC;
           AN2 : out  STD_LOGIC;
           AN3 : out  STD_LOGIC;
			  DataADDRESS: out  STD_LOGIC_VECTOR (3 downto 0));
end WrapperforTwo;

architecture Behavioral of WrapperforTwo is
signal ithink			:std_logic_vector(3 downto 0);
signal invert_reset 	: std_logic;
signal read1,read2,read3,read4 : std_logic_vector(3 downto 0);
signal burst_count 	: integer range 0 to 6 := 6;
signal datainout 		: std_logic_vector(3 downto 0);
signal DecOut			:std_logic;
signal OE,OE2,WE,WE2	:std_logic;
signal ADDR,ADDR2  	:std_logic_vector(1 downto 0);
signal myBUS_ID	:integer;
signal kthou_disp_n,khund_disp_n,ktens_disp_n,kones_disp_n:std_logic_vector(6 downto 0);
signal lastReady     :std_logic_vector(6 downto 0);
signal ANset			:std_logic			:= '0';
signal cAN1,cAN2,cAN0:std_logic	:= '1';

component SRAM_MEM
    Port ( Address : in  STD_LOGIC_VECTOR (2 downto 0);
           Data : inout  STD_LOGIC_VECTOR (3 downto 0);
           WriteEnable : in  STD_LOGIC;
           OutEnable : in  STD_LOGIC;
           AddressOffset : in  STD_LOGIC_VECTOR (1 downto 0);
			  DataADDRESS: out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component MemControl 
		generic(MY_ID:integer);
    Port ( Clk : in  STD_LOGIC;
           OE : out  STD_LOGIC;
           WE : out  STD_LOGIC;
           BUS_ID : in  integer;
           RW : in  STD_LOGIC;
           Ready : in  STD_LOGIC;
           Burst : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  DecOut: out std_logic;
           ADDR : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

component seven_seg_disp
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
end component;


begin

	process(Clk)
	begin
		if (clk'event and clk = '1')then
			
			lastReady(6 downto 1) <= lastReady(5 downto 0);
			lastReady(0) <= Ready;
			end if;
	end process;
	
	
myBUS_ID <= 0 when BUS_ID = '0' else 1;

AN0 <= 	cAN0 when ANset = '1' else
			'1';
AN1 <= 	cAN1 when ANset = '1' else
			'1';
AN2 <= 	cAN2 when ANset = '1' else
			'1';

		
		ohyeh:seven_seg_disp
    Port Map (hund_disp_n  => khund_disp_n,
	        tens_disp_n  => ktens_disp_n,
           ones_disp_n  => kones_disp_n,
			  thou_disp_n	=> kthou_disp_n,
	        clk          => clk,
			  reset_n      => invert_reset,
			  unused_anode => AN3,
			  hund_anode   => cAN2,
	        tens_anode   => cAN1,
	        ones_anode   => cAN0,
			  CAn => CA,
			  CBn => CB,
			  CCn => CC,
			  CDn => CD,
			  CEn => CE,
			  CFn => CF,
			  CGn => CG);
		
		
		
		
		

		yeh:MemControl
		generic map(MY_ID => 0)
		Port map ( Clk => Clk,
					  OE => OE,
					  WE => WE,
					  BUS_ID => myBUS_ID,
					  RW => RW,
					  Ready => Ready,
					  Burst => Burst,
					  Reset => Reset,
					  DecOut=> DecOut,
					  ADDR  => ADDR);
					  
	yeh2:SRAM_MEM
    Port map ( 	Address =>  Address,
						Data    => datainout,
						WriteEnable => WE,
						OutEnable   => OE,
						AddressOffset => ADDR,
						DataADDRESS => DataADDRESS);
	yeh22:SRAM_MEM
    Port map ( 	Address =>  Address,
						Data    => datainout,
						WriteEnable => WE2,
						OutEnable   => OE2,
						AddressOffset => ADDR2,
						DataADDRESS => ithink);	
		yeh12:MemControl
		generic map(MY_ID => 1)
		Port map ( Clk => Clk,
					  OE => OE2,
					  WE => WE2,
					  BUS_ID => myBUS_ID,
					  RW => RW,
					  Ready => Ready,
					  Burst => Burst,
					  Reset => Reset,
					  DecOut=> DecOut,
					  ADDR  => ADDR2);
	
	
	testreaddata <= datainout;
	
	
	invert_reset <= not(Reset);
	
--	process(clk)
--	begin
--		if (Clk'event and Clk = '1') then
--			
--				if RW = '0' then
--					datainout <= WriteData;
--				else
--					datainout <= "ZZZZ";
--				end if;
--			
--		end if;
--	end process;
	datainout <= 	WriteData when (RW = '0') else
						"ZZZZ";
	
	
	
	burstcountmod:Process(Clk)
	BEGIN
		if (Clk'event and Clk = '1') then
			if(Burst = '1' and Ready = '1' and burst_count > 0) then
				burst_count <= burst_count - 1;
			else
				burst_count <= 6;
			end if;
		end if;
	end process;
	ansetset:Process(Clk)
	begin
		if (Clk'event and Clk = '1')then
			if(RW = '1')then
				if(Burst = '1' and Ready = '1' and burst_count > 0)then
					
					ANset<='1';
				elsif(Burst = '0' and Ready = '1' and lastReady(2) = '0')then
					ANset<='0';
				else
					ANset<=ANset;
				end if;
			end if;
		end if;
	end process;
	read1set:Process(Clk)
	begin
		if (Clk'event and Clk = '1')then
			if(RW = '1')then
				if(Burst = '1' and Ready = '1' and burst_count > 0)then
					if lastReady(2) = '0' then--burst_count = 4 and 
						read1 <= datainout;
					else
						read1 <= read1;
					end if;
				elsif(Burst = '0' and Ready = '1' and lastReady(2) = '0')then
						read1 <= datainout;				
				else
					read1 <= read1;
				end if;
			end if;
		end if;
	end process;
	read2set:Process(Clk)
	begin
		if (Clk'event and Clk = '1')then
			if(RW = '1')then
				if(Burst = '1' and Ready = '1' and burst_count > 0)then
					if lastReady(3) = '0' then--burst_count = 3 and 
						read2 <= datainout;
					else
						read2 <= read2;
					end if;
				elsif(Burst = '0' and Ready = '1' and lastReady(2) = '0')then
						read2 <= "ZZZZ";
				else
					read2 <= read2;
				end if;
			end if;
		end if;
	end process;
	read3set:Process(Clk)
	begin
		if (Clk'event and Clk = '1')then
			if(RW = '1')then
				if(Burst = '1' and Ready = '1' and burst_count > 0)then
					if lastReady(4) = '0' then--burst_count = 2 and 
						read3 <= datainout;
					else
						read3 <= read3;
					end if;
				elsif(Burst = '0' and Ready = '1' and lastReady(2) = '0')then
						read3 <= "ZZZZ";
				else
					read3 <= read3;
				end if;
			end if;
		end if;
	end process;
		read4set:Process(Clk)
	begin
		if (Clk'event and Clk = '1')then
			if(RW = '1')then
				if(Burst = '1' and Ready = '1' and burst_count > 0)then
					if lastReady(4) = '1' and lastReady(6) = '0' then--burst_count = 1 and 
						read4 <= datainout;
					else
						read4 <= read4;
					end if;
				elsif(Burst = '0' and Ready = '1' and lastReady(2) = '0')then
						read4 <= "ZZZZ";				
				else
					read4 <= read4;
				end if;
			end if;
		end if;
	end process;
	Process(Clk)
	begin
		if(Clk'event and Clk = '1') then
			case read4 is
				when "0000"=> kones_disp_n <= not("1111110");  -- '0'
				when "0001"=> kones_disp_n <= not("0110000");  -- '1'
				when "0010"=> kones_disp_n <= not("1101101");  -- '2'
				when "0011"=> kones_disp_n <= not("1111001");  -- '3'
				when "0100"=> kones_disp_n <= not("0110011");  -- '4' 
				when "0101"=> kones_disp_n <= not("1011011");  -- '5'
				when "0110"=> kones_disp_n <= not("1011111");  -- '6'
				when "0111"=> kones_disp_n <= not("1110000");  -- '7'
				when "1000"=> kones_disp_n <= not("1111111");  -- '8'
				when "1001"=> kones_disp_n <= not("1111011");  -- '9'
				when "1010"=> kones_disp_n <= not("1110111");  -- 'A/10'
				when "1011"=> kones_disp_n <= not("0011111");  -- 'B/11'
				when "1100"=> kones_disp_n <= not("1001110");  -- 'C/12'
				when "1101"=> kones_disp_n <= not("0111101");  -- 'D/13'
				when "1110"=> kones_disp_n <= not("1001111");  -- 'E/14'
				when "1111"=> kones_disp_n <= not("1000111");  -- 'F/15'
				when others=> kones_disp_n <= not("0000000");
			end case;
			case read3 is
				when "0000"=> ktens_disp_n <= not("1111110");  -- '0'
				when "0001"=> ktens_disp_n <= not("0110000");  -- '1'
				when "0010"=> ktens_disp_n <= not("1101101");  -- '2'
				when "0011"=> ktens_disp_n <= not("1111001");  -- '3'
				when "0100"=> ktens_disp_n <= not("0110011");  -- '4' 
				when "0101"=> ktens_disp_n <= not("1011011");  -- '5'
				when "0110"=> ktens_disp_n <= not("1011111");  -- '6'
				when "0111"=> ktens_disp_n <= not("1110000");  -- '7'
				when "1000"=> ktens_disp_n <= not("1111111");  -- '8'
				when "1001"=> ktens_disp_n <= not("1111011");  -- '9'
				when "1010"=> ktens_disp_n <= not("1110111");  -- 'A/10'
				when "1011"=> ktens_disp_n <= not("0011111");  -- 'B/11'
				when "1100"=> ktens_disp_n <= not("1001110");  -- 'C/12'
				when "1101"=> ktens_disp_n <= not("0111101");  -- 'D/13'
				when "1110"=> ktens_disp_n <= not("1001111");  -- 'E/14'
				when "1111"=> ktens_disp_n <= not("1000111");  -- 'F/15'
				when others=> ktens_disp_n <= not("0000000");
			 end case;
			 case read2 is
				when "0000"=> khund_disp_n <= not("1111110");  -- '0'
				when "0001"=> khund_disp_n <= not("0110000");  -- '1'
				when "0010"=> khund_disp_n <= not("1101101");  -- '2'
				when "0011"=> khund_disp_n <= not("1111001");  -- '3'
				when "0100"=> khund_disp_n <= not("0110011");  -- '4' 
				when "0101"=> khund_disp_n <= not("1011011");  -- '5'
				when "0110"=> khund_disp_n <= not("1011111");  -- '6'
				when "0111"=> khund_disp_n <= not("1110000");  -- '7'
				when "1000"=> khund_disp_n <= not("1111111");  -- '8'
				when "1001"=> khund_disp_n <= not("1111011");  -- '9'
				when "1010"=> khund_disp_n <= not("1110111");  -- 'A/10'
				when "1011"=> khund_disp_n <= not("0011111");  -- 'B/11'
				when "1100"=> khund_disp_n <= not("1001110");  -- 'C/12'
				when "1101"=> khund_disp_n <= not("0111101");  -- 'D/13'
				when "1110"=> khund_disp_n <= not("1001111");  -- 'E/14'
				when "1111"=> khund_disp_n <= not("1000111");  -- 'F/15'
				when others=> khund_disp_n <= not("0000000");
			 end case;
			 case read1 is
				when "0000"=> kthou_disp_n <= not("1111110");  -- '0'
				when "0001"=> kthou_disp_n <= not("0110000");  -- '1'
				when "0010"=> kthou_disp_n <= not("1101101");  -- '2'
				when "0011"=> kthou_disp_n <= not("1111001");  -- '3'
				when "0100"=> kthou_disp_n <= not("0110011");  -- '4' 
				when "0101"=> kthou_disp_n <= not("1011011");  -- '5'
				when "0110"=> kthou_disp_n <= not("1011111");  -- '6'
				when "0111"=> kthou_disp_n <= not("1110000");  -- '7'
				when "1000"=> kthou_disp_n <= not("1111111");  -- '8'
				when "1001"=> kthou_disp_n <= not("1111011");  -- '9'
				when "1010"=> kthou_disp_n <= not("1110111");  -- 'A/10'
				when "1011"=> kthou_disp_n <= not("0011111");  -- 'B/11'
				when "1100"=> kthou_disp_n <= not("1001110");  -- 'C/12'
				when "1101"=> kthou_disp_n <= not("0111101");  -- 'D/13'
				when "1110"=> kthou_disp_n <= not("1001111");  -- 'E/14'
				when "1111"=> kthou_disp_n <= not("1000111");  -- 'F/15'
				when others=> kthou_disp_n <= not("0000000");
			 end case;
		end if;
	end process;

end Behavioral;