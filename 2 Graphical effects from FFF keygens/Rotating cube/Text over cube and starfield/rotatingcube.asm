
; ripped by your bro r0ger^PRF.

; this is recoded only to use it in your main keygen form 
; (optimized for STATIC control)

AboutProc	PROTO	:DWORD,:DWORD,:DWORD,:DWORD
;CubeProc	PROTO	:DWORD

.data
pIntroBackBufferThreadID	dd 0
wDC1                     dd 0
wDC2                     dd 0
y                        dd 0
x                        dd 0
x1                       dd 0
R                        dd 0
G                        dd 0
B                        dd 0
B1                       dd 0
B2                       dd 0
B3                       dd 0
B4                       dd 0
B5                       dd 0
B6                       dd 0





Radian 		real4 0.017453292
			
r3kt			RECT	<>
.const
	ID_MSX		EQU 1001
ZoomValue 	real4 64.0 ; if u lower this value,all its sides are starting to zoom out
						; ( ... perhaps experience some lsd ?? ) :P
RealSpeed 	real4 1.70

Cube_xPos	equ	350
Cube_yPos	equ	200

CubeSize	equ	13
CubeColor	equ 007E7E7Eh

DCWidth		equ	342
DCHeight	equ	201
    LFont        LOGFONT <>
    
.data?

; --- vARiABLES fOR cUBE eDGES/SiDES ... dO nOT mODiFY `eM ! ---

dword_40B67C dd ?
dword_40B694 dd ?
dword_40B698 dd ?
dword_40B69C dd ?
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
dword_40B6F4 dd ?
dword_40B6F8 dd ?
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
		db    ? ;
SizeBuffer 	 db 4 dup(?)
CubeRekt 	 RECT	<?>
ColorBuffer  db 4 dup(?)

; --- vARiABLES fOR cUBE eDGES/SiDES ... dO nOT mODiFY `eM ! ---

cubeDC		 dd ?
xWnd		 dd ?
hdcSrc		 dd ?
xDC			 dd ?
TxtLen		 dd ?
hAboutFont	 dd ?
CubeThread	dd  ?
ThreadId    dd  ?
cubedc		dd  ?
hWidth		dd	?
hHeight		dd	?

.code

CubeProc proc near

var_34 	= dword ptr -34h
var_30 	= dword ptr -30h
var_2C 	= dword ptr -2Ch
var_28 	= dword ptr -28h
var_24 	= dword ptr -24h
var_20 	= dword ptr -20h
var_1C 	= dword ptr -1Ch
var_18 	= dword ptr -18h
var_14 	= dword ptr -14h
lpThreadParameter= dword ptr  4

		push ebp
		add esp, 0FFFFFFE8h
		mov ebx, offset SizeBuffer
		mov esi, offset ColorBuffer
		mov edi, offset r3kt
		mov ebp, offset CubeRekt

		invoke  GetDlgItem,hDlgWnd,2009
		invoke GetDC,eax
		mov xDC,eax
		invoke CreateCompatibleDC,eax
		mov hdcSrc,eax
		invoke CreateCompatibleBitmap,xDC,DCWidth,DCHeight
		mov cubeDC,eax
		invoke SelectObject,hdcSrc,eax
		invoke SetBkMode,hdcSrc,TRANSPARENT
		invoke CreateSolidBrush,Black ;created some bg color for the anim,
									;but not rly essential :E
		invoke SelectObject,hdcSrc,eax
		

		invoke CreateFontIndirect,addr AboutFont

		mov hAboutFont,eax
		invoke SelectObject,hdcSrc,eax
		invoke SetTextColor,hdcSrc,White
		invoke SetBkMode,hdcSrc,TRANSPARENT
		;invoke SelectObject,hdcSrc,eax
		invoke lstrlen,addr AboutText
		mov TxtLen,eax
		invoke DrawText,hdcSrc,addr AboutText,TxtLen,offset CubeRekt,DT_CENTER or DT_NOPREFIX
		invoke DrawText,hDC,addr AboutText,TxtLen,offset CubeRekt,DT_CENTER or DT_NOPREFIX
		mov dword ptr [ebx], CubeSize
		xor eax, eax
		mov [esp+28h+var_28], eax
		xor eax, eax
		mov [esp+28h+var_24], eax
		xor eax, eax
		mov [esp+28h+var_20], eax
		mov dword ptr [esi], CubeColor

