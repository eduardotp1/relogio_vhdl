# Relogio_Forba

Projeto de um relógio para FPGA feito em VHDL.

## Sumário

- [Grupo](#grupo)
- [Modo de Usar](#modo-de-usar)
- [Fluxo de Dados e TopLevel](#fluxo-de-dados-e-toplevel)
- [Máquina de Estados](#maquina-de-estados)
- [Dificuldades do Projeto](#dificuldades-do-projeto)

## Grupo

- Eduardo Tirta
- Filipe Borba
- Gabriel Moreira
- Guilherme Graicer

## Modo de Usar
Para utilizar o relógio, basta abrir o arquivo relogio_forba.qar em seu Intel Quartus Software e compilar o código. Feito isso, é necessário mandar o código para a placa através da interface Programmer do Quartus.

O relógio iniciará em 00:00:00, cabendo ao usuário ajustá-lo para o horário correto. Para tanto, são utilizadas as chaves SW(0) para ajuste de segundo, SW(1) para ajuste de minuto e SW(2) para ajuste de hora. Essas chaves estão indicadas na figura abaixo. Além disso, caso o usuário queira parar o relógio, basta segurar o KEY(1). Caso queira resetar o relógio, basta apertar o KEY(0).

![FPGA](https://i.imgur.com/WgNEGB2.jpg)
Figura 1 - FPGA com indicação dos botões.

## Fluxo de Dados e TopLevel
O código é dividido basicamente em três partes: Fluxo de Dados, Unidade de Controle e um Top-Level.
Nosso fluxo de dados é responsável por realizar as operações de comparação e soma de horário, além de guardar os valores em registradores para serem mostrados no Top-Level. Esse fluxo de dados é controlado pela Unidade de Controle, pois é ela que indica qual comparação deve ser feita e qual horário deve ser somado. Essas operações são realizadas através de uma ULA dentro do fluxo de dados, que recebe entradas de dois Multiplexadores: um deles com o horário atual e o outro com as constantes de comparação.
Por fim, o Top-Level é responsável por juntar tanto o fluxo de dados quanto a unidade de controle, porém com o adicional de controlar os botões da placa e os displays de 7 segmentos.
Nossa unidade de controle será explicada na próxima sessão.

![Fluxo de Dados](https://i.imgur.com/3U9ED5J.jpg)
Figura 2 - Fluxo de Dados do nosso projeto.

## Máquina de Estados
Nossa Unidade de Controle é dada por uma Máquina de Estados, representada na Figura 3.
A nossa máquina se inicia no Nada, onde espera o primeiro clock mudar o sinal Proximo para 1, com isso, ele vai para o estado cus, que é responsável por comparar a unidade de segundos por 9, caso o resultado desta comparação(subtração do valor do registrador por 9) resultar em 0, alterando o sinal Z para 1, ele irá comparar a dezena de segundo por 5, caso contrário, vai para o estado mais_us que soma um no registrador da unidade de segundo e muda o sinal proximo para 0 e vai para o estado Nada novamente. Depois ele segue a máquina de estado por completo. Mudando um pouco o raciocínio ao chegar na comparação das horas, neste caso, verificamos a dezena da hora se for 2, assim, evitamos um problema que iria ocorrer caso comparacemos a unidade da hora por 3 antes de somar a dezena da hora......................
![Maquina de Estados](https://i.imgur.com/KPPrZpd.jpg)
Figura 3 - Máquina de Estados do nosso projeto.

## Dificuldades do Projeto
A primeira dificuldade surgiu na criação da própria máquina de estados. A primeira versão dela foi feito com base em um rascunho que tínhamos feito em aula, porém ela não satisfazia todas as condições das casas decimais do relógio. Por exemplo, havia a mudança da dezena da hora para o próximo estado tanto quanto o conjunto dezena-unidade da hora era 23 como 19, e isso causou uma certa dificuldade.

A segunda dificuldade que enfrentamos foi um pouco mais técnica uma vez que não conseguiamos transferir o código do Quartus para a placa Cyclone. A transferência por algum motivo não funcionava no sistema operacional Linux, por isso optamos por continuar o desenvolvimento do projeto no Windows.

A terceira e principal dificuldade foi um problema no sinal reset que estava saindo da máquina de estado no estado errado. Na nossa lógica, resetamos a casa decimal abaixo quando era feita a comparação na ALU com uma constante escolhida e o Z da saída resultava em 1. Mas o que deveria ser feito seria resetar a casa decimal abaixo quando aumentássemos a de cima (se somamos um na dezena de segundo, a unidade de segundo deveria voltar a ser 0 por exemplo).
