
-------------------------------------------------
-- Example of dynamic lighting, 4 digit 7-segment LED
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Dynamic7SEG is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Data_in0 : in  STD_LOGIC_VECTOR (3 downto 0);
           Data_in1 : in  STD_LOGIC_VECTOR (3 downto 0);
           Data_in2 : in  STD_LOGIC_VECTOR (3 downto 0);
           Data_in3 : in  STD_LOGIC_VECTOR (3 downto 0);
           Data_out : out  STD_LOGIC_VECTOR (3 downto 0);
		   TR : out  STD_LOGIC_VECTOR (3 downto 0));
end Dynamic7SEG;

architecture RTL of Dynamic7SEG is
	signal cnt : STD_LOGIC_VECTOR (8 downto 0);
	signal dig : STD_LOGIC_VECTOR (2 downto 0);
begin

	process(CLK, RST)
	begin
		if (RST = '1') then
			cnt <= (others => '0');
		elsif (rising_edge(CLK)) then
			cnt <= cnt + 1;
		end if;
	end process;
	
    -- カウンタの上位2bitだけ抽出
    dig <= cnt(8 downto 6);
	
	process(dig, Data_in0, Data_in1, Data_in2, Data_in3)
	begin
		
		if (RST = '1') then
			-- 0000を表示
			Data_out <= "0000";
			TR <= "0000";
		end if;
        -- digの値によってLEDの表示セクションを切り替え
        -- 4桁の表示を高速に切り替えることで錯視させる
		case dig is
			when "000" =>
				Data_out <= Data_in0;
				TR <= "1110";
			when "010" =>
				Data_out <= Data_in1;
				TR <= "1101";
			when "100" =>
				Data_out <= Data_in2;
				TR <= "1011";
			when "110" =>
				Data_out <= Data_in3;
				TR <= "0111";
			when others =>
				Data_out <= "1111";
				TR <= "1111";
		end case;
		
	end process;

end RTL;