
comment */

  TV static aboutbox from REVENGE keygen
  Similar to EGOiST's template but remade
  and improved by lord_Phoenix.
  
  so this is actually lord_Phoenix's version
  of the tv noise effect.
  
  included in statexpert.3.01.russian.keygen-rev.zip
  
  ripped and recoded by r0ger^PRF.
  
/*

AboutProc	PROTO	:DWORD,:DWORD,:DWORD,:DWORD
DrawProc	PROTO	:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
StaticInit  PROTO	:DWORD
Rndproc		PROTO	:DWORD

.const

aWidth	equ	13Dh
aHeight	equ	0ABh

StaticCol1	equ	0
StaticCol2	equ	303030h

yStartPos	equ	0AEh
yEndPos		equ	102h
xLeft		equ 10

TxtHeight	equ	15

.data 

AbtText 	db "         PERYFERiAH tEAM Presents",13,13,13,13
			db "another fine aboutbox similar",13
			db "to EGOiST[tSRh]'s tv noise effect",13
			db "but remade and improved by lord_Phoenix",13
			db "for the statexpert.3.01.russian.keygen-rev",13
			db "release only.",13,13
			db "ripped with IDA Pro 6.8 + CSC plugin",13
			db "and recoded by r0ger ^ PRF.",13,13
			db "peryferiah.ro coming soon guys ;)",13

AboutFont db "courier new",0
RndValue dd 0BC614Eh

.data?
BoxDC 	dd ?
hdcSrc 	dd ?
ho 		dd ?
ThreadId dd ?
hThread dd ?
dccc    dd ?
hWnd 	dd ?
x 		dd ?
y 		dd ?
h 		dd ?
X 		RECT <?>

.code

AboutProc proc _hWnd:DWORD,Msg:DWORD,wParamz:DWORD,lParamz:DWORD

	.if [Msg] == WM_INITDIALOG
		invoke GetParent,_hWnd
		invoke GetWindowRect,eax,offset X
		mov edi, X.left
		mov esi, X.top
		invoke SetWindowPos,_hWnd,HWND_TOPMOST,edi,esi,aWidth,aHeight,0
		push _hWnd
		pop hWnd
		call AboutInit
	.elseif [Msg] == WM_LBUTTONDOWN
		invoke SendMessage,_hWnd,WM_CLOSE,0,0
	.elseif [Msg] == WM_CLOSE
		invoke EndDialog,_hWnd,0
		call KillAbout
	.endif
	
	invoke DefWindowProc,_hWnd,Msg,wParamz,lParamz
	
	xor eax,eax
	ret
AboutProc endp

AboutInit proc near

		invoke GetWindowDC,hWnd
		mov BoxDC, eax
		invoke GetDC,0
		mov dccc,eax
		invoke CreateCompatibleDC,eax
		mov hdcSrc, eax
		invoke CreateCompatibleBitmap,BoxDC,aWidth,aHeight
		mov ho, eax
		invoke SelectObject,hdcSrc,eax
		invoke CreateFont,14,7,0,0,2BCh,0,0,0,0,2,0,2,0,offset AboutFont
		mov h, eax
		invoke CreateThread,0,0,offset DrawProc,0,0,offset ThreadId
		mov hThread, eax
		invoke SetThreadPriority,eax,THREAD_PRIORITY_ABOVE_NORMAL
		ret

AboutInit endp

DrawProc proc var_10:DWORD,var_C:DWORD,_y:DWORD,var_4:DWORD,lpThreadParameter:DWORD

		mov  [var_C], yStartPos
		push [var_C]
		pop  [var_4]
		mov  [var_10], yEndPos
		neg  [var_10]

init_abtb0x: 			
		invoke StaticInit,hdcSrc
		invoke SetBkMode,hdcSrc,TRANSPARENT
		invoke SetTextColor,hdcSrc,White
		invoke SelectObject,hdcSrc,h
		mov esi, offset AbtText 
		invoke lstrlen,offset AbtText
		mov ebx, eax
		inc ebx
		mov edi, esi
		mov eax, [var_4]
		mov [_y], eax

get_linez_count:
		cmp byte ptr [esi], 13
		jnz next_line
		mov cl, [esi]
		push ecx
		mov byte ptr [esi], 0
		invoke lstrlen,edi
		invoke TextOut,hdcSrc,xLeft,[_y],edi,eax
		add [_y], TxtHeight
		pop ecx
		mov edi, esi
		inc edi
		mov [esi], cl

next_line:
		inc esi
		dec ebx
		jnz get_linez_count
		dec [var_4]
		mov eax, [var_10]
		cmp [var_4], eax
		jl scroll_reset
		jmp finalize

scroll_reset:
		mov eax, [var_C]
		mov [var_4], eax

finalize: 			
		invoke BitBlt,BoxDC,0,0,aWidth,aHeight,hdcSrc,0,0,SRCCOPY
		invoke Sleep,1
		jmp init_abtb0x
DrawProc endp

StaticInit proc hdc:DWORD

		invoke PatBlt,hdc,0,0,aWidth,aHeight,BLACKNESS
		xor esi, esi
		xor edi, edi

loc_4014D1:
		mov x, esi
		mov y, edi
		invoke Rndproc,2
		or eax, eax
		jnz loc_4014EF
		mov eax, StaticCol1
		jmp loc_4014F4

loc_4014EF:
		mov eax, StaticCol2

loc_4014F4: 			
		push eax
		push y 	
		push x 	
		push hdc 
		call SetPixel
		inc esi
		cmp esi, aWidth
		jbe loc_4014D1
		xor esi, esi
		inc edi
		inc edi
		cmp edi, aHeight
		jbe loc_4014D1
		ret

StaticInit endp

Rndproc proc Amount:DWORD

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
		div Amount
		mov eax, edx
		ret

Rndproc endp

KillAbout proc
        invoke ReleaseDC,hWnd,BoxDC
        invoke ReleaseDC,hWnd,dccc
		invoke TerminateThread,hThread,0
		invoke DeleteObject,h
		invoke DeleteObject,ho
		invoke DeleteDC,hdcSrc
		ret
KillAbout endp
