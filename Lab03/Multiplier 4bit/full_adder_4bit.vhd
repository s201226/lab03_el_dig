library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_4bit is
	port(val01,val02:in unsigned(3 downto 0);
		sum:out unsigned(3 downto 0);
		c_o:out std_logic);
end full_adder_4bit;


architecture behavior of full_adder_4bit is
begin
	process(val01,val02)
	
	variable carry:std_logic_vector(4 downto 0);
	
	begin
		carry(0):='0';
		
		for i in 0 to 3 loop
			sum(i)<=val01(i) xor val02(i) xor carry(i);
			carry(i+1):=(carry(i) and val01(i))or(carry(i) and val02(i))or(val01(i) and val02(i));
		end loop;

		c_o<=carry(4);
	end process;
end behavior;