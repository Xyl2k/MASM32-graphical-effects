
comment */
	
	aboutbox ripped from PcBoost_3.4.16.2007.Keygen.tPORt.zip
	by r0ger ^ PRF . 

	was included in other keygens for 2oo7 PGWARE prods 
	by the same cracking group.
	
	initially coded by x0man & Guru.eXe.
	
*/

AboutProc	PROTO	:DWORD,:DWORD,:DWORD,:DWORD

.data 

Text_xPos 	dd 0C8h
yPos_Start 	dd 49h
FontName 	LOGFONT <12h,0,0,0,258h,0,0,0,1,0,0,0,0,'ms sans serif'>
hDlg 		dd 0
byte_40624F db 0
byte_406250 db 0
byte_406251 db 0FFh
hDC 		dd 0
SourceDC 	dd 0
hAbtFont dd 0
h 			dd 0
dword_406276 dd 0
AboutText 	db "PERYFERiAH tEAM",0
		db ">----------------------------<",0
		db "Proudly Present",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db "Another aboutbox effect ripped from ",0
		db "PcBoost_3.4.16.2007.Keygen.tPORt.zip",0
		db "(and other PGWARE keygens made by them)",0 
		db "using IDA Pro 6.8 with CSC plugin",0
		db "with color-shift included",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db "coded by: x0man and Guru.eXe",0
		db "ripped and recoded by: r0ger ^ PRF",0
		db "rip date: o4.dec.2o22",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db "feel free to use this CooL",0
		db "aboutbox on your patchers/keygens",0
		db "[[ MASM32 ONLY ! ]]",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db "GreetZ 2:",0
		db " ",0
		db "Al0hA",0
		db "B@TRyNU",0
		db "GRUiA",0
		db "DAViiiiDDDDDDD",0
		db "MaryNello",0
		db "yMRAN",0
		db "WeeGee",0
		db "ShoGun",0
		db "zzLaTaNN",0
		db "QueenAntonia",0
		db "ShTEFY",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db "but also 2:",0
		db " ",0
		db "Intel Core 2 Extreme",0
		db "Dilik",0
		db "ReSampled (A.k.A SofT MANiAC)",0
		db "Log0",0
		db "Bang1338",0
		db "Vad1m",0
		db "kEy-tONe",0
		db "Bl4ckCyb3rEnigm4",0
		db "SKG-1010",0
		db "Xylitol",0
		db "Cachito",0
		db "Talers",0
		db "Roentgen",0
		db "kao",0
		db "fearless",0
		db "lili",0
		db "ByTESRam",0
		db "JonArbuckle",0
		db " ",0
		db "and many otherz =)",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db "u can find us at :",0
		db " ",0
		db "web : [[Hyperlink Blocked]]",0
		db "ig : @r0ger888",0
		db "telegram : t.me/r0ger888",0
		db "github : r0ger888",0
		db "discord : r0ger#2649",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db " ",0
		db "fUCK dA LaM3rZ",0
		db "...",0
		db " ",0
		db "as usual...",0
		
dword_4064B2 dd 0Ah
			dw 0
			dd 0
			db 2 dup(0)
ho 			dd 0
hdcSrc 		dd 0
dword_4064C6 dd 0
dword_4064CA dd 0
DelayTime 	dd 0

.code
AboutProc proc hWnd:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
LOCAL X:DWORD
LOCAL Y:DWORD

	push hWnd
	pop hDlg

	.if [uMsg] == WM_INITDIALOG

		invoke GetSystemMetrics,0
		push eax
		push 190h
		call TopXY
		mov X,eax
		invoke GetSystemMetrics,1
		push eax
		push 0C8h
		call TopXY
		mov Y,118h
		invoke SetWindowPos,hWnd,0,X,Y,190h,0C8h,40h
		invoke GetDC,hDlg
		mov hDC,eax
		invoke CreateCompatibleDC,0
		mov SourceDC,eax
		invoke CreateBitmap,190h,0C8h,1,20h,0
		mov h,eax
		invoke CreateFontIndirect,addr FontName
		mov hAbtFont,eax
		invoke SelectObject,SourceDC,h
		invoke SelectObject,SourceDC,hAbtFont
		invoke SetBkMode,SourceDC,TRANSPARENT
		invoke SetTextAlign,SourceDC,6
		invoke CreateRoundRectRgn,0,0,190h,0C8h,28h,28h
		invoke SetWindowRgn,hWnd,eax,1
		call TextInit
		call BackgroundInit
		invoke SetTimer,hWnd,0,10,0 ; original speed = 25
		
	.elseif [uMsg] == WM_TIMER
		
		call AnimProc

	.elseif [uMsg] == WM_LBUTTONDOWN
		
		invoke SendMessage,hWnd,WM_NCLBUTTONDOWN,HTCAPTION,0

	.elseif [uMsg] == WM_RBUTTONUP
	
		invoke SendMessage,hWnd,WM_CLOSE,0,0

	.elseif [uMsg] == WM_CLOSE

		call KillAbout
		invoke ReleaseDC,hDlg,hDC
		invoke DeleteDC,SourceDC
		invoke DeleteObject,hAbtFont
		invoke DeleteObject,h
		invoke EndDialog,hDlg,0

	.endif
	
	xor eax,eax
	ret
