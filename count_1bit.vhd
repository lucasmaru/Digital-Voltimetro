
entity count_1bit is
	port(
		ena : in bit;
		rst : in bit;
		clk : in bit;
		cy  : out bit; 
		q   : out bit
	);
end;

architecture count_1bit_arq of count_1bit is
	
	signal d     : bit; --Entrada al ffd
	signal q_s   : bit; --La salida del ffd q, va a otros lugares, un puerto out no se puede leer adentro por eso lo declaro 
	signal rst_n : bit; --La negacion de la entrada rst
	
    -- Declaración del componente: copia de la interfaz de ffd.vhd
	component ffd
        port (
            clr : in bit;
	    clk : in bit;
            d   : in bit;
            q   : out bit
        );
	end component;
	
	begin	
	q     <= q_s; --Asigno el puerto q a la señal para poder llevarla a donde necesito
	rst_n <= not rst; --Niego rst
	d     <= (rst_n and not q_s and ena) or (rst_n and q_s and not ena); --Ecuacion del D
	cy    <= (q_s and rst_n and ena);
	ffd1 : ffd
		 port map (
			clr => '0',--Constante literal que deshabilita
			clk => clk,
			d   => d,
			q   => q_s
		);
end;
	