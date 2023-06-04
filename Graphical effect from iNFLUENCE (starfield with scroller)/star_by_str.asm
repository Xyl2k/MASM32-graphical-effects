
comment */

	starfield effect with text scroller ripped from TeaM iNFLUENCE.
	
	initially coded by str , ripped by r0ger.
	
	included in tonz of releases made by str^iNF from oct-nov 2oo6:
	
	- Advanced.Net.Monitor.for.Classroom.Professional.v2.5.4.TeaM.iNFLUENCE.zip
	- MiLoPhoto.v2.3.TeaM.iNFLUENCE-keygen.zip
	- RSScrawler.v2.0.3.build.163.TeaM.iNFLUENCE-keygen.zip
	- 3D.Geometrical.Objects.TeaM.iNFLUENCE-keygen.zip
	- Advanced.eLearning.Builder.v3.5.9.TeaM.iNFLUENCE-keygen.zip
	- Apollo.DVD.Copy.v4.6.17.TeaM.iNFLUENCE-keygen.zip
	- Batch.Image.Resizer.v.2.81.TeaM.iNFLUENCE-keygen.zip
	- KLS.Backup.2006.Professional.v2.1.5.0.TeaM.iNFLUENCE-keygen.zip
	- Molecular.Structure.of.the.Substance.v2.4.TeaM.iNFLUENCE-keygen.zip
	- No1.DVD.Ripper.v4.3.TeaM.iNFLUENCE-keygen.zip (source rip)
	- Power.Video.Converter.v1.5.27.TeaM.iNFLUENCE-keygen.zip
	.... and literally many other releases.
	
	special thanx to BlueElvis for helping me unpack this keygen since
	the automatic unpackers i've been using to rip don't work with PEspin.
	
	fuck PEspin btw. :p

*/

tagSIZE STRUCT
        _cx   dd ?
        cy    dd ?
tagSIZE ENDS
        
.data
x 	dd 20
y 	dd 140
EfWeight dd 353
EfHeight dd 182

;----- variables for color shift -----
byte_409010 db 0FFh
byte_409011 db 0
byte_409012 db 0
byte_409013 db 80h
byte_409014 db 80h
byte_409015 db 10h
byte_409016 db 0F2h
byte_409017 db 0F1h
byte_409018 db 30h
;----- variables for color shift -----

EndPos 	dd 1DEh
ScrFont		LOGFONT <12,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'Terminal'>
ScrollerText db "                                             "
		db "PERYFERiAH kLAN PrOuDLy PrEsEnT a new graphical "
		db "effect from TeaM iNFLUENCE (ripped by r0ger using IDA Pro 6.8, coded by str)           "
		db "Greetz 2 GRUiA, MaryNello, Al0hA, B@TRyNU, r"
		db "0bica, PuMmy, s0r3l, sabYn, WeeGee, yMRAN, ShoGunu, QueenAntonia,"
		db " NoNNy, and many other PRF memberz and to BGSPA, DiSiRE, FEELiNNE"
		db "RS, RLTS, BTCR, CRUDE, LAXiTY, DVT, tSRh, FALLEN and many other t"
		db "eams who still keep the scene alive in 2o23 :)                   ",0
TxtLen	equ $-ScrollerText

dword_40916B dd 0
ccy 	dd 0
StarSpeed dd 5
byte_409177 db 0
hh 	dd 0
dword_409840 dd 0
dword_409848 dd 0
dword_40984C dd 0
hMem 		 dd 0
dword_409854 dd 0
hbr 	dd 0
psizl	tagSIZE <>
star_rc 	RECT <>
dword_40986C dd 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0

.data?
dword_409BAF dd ?
hScrFont	 dd ?

.code
StarfieldProc proc near lpThreadParameter:DWORD
LOCAL var_3E:BYTE
LOCAL var_3D:BYTE
LOCAL var_3C:BYTE
LOCAL hDC:DWORD
LOCAL var_34:DWORD
LOCAL var_30:DWORD
LOCAL var_2C:DWORD
LOCAL color:DWORD
LOCAL _y:DWORD
LOCAL _x:DWORD
LOCAL _h:DWORD
LOCAL var_10:DWORD
LOCAL var_C:DWORD
LOCAL hdc:DWORD
LOCAL hdcSrc:DWORD

		mov eax, EfWeight
		sub eax, x
		inc eax
		mov dword_40916B, eax
		mov eax, EfHeight
		sub eax, y
		inc eax
		mov ccy, eax
		push dword_409BAF
		pop [_x]
		invoke GetDC,xWnd
		mov [hdc], eax
		invoke CreateCompatibleBitmap,[hdc],dword_40916B,ccy
		mov [_h], eax
		invoke CreateCompatibleDC,[hdc]
		mov [var_C], eax
		invoke SelectObject,[var_C],[_h]
		invoke BitBlt,[var_C],0,0,dword_40916B,ccy,[hdc],x,y,SRCCOPY
		invoke CreateCompatibleDC,[var_C]
		mov [hdcSrc], eax
		invoke CreateCompatibleBitmap,[var_C],dword_40916B,ccy
		mov [var_10],eax
		invoke SelectObject,[hdcSrc],[var_10]
		mov al, byte_409015
		mov byte_409012, al
		mov al, byte_409014
		mov byte_409011, al
		mov al, byte_409013
		mov byte_409010, al
		mov al, byte_409018
		mov [var_3D], al
		mov [var_3E], 1
		mov al, byte_409017
		cmp al, [var_3D]
		jbe loc_401100
		mov [var_3D], al
		mov [var_3E], 2