AboutProc endp

AnimProc proc near
		mov al, byte_406251
		cmp al, 0FFh
		jnz loc_401850
		mov byte_406250, 0FFh
		jmp loc_40185B

loc_401850:
		or al, al
		jnz loc_40185B
		mov byte_406250, 1

loc_40185B:
		add al, byte_406250
		mov byte_406251, al
		push 0FFh
		push 0FFh
		push eax
		call ColorShift
		invoke SetTextColor,SourceDC,eax
		invoke BitBlt,SourceDC,0,0,190h,0C8h,hdcSrc,0,0,SRCCOPY
		push dword_4064CA
		call VerticalScroll
		invoke BitBlt,hDC,0,0,190h,0C8h,SourceDC,0,0,SRCCOPY
		cmp DelayTime, 3E8h
		jnb loc_4018F2
		add DelayTime, 14h
		jmp locret_401944

loc_4018F2:
		xor eax, eax
		mov al, byte_40624F
		cmp al, 1
		jnz loc_401905
		inc dword_4064CA
		jmp loc_40190B

loc_401905:
		dec dword_4064CA

loc_40190B:
		mov eax, dword_4064CA
		cmp eax, dword_4064C6
		jnz loc_40192B
		mov byte_40624F, 1
		mov DelayTime, 0
		jmp locret_401944

loc_40192B:
		cmp eax, yPos_Start
		jnz locret_401944
		mov byte_40624F, 0FFh
		mov DelayTime, 0

locret_401944:
		retn
AnimProc endp

ColorShift proc near

arg_0 	= byte ptr  8
arg_4 	= byte ptr  0Ch
arg_8 	= byte ptr  10h

		push ebp
		mov ebp, esp
		movzx eax, [ebp+arg_8]
		shl eax, 8
		mov al, [ebp+arg_4]
		shl eax, 8
		mov al, [ebp+arg_0]
		leave
		retn 0Ch
		
ColorShift endp

VerticalScroll proc near

d 	= dword ptr -0Ch
y 	= dword ptr -8
x 	= dword ptr -4
arg_0 	= dword ptr  8

		push ebp
		mov ebp, esp
		add esp, 0FFFFFFF4h
		mov edi, offset AboutText
		push Text_xPos
		pop [ebp+x]
		push [ebp+arg_0]
		pop [ebp+y]
		mov edi, offset AboutText

loc_401749:
		push edi
		invoke lstrlen,edi
		mov [ebp+d], eax
		pop edi
		push edi
		cmp byte ptr [edi], 0Dh
		jz loc_401775
		invoke ExtTextOut,SourceDC,[ebp+x],[ebp+y],2,0,edi,[ebp+d],0
		
loc_401775:
		pop edi
		add edi, [ebp+d]
		inc edi
		add [ebp+y], 0Fh
		cmp byte ptr [edi], 0
		jnz loc_401749
		mov dword_406276, eax
		leave
		retn 4
VerticalScroll endp

TopXY proc near

arg_0 	= dword ptr  8
arg_4 	= dword ptr  0Ch

		push ebp
		mov ebp, esp
		shr [ebp+arg_4], 1
		shr [ebp+arg_0], 1
		mov eax, [ebp+arg_0]
		sub [ebp+arg_4], eax
		mov eax, [ebp+arg_4]
		leave
		retn 8
TopXY endp

TextInit proc near
	
		mov edi, offset AboutText
		xor eax, eax
		xor edx, edx
		xor ecx, ecx
		dec ecx

loc_401798:
		mov bl, [edx+edi]
		or bl, bl
		jz loc_4017A4
		cmp bl, 0Dh
		jnz loc_4017AE

loc_4017A4:
		inc eax
		cmp byte ptr [edx+edi+1], 0
		jnz loc_4017AE
		jmp loc_4017B1

loc_4017AE:
		inc edx
		loop loc_401798

loc_4017B1:
		mov dword_406276, eax
		retn
TextInit endp

BackgroundInit proc near

		invoke CreateCompatibleDC,0
		mov hdcSrc, eax
		invoke GetModuleHandle,0
		invoke LoadBitmap,eax,506
		mov ho, eax
		invoke SelectObject,hdcSrc,eax
		mov DelayTime, 0
		mov byte_40624F, 0FFh
		push yPos_Start
		pop dword_4064CA
		mov eax, dword_406276
		imul eax, 11h
		imul eax, -1
		mov dword_4064C6, eax
		mov eax, dword_4064B2
		imul eax, 11h
		add dword_4064C6, eax
		retn
BackgroundInit endp

KillAbout proc near
		
		invoke DeleteObject,ho
		invoke DeleteDC,hdcSrc
		ret
		
KillAbout endp

