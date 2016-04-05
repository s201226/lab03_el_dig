library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_gen is
	port(clk:in std_logic;
		data:out std_logic_vector(11 downto 0);
		data_s01,data_s02:out unsigned(3 downto 0));
end data_gen;


architecture behavior of data_gen is

type data_lib is array(0 to 9) of unsigned(3 downto 0);

signal val01,val02: data_lib;
signal i:integer:=0;

begin
	--generazione valori
	
	val01(0)<="0000";
	val01(1)<="0110";
	val01(2)<="0110";
	val01(3)<="0001";
	val01(4)<="1111";
	val01(5)<="0001";
	val01(6)<="1000";
	val01(7)<="0000";
	val01(8)<="0001";
	val01(9)<="0101";
	
	val02(0)<="0000";
	val02(1)<="0000";
	val02(2)<="0001";
	val02(3)<="1111";
	val02(4)<="1111";
	val02(5)<="0001";
	val02(6)<="0100";
	val02(7)<="1110";
	val02(8)<="0010";
	val02(9)<="1010";
	
	--passaggio ordinato
	
	process(clk)
	begin
		if(clk'event and clk='0') then
			data<=std_logic_vector(val01(i))&"0000"&std_logic_vector(val02(i));
			data_s01<=val01(i);
			data_s02<=val02(i);
			if(i<9) then
				i<=i+1;
			else i<=0;
			end if;
		end if;
	end process;
end architecture;