loc_401100:
		mov al, byte_409016
		cmp al, [var_3D]
		jbe loc_401111
		mov [var_3D], al
		mov [var_3E], 3

loc_401111:
		xor eax, eax
		mov al, byte_409010
		shl eax, 8
		mov al, byte_409011
		shl eax, 8
		mov al, byte_409012
		mov [color], eax
		invoke SetTextColor,[hdcSrc],[color]
		invoke SetBkMode,[hdcSrc],TRANSPARENT
		invoke SelectObject,[hdcSrc],hh
		invoke CreateFontIndirect,offset ScrFont
		mov hScrFont,eax
		invoke SelectObject,[hdcSrc],hScrFont
		lea eax, [psizl]
		invoke GetTextExtentPoint32,[hdcSrc],offset ScrollerText,EndPos,eax
		invoke BitBlt,[hdcSrc],0,0,dword_40916B,ccy,[hdc],x,y,SRCCOPY
		mov [var_2C], 1
		mov [var_30], 0
		mov [_y], 1
		mov [var_34], 0
		mov star_rc.left, 0
		mov star_rc.top, 0
		push dword_40916B
		pop star_rc.right
		push ccy
		pop star_rc.bottom
		invoke CreateCompatibleDC,[hdc]
		mov [hDC], eax
		invoke CreateCompatibleBitmap,[hdc],dword_40916B,ccy
		mov dword ptr [var_3C], eax
		invoke SelectObject,[hDC],dword ptr [var_3C]

loc_401206:
		invoke FillRect,[hDC],offset star_rc,hbr
		xor ecx, ecx
		jmp loc_40130C

loc_401220:
		mov eax, 1Ch
		mul ecx
		add eax, dword_409854
		mov ebx, eax
		mov eax, StarSpeed
		cmp [ebx+8], eax
		ja loc_401248
		push ecx
		push ebx
		call StarCount
		pop ecx
		mov byte_409177, 1

loc_401248:
		push dword ptr [ebx+0Ch]
		pop dword ptr [ebx+14h]
		push dword ptr [ebx+10h]
		pop dword ptr [ebx+18h]
		mov eax, StarSpeed
		sub [ebx+8], eax
		mov eax, [ebx]
		shl eax, 8
		cdq
		idiv dword ptr [ebx+8]
		add eax, dword_409848
		mov [ebx+0Ch], eax
		mov eax, [ebx+4]
		shl eax, 8
		cdq
		idiv dword ptr [ebx+8]
		add eax, dword_40984C
		mov [ebx+10h], eax
		cmp byte_409177, 0
		jz loc_40129D
		push dword ptr [ebx+0Ch]
		pop dword ptr [ebx+14h]
		push dword ptr [ebx+10h]
		pop dword ptr [ebx+18h]
		mov byte_409177, 0

loc_40129D:
		mov eax, dword_40916B
		mov edx, ccy
		cmp dword ptr [ebx+0Ch], 0
		jb loc_4012BE
		cmp [ebx+0Ch], eax
		ja loc_4012BE
		cmp dword ptr [ebx+10h], 0
		jb loc_4012BE
		cmp [ebx+10h], edx
		jbe loc_4012C5

loc_4012BE:
		mov dword ptr [ebx+8], 0

loc_4012C5:
		push ecx
		xor eax, eax
		mov ah, cl
		mov al, ah
		shl eax, 8
		mov al, ah
		invoke CreatePen,0,0,eax
		push eax
		invoke SelectObject,[hDC],eax
		invoke MoveToEx,[hDC],dword ptr [ebx+14h],dword ptr [ebx+18h],0
		invoke LineTo,[hDC],dword ptr [ebx+0Ch],dword ptr [ebx+10h]
		pop eax
		invoke DeleteObject,eax
		pop ecx
		inc ecx

loc_40130C:
		cmp ecx, 12Ch
		jnz loc_401220
		invoke BitBlt,[hdcSrc],0,0,dword_40916B,ccy,[hDC],0,0,SRCCOPY
		cmp [var_30], 0
		jnz loc_4013F1
		mov al, byte_409012
		mov bl, byte_409018
		cmp al, bl
		jnb loc_40135C
		add byte_409012, 2