loc_404B67:
		invoke PatBlt,hdcSrc,0,0,DCWidth,DCHeight,PATCOPY
		fld [esp+28h+var_28]
		fadd RealSpeed
		fstp [esp+28h+var_28]
		wait
		fld [esp+28h+var_24]
		fadd RealSpeed
		fstp [esp+28h+var_24]
		wait
		fld [esp+28h+var_20]
		fadd RealSpeed
		fstp [esp+28h+var_20]
		wait
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+2Ch+var_2C] ; float
		wait
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+30h+var_30] ; float
		wait
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+34h+var_34] ; float
		wait
		push [esp+34h+var_28] ; float
		push [esp+38h+var_24] ; float
		push [esp+3Ch+var_20] ; float
		xor eax, eax
		call CreateSide
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+2Ch+var_2C] ; float
		wait
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+30h+var_30] ; float
		wait
		mov eax, [ebx]
		neg eax
		mov [esp+30h+var_1C], eax
		fild [esp+30h+var_1C]
		add esp, 0FFFFFFFCh
		fstp [esp+34h+var_34] ; float
		wait
		push [esp+34h+var_28] ; float
		push [esp+38h+var_24] ; float
		push [esp+3Ch+var_20] ; float
		mov eax, 1
		call CreateSide
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+2Ch+var_2C] ; float
		wait
		mov eax, [ebx]
		neg eax
		mov [esp+2Ch+var_1C], eax
		fild [esp+2Ch+var_1C]
		add esp, 0FFFFFFFCh
		fstp [esp+30h+var_30] ; float
		wait
		mov eax, [ebx]
		neg eax
		mov [esp+30h+var_18], eax
		fild [esp+30h+var_18]
		add esp, 0FFFFFFFCh
		fstp [esp+34h+var_34] ; float
		wait
		push [esp+34h+var_28] ; float
		push [esp+38h+var_24] ; float
		push [esp+3Ch+var_20] ; float
		mov eax, 2
		call CreateSide
		mov eax, [ebx]
		neg eax
		mov [esp+28h+var_1C], eax
		fild [esp+28h+var_1C]
		add esp, 0FFFFFFFCh
		fstp [esp+2Ch+var_2C] ; float
		wait
		mov eax, [ebx]
		neg eax
		mov [esp+2Ch+var_18], eax
		fild [esp+2Ch+var_18]
		add esp, 0FFFFFFFCh
		fstp [esp+30h+var_30] ; float
		wait
		mov eax, [ebx]
		neg eax
		mov [esp+30h+var_14], eax
		fild [esp+30h+var_14]
		add esp, 0FFFFFFFCh
		fstp [esp+34h+var_34] ; float
		wait
		push [esp+34h+var_28] ; float
		push [esp+38h+var_24] ; float
		push [esp+3Ch+var_20] ; float
		mov eax, 3
		call CreateSide
		mov eax, [ebx]
		neg eax
		mov [esp+28h+var_1C], eax
		fild [esp+28h+var_1C]
		add esp, 0FFFFFFFCh
		fstp [esp+2Ch+var_2C] ; float
		wait
		mov eax, [ebx]
		neg eax
		mov [esp+2Ch+var_18], eax
		fild [esp+2Ch+var_18]
		add esp, 0FFFFFFFCh
		fstp [esp+30h+var_30] ; float
		wait
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+34h+var_34] ; float
		wait
		push [esp+34h+var_28] ; float
		push [esp+38h+var_24] ; float
		push [esp+3Ch+var_20] ; float
		mov eax, 4
		call CreateSide
		mov eax, [ebx]
		neg eax
		mov [esp+28h+var_1C], eax
		fild [esp+28h+var_1C]
		add esp, 0FFFFFFFCh
		fstp [esp+2Ch+var_2C] ; float
		wait
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+30h+var_30] ; float
		wait
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+34h+var_34] ; float
		wait
		push [esp+34h+var_28] ; float
		push [esp+38h+var_24] ; float
		push [esp+3Ch+var_20] ; float
		mov eax, 5
		call CreateSide
		mov eax, [ebx]
		neg eax
		mov [esp+28h+var_1C], eax
		fild [esp+28h+var_1C]
		add esp, 0FFFFFFFCh
		fstp [esp+2Ch+var_2C] ; float
		wait
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+30h+var_30] ; float
		wait
		mov eax, [ebx]
		neg eax
		mov [esp+30h+var_18], eax
		fild [esp+30h+var_18]
		add esp, 0FFFFFFFCh
		fstp [esp+34h+var_34] ; float
		wait
		push [esp+34h+var_28] ; float
		push [esp+38h+var_24] ; float
		push [esp+3Ch+var_20] ; float
		mov eax, 6
		call CreateSide
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+2Ch+var_2C] ; float
		wait
		mov eax, [ebx]
		neg eax
		mov [esp+2Ch+var_1C], eax
		fild [esp+2Ch+var_1C]
		add esp, 0FFFFFFFCh
		fstp [esp+30h+var_30] ; float
		wait
		fild dword ptr [ebx]
		add esp, 0FFFFFFFCh
		fstp [esp+34h+var_34] ; float
		wait
		push [esp+34h+var_28] ; float
		push [esp+38h+var_24] ; float
		push [esp+3Ch+var_20] ; float
		mov eax, 7
		call CreateSide
		xor eax, eax
		call AttachTop
		mov eax, 1
		call AttachTop
		mov eax, 2
		call AttachTop
		mov eax, 3
		call AttachTop
		mov eax, 4
		call AttachTop
		mov eax, 5
		call AttachTop
		mov eax, 6
		call AttachTop
		mov eax, 7
		call AttachTop
		invoke DrawText,hdcSrc,addr AboutText,TxtLen,offset CubeRekt,DT_CENTER or DT_NOPREFIX
		invoke BitBlt,xDC,0,0,[ebp+8],[ebp+12],hdcSrc,0,0,SRCCOPY
		mov ecx, [esi]
		mov edx, 1
		xor eax, eax
		call InsertEdge
		mov ecx, [esi]
		mov edx, 2
		mov eax, 1
		call InsertEdge
		mov ecx, [esi]
		mov edx, 7
		mov eax, 2
		call InsertEdge
		mov ecx, [esi]
		xor edx, edx
		mov eax, 7
		call InsertEdge
		mov ecx, [esi]
		mov edx, 4
		mov eax, 3
		call InsertEdge
		mov ecx, [esi]
		mov edx, 5
		mov eax, 4
		call InsertEdge
		mov ecx, [esi]
		mov edx, 6
		mov eax, 5
		call InsertEdge
		mov ecx, [esi]
		mov edx, 3
		mov eax, 6
		call InsertEdge
		mov ecx, [esi]
		mov edx, 5
		xor eax, eax
		call InsertEdge
		mov ecx, [esi]
		mov edx, 6
		mov eax, 1
		call InsertEdge
		mov ecx, [esi]
		mov edx, 3
		mov eax, 2
		call InsertEdge
		mov ecx, [esi]
		mov edx, 4
		mov eax, 7
		call InsertEdge
		
				
