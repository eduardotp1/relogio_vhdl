library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity relogio_forba is
	port (
		-- Entradas (placa)
		CLOCK_50 : in STD_LOGIC;
		KEY: in STD_LOGIC_VECTOR(3 DOWNTO 0);
		SW: in STD_LOGIC_VECTOR(17 DOWNTO 0);
		
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 downto 0)
	);
end entity;


architecture comportamento of relogio_forba is
	signal auxmodo_ajuste_seg, auxmodo_ajuste_min, auxmodo_ajuste_hora: std_logic;
	signal auxClock, auxclk_1seg : std_logic;
	signal auxSelectFuncaoULA: std_logic;
	signal auxSelectTempo:  std_logic_vector (2 downto 0);
	signal auxSelectConstante: std_logic_vector (2 downto 0);
	signal auxCarregaSaida: std_logic_vector(5 downto 0);
	signal auxResetReg, auxZerar: std_logic_vector(5 downto 0);
	signal auxZ: std_logic;
	signal resetEstado : std_logic;
	signal proximoEstado : std_logic;
	signal auxvai_nada : std_logic;
	signal AUXUN_SEG, AUXDEZ_SEG, AUXUN_MIN, AUXDEZ_MIN, AUXUN_HORA, AUXDEZ_HORA: std_logic_vector(3 downto 0);
		
begin
	FD : entity work.fluxoDados
	port map (
		selectFuncaoULA => auxSelectFuncaoULA,
		selectTempo => auxSelectTempo,
		selectConstante => auxSelectConstante,
		carregaSaida => auxCarregaSaida,
		clk => CLOCK_50, rst => auxZerar, Z => auxZ,
		US_atual => AUXUN_SEG, DS_atual => AUXDEZ_SEG,
		UM_atual => AUXUN_MIN, DM_atual => AUXDEZ_MIN,
		UH_atual => AUXUN_HORA, DH_atual => AUXDEZ_HORA);
	
	CU : entity work.SM1
	port map (
		clock => CLOCK_50,
		reset => resetEstado,
		vaiNada => auxvai_nada,
		proximo => proximoEstado,
		Z => auxZ,
		selectConstante => auxSelectConstante,
		selectTempo => auxSelectTempo,
		carregaSaida => auxCarregaSaida,
		resetReg => auxResetReg,
		selectFuncaoULA => auxSelectFuncaoULA);

	display0 : entity work.conversorHex7seg
	Port map (saida7seg => HEX0, dadoHex => "0000", apaga => '1');
	
	display1 : entity work.conversorHex7seg
	Port map (saida7seg => HEX1, dadoHex => "0000", apaga => '1');
	
	-- Unidade de Segundo
	display2 : entity work.conversorHex7seg
	Port map (saida7seg => HEX2, dadoHex => AUXUN_SEG);
	
	-- Dezena de Segundo
	display3 : entity work.conversorHex7seg
	Port map (saida7seg => HEX3, dadoHex => AUXDEZ_SEG);
	
	-- Unidade de Minuto
	display4 : entity work.conversorHex7seg
	Port map (saida7seg => HEX4, dadoHex => AUXUN_MIN);

	-- Dezena de Minuto
	display5 : entity work.conversorHex7seg
	Port map (saida7seg => HEX5, dadoHex => AUXDEZ_MIN);

	-- Unidade de Hora
	display6 : entity work.conversorHex7seg
	Port map (saida7seg => HEX6, dadoHex => AUXUN_HORA);

	-- Dezena de Hora
	display7 : entity work.conversorHex7seg
	Port map (saida7seg => HEX7, dadoHex => AUXDEZ_HORA);
	
	--Clock de 1 seg
	clock_1seg: entity work.clock_50_to_1s
   port map (clk_50 => CLOCK_50, clk_1s => auxclk_1seg,
	modo_ajuste_seg => auxmodo_ajuste_seg, 
	modo_ajuste_min => auxmodo_ajuste_min,
	modo_ajuste_hora => auxmodo_ajuste_hora);
	
	detectorSub0: entity work.edgeDetector(bordaSubida) 
	port map (clk => CLOCK_50, entrada => auxclk_1seg, saida => proximoEstado);
	
	-- Switches da placa
	auxmodo_ajuste_hora <= SW(2);
	auxmodo_ajuste_min <= SW(1);
	auxmodo_ajuste_seg <= SW(0);

	-- Botoes da Placa
	resetEstado <= not(KEY(1)); --  Pressionando a tecla 1
	auxZerar <=  (not(KEY(0) & KEY(0) & KEY(0) & KEY(0) & KEY(0) & KEY(0))) or auxResetReg; --  Pressionando a tecla 0
	--  Pressionando a tecla 1, reinicia a maquina de estados para o estado inicial. Segurar trava o relogio;
	--  Pressionando a tecla 0, faz um hard reset em todos os registradores.
	
	auxClock <= CLOCK_50;
	auxvai_nada <= '1';

end architecture;