loc_40135C:
		mov al, byte_409011
		mov bl, byte_409017
		cmp al, bl
		jnb loc_401372
		add byte_409011, 2

loc_401372:
		mov al, byte_409010
		mov bl, byte_409016
		cmp al, bl
		jnb loc_401388
		add byte_409010, 2

loc_401388:
		cmp [var_3E], 1
		jnz loc_40139B
		mov al, byte_409012
		mov bl, byte_409018
		jmp loc_4013BF

loc_40139B:
		cmp [var_3E], 2
		jnz loc_4013AE
		mov al, byte_409011
		mov bl, byte_409017
		jmp loc_4013BF

loc_4013AE:
		cmp [var_3E], 3
		jnz loc_4013BF
		mov al, byte_409010
		mov bl, byte_409016

loc_4013BF:
		cmp al, bl
		jb loc_401493
		mov [var_30], 1
		mov al, byte_409017
		mov byte_409011, al
		mov al, byte_409016
		mov byte_409010, al
		mov al, byte_409018
		mov byte_409012, al
		jmp loc_401493

loc_4013F1:
		mov al, byte_409012
		mov bl, byte_409015
		cmp al, bl
		jbe loc_401407
		sub byte_409012, 2

loc_401407:
		mov al, byte_409011
		mov bl, byte_409014
		cmp al, bl
		jbe loc_40141D
		sub byte_409011, 2

loc_40141D:
		mov al, byte_409010
		mov bl, byte_409013
		cmp al, bl
		jbe loc_401433
		sub byte_409010, 2

loc_401433:
		cmp [var_3E], 1
		jnz loc_401446
		mov al, byte_409012
		mov bl, byte_409015
		jmp loc_40146A

loc_401446:
		cmp [var_3E], 2
		jnz loc_401459
		mov al, byte_409011
		mov bl, byte_409014
		jmp loc_40146A

loc_401459:
		cmp [var_3E], 3
		jnz loc_40146A
		mov al, byte_409010
		mov bl, byte_409013

loc_40146A:
		cmp al, bl
		ja loc_401493
		mov [var_30], 0
		mov al, byte_409014
		mov byte_409011, al
		mov al, byte_409013
		mov byte_409010, al
		mov al, byte_409015
		mov byte_409012, al

loc_401493:
		xor eax, eax
		mov al, byte_409010
		shl eax, 8
		mov al, byte_409011
		shl eax, 8
		mov al, byte_409012
		mov [color], eax ; <-- cyan color shift 
		invoke SetTextColor,[hdcSrc],White
		pusha
		mov eax, ccy
		sub eax, [psizl.cy]
		shr eax, 1
		mov [_y], eax
		popa
		mov eax, EndPos
		sub eax, 1
		invoke TextOut,[hdcSrc],[_x],[_y],offset ScrollerText,TxtLen
		invoke BitBlt,[hdc],x,y,dword_40916B,ccy,[hdcSrc],0,0,SRCCOPY
		invoke Sleep,12
		dec [_x]
		xor ebx, ebx
		sub ebx, [psizl._cx]
		cmp [_x], ebx
		jnz loc_40152C
		push dword_409BAF
		pop [_x]

loc_40152C:
		cmp dword_409840, 0
		jz loc_401539

loc_401535:
		xor eax, eax
		jmp loc_401535

loc_401539:
		cmp [var_2C], 0
		jnz loc_401206
		ret

StarfieldProc endp

StarCount proc near arg_0:DWORD

		push ebx
		mov ebx, [arg_0]
		push dword_40916B
		call Rndproc
		sub eax, dword_409848
		mov [ebx], eax
		push ccy
		call Rndproc
		sub eax, dword_40984C
		mov [ebx+4], eax
		mov dword ptr [ebx+8], 100h
		push dword_409848
		pop dword ptr [ebx+0Ch]
		push dword_40984C
		pop dword ptr [ebx+10h]
		mov eax, [arg_0]
		pop ebx
		ret
StarCount endp

Rndproc proc near arg_0:DWORD

		mov eax, dword_40986C
		mov ecx, 17h
		mul ecx
		add eax, 7
		and eax, 0FFFFFFFFh
		ror eax, 1
		xor eax, dword_40986C
		mov dword_40986C, eax
		mov ecx, [arg_0]
		xor edx, edx
		div ecx
		mov eax, edx
		ret

Rndproc endp

StarInit proc near
		pusha
		xor eax, eax
		mov eax, EfWeight
		sub eax, x
		shr eax, 1
		mov dword_409848, eax
		xor eax, eax
		mov eax, EfHeight
		sub eax, y
		shr eax, 1
		mov dword_40984C, eax
		invoke GlobalAlloc,GHND,8400
		mov hMem, eax
		invoke GlobalLock,hMem
		mov dword_409854, eax
		invoke GetStockObject,BLACK_BRUSH
		mov hbr, eax
		popa
		retn
StarInit endp
