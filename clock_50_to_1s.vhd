--Codigo retirado e adaptado do link
--https://www.fpga4student.com/2016/11/vhdl-code-for-digital-clock-on-fpga.html

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity clock_50_to_1s is
port (
   clk_50: in std_logic;
	modo_ajuste: in std_logic;
	modo_ajuste_fino: in std_logic;
   clk_1s: out std_logic
  );
end clock_50_to_1s;
architecture arch of clock_50_to_1s is

signal counter: std_logic_vector(27 downto 0):=(others =>'0');

begin
	process(clk_50)
		begin
			if(rising_edge(clk_50)) then
				if (modo_ajuste_fino = '1') and (modo_ajuste = '0') then
					counter <= counter + x"0000009";
				elsif (modo_ajuste_fino = '0') and (modo_ajuste = '1') then
					counter <= counter + x"0000999";
				else
					counter <= counter + x"0000001";
				end if;
				
				if(counter>=x"2FAF080") then
					counter <= x"0000000";
				end if;
				
			end if;
end process;

clk_1s <= '0' when counter < x"17D7840" else '1';

end arch;