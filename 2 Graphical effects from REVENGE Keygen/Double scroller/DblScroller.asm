
comment */

  some tv static effect with double scrollers ripped by r0ger^PRF
  initially coded by Zer0^ReVeNgE.
  
  was included in :
  
  - security.administrator.10.0.keygen-rev.zip (rip source)
  - advanced.postal.envelope.1.3.2.keygen-rev.zip (red static)
  - typespeak.1.0.keygen-rev.zip (red static)
  - urlcontrol.1.3.russian.keygen-rev.zip (white static)
 
/*

TVStaticInit PROTO :DWORD
DrawTVBox 	 PROTO ;<-- sry i needed to add this so it doesn't detect this as "undefined symbol" when calling it through *invoke* API.
DeleteTVBox	 PROTO

.const
TVWidth		equ	9Ah
TVHeight	equ	38h

ScrText1_StartPos equ 0B8h
ScrText1_EndPos	equ	190h
ScrText2_StartPos equ 0FEh
ScrText2_EndPos	equ	8DCh

ScrText1_Color	equ	00FFDEA6h
ScrText2_Color	equ	0FEFEFEFh ;original colour.

ScrText1_yPos	equ	10h
ScrText2_yPos	equ	1Eh

.data 
ScrText1 db "Graphical effect from REVENGE keygen by Zer0",0
ScrText2 db "Yet another n0ice GDI graphical effect, ripped, improved and recoded by "
		 db "ur bro r0ger^PRF - initially coded by Zer0^ReVeNgE. Tools used as usual : "
		 db "IDA Pro 6.8 and WinASM Studio. Music name : cerror and funky fish - garbage on titan . "
		 db "rip source : <security.administrator.10.0.keygen-rev> . feel free 2 "
		 db "use this tv static effect on your releases - only for MASM32 coderz =) ",0

ScrFont1 LOGFONT <12,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'terminal'>
ScrFont2 LOGFONT <8,6,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'terminal'>
RndValue dd 0BC614Eh

.data?
hScrFont1 	dd ?
hScrFont2 	dd ?
hScrTextLen	dd ?
hdc 		dd ?
hdcSrc 		dd ?
ho 			dd ?
ThreadId 	dd ?
hThread 	dd ?
hWnd 		dd ?
ecs 		dd ?
uai 		dd ?

.code
TVStaticInit proc AnimHandle:DWORD

		invoke GetWindowDC,AnimHandle
		mov hdc, eax
		invoke GetDC,0
		invoke CreateCompatibleDC,eax
		mov hdcSrc, eax
		invoke CreateCompatibleBitmap,hdc,TVWidth,TVHeight
		mov ho, eax
		invoke SelectObject,hdcSrc,eax
		invoke CreateFontIndirect,addr ScrFont1
		mov hScrFont1, eax
		invoke CreateFontIndirect,addr ScrFont2
		mov hScrFont2, eax
		invoke CreateThread,0,0,offset DrawTVBox,0,0,offset ThreadId
		mov hThread, eax
		invoke SetThreadPriority,eax,THREAD_PRIORITY_ABOVE_NORMAL ; <-- 0FFFFFFFEh in IDA Pro.
		ret

TVStaticInit endp

DrawTVBox proc near

var_18 	= dword ptr -18h
var_14 	= dword ptr -14h
var_10 	= dword ptr -10h
var_C 	= dword ptr -0Ch
var_8 	= dword ptr -8
_x 	= dword ptr -4
lpThreadParameter= dword ptr  8

		push ebp
		mov ebp, esp
		add esp, 0FFFFFFE8h
		mov [ebp+var_8], ScrText1_StartPos
		push [ebp+var_8]
		pop [ebp+_x]
		mov [ebp+var_C], ScrText1_EndPos
		neg [ebp+var_C]
		mov [ebp+var_14], ScrText2_StartPos
		push [ebp+var_14]
		pop [ebp+var_10]
		mov [ebp+var_18], ScrText2_EndPos
		neg [ebp+var_18]

loc_4012D5: 			
		push hdcSrc
		call WhiteNoise
		invoke SetBkMode,hdcSrc,TRANSPARENT
		invoke SetTextColor,hdcSrc,ScrText1_Color
		invoke SelectObject,hdcSrc,hScrFont1
		invoke TextOut,hdcSrc,[ebp+_x],ScrText1_yPos,offset ScrText1,sizeof ScrText1
		dec [ebp+_x]
		mov eax, [ebp+var_C]
		cmp [ebp+_x], eax
		jl loc_401332
		jmp loc_401338

loc_401332:
		mov eax, [ebp+var_8]
		mov [ebp+_x], eax

loc_401338:
		invoke SetBkMode,hdcSrc,TRANSPARENT
		invoke SetTextColor,hdcSrc,White
		invoke SelectObject,hdcSrc,hScrFont2
		invoke lstrlen,offset ScrText2
		mov hScrTextLen,eax
		invoke TextOut,hdcSrc,[ebp+var_10],ScrText2_yPos,offset ScrText2,hScrTextLen
		dec [ebp+var_10]
		dec [ebp+var_10]
		mov eax, [ebp+var_18]
		cmp [ebp+var_10], eax
		jl loc_401390
		jmp loc_401396

loc_401390:
		mov eax, [ebp+var_14]
		mov [ebp+var_10], eax

loc_401396:
		invoke BitBlt,hdc,0B2h,19h,TVWidth,TVHeight,hdcSrc,0,0,SRCCOPY
		invoke Sleep,12 ;normal speed for it is 23h [35 in hex]
		jmp loc_4012D5
DrawTVBox endp

WhiteNoise proc near

_hdc 	= dword ptr  8

		push ebp
		mov ebp, esp
		invoke PatBlt,[ebp+_hdc],0,0,TVWidth,TVHeight,BLACKNESS
		xor esi, esi
		xor edi, edi

loc_40125A:
		mov ecs, esi
		mov uai, edi
		push 32h
		call Rndproc
		add al, 64h
		mov ah, al
		shl eax, 8
		mov al, ah
		invoke SetPixel,[ebp+_hdc],ecs,uai,eax
		inc esi
		cmp esi, TVWidth
		jbe loc_40125A
		xor esi, esi
		inc edi
		inc edi
		cmp edi, TVHeight
		jbe loc_40125A
		leave
		retn 4
WhiteNoise endp

Rndproc proc near

arg_0 	= dword ptr  8

		push ebp
		mov ebp, esp
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
		div [ebp+arg_0]
		mov eax, edx
		leave
		retn 4
Rndproc endp

DeleteTVBox proc
	
	invoke TerminateThread,hThread,0
	invoke DeleteObject,ho
	invoke DeleteDC,hdcSrc
	ret
	
DeleteTVBox endp