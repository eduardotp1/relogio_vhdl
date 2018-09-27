-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- Generated by Quartus Prime Version 18.0.0 Build 614 04/24/2018 SJ Lite Edition
-- Created on Wed Sep 26 21:31:10 2018

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SM1 IS
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC := '0';
        vaiNada : IN STD_LOGIC := '0';
        proximo : IN STD_LOGIC := '0';
        Z : IN STD_LOGIC := '0';
        selectConstante : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        selectTempo : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        carregaSaida : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        resetReg : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        selectFuncaoULA : OUT STD_LOGIC
    );
END SM1;

ARCHITECTURE BEHAVIOR OF SM1 IS
    TYPE type_fstate IS (cus,mais_us,cds,mais_ds,cum,mais_um,cdm,mais_dm,cdh_2,cuh_4,cuh_9,mais_uh,mais_dh,nada, zerador);
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
    SIGNAL reg_selectConstante : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL reg_selectTempo : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL reg_carregaSaida : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";
    SIGNAL reg_resetReg : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";
    SIGNAL reg_selectFuncaoULA : STD_LOGIC := '0';
BEGIN
    PROCESS (clock,reg_fstate)
    BEGIN
        IF (clock='1' AND clock'event) THEN
            fstate <= reg_fstate;
        END IF;
    END PROCESS;

    PROCESS (fstate,reset,vaiNada,proximo,Z,reg_selectConstante,reg_selectTempo,reg_carregaSaida,reg_resetReg,reg_selectFuncaoULA)
    BEGIN
        IF (reset='1') THEN
            reg_fstate <= nada;
            reg_selectConstante <= "000";
            reg_selectTempo <= "000";
            reg_carregaSaida <= "000000";
            reg_resetReg <= "000000";
            reg_selectFuncaoULA <= '0';
            selectConstante <= "000";
            selectTempo <= "000";
            carregaSaida <= "000000";
            resetReg <= "000000";
            selectFuncaoULA <= '0';
        ELSE
            reg_selectConstante <= "000";
            reg_selectTempo <= "000";
            reg_carregaSaida <= "000000";
            reg_resetReg <= "000000";
            reg_selectFuncaoULA <= '0';
            selectConstante <= "000";
            selectTempo <= "000";
            carregaSaida <= "000000";
            resetReg <= "000000";
            selectFuncaoULA <= '0';
            CASE fstate IS
                WHEN cus =>
                    IF (NOT((Z = '1'))) THEN
                        reg_fstate <= mais_us;
                    ELSIF ((Z = '1')) THEN
                        reg_fstate <= cds;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= cus;
                    END IF;

                    reg_selectFuncaoULA <= '1';

                    reg_selectConstante <= "100";

                    reg_carregaSaida <= "000000";

                    reg_resetReg <= "000000";

                    reg_selectTempo <= "000";
                WHEN mais_us =>
                    IF ((vaiNada = '1')) THEN
                        reg_fstate <= nada;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= mais_us;
                    END IF;

                    reg_selectFuncaoULA <= '0';

                    reg_selectConstante <= "000";

                    reg_carregaSaida <= "000001";

                    reg_resetReg <= "000000";

                    reg_selectTempo <= "000";
                WHEN cds =>
                    IF (NOT((Z = '1'))) THEN
                        reg_fstate <= mais_ds;
                    ELSIF ((Z = '1')) THEN
                        reg_fstate <= cum;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= cds;
                    END IF;

                    reg_selectFuncaoULA <= '1';

                    reg_selectConstante <= "011";

                    reg_carregaSaida <= "000000";

                    reg_resetReg <= "000000";

                    reg_selectTempo <= "001";
                WHEN mais_ds =>
                    IF ((vaiNada = '1')) THEN
                        reg_fstate <= nada;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= mais_ds;
                    END IF;

                    reg_selectFuncaoULA <= '0';

                    reg_selectConstante <= "000";

                    reg_carregaSaida <= "000010";

                    reg_resetReg <= "000001";

                    reg_selectTempo <= "001";
                WHEN cum =>
                    IF (NOT((Z = '1'))) THEN
                        reg_fstate <= mais_um;
                    ELSIF ((Z = '1')) THEN
                        reg_fstate <= cdm;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= cum;
                    END IF;

                    reg_selectFuncaoULA <= '1';

                    reg_selectConstante <= "100";

                    reg_carregaSaida <= "000000";

                    reg_resetReg <= "000000";

                    reg_selectTempo <= "010";
                WHEN mais_um =>
                    IF ((vaiNada = '1')) THEN
                        reg_fstate <= nada;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= mais_um;
                    END IF;

                    reg_selectFuncaoULA <= '0';

                    reg_selectConstante <= "000";

                    reg_carregaSaida <= "000100";

                    reg_resetReg <= "000011";

                    reg_selectTempo <= "010";
                WHEN cdm =>
                    IF (NOT((Z = '1'))) THEN
                        reg_fstate <= mais_dm;
                    ELSIF ((Z = '1')) THEN
                        reg_fstate <= cdh_2;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= cdm;
                    END IF;

                    reg_selectFuncaoULA <= '1';

                    reg_selectConstante <= "011";

                    reg_carregaSaida <= "000000";

                    reg_resetReg <= "000000";

                    reg_selectTempo <= "011";
                WHEN mais_dm =>
                    IF ((vaiNada = '1')) THEN
                        reg_fstate <= nada;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= mais_dm;
                    END IF;

                    reg_selectFuncaoULA <= '0';

                    reg_selectConstante <= "000";

                    reg_carregaSaida <= "001000";

                    reg_resetReg <= "000111";

                    reg_selectTempo <= "011";
                WHEN cdh_2 =>
                    IF (NOT((Z = '1'))) THEN
                        reg_fstate <= cuh_9;
                    ELSIF ((Z = '1')) THEN
                        reg_fstate <= cuh_4;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= cdh_2;
                    END IF;

                    reg_selectFuncaoULA <= '1';

                    reg_selectConstante <= "001";

                    reg_carregaSaida <= "000000";

                    reg_resetReg <= "000000";

                    reg_selectTempo <= "101";
                WHEN cuh_4 =>
                    IF (NOT((Z = '1'))) THEN
                        reg_fstate <= mais_uh;
                    -- Inserting 'else' block to prevent latch inference
						  ELSIF ((Z='1')) THEN
							reg_fstate <= zerador;
                    ELSE
                        reg_fstate <= cuh_4;
                    END IF;

                    reg_selectFuncaoULA <= '1';

                    reg_selectConstante <= "010";

                    reg_carregaSaida <= "000000";

                    reg_resetReg <= "000000";

                    reg_selectTempo <= "100";
                WHEN cuh_9 =>
                    IF ((Z = '1')) THEN
                        reg_fstate <= mais_dh;
                    ELSIF (NOT((Z = '1'))) THEN
                        reg_fstate <= mais_uh;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= cuh_9;
                    END IF;

                    reg_selectFuncaoULA <= '1';

                    reg_selectConstante <= "100";

                    reg_carregaSaida <= "000000";

                    reg_resetReg <= "000000";

                    reg_selectTempo <= "100";
                WHEN mais_uh =>
                    IF ((vaiNada = '1')) THEN
                        reg_fstate <= nada;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= mais_uh;
                    END IF;

                    reg_selectFuncaoULA <= '0';

                    reg_selectConstante <= "000";

                    reg_carregaSaida <= "010000";

                    reg_resetReg <= "001111";

                    reg_selectTempo <= "100";
                WHEN mais_dh =>
                    IF ((vaiNada = '1')) THEN
                        reg_fstate <= nada;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= mais_dh;
                    END IF;

                    reg_selectFuncaoULA <= '0';

                    reg_selectConstante <= "000";

                    reg_carregaSaida <= "100000";

                    reg_resetReg <= "011111";

                    reg_selectTempo <= "101";
                WHEN nada =>
                    IF ((proximo = '1')) THEN
                        reg_fstate <= cus;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= nada;
                    END IF;

                    reg_selectFuncaoULA <= '0';

                    reg_selectConstante <= "000";

                    reg_carregaSaida <= "000000";

                    reg_resetReg <= "000000";

                    reg_selectTempo <= "000";
					 WHEN zerador =>
						  reg_fstate <= nada;
						  
						  reg_selectFuncaoULA <= '0';

                    reg_selectConstante <= "000";

                    reg_carregaSaida <= "000000";

                    reg_resetReg <= "111111";

                    reg_selectTempo <= "000";
						  
                WHEN OTHERS => 
                    reg_selectConstante <= "XXX";
                    reg_selectTempo <= "XXX";
                    reg_carregaSaida <= "XXXXXX";
                    reg_resetReg <= "XXXXXX";
                    reg_selectFuncaoULA <= 'X';
                    report "Reach undefined state";
            END CASE;
            selectConstante <= reg_selectConstante;
            selectTempo <= reg_selectTempo;
            carregaSaida <= reg_carregaSaida;
            resetReg <= reg_resetReg;
            selectFuncaoULA <= reg_selectFuncaoULA;
        END IF;
    END PROCESS;
END BEHAVIOR;
