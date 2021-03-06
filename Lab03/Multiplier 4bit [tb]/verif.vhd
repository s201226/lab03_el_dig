library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity verif is
	port(or_num01,or_num02,hex_num01,hex_num02:in unsigned(3 downto 0);
	  hex_prod:in unsigned(7 downto 0);
		error:out std_logic);
end verif;


architecture behavior of verif is
begin
	process(or_num01,or_num02,hex_num01,hex_num02,hex_prod)
	variable flag:std_logic;
	begin
		flag:='0';
		
		if(or_num01/=hex_num01) then flag:='1';
		elsif(or_num02/=hex_num02) then flag:='1';
		elsif(to_integer(or_num01)*to_integer(or_num02)/=to_integer(hex_prod)) then flag:='1';
		end if;
		
		if (flag='1') then error<='1';
		else error<='0';
		end if;
	end process;
end architecture;