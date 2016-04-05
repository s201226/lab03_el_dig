library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_16bit is
	port(val01,val02:in signed(15 downto 0);
		sum:out signed(15downto 0));
end full_adder_16bit;


architecture behavior of full_adder_16bit is
begin
	process(val01,val02)
		
	variable carry:std_logic_vector(16 downto 0);
	
	begin
		carry(0):='0';
		for i in 0 to 15 loop
			sum(i)<=val01(i) xor val02(i) xor carry(i);
			carry(i+1):=(carry(i) and val01(i))or(carry(i) and val02(i))or(val01(i) and val02(i));
		end loop;
	end process;
end behavior;