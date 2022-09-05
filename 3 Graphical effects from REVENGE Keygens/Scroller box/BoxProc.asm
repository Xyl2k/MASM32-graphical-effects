
comment */

	scroller box ripped from xl.project.2.0.keygen-rev.zip
	similar to xfrog.3.5.051204.keygen-tsrh.zip (Funbit's
	version), but REV's keygen is LP's version.
	
	thx 2 sama for help.
	
	ripped by ur bro r0ger.
	
	p.s.: the black bg is actually a bug in windows 10,
	but in windows 7 shows transparent and works fine.
	
*/


SkrBoxInit		PROTO	:DWORD
DrawProc		PROTO
Rndproc			PROTO	:DWORD
StaticProc		PROTO	:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

.const
xPos		equ	235
yPos		equ 26
BoxWidth	equ 208
BoxHeight	equ	70

TextHeight	equ 10

LineColor	equ 0FFFFFFh

.data 
BoxDC 	 	 dd 0
hdcSrc 		 dd 0
BoxBmp 		 dd 0
ThreadId 	 dd 0
BoxThread 	 dd 0
x 			 dd 0
y 			 dd 0
Infofont 	 dd 0
NoiseAmount  dd 0
hdc 		 dd 0
SkrFont		LOGFONT	<8,6,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'terminal'>
		; original --> <0FFFFFFF6h,0,0,0,320h,0,0,0,0,0,0,0,0,'Verdana'>

InfoText 	db "PERYFERiAH tEAM PrEsEnT",13,13
		db "another scroller box ripped from",13
		db "xl.project.2.0.keygen-rev.zip",0FFh,13
		db "ripped by your bro",13
		db "r0ger ^ PRF",0FFh,13,13,13,13,13,13,13,13
		db "this scroller box is similar to",13
		db "one of TSRh's keygens which is",13
		db "xfrog.3.5.051204.keygen-tsrh.zip",13
		db "but the initial version of this",13
		db "is coded by Funbit, but improved",13
		db "by lord_Phoenix^ReVeNgE.",13,13,13,13,13,13,13,13
		db "feel free 2 use this in ur main",13
		db "keygen/patch forms in masm32.",13,13
		db "cH33rZ 4 NoW !   :D",0FFh,0

Haah db "am0gus",0 ; <-- there was a string around which says "<-.*!@LP!REV@!*.->",
					; and i'm not sure what was that for. perhaps his signature??

RndValue dd 0BC614Eh

.code
SkrBoxInit proc uses edi esi ebx AnimHandle:HWND

		invoke GetWindowDC,AnimHandle
		mov BoxDC, eax
		invoke GetDC,0
		invoke CreateCompatibleDC,eax	
		mov hdcSrc, eax
		invoke CreateCompatibleBitmap,BoxDC,BoxWidth,BoxHeight		
		mov BoxBmp, eax
		invoke SelectObject,hdcSrc,eax
		invoke CreateFontIndirect,addr SkrFont
		mov Infofont, eax
		invoke CreateThread,0,0,offset DrawProc,0,0,offset ThreadId
		mov BoxThread, eax
		invoke SetThreadPriority,BoxThread,THREAD_PRIORITY_ABOVE_NORMAL
		ret
SkrBoxInit endp

DrawProc proc near
LOCAL SkrRekt:RECT
LOCAL var_39:BYTE
LOCAL _y:DWORD
LOCAL w:DWORD
LOCAL _h:DWORD
LOCAL bottom:DWORD
LOCAL right:DWORD
LOCAL top:DWORD
LOCAL left:DWORD
LOCAL var_C:DWORD
LOCAL var_8:DWORD
LOCAL var_4:DWORD
LOCAL lpThreadParameter:DWORD

@@:  mov NoiseAmount, 4Fh
  
        invoke CreatePen,0,1,LineColor
        invoke SelectObject,hdcSrc,eax
        invoke CreateSolidBrush,LineColor
        invoke SelectObject,hdcSrc,eax
        invoke BitBlt,hdcSrc,0,0,BoxWidth,BoxHeight,BoxDC,xPos,yPos,SRCCOPY
        xor eax, eax
        mov eax, BoxWidth
        shr eax, 1
        mov ebx, BoxHeight
        shr ebx, 1
        sub eax, 3
        mov left, eax
        mov top, ebx
        inc top
        add eax, 6
        mov right, eax
        mov bottom, ebx
        dec bottom
        mov _h, 0
        mov w, 6
loc_4012DD: 			
		invoke Rectangle,hdcSrc,left,top,right,bottom
		invoke StaticProc,hdcSrc,left,top,w,_h
		invoke AlphaBlend,BoxDC,xPos,yPos,BoxWidth,BoxHeight,hdcSrc,0,0,BoxWidth,BoxHeight,960000h
		invoke AlphaBlend,BoxDC,xPos,yPos,BoxWidth,BoxHeight,hdcSrc,0,0,BoxWidth,BoxHeight,960000h
		invoke BitBlt,BoxDC,xPos,yPos,BoxWidth,BoxHeight,hdcSrc,0,0,SRCCOPY
		cmp left, 0
		jz loc_4013A0
		invoke Sleep,5
		jmp loc_4013A7

loc_4013A0: 			; dwMilliseconds
		invoke Sleep,5

loc_4013A7:
		cmp left, 0
		jz loc_4013BE
		dec left
		inc right
		add w, 2
		jmp loc_4012DD
		jmp loc_4013D6

