library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplier_4bit is
	port(sw:in std_logic_vector(11 downto 0);
		hex6,hex4,hex1,hex0:out std_logic_vector(0 to 6));
end Multiplier_4bit;


architecture behavior of Multiplier_4bit is

component full_adder_4bit is
	port(val01,val02:in unsigned(3 downto 0);
		sum:out unsigned(3 downto 0);
		c_o:out std_logic);
end component;

component decoder_7seg is
	port(x:in unsigned(3 downto 0);
		hex:out std_logic_vector(0 to 6));
end component;

signal val01,val02:unsigned(3 downto 0);
signal row0,row1,row2,row3:unsigned(3 downto 0);
signal to_add1,to_add2,to_add3:unsigned(3 downto 0);
signal from_add1,from_add2,from_add3:unsigned(3 downto 0);
signal c_add1,c_add2,c_add3:std_logic;
signal output:unsigned(7 downto 0);

begin
	val01<=unsigned(sw(11 downto 8));
	val02<=unsigned(sw(3 downto 0));
	
	process(val01,val02)
	begin
		for i in 0 to 3 loop
			row0(i)<=val01(i)and val02(0);
			row1(i)<=val01(i)and val02(1);
			row2(i)<=val01(i)and val02(2);
			row3(i)<=val01(i)and val02(3);
		end loop;
	end process;
	
	to_add1<='0'&row0(3 downto 1);
	
	adder1:full_adder_4bit port map
		(val01=>to_add1,
		val02=>row1,
		sum=>from_add1,
		c_o=>c_add1);
		
	to_add2<=c_add1&from_add1(3 downto 1);
		
	adder2:full_adder_4bit port map
		(val01=>to_add2,
		val02=>row2,
		sum=>from_add2,
		c_o=>c_add2);
		
	to_add3<=c_add2&from_add2(3 downto 1);
		
	adder3:full_adder_4bit port map
		(val01=>to_add3,
		val02=>row3,
		sum=>from_add3,
		c_o=>c_add3);
		
	output<=c_add3&from_add3&from_add2(0)&from_add1(0)&row0(0);

	--output su 7seg display
	
	disp6:decoder_7seg port map(val01,hex6);
	disp4:decoder_7seg port map(val02,hex4);
	disp1:decoder_7seg port map(output(7 downto 4),hex1);
	disp0:decoder_7seg port map(output(3 downto 0),hex0);
	
end behavior;
		