loc_404EDF: 		
		
		invoke Sleep,5
		jmp loc_404B67
CubeProc endp

CreateSide proc near

var_24 	= tbyte ptr -24h
var_18 	= dword ptr -18h
var_14 	= dword ptr -14h
var_10 	= dword ptr -10h
var_C 	= dword ptr -0Ch
var_8 	= dword ptr -8
var_4 	= dword ptr -4
arg_0 	= dword ptr  8
arg_4 	= dword ptr  0Ch
arg_8 	= dword ptr  10h
arg_C 	= dword ptr  14h
arg_10 	= dword ptr  18h
arg_14 	= dword ptr  1Ch

		push ebp
		mov ebp, esp
		add esp, 0FFFFFFDCh
		push ebx
		mov ebx, eax
		fld [ebp+arg_8]
		fmul Radian
		fstp [ebp+arg_8]
		wait
		fld [ebp+arg_4]
		fmul Radian
		fstp [ebp+arg_4]
		wait
		fld [ebp+arg_0]
		fmul Radian
		fstp [ebp+arg_0]
		wait
		fld [ebp+arg_0]
		call c0sinus ; System::__linkproc__ COS(void)
		fmul [ebp+arg_14]
		fstp [ebp+var_24]
		wait
		fld [ebp+arg_0]
		call s1nus ; System::__linkproc__ SIN(void)
		fmul [ebp+arg_10]
		fld [ebp+var_24]
		fsubrp st(1), st
		fstp [ebp+var_4]
		wait
		fld [ebp+arg_0]
		call s1nus ; System::__linkproc__ SIN(void)
		fmul [ebp+arg_14]
		fstp [ebp+var_24]
		wait
		fld [ebp+arg_0]
		call c0sinus ; System::__linkproc__ COS(void)
		fmul [ebp+arg_10]
		fld [ebp+var_24]
		faddp st(1), st
		fstp [ebp+var_C]
		wait
		fld [ebp+arg_4]
		call c0sinus ; System::__linkproc__ COS(void)
		fmul [ebp+var_4]
		fstp [ebp+var_24]
		wait
		fld [ebp+arg_4]
		call s1nus ; System::__linkproc__ SIN(void)
		fmul [ebp+arg_C]
		fld [ebp+var_24]
		fsubrp st(1), st
		fstp [ebp+var_8]
		wait
		fld [ebp+arg_4]
		call s1nus ; System::__linkproc__ SIN(void)
		fmul [ebp+var_4]
		fstp [ebp+var_24]
		wait
		fld [ebp+arg_4]
		call c0sinus ; System::__linkproc__ COS(void)
		fmul [ebp+arg_C]
		fld [ebp+var_24]
		faddp st(1), st
		fstp [ebp+var_14]
		wait
		fld [ebp+arg_8]
		call c0sinus ; System::__linkproc__ COS(void)
		fmul [ebp+var_C]
		fstp [ebp+var_24]
		wait
		fld [ebp+arg_8]
		call s1nus ; System::__linkproc__ SIN(void)
		fmul [ebp+var_14]
		fld [ebp+var_24]
		fsubrp st(1), st
		fstp [ebp+var_10]
		wait
		fld [ebp+arg_8]
		call s1nus ; System::__linkproc__ SIN(void)
		fmul [ebp+var_C]
		fstp [ebp+var_24]
		wait
		fld [ebp+arg_8]
		call c0sinus ; System::__linkproc__ COS(void)
		fmul [ebp+var_14]
		fld [ebp+var_24]
		faddp st(1), st
		fstp [ebp+var_18]
		wait
		lea eax, [ebx+ebx*2]
		mov edx, [ebp+var_8]
		mov dword_40B694[eax*4], edx
		lea eax, [ebx+ebx*2]
		mov edx, [ebp+var_10]
		mov dword_40B698[eax*4], edx
		lea eax, [ebx+ebx*2]
		mov edx, [ebp+var_18]
		mov dword_40B69C[eax*4], edx
		pop ebx
		mov esp, ebp
		pop ebp
		retn 18h
