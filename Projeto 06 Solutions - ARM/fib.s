		mov		r0, #10
		mov		r5, r0
		mov		r3, #1
		mov		r4, #1
		
		cmp		r5, #0
		beq		ehUm
		cmp		r5, #1
		beq		ehUm
		
loop		sub		r5,r5,#1
		add		r1,r4,r3
		mov		r3, r4
		mov		r4, r1
		
		cmp		r5, #1
		bgt		loop
		bal		fim
		
ehUm		mov		r1, #1
		bal		fim
fim
		mov		r3,#0
		mov		r4,#0
		mov		r5,#0
