// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.


@R2    // Define em qual memoria estou mexendo e cria um objeto na memoria caso nao exista
M = 0  // Estou Zerando registrador de saida, ou seja, RAM[2] = 0

@i     // Estou definindo um contador para o LOOP (a partir de @, as operações se referem ao objeto indicado, caso, i)
M = 0  // Zerando o contador do LOOP

(LOOP)
    @i
    M=M+1   // Salvando na memoria M de i Incremento de 1
    D=M     // Em uma memoria de Dado, colocando o valor salvo de i
    @R0     // Agora alterando RAM[0]
    D=D-M   // Dado aqui é 1 e dele está sendo Decrementado o valor d R0 que é o numero de iterações Ex: 1 - 5 iterações 

    @END
    D; JGT  // Se D (que inicialmente vale 1 - n iterações) for maior que 0, Finaliza LOOP
            // Suponha que R0 (numero iterações = 5), entao para cada loop teremos 1 - 5, 2 - 5, 3 - 5, 4 - 5, 5 - 5, 6 - 5 (END)
    @R1   
    D=M     // Pegando o valor armazenado em R1 e colocando em uma memória D
    @R2
    M=M+D   // Acrescentando valor da memoria D em M de R2, ou seja, o valor de R1 em R2

    @LOOP   // Define variavel de loop
    0;JMP   // Executa Jump para inicio LOOP
(END)
    @END
    0;JMP
