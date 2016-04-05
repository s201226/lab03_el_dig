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
		data:out std_logic_vector(16 downto 0);
		data_s01,data_s02:out signed(7 downto 0);
		resetn:out std_logic);
end component;

component coder_7seg is
	port(hex:in std_logic_vector(0 to 6);
		num:out unsigned(3 downto 0));
end component;

component verif is
	port(or_num01,or_num02,ledr_sum,hex_num01,hex_num02,hex_sum:in signed(7 downto 0);
		carry,sum_subn:in std_logic;
		error:out std_logic);
end component;

--register (per i ritardi)

component ff_asyncrst_sign8bit is
	port(D:in signed(7 downto 0);
		Clk,Resetn:in std_logic;
		Q:buffer signed(7 downto 0));
end component;

component ff_asyncrst_sign1bit is
	port(D,Clk,Resetn:in std_logic;
		Q:buffer std_logic);
end component;

--unit under test

component Add_sub is
	port(sw:in std_logic_vector(16 downto 0);
		key:in std_logic_vector(1 downto 0);
		ledr:out std_logic_vector(7 downto 0);
		ledg:out std_logic_vector(8 downto 0);
		hex7,hex6,hex5,hex4,hex1,hex0:out std_logic_vector(0 to 6));
end component;



signal clk,resetn,error:std_logic;
signal to_uut:std_logic_vector(16 downto 0);
signal g_val01,g_val02:signed(7 downto 0); --generated values
signal to_key:std_logic_vector(1 downto 0);

signal reg1reg20,reg1reg21,n_val01,n_val02,n_num01,n_num02:signed(7 downto 0); --collegamento registri
signal reg1reg2as,sum_subn:std_logic;

signal ledr:std_logic_vector(7 downto 0);
signal ledg:std_logic_vector(8 downto 0);
signal hex7,hex6,hex5,hex4,hex1,hex0:std_logic_vector(0 to 6);
signal s7,s6,s5,s4,s1,s0:unsigned(3 downto 0); --corrispondenti numerici delle cifre hex
signal num01,num02,sum:signed(7 downto 0); --numeri signed visualizzati su 7seg display

begin
	clk_gen:clock port map(clk);
	
	--generazione input e output
	
	input:data_gen port map
		(clk=>clk,
		data=>to_uut,
		data_s01=>g_val01,
		data_s02=>g_val02,
		resetn=>resetn);
	
	to_key<=clk&resetn;
	
	uut:Add_sub port map
		(sw=>to_uut,
		key=>to_key,
		ledr=>ledr,
		ledg=>ledg,
		hex7=>hex7,
		hex6=>hex6,
		hex5=>hex5,
		hex4=>hex4,
		hex1=>hex1,
		hex0=>hex0);
		
	disp7:coder_7seg port map(hex7,s7);
	disp6:coder_7seg port map(hex6,s6);
	disp5:coder_7seg port map(hex5,s5);
	disp4:coder_7seg port map(hex4,s4);
	disp1:coder_7seg port map(hex1,s1);
	disp0:coder_7seg port map(hex0,s0);
	
	--verifica
	
	num01<=signed(std_logic_vector(s7)&std_logic_vector(s6));
	num02<=signed(std_logic_vector(s5)&std_logic_vector(s4));
	sum<=signed(std_logic_vector(s1)&std_logic_vector(s0));
	
	output:verif port map
		(or_num01=>n_val01,
		or_num02=>n_val02,
		ledr_sum=>signed(ledr),
		hex_num01=>n_num01,
		hex_num02=>n_num02,
		hex_sum=>sum,
		carry=>ledg(8),
		sum_subn=>sum_subn,
		error=>error);
	
	--gestione ritardi
	
	reg10:ff_asyncrst_sign8bit port map  --registro 1 del primo valore
		(D=>g_val01,
		Clk=>clk,
		Resetn=>resetn,
		Q=>reg1reg20);
		
	reg11:ff_asyncrst_sign8bit port map  --registro 1 del secondo valore
		(D=>g_val02,
		Clk=>clk,
		Resetn=>resetn,
		Q=>reg1reg21);
		
	reg20:ff_asyncrst_sign8bit port map  --registro 2 del primo valore
		(D=>reg1reg20,
		Clk=>clk,
		Resetn=>resetn,
		Q=>n_val01);
		
	reg21:ff_asyncrst_sign8bit port map
		(D=>reg1reg21,
		Clk=>clk,
		Resetn=>resetn,
		Q=>n_val02);
	
	reg30:ff_asyncrst_sign8bit port map
		(D=>num01,
		Clk=>clk,
		Resetn=>resetn,
		Q=>n_num01);
		
	reg31:ff_asyncrst_sign8bit port map
		(D=>num02,
		Clk=>clk,
		Resetn=>resetn,
		Q=>n_num02);
		
	regc0:ff_asyncrst_sign1bit port map
		(D=>to_uut(16),
		Clk=>clk,
		Resetn=>resetn,
		Q=>reg1reg2as);
		
	regc1:ff_asyncrst_sign1bit port map
		(D=>reg1reg2as,
		Clk=>clk,
		Resetn=>resetn,
		Q=>sum_subn);
end test;
