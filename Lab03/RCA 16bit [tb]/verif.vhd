library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity verif is
	port(or_num01,or_num02,output:in signed(15 downto 0);
		carry:in std_logic;
		error:out std_logic);
end verif;


architecture behavior of verif is
begin
	process(or_num01,or_num02,output)
	variable flag:std_logic;
	begin
		if(((to_integer(or_num01)+to_integer(or_num02))/=to_integer(output))xor(carry='1')) then flag:='1';
		else flag:='0';
		end if;
		
		if (flag='1') then error<='1';
		else error<='0';
		end if;
	end process;
end architecture;