library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ff_asyncrst_sign1bit is
	port(D,Clk,Resetn:in std_logic;
		Q:buffer std_logic);
end ff_asyncrst_sign1bit;


architecture behavior of ff_asyncrst_sign1bit is
begin
	main:process(Clk,Resetn)
	begin
		if (Resetn='0') then
			Q<='0';
		elsif (Clk'event and Clk='1') then
			Q<=D;
		end if;
	end process main;
end behavior;