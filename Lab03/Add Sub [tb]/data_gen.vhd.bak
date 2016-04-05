library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_gen is
	port(clk:in std_logic;
		data:out std_logic_vector(15 downto 0);
		data_s01,data_s02:out signed(7 downto 0);
		resetn:out std_logic);
end data_gen;


architecture behavior of data_gen is

type data_lib is array(0 to 9) of signed(7 downto 0);

signal val01,val02: data_lib;
signal i:integer:=0;

begin
	--generazione valori
	
	val01(0)<="00000000";
	val01(1)<="00100000";
	val01(2)<="11000000";
	val01(3)<="01000000";
	val01(4)<="10100000";
	val01(5)<="11100000";
	val01(6)<="00100000";
	val01(7)<="10000000";
	val01(8)<="01100000";
	val01(9)<="00000000";
	
	val02(0)<="00100000";
	val02(1)<="01000000";
	val02(2)<="11100000";
	val02(3)<="10100000";
	val02(4)<="01100000";
	val02(5)<="10000000";
	val02(6)<="01100000";
	val02(7)<="11100000";
	val02(8)<="00100000";
	val02(9)<="00000000";
	
	--passaggio ordinato
	
	process(clk)
	begin
	  resetn<='1';
		if(clk'event and clk='0') then
			data<=std_logic_vector(val01(i))&std_logic_vector(val02(i));
			data_s01<=val01(i);
			data_s02<=val02(i);
			if(i<9) then
				i<=i+1;
			else i<=0; resetn<='0';
			end if;
		end if;
	end process;
end architecture;