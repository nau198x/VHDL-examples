
-------------------------------------------------
-- Counter with decimal number with carry
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cnt10 is
    Port ( CLK : in  STD_LOGIC; -- Clock signal
           RST : in  STD_LOGIC; -- Reset signal
		   CE : in STD_LOGIC; -- Count enable
		   Data : out  STD_LOGIC_VECTOR (3 downto 0);
		   CRR : out STD_LOGIC); -- Carry signal
end cnt10;

architecture RTL of cnt10 is
    -- Inner signal
	signal tmp : std_logic_vector(3 downto 0);
begin
	process(clk , rst)
	begin
        -- 非同期リセット
        if(rst = '1')then
            tmp <= (others => '0');
        -- CLKの立ち上がりをトリガー
		elsif(rising_edge(clk))then
			if (CE = '1') then
				if(tmp = 9)then
					tmp <= (others => '0');
				else
                    tmp <= tmp + 1;
				end if;
			end if;
        end if;
	end process;
    
    -- Output Data
	Data <= tmp;
	CRR <= '1' when tmp = 9 and CE = '1';
	
end RTL;