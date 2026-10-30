-- tb_ffd.vhd
entity tb_ffd is
end;

architecture sim of tb_ffd is

    signal ck  : bit := '0';
    signal rst : bit := '1';
    signal d   : bit := '0';
    signal q   : bit;

begin

    -- Dispositivo bajo prueba
    dut : entity work.ffd
        port map (
            clk => ck,
            rst => rst,
            d   => d,
            q   => q
        );

    -- Reloj: se invierte cada 20 ns (período de 40 ns, flancos ascendentes en 20, 60, 100...)
    ck <= not ck after 20 ns;

    -- Estímulos: cambian entre flancos para que se vea qué hace el reloj
    estimulos : process
    begin
        rst <= '1'; d <= '0';
        wait for 50 ns;           -- t = 50
        rst <= '0'; d <= '1';
        wait for 80 ns;           -- t = 130
        d <= '0';
        wait for 80 ns;           -- t = 210
        d <= '1';
        wait for 80 ns;           -- t = 290  (rst sube ENTRE dos flancos)
        rst <= '1';
        wait for 80 ns;           -- t = 370
        rst <= '0';
        wait for 80 ns;           -- t = 450
        wait;
    end process;

end;
