library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ff_asyncrst_sign16bit is
	port(D:in signed(15 downto 0);
		Clk,Resetn:in std_logic;
		Q:buffer signed(15 downto 0));
end ff_asyncrst_sign16bit;


architecture behavior of ff_asyncrst_sign16bit is
begin
	main:process(Clk,Resetn)
	begin
		if (Resetn='0') then
			Q<=(others=>'0');
		elsif (Clk'event and Clk='1') then
			Q<=D;
		end if;
	end process main;
end behavior;