library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_16bit is
	port(val01,val02:in signed(15 downto 0);
		sum:out signed(15downto 0));
end full_adder_16bit;


architecture behavior of full_adder_16bit is

component full_adder_4bit is
	port(val01,val02:in signed(3 downto 0);
		carry_i:in std_logic;
		sum:out signed(3 downto 0);
		carry_o:out std_logic);
end component;

signal c_add1,c_add2,c_add3,c_add4,cprop2,cprop3,prop2,prop3:std_logic;

begin
	add1:full_adder_4bit port map
		(val01=>val01(3 downto 0),
		val02=>val02(3 downto 0),
		carry_i=>'0',
		sum=>sum(3 downto 0),
		carry_o=>c_add1);
		
	add2:full_adder_4bit port map
		(val01=>val01(7 downto 4),
		val02=>val02(7 downto 4),
		carry_i=>c_add1,
		sum=>sum(7 downto 4),
		carry_o=>c_add2);
		
	prop2<=(val01(4)or val02(4))and(val01(5)or val02(5))and(val01(6)or val02(6))and(val01(7)or val02(7))and c_add2;
	
	cprop2<=c_add1 when prop2='1' else
			c_add2 when prop2='0';
		
	add3:full_adder_4bit port map
		(val01=>val01(11 downto 8),
		val02=>val02(11 downto 8),
		carry_i=>cprop2,
		sum=>sum(11 downto 8),
		carry_o=>c_add3);
		
	prop3<=(val01(8)or val02(8))and(val01(9)or val02(9))and(val01(10)or val02(10))and(val01(11)or val02(11))and c_add3;
	
	cprop3<=c_add2 when prop3='1' else
			c_add3 when prop3='0';
		
	add4:full_adder_4bit port map
		(val01=>val01(15 downto 12),
		val02=>val02(15 downto 12),
		carry_i=>cprop3,
		sum=>sum(15 downto 12),
		carry_o=>c_add4);
end behavior;