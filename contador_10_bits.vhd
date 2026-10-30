entity contador_10_bit is
	port(
		ena : in bit;
		rst : in bit;
		clk : in bit;
		cy  : out bit; 
		q   : out bit_vector(9 downto 0)
	);
end;

architecture contador_10_bit_arq of contador_10_bit is

	signal ena_i  : bit_vector(10 downto 0);

	-- Declaración del componente: copia de la interfaz de count_1_bit.vhd
	component count_1bit
        port(
		ena : in bit;
		rst : in bit;
		clk : in bit;
		cy  : out bit; 
		q   : out bit
	);
	end component;

	begin
		--Conecto los extremos
		ena_i(0) <= ena; --Entrada de la cadena
		cy <= ena_i(10); --Salida de la cadena
	
	counters : for i in 0 to 9
	
	