CreateSide endp

AttachTop proc near

var_14 	= dword ptr -14h
var_10 	= dword ptr -10h

		push ebx
		push esi
		push edi
		add esp, 0FFFFFFF8h
		mov ebx, eax
		mov esi, 4
		mov [esp+14h+var_14], esi
		fild [esp+14h+var_14]
		lea edi, [ebx+ebx*2]
		fmul dword_40B694[edi*4]
		fld ZoomValue
		fadd dword_40B69C[edi*4]
		fdivr ZoomValue
		fmulp st(1), st
		mov eax, Cube_xPos
		sar eax, 1
		jns loc_40492A
		adc eax, 0

loc_40492A:
		mov [esp+14h+var_10], eax
		fild [esp+14h+var_10]
		faddp st(1), st
		call r0und ; System::__linkproc__ ROUND(void)
		mov dword_40B6F4[ebx*8], eax
		mov [esp+14h+var_14], esi
		fild [esp+14h+var_14]
		fmul dword_40B698[edi*4]
		fld ZoomValue
		lea eax, [ebx+ebx*2]
		fadd dword_40B69C[eax*4]
		fdivr ZoomValue
		fmulp st(1), st
		mov eax, Cube_yPos
		sar eax, 1
		jns loc_404971
		adc eax, 0

loc_404971:
		mov [esp+14h+var_10], eax
		fild [esp+14h+var_10]
		faddp st(1), st
		call r0und ; System::__linkproc__ ROUND(void)
		mov dword_40B6F8[ebx*8], eax
		pop ecx
		pop edx
		pop edi
		pop esi
		pop ebx
		retn
AttachTop endp

InsertEdge proc
		push ebx
		push esi
		push edi
		mov edi, edx
		mov esi, eax
		invoke CreatePen,0,1,ecx
		mov ebx, eax
		invoke SelectObject,xDC,ebx
		invoke MoveToEx,xDC,dword_40B6F4[esi*8],dword_40B6F8[esi*8],0
		invoke LineTo,xDC,dword_40B6F4[edi*8],dword_40B6F8[edi*8]
		invoke DeleteObject,ebx
		pop edi
		pop esi
		pop ebx
		retn
InsertEdge endp

c0sinus proc 
 
	fcos
	fnstsw ax
	sahf
	jp short loc_402660
	retn

loc_402660:
	fstp st
	fldz
	retn
	
c0sinus endp

s1nus proc 

	fsin
	fnstsw ax
	sahf
	jp short loc_402670
	retn

loc_402670:
	fstp st
	fldz
	ret
	
s1nus endp

r0und proc near

var_8 = qword ptr -8

	sub esp, 8
	fistp [esp+8+var_8]
	wait
	pop eax
	pop edx
	retn
	
r0und endp
