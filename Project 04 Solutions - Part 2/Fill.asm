// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(INI)
    @8192	 // 8192 eh o numero de blocos de 16 pixels da tela
    D=A
    @i                   
    M=D      // armazenamos os i blocos, isto eh, i = 8192  

(LOOP)
    @i
    M=M-1    // i = i - 1
    D=M    
    @INI
    D;JLT    // Para cada bloco de 16 pixels , do final da tela para o começo, vamos pinar a tela      

    @KBD
    D = M
    @PRETO
    D; JGT   // Se alguma tecla esta pressionada , KBD sera 1 e SCREEN deve ficar preta, entao fazemos um jump para PRETO 

    @SCREEN
    D=A                
    @i        
    A=D+M  
    M=0
    @LOOP
    0;JMP    // Caso contrario, apenas deixamos a tela em branco

    (PRETO)
    @SCREEN            
    D=A
    @i
    A=D+M              
    M=-1               
    @LOOP
    0; JMP   // Para pintar de preto os 16 pixels, fazemos M=-1 pois a nivel de processador, M=-1 é 1111111111111111

(END)
@END
0; JMP