loc_4013BE:
		cmp top, 0
		jz loc_4013D44
		dec top
		inc bottom
		inc _h
		jmp loc_4012DD
		jmp loc_4013D6

loc_4013D44:
		jmp $+2

loc_4013D6:
		mov [SkrRekt.left], 0
		mov [SkrRekt.top], 0
		mov eax, BoxWidth
		mov [SkrRekt.right], eax
		mov eax, BoxHeight
		mov [SkrRekt.bottom], eax
		;add NoiseAmount, 0Ah
		mov var_8, 8Ch
		push var_8
		pop var_4
		mov var_C, BoxHeight
		neg var_C
		invoke SetTextAlign,hdcSrc,TA_CENTER
		
loc_401420: 			
		invoke Rectangle,hdcSrc,left,top,right,bottom
		invoke StaticProc,hdcSrc,left,top,w,_h
		invoke SetBkMode,hdcSrc,TRANSPARENT
		invoke SelectObject,hdcSrc,Infofont
		
		mov eax, var_4
		mov _y, eax
		mov esi, offset InfoText
		mov edi, esi
		mov ebx, esi

loc_40147B: 			
		invoke SetTextColor,hdcSrc,White
		mov var_39, 0
		cmp byte ptr [esi], 0Dh
		jz loc_4014B8
		cmp byte ptr [esi], 0FFh
		jz loc_4014A0
		cmp byte ptr [esi], 0
		jnz loc_4014F0
		jmp loc_4014B8

loc_4014A0:
		invoke SetTextColor,hdcSrc,00FFAC46h

loc_4014B8:
		mov cl, [esi]
		push ecx
		mov byte ptr [esi], 0
		invoke lstrlen,edi
		
		push ebx
		mov ebx, BoxWidth
		shr ebx, 1
		
		push 0 	; lpDx
		push eax 	; c
		push edi 	; lpString
		lea eax, r3kt
		push eax 	; lprect
		push 4 	; options
		push _y ; y
		push ebx 	; x
		push hdcSrc 	; hdc
		call ExtTextOutA
		
		pop ebx
		add _y, TextHeight
		pop ecx
		mov edi, esi
		inc edi
		mov [esi], cl
loc_4014F0:
		lodsb
		cmp var_39, 0
		jz loc_4014F8
		lodsd

loc_4014F8:
		mov ebx, edi
		cmp ebx, offset Haah
		jnz loc_40147B
        invoke PatBlt,hdcSrc,0,0,BoxWidth,1,PATCOPY
        invoke PatBlt,hdcSrc,0,BoxHeight-1,BoxWidth,1,PATCOPY
		dec var_4
		mov eax, _y
		add eax, 0Fh
		mov ebx, 0FFFFFFF1h
		cmp eax, ebx
		jl loc_401594
		jmp $+2

loc_401550: 			
		invoke BitBlt,BoxDC,xPos,yPos,BoxWidth,BoxHeight,hdcSrc,0,0,SRCCOPY
		invoke Sleep,12
		cmp NoiseAmount, 46h
		je loc_40158F
	;	add NoiseAmount, 1

loc_40158F:
		jmp loc_401420

loc_401594: 			
		invoke Rectangle,hdcSrc,left,top,right,bottom
		invoke StaticProc,hdcSrc,left,top,w,_h
		invoke BitBlt,BoxDC,xPos,yPos,BoxWidth,BoxHeight,hdcSrc,0,0,SRCCOPY
		invoke Sleep,12
		;cmp NoiseAmount, 30h
		jz loc_40168A
	;	add NoiseAmount, 1
		jmp loc_4013D6

loc_40168A:
		jmp loc_4013D6
DrawProc endp

StaticProc proc uses edi esi ebx _hdc:DWORD, _x:DWORD, _y_:DWORD, _w_:DWORD, _h_:DWORD 

		cmp [_h_], 3
		jb locret_40123D
		inc [_x]
		inc [_y_]
		mov esi,[_x]
		mov edi,[_y_]
		cmp [_h_], 1
		jz loc_4011D5
		shl [_h_], 1
		sub [_h_], 5
		jmp loc_4011D9

loc_4011D5:
		sub [_h_], 2

loc_4011D9:
		sub [_w_], 2
		xor eax, eax
		push eax
		invoke PatBlt,_hdc,_x,_y_,_w_,_h_,BLACKNESS

loc_4011F6:
		mov x, esi
		mov y, edi
		
		invoke Rndproc,NoiseAmount
		
		add al, 9
		mov ah, al
		shl eax, 8
		mov al, ah
		invoke SetPixel,_hdc,x,y,eax
		
		inc esi
		cmp esi, [_w_]
		jbe loc_4011F6
		mov esi, [_x]
		inc edi
		pop eax
		inc eax
		push eax
		cmp eax, [_h_]
		jbe loc_4011F6

locret_40123D:
		
		ret
StaticProc endp

Rndproc proc uses edi esi ebx _div:dword

	mov eax, RndValue
	xor edx, edx
	mov ecx, 1F31Dh
	div ecx
	mov ecx, eax
	mov eax, 41A7h
	mul edx
	mov edx, ecx
	mov ecx, eax
	mov eax, 0B14h
	mul edx
	sub ecx, eax
	xor edx, edx
	mov eax, ecx
	mov RndValue, ecx
	div dword ptr[_div]
	mov eax, edx
	ret
	
Rndproc endp

CleanEf	proc

	invoke TerminateThread,BoxThread,0
	invoke DeleteObject,BoxBmp
	invoke DeleteDC,hdcSrc
	Ret
CleanEf EndP
