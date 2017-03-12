----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:19:14 05/08/2014 
-- Design Name: 
-- Module Name:    MemControl - Behavioral 
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.

--library UNISIM;
--use UNISIM.VComponents.all;

entity MemControl is
		generic(MY_ID: integer);
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
end MemControl;

architecture Behavioral of MemControl is

type states is(IDLE,decision,Mem_Read,Mem_Write,Writewait,ReadWait,R2,R3,R4,R4w);
signal state,next_state:states:=IDLE;

begin

	process(Clk)
	begin
		if(clk'event and clk = '1')then
			if (BUS_ID = MY_ID) then
				if(Reset = '1') then
					next_state <= IDLE;
				else
					if (state = decision) then
						if (RW = '1') then
							next_state <= ReadWait;
						else
							next_state <= Mem_Write;
						END if;
					elsif (state = IDLE and Ready = '0')then
						next_state <= decision;
					elsif(state = ReadWait and Ready = '1') then
						next_state <= Mem_Read;
					elsif(state = Mem_Write and Ready = '1') then
						next_state <= writewait;
					elsif(state = writewait and Ready = '1') then
						next_state <= IDLE;
					elsif(state = Mem_Read and Ready = '1' and Burst = '0')then
						next_state <= IDLE;
					elsif(state = Mem_Read and Ready = '1' and Burst = '1')then
						next_state <= R2;
					elsif(state = R2)then
						next_state <= R3;
					elsif(state = R3)then
						next_state <= R4;
					elsif(state = R4)then
						next_state <= R4w;
					elsif(state = R4w)then
						next_state <= IDLE;
					else
						next_state <= state;
					end if;
				end if;
			else
				next_state <= IDLE;	
			end if;
		end if;
	end process;
	
	decdrive:process(Clk)
	begin
		if(clk'event and clk='1')then
		if (BUS_ID = MY_ID) then
			if(state = decision)then
				DecOut <= '1';
			else
				DecOut <= '0';
			end if;
		else
			DecOut <= '0';
		end if;
		end if;
	end process;
	
	
	offset:process(Clk)
	begin
		if(clk'event and clk = '1')then
			case state is
				when IDLE			=> ADDR <= "00";
				when decision		=> ADDR <= "00";
				when Mem_Write		=> ADDR <= "00";
				when writewait    => ADDR <= "00";
				when ReadWait		=> ADDR <= "00";
				when Mem_Read		=> ADDR <= "00";
				when R2				=> ADDR <= "01";
				when R3				=> ADDR <= "10";
				when R4				=> ADDR <= "11";
				when R4w				=> ADDR <= "11";
			end case;
		end if;
	end process;

	outenable:process(Clk)
	begin
		if(clk'event and clk = '1')then
		if (BUS_ID = MY_ID) then
			if(Ready = '1' and RW = '1')then
				if(state = ReadWait)then
					OE <= '1';
				elsif(state = Mem_Read)then
					OE <= '1';
				elsif(state = R2)then
					OE <= '1';
				elsif(state = R3)then
					OE <= '1';
				elsif(state = R4)then
					OE <= '1';
				elsif(state = R4w)then
					OE <= '1';
				else
					OE <= '0';
				end if;
			else
				OE <= '0';
			end if;
		else
			OE <= '0';
		end if;
		end if;
	end process;
	
	writeenable:process(Clk)
	begin
		if(Clk'event and clk = '1')then
		if (BUS_ID = MY_ID) then
			if(state = Mem_Write and Ready = '1' and RW = '0')then
				WE <= '1';
			elsif(state = writewait and Ready = '1' and RW = '0') then
				WE <= '1';
			else
				WE <= '0';
			end if;
		else
			WE <= '0';
		end if;
		end if;	
	end process;		
			
			
	state <= next_state;	
	end Behavioral;

