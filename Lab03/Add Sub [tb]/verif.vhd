library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity verif is
	port(or_num01,or_num02,ledr_sum,hex_num01,hex_num02,hex_sum:in signed(7 downto 0);
		carry,sum_subn:in std_logic;
		error:out std_logic);
end verif;


architecture behavior of verif is
begin
	process(or_num01,or_num02,ledr_sum,hex_num01,hex_num02,hex_sum)
	variable flag:std_logic;
	begin
		flag:='0';
		
		if(or_num01/=hex_num01) then flag:='1';
		elsif(or_num02/=hex_num02) then flag:='1';
		elsif(hex_sum/=ledr_sum) then flag:='1';
		else case sum_subn is
			when '1'=>if(((to_integer(or_num01)+to_integer(or_num02))/=to_integer(hex_sum))xor(carry='1')) then flag:='1';
						end if;
			when others=>if(((to_integer(or_num01)-to_integer(or_num02))/=to_integer(hex_sum))xor(carry='1')) then flag:='1';
						end if;
			end case;
		end if;
		
		if (flag='1') then error<='1';
		else error<='0';
		end if;
	end process;
end architecture;