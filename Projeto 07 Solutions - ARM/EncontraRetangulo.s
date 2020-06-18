				;		Parâmetros de EncontraRetangulo:
				;		- vetorPontos = [x0, y0, x1, y1, ...]
				;		- tamN (tamanho do vetor)
				;		Registradores de Retorno de EncontrRetangulo:
				;		- Ponto inferior esquedo (r0,r1)
				;		- Ponto superior direito (r2,r3)
				
vetorPontos		DCD		1,6,2,2,2,4,4,8,-3,-4,-2,32,88,88
tam				EQU		7
				
Inicio
				ADR		r0, vetorPontos
				MOV		r1, #tam
				
				BL		EncontraRetangulo
				END
				
EncontraRetangulo
				;		r0 e r1 representam um dos pontos vermelhos da borda
				;		Seja o Inferior Esquerdo ou o Superior Direito
				;		r2	- X atual
				;		r3	- Y atual
				
				;		- Empilha o que estiver armazenado nos registradores r4-r10
				;		- r4 eh uma copia do vetor em R0 inicialmente
				;		- r5 recebe o tamanho real do vetor, pois como tamN eh o
				;		- numero de pontos, logo 2*tamN
				STMFD	SP, {r4-r10}
				MOV		r4, r0
				ADD		r5, r1, r1
				
				;		Primeiro Valor X do vetor salvo em r2
				;		Primeiro Valor Y do vetor salvo em r3
				LDR		r2, [r4]
				LDR		r3, [r4, #4]!
				
				;		r6	- X inferior
				;		r7	- Y inferior
				;		Formam ponto inferior ao primeiro ponto (X,Y) do vetor
				;		Ponto vermelho inferior esquerdo
				;		r8	- X superior
				;		r9	- Y superior
				;		Formam ponto superior ao primeiro ponto (X,Y) do vetor
				;		Ponto vermelho superior direito
				SUB		r6, r2, #1
				SUB		r7, r3, #1
				ADD		r8, r2, #1
				ADD		r9, r3, #1
				
				
LOOP				ADD		r4, r4, #4
				SUBS		r5, r5, #2
				BEQ		FimRetangulo
				
				LDR		r2, [r4]
				LDR		r3, [r4, #4]!
				
				;		Ajuste inicial de borda inferior esquerda
				MOV		r0, r6
				MOV		r1, r7
				
				;		Armazenando LR principal em R10 antes de chamar
				;		Ajuste Inferior Esquerdo
				MOV		r10,	LR
				BL		AjustaBordaInfEsq
				
				;		Devolvendo para LR o valor que foi armazenado
				;		antes do Ajuste Inferior Esquerdo
				MOV		LR, r10
				
				;		- r6 e r7 recebem X,Y da nova posicao do ponto
				;		- inferior esquerdo
				MOV		r6, r0
				MOV		r7, r1
				
				;		Ajuste de borda superior direita
				MOV		r0, r8
				MOV		r1, r9
				
				;		Armazenando LR principal em r1 antes de chamar
				;		Ajuste Superior Direito
				MOV		r10,	LR
				BL		AjustaBordaSupDir
				
				;		Devolvendo para LR o valor que foi armazenado
				;		antes do Ajuste Superior Direito
				MOV		LR,	r10
				
				MOV		r8, r0
				MOV		r9, r1
				
				;		Apos os ajustes para um primeiro ponto (X,Y) do vetor
				;		Passamos para a proxima iteracao
				BAL		LOOP
				
				
FimRetangulo
				;		Passando para os registradores r0-r3 como convencionado,
				;		o retorno de Encontra Retangulo
				MOV		r0, r6
				MOV		r1, r7
				MOV		r2, r8
				MOV		r3, r9
				
				;		Desempilhando os valores iniciais de r4-r10
				LDMFD	SP, {r4-r10}
				;		Finaliza funcao EncontraRetangulo
				MOV		PC, LR
				
				
AjustaBordaInfEsq
				CMP		r2, r0 ; X_Atual - X_Inferior_Esq
				MOVLE	r0, r2
				
				CMP		r3, r1 ; Y_Atual - Y_Inferior_Esq
				MOVLE	r1, r3
				
				;		Garante que o ponto da Borda Inferior Esquerda fique sempre
				;		mais a esquerda que o ponto no plano, garantindo a condicao
				;		de que nenhum ponto do vetor pode ficar na borda
				SUBLE	r0, r0, #1
				SUBLE	r1, r1, #1
				
				;		Finaliza funcao AjustaBordaInfEsq
				MOV		PC, LR
				
				
AjustaBordaSupDir
				CMP		r2, r0 ; X_Atual - X_Superior_Dir
				MOVGE	r0, r2
				
				CMP		r3, r1 ; Y_Atual - Y_Superior_Dir
				MOVGE	r1, r3
				
				;		Garante que o ponto da Borda Superior Direita fique sempre
				;		mais a direita que o ponto no plano, garantindo a condicao
				;		de que nenhum ponto do vetor pode ficar na borda
				ADDGE	r0, r0, #1
				ADDGE	r1, r1, #1
				
				;		Finaliza funcao AjustaBordaSupDir
				MOV		PC, LR
