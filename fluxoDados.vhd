library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fluxoDados is
    port (
        selectFuncaoULA: in std_logic;
        selectTempo:  in std_logic_vector (2 downto 0);
        selectConstante:  in std_logic_vector (2 downto 0);
        carregaSaida: in std_logic_vector(5 downto 0);
		  rst: in std_logic_vector(5 downto 0);
		  clk:  in std_logic;
		  
		  -- Saidas para os displays de 7 segmentos
		  US_atual, DS_atual: out std_logic_vector(3 downto 0);
		  UM_atual, DM_atual: out std_logic_vector(3 downto 0);
		  UH_atual, DH_atual: out std_logic_vector(3 downto 0);
		  Z: out std_logic
   );
end entity;

architecture simples of fluxoDados is
	signal auxUS_atual, auxDS_atual: std_logic_vector(3 downto 0);
	signal auxUM_atual, auxDM_atual: std_logic_vector(3 downto 0);
	signal auxUH_atual, auxDH_atual: std_logic_vector(3 downto 0);
	signal auxZ: std_logic;
	
	constant um : std_logic_vector(3 downto 0) := "0001";
	constant dois : std_logic_vector(3 downto 0) := "0010";
	constant quatro : std_logic_vector(3 downto 0) := "0011";
	constant cinco : std_logic_vector(3 downto 0) := "0101";
	constant nove : std_logic_vector(3 downto 0) := "1001";
	
	signal saidaMuxTempo, saidaMuxConstante, saidaULA: std_logic_vector(3 downto 0);
	
begin
	muxTempo: entity work.mux6to1
		port map (unidade_s => auxUS_atual, dezena_s => auxDS_atual,
		unidade_m => auxUM_atual, dezena_m => auxDM_atual,
		unidade_h => auxUH_atual, dezena_h => auxDH_atual,
		sel => selectTempo, output => saidaMuxTempo);

	muxConstante: entity work.mux5to1
		port map (A => um, B => dois, C => quatro, D => cinco, E => nove,
		sel => selectConstante, q => saidaMuxConstante);
		
	ULA: entity work.ULA
		port map (A => saidaMuxTempo, B => saidaMuxConstante,
		Sel => '0' & selectFuncaoULA, C => saidaULA
	);

	un_segundo_reg: entity work.registradorGenerico 
						generic map (larguraDados => 4)
						port map (DIN => saidaULA, DOUT => auxUS_atual,
							ENABLE => carregaSaida(0), CLK => clk, RST => rst(0));
	dez_segundo_reg: entity work.registradorGenerico 
						generic map (larguraDados => 4)
						port map (DIN => saidaULA, DOUT => auxDS_atual,
							ENABLE => carregaSaida(1), CLK => clk, RST => rst(1));
	un_minuto_reg: entity work.registradorGenerico 
						generic map (larguraDados => 4)
						port map (DIN => saidaULA, DOUT => auxUM_atual,
							ENABLE => carregaSaida(2), CLK => clk, RST => rst(2));
	dez_minuto_reg: entity work.registradorGenerico 
						generic map (larguraDados => 4)
						port map (DIN => saidaULA, DOUT => auxDM_atual,
							ENABLE => carregaSaida(3), CLK => clk, RST => rst(3));
	un_hora_reg: entity work.registradorGenerico 
						generic map (larguraDados => 4)
						port map (DIN => saidaULA, DOUT => auxUH_atual,
							ENABLE => carregaSaida(4), CLK => clk, RST => rst(4));
	dez_hora_reg: entity work.registradorGenerico 
						generic map (larguraDados => 4)
						port map (DIN => saidaULA, DOUT => auxDH_atual,
							ENABLE => carregaSaida(5), CLK => clk, RST => rst(5));
							
--	auxUS_atual <= US_atual;
--	auxDS_atual <= DS_atual;
--	auxUM_atual <= UM_atual;
--	auxDM_atual <= DM_atual;
--	auxUH_atual <= UH_atual;
--	auxDH_atual <= DH_atual;
	US_atual <= auxUS_atual;
	DS_atual <= auxDS_atual;
	UM_atual <= auxUM_atual;
	DM_atual <= auxDM_atual;
	UH_atual <= auxUH_atual;
	DH_atual <= auxDH_atual;
	
	auxZ <= NOT(saidaULA(3) OR saidaULA(2) OR saidaULA(1) OR saidaULA(0));
	Z <= auxZ;
	
end architecture;