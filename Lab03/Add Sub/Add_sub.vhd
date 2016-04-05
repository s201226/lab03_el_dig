library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Add_sub is
	port(sw:in std_logic_vector(16 downto 0);
		key:in std_logic_vector(1 downto 0);
		ledr:out std_logic_vector(7 downto 0);
		ledg:out std_logic_vector(8 downto 0);
		hex7,hex6,hex5,hex4,hex1,hex0:out std_logic_vector(0 to 6));
end Add_sub;


architecture behavior of Add_sub is

--flip flop (8 e 1 bit)

component ff_asyncrst_sign8bit is
	port(D:in signed(7 downto 0);
		Clk,Resetn:in std_logic;
		Q:buffer signed(7 downto 0));
end component;

component ff_asyncrst_sign1bit is
	port(D,Clk,Resetn:in std_logic;
		Q:buffer std_logic);
end component;

--sommatore

component full_adder_8bit is
	port(val01,val02:in signed(7 downto 0);
		sum_subn:in std_logic;
		sum:out signed(7downto 0);
		c_o:out std_logic);
end component;

--decoder 7 segmenti

component decoder_7seg is
	port(x:in unsigned(3 downto 0);
		hex:out std_logic_vector(0 to 6));
end component;

signal resetn,clk,sum_subn,carry,to_ledg:std_logic;
signal val01,val02,to_reg03,to_ledr:signed(7 downto 0);

begin
	--acquisizione ingresso
	
	resetn<=key(0);
	clk<=key(1);
	sum_subn<=sw(16);
	
	reg01:ff_asyncrst_sign8bit port map
		(D=>signed(sw(15 downto 8)),
		Clk=>clk,
		Resetn=>resetn,
		Q=>val01);
	
	reg02:ff_asyncrst_sign8bit port map
		(D=>signed(sw(7 downto 0)),
		Clk=>clk,
		Resetn=>resetn,
		Q=>val02);
	
	--somma
	
	adder:full_adder_8bit port map
		(val01=>val01,
		val02=>val02,
		sum_subn=>sum_subn,
		sum=>to_reg03,
		c_o=>carry);
		
	--acquisizione uscita
		
	reg03:ff_asyncrst_sign8bit port map
		(D=>to_reg03,
		Clk=>clk,
		Resetn=>resetn,
		Q=>to_ledr);
	
	reg04:ff_asyncrst_sign1bit port map
		(D=>carry,
		Clk=>clk,
		Resetn=>resetn,
		Q=>to_ledg);
	
	--output su led
	
	ledr<=std_logic_vector(to_ledr);
	ledg<=to_ledg&"00000000";
	
	--output su 7seg display
	
	disp7:decoder_7seg port map(unsigned(val01(7 downto 4)),hex7);
	disp6:decoder_7seg port map(unsigned(val01(3 downto 0)),hex6);
	disp5:decoder_7seg port map(unsigned(val02(7 downto 4)),hex5);
	disp4:decoder_7seg port map(unsigned(val02(3 downto 0)),hex4);
	disp1:decoder_7seg port map(unsigned(to_ledr(7 downto 4)),hex1);
	disp0:decoder_7seg port map(unsigned(to_ledr(3 downto 0)),hex0);
	
end behavior;
		