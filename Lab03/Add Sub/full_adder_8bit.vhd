library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_8bit is
	port(val01,val02:in signed(7 downto 0);
		sum_subn:in std_logic;
		sum:out signed(7downto 0);
		c_o:out std_logic);
end full_adder_8bit;


architecture behavior of full_adder_8bit is
begin
	process(val01,val02)
	
	variable v_val02,v_sum:signed(7 downto 0);
	variable carry:std_logic_vector(8 downto 0);
	
	begin
		v_val02:=val02;
		
		if(sum_subn='1') then carry(0):='0';
		else
			for i in 0 to 7 loop
				v_val02(i):=not val02(i);
			end loop;
			carry(0):='1';
		end if;
		
		for i in 0 to 7 loop
			v_sum(i):=val01(i) xor v_val02(i) xor carry(i);
			carry(i+1):=(carry(i) and val01(i))or(carry(i) and v_val02(i))or(val01(i) and v_val02(i));
		end loop;
		
		sum<=v_sum;
		
		if(((not val01(7)and not v_val02(7)and v_sum(7))or(val01(7)and v_val02(7)and not v_sum(7)))='1') then c_o<='1';
		else c_o<='0';
		end if;
	end process;
end behavior;