			mov		r0, #400
			mov		r10, #4
			str		r10, [r0]
			mov		r10, #3
			str		r10, [r0, #4]
			mov		r10, #2
			str		r10, [r0, #8]
			mov		r10, #5
			str		r10, [r0, #12]
			mov		r10, #1
			str		r10, [r0, #16]
			mov		r10, #6
			str		r10, [r0, #20]
			mov		r10, #7
			str		r10, [r0, #24]
			mov		r1, #7
			
			
			ldr		r2, [r0]
loop			cmp		r1, #0
			ble		fim
			
			ldr		r4, [r0]
			cmp		r4, r2
			blt		salvaMenor
			add		r0,r0,#4
			sub		r1,r1,#1
			bal		loop
			
salvaMenor	mov		r2, r4
			add		r0,r0,#4
			sub		r1,r1,#1
			bal		loop
fim
			
			
