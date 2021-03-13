.code

BuildMatrix	Proc
;	*****************************
;	RGB Matrix, not needed here
;	*****************************
;		mov esi,hMatrix
;		mov x,0
;		mov y,0
;		mov R,255
;		mov G,0
;		mov B,0
;		mov R1,0
;		mov G1,0
;		mov B1,0
;		.repeat
;			.repeat
;				xor eax,eax
;				mov ecx,B
;				mov edx,B1
;				sub ecx,edx
;				mov ah,cl
;				rol eax,8
;				mov ecx,G
;				mov edx,G1
;				sub ecx,edx
;				mov ah,cl
;				mov ecx,R
;				mov edx,R1
;				add ecx,edx
;				mov al,cl
;				mov [esi],eax
;				add esi,4
;				invoke SetPixel,wDC,x,y,eax
;				inc G
;				.if G >= 255
;					inc G1
;				.endif
;				inc x
;			.until x == EFFECTS_WIDTH
;			mov x,0
;			mov G,0
;			mov G1,0
;			dec R
;			inc B
;				.if B >= 255
;					inc B1
;				.endif
;				.if R <= 0
;					inc R1
;				.endif
;			inc y
;		.until y == EFFECTS_HEIGHT
;	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
;
;	*****************************************************
;		HSV Matrix here, but only [344;1] vector needed
;		kinda lame implementation, but hey, it works :p
;	*****************************************************
	mov esi,hMatrix
	mov x,0
;	mov y,0
;	.repeat
		mov R,255
		mov G,0
		mov B,0
		.repeat
			xor eax,eax
			mov ecx,B
			mov ah,cl
			rol eax,8
			mov ecx,G
			mov ah,cl
			mov ecx,R
			mov al,cl
			mov [esi],eax
			add esi,4
			.if B1 != 1 && R >= 255 && B <= 0
				mov R,255
				mov B,0
				add G,5
				.if G >= 255
					mov G,255
					mov B1,1
				.endif
			.elseif B2 != 1 && G >= 255 && B <= 0
				mov G,255
				mov B,0
				sub R,5
				.if R == -1 ||  R == -2 ||  R == -3 || R <= 0
					mov R,0
					mov B2,1
				.endif
			.elseif B3 != 1 && R <= 0 && G >= 255
				mov R,0
				mov G,255
				add B,5
				.if B >= 255
					mov B,255
					mov B3,1
				.endif
			.elseif B4 != 1 && B >= 255 && R <= 0
				mov B,255
				mov R,0
				sub G,5
				.if  G == -1 ||  R == -2 ||  R == -3 ||  G <= 0
					mov G,0
					mov B4,1
				.endif
			.elseif B5 != 1 && G <= 0  && B >= 255
				mov G,0
				mov B,255
				add R,5
				.if R >= 255
					mov R,255
					mov B5,1
				.endif
			.elseif B6 != 1 && R >= 255 && G <= 0
				mov R,255
				mov G,0
				sub B,5
				.if  B == -1 ||  R == -2 ||  R == -3 ||  B <= 0
					mov B,0
					mov B6,1
				.endif
			.endif
			inc x
		.until x == EFFECTS_WIDTH
		mov x,0
		mov B1,0
		mov B2,0
		mov B3,0
		mov B4,0
		mov B5,0
		mov B6,0
;		inc y
;	.until y == EFFECTS_HEIGHT
;	mov y,0
	Ret
BuildMatrix endp