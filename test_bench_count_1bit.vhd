
entity test_bench_count_1bit is
end;

architecture test_bench_count_1bit_arq of test_bench_count_1bit is

	signal ena_t : bit;
	signal rst_t : bit;
	signal clk_t : bit:= '0' ;
	signal q_t   : bit;
	signal cy_t  : bit;

	component count_1bit
        port (
            ena : in bit;
	    rst : in bit;
            clk : in bit;
            cy  : out bit;
	     q  : out bit
        );
	end component;

	begin
	dut : count_1bit
		port map (
		ena =>ena_t,
	    	rst =>rst_t,
            	clk =>clk_t,
            	cy  =>cy_t,
	     	q   =>q_t
	);
	
	clk_t <= not clk_t after 20 ns;

	
	process
	begin
    		-- t=0: todo apagado
    		rst_t <= '0'; ena_t <= '0';
    		wait for 80 ns;      -- flancos 20, 60: q=0 (ena=0 no cambia)

   		 -- t=80: cuenta
    		ena_t <= '1';
    		wait for 120 ns;     -- flancos 100: q=1, 140: q=0, 180: q=1
                         
		-- cy=1 en 100-140 y en 180-200 (q=1 y ena=1)

    		-- t=200: ena=0 con q=1
    		ena_t <= '0';
    		wait for 80 ns;      -- flancos 220, 260: q sigue en 1, cy=0

    		-- t=280: reset con ena=0 y q=1

		rst_t <= '1';
    		wait for 80 ns;      -- flanco 300: q=0 (si no hubiera reset, mantendría 1)
		
    		-- t=360: reset con ena=1 y q=0
    		ena_t <= '1';
    		wait for 80 ns;      -- flancos 380, 420: q sigue en 0
                        	     -- (sin reset hubiera alternado a 1)

    		-- t=440: suelto el reset, vuelve a contar
    		rst_t <= '0';
    		wait for 120 ns;     -- flancos 460: q=1, 500: q=0, 540: q=1

    				     -- t=560: reset con q=1 y ena=1
    		rst_t <= '1';
   		wait for 80 ns;      -- cy cae a 0 inmediatamente en 560 (combinacional)
                    		     -- q cae a 0 recién en el flanco 580 (sincrónico)

    		wait;                -- fin
	end process;
end;
		 