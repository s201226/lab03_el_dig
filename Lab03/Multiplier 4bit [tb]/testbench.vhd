library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;


architecture test of testbench is

--testbench part

component clock is
	port(clk:out std_logic);
end component;

component data_gen is
	port(clk:in std_logic;
		data:out std_logic_vector(11 downto 0);
		data_s01,data_s02:out unsigned(3 downto 0));
end component;

component coder_7seg is
	port(hex:in std_logic_vector(0 to 6);
		num:out unsigned(3 downto 0));
end component;

component verif is
	port(or_num01,or_num02,hex_num01,hex_num02:in unsigned(3 downto 0);
	  hex_prod:in unsigned(7 downto 0);
		error:out std_logic);
end component;

--unit under test

component Multiplier_4bit is
	port(sw:in std_logic_vector(11 downto 0);
		hex6,hex4,hex1,hex0:out std_logic_vector(0 to 6));
end component;

signal clk,error:std_logic;
signal to_uut:std_logic_vector(11 downto 0);
signal hex6,hex4,hex1,hex0:std_logic_vector(0 to 6);
signal g_val01,g_val02,s6,s4,s1,s0:unsigned(3 downto 0);
signal prod:unsigned(7 downto 0);


begin
	clk_gen:clock port map(clk);
	
	--generazione input e output
	
	input:data_gen port map
		(clk=>clk,
		data=>to_uut,
		data_s01=>g_val01,
		data_s02=>g_val02);
	
	uut:Multiplier_4bit port map
		(sw=>to_uut,
		hex6=>hex6,
		hex4=>hex4,
		hex1=>hex1,
		hex0=>hex0);
		
	disp6:coder_7seg port map(hex6,s6);
	disp4:coder_7seg port map(hex4,s4);
	disp1:coder_7seg port map(hex1,s1);
	disp0:coder_7seg port map(hex0,s0);
	
	--verifica
	
	prod<=s1&s0;
	
	output:verif port map
		(or_num01=>g_val01,
		or_num02=>g_val02,
		hex_num01=>s6,
		hex_num02=>s4,
		hex_prod=>prod,
		error=>error);
end test;
