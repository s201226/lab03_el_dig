library ieee;
use ieee.std_logic_1164.all;

entity clock is
	port(clk:buffer std_logic);
end clock;


architecture behavior of clock is
begin
	process
	begin
		clk<='0';
		wait for 10 ns;
		clk<='1';
		wait for 10 ns;
	end process;
end architecture;