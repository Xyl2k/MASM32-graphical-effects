
.586p
.mmx			
.model flat, stdcall
option casemap :none

;******************************************************************************
;* INCLUDES                                                                   *
;******************************************************************************
include				\masm32\include\windows.inc
include				\masm32\include\user32.inc
include				\masm32\include\kernel32.inc
include				\masm32\include\shell32.inc
include				\masm32\include\advapi32.inc
include				\masm32\include\gdi32.inc
include				\masm32\include\comctl32.inc
include				\masm32\include\comdlg32.inc
include				\masm32\include\masm32.inc
include				\masm32\include\winmm.inc
include				\masm32\include\msvcrt.inc
include				\masm32\macros\macros.asm

includelib			\masm32\lib\user32.lib
includelib			\masm32\lib\kernel32.lib
includelib			\masm32\lib\shell32.lib
includelib			\masm32\lib\advapi32.lib
includelib			\masm32\lib\gdi32.lib
includelib			\masm32\lib\comctl32.lib
includelib			\masm32\lib\comdlg32.lib
includelib			\masm32\lib\masm32.lib
includelib			\masm32\lib\winmm.lib
includelib			\masm32\lib\msvcrt.lib


include ufmod.inc
includelib ufmod.lib
;******************************************************************************
;* PROTOTYPES                                                                 *
;******************************************************************************
DialogProc 			proto :dword,:dword,:dword,:dword
AboutProc 			proto :dword,:dword,:dword,:dword
UpdateScroller			proto
CreateTVBox 			proto :dword
UpdateTVBox 			proto


;******************************************************************************
;* DATA & CONSTANTS                                                           *
;******************************************************************************
.const
BTN_ABOUT			equ 102

.data
AboutFont			LOGFONT <14, 7, 0, 0, FW_BOLD, FALSE, FALSE, FALSE, ANSI_CHARSET, OUT_CHARACTER_PRECIS, 										CLIP_DEFAULT_PRECIS,PROOF_QUALITY,DEFAULT_PITCH,"courier new">

szAboutText 		db "Made With love for you :",13
			db "Nice About effect 2",0
			db "Coded by:",13
			db "FudoWarez",0
			db "Greetz to:",13
			db "My loved Girl Carla and You",0
			db "[    Team ICU     ]",13
			db "[   Forever :)    ]",0
			db "Home Page:",13
			db "www.tuts4you.com",0
			db 11

			



.data?


wx	equ 314
wy	equ 124

histance	dd ?
mcolor	dd ?
threadID	dd ?
counter	dd ?
menlock	dd ?
menfree	dd ?
mtext	dd ?
fade	dd ?
legth	dd ?
;******************************************************************************
;* CODE                                                                       *
;******************************************************************************
.code

include music.asm

main:

	invoke InitCommonControls
	invoke GetModuleHandle,0
	mov histance,eax
	 invoke DialogBoxParam,eax,1,0,addr DialogProc,0
	invoke ExitProcess,0
align 4
DialogProc proc uses ebx esi edi hwnd:dword,message:dword,wparam:dword,lparam:dword
	
	mov eax,message
	.if eax==WM_INITDIALOG

	.elseif eax==WM_COMMAND
		mov eax,wparam
		.if ax==BTN_ABOUT
		invoke GetModuleHandle,0
		invoke DialogBoxParam,eax,2,hwnd,addr AboutProc ,WM_INITDIALOG
		.endif
	.elseif eax==WM_CLOSE
		invoke EndDialog,hwnd,0
	.endif
	xor eax,eax
	ret 	                         
DialogProc endp

align 4
AboutProc proc uses ebx esi edi hwnd:dword,message:dword,wparam:dword,lparam:dword
	local rect:RECT
	mov eax,message
	.if eax==WM_INITDIALOG

		invoke GetParent,hwnd
		mov ecx,eax
		invoke GetWindowRect,ecx,addr rect
		mov edi,rect.left
		mov esi, rect.top
		add edi,2
		add esi,22
		invoke SetWindowPos,hwnd,HWND_TOP,edi,esi, wx,wy,0
		xor esi,esi
		mov edi,20
		;invoke CreateRoundRectRgn,esi,esi,wx,wy,edi,edi
		;invoke SetWindowRgn,hwnd,eax,1
		RGB 0,0,0
		invoke CreateSolidBrush,eax
		mov mcolor,eax
		invoke GlobalAlloc,GHND,19600
		mov menfree,eax	
		invoke GlobalLock,eax
		mov menlock,eax
		invoke SetTimer,hwnd,1,10,0
		xor eax,eax
		invoke CreateThread,0,0,offset UpdateScroller,0,0,eax
		mov threadID,eax
		invoke SetThreadPriority,eax,THREAD_PRIORITY_LOWEST
		invoke uFMOD_PlaySong,offset xm,xm_length,XM_MEMORY

	.elseif eax == WM_TIMER
      		invoke  InvalidateRect, hwnd, 0, 0

	.elseif eax == WM_PAINT
		invoke CreateTVBox,hwnd

	.elseif eax == WM_RBUTTONDOWN
		invoke  SendMessage,hwnd,WM_CLOSE,0,0

	.elseif eax == WM_LBUTTONDOWN
		invoke PostMessage, hwnd,WM_NCLBUTTONDOWN, 2,lparam

	.elseif eax==WM_CLOSE
		invoke uFMOD_PlaySong,0,0,0
		invoke TerminateThread,threadID,0
		invoke GlobalUnlock,menlock
		invoke GlobalFree,menfree
		invoke EndDialog,hwnd,0

	.endif
	xor eax,eax

	ret 	                         
AboutProc endp


align 4
CreateTVBox proc hwnd:dword
	local ps:PAINTSTRUCT, rect:RECT, bm:BITMAP;
	local hdcx:dword, srcdc:dword, hbitmap:dword, mbitmap:dword;
	local hdc:dword, hfont:dword;

	invoke BeginPaint,hwnd,addr ps
	mov hdcx,eax
	invoke CreateCompatibleDC, hdcx
	mov srcdc, eax
	invoke CreateCompatibleBitmap,hdcx,wx,wy
	mov hbitmap,eax
	invoke  SelectObject,srcdc,hbitmap
	invoke SetRect,addr rect, 0,0, wx, wy
	invoke FillRect, srcdc, addr rect,mcolor
	invoke LoadBitmap,histance,123
	mov mbitmap,eax
	invoke CreateCompatibleDC, 0
	mov hdc,eax
	invoke  SelectObject,hdc, mbitmap
	invoke GetObject,mbitmap,sizeof BITMAP,addr bm
	invoke  SetBkMode, srcdc, TRANSPARENT
	invoke CreateFontIndirect,addr AboutFont
	mov hfont,eax
	invoke  SelectObject, srcdc,hfont

	invoke SetRect,addr rect, 100,wy/3, wx, wy
	invoke  SetTextColor, srcdc, fade
	invoke DrawText,srcdc,mtext,legth,addr rect,DT_CENTER or DT_TOP

	invoke BitBlt,srcdc,7,10,wx,wy,hdc,0,0,SRCCOPY

	xor ecx,ecx
	.while ecx != 02BCh

	mov eax,01Ch
	mul ecx
	add eax,menlock
	mov ebx,eax
	mov eax,2

	.if dword ptr [ebx+8] <=eax

	push ecx
	push ebx
	call stars
	pop ecx

	.endif

	mov eax,2
	sub dword ptr [ebx+8],eax
	mov eax,dword ptr [ebx]
	shl eax,8
	cdq

	idiv dword ptr [ebx+8]
	mov edi,wx
	shr edi,1
	add eax,edi
	mov dword ptr [ebx+0Ch],eax
	mov eax,dword ptr [ebx+4]
	shl eax,8
	cdq
	idiv dword ptr [ebx+8]
	mov edi,wy
	shr edi,1
	add eax,edi
	mov dword ptr [ebx+010h],eax
	mov eax,wx
	mov edx,wy

	.if dword ptr [ebx+0Ch] >= 0 && dword ptr [ebx+0Ch] <=  eax  &&  dword ptr [ebx+010h] >= 0

	cmp dword ptr [ebx+010h],edx
	jbe @Skip

	.endif

	mov dword ptr [ebx+8],0

	@Skip:


	push ecx
	RGB 180,180,180
	invoke SetPixel,srcdc,dword ptr [ebx+0Ch],dword ptr [ebx+010h],eax
	pop ecx
	inc ecx

	.endw

	invoke BitBlt,hdcx,0,0,wx,wy,srcdc,0,0,SRCCOPY

	invoke DeleteObject,hbitmap
	invoke DeleteObject,mbitmap
	invoke DeleteObject,hfont
	invoke DeleteDC,srcdc
	invoke DeleteDC,hdc
	invoke EndPaint,hwnd,addr ps

	ret
CreateTVBox endp

align 4
UpdateScroller proc
	local black:dword, white:dword, time:dword



	RGB 255,255,255
	mov white,eax

	RGB 0,0,0
	mov black,eax
	mov fade,eax

	@@:

	mov esi,offset szAboutText           

	.while byte ptr [esi] != 11

	invoke lstrlen,esi
	mov legth,eax

	mov mtext,esi
	.while eax != white

	invoke Sleep,30
	push fade
	push white
	call FadeIn_Out
	mov fade,eax

	.endw

	.while eax != 150

	invoke Sleep,20
	inc time
	mov eax,time

	.endw

	mov time,0

	.while eax != black

	invoke Sleep,30
	push fade
	push black
	call FadeIn_Out
	mov fade,eax

	.endw

	add esi,legth
	inc esi
	.endw

	jmp @B
	ret

UpdateScroller endp


align 4
FadeIn_Out proc uses ebx edi esi fade_in:dword,fade_out:dword

	mov esi,fade_in
	mov edi,fade_out
	mov eax,esi
	shr eax,16
	mov bl,al
	mov eax,edi
	shr eax,16
	call FadeIn_Out_Update
	shl ebx,8
	mov eax,esi
	shr eax,8
	mov bl,al
	mov eax,edi
	shr eax,8
	call FadeIn_Out_Update
	shl ebx,8
	mov eax,esi
	mov bl,al
	mov eax,edi
	call FadeIn_Out_Update
	shr ebx,8
	mov eax,ebx
	ret

FadeIn_Out endp

align 4
FadeIn_Out_Update proc

	.if al == bl
	mov bh,al
	jmp @F
	.endif

	mov cl,al
	mov dl,bl

	.if al > bl

	mov ah,al
	sub ah,bl

	.if ah >= 128
	sub cl,10
	.endif

	sub cl,5
	add dl,15

	.if al  > dl && cl  > dl
	mov bh,cl
	jmp @F
	.endif

	mov bh,bl
	jmp @F

	.endif

	mov ah,bl
	sub ah,al

	.if ah >= 128
	add cl,10
	.endif

	add cl,5
	sub dl,15

	.if al  <= dl && cl  <= dl
	mov bh,cl
	jmp @F
	.endif

	mov bh,bl

	@@:

	ret
FadeIn_Out_Update endp


stars proc uses ebx a:dword
	mov ebx,a
	push wx
	call stars1
	mov edi,wx
	shr edi,1
	sub eax,edi
	mov dword ptr ds:[ebx],eax
	mov dword ptr ds:[ebx+0Ch],edi
	push wy
	call stars1
	mov edi,wy
	shr edi,1
	sub eax,edi
	mov dword ptr ds:[ebx+4],eax
	mov dword ptr ds:[ebx+8],0100h
	mov dword ptr ds:[ebx+010h],edi
	mov eax,a
	ret
stars endp


stars1 proc a:dword

	mov eax,counter
	mov ecx,017h
	mul ecx
	add eax,7
	and eax,0FFFFFFFFh
	ror eax,1
	xor eax,counter
	mov counter,eax
	mov ecx,a
	xor edx,edx
	div ecx
	mov eax,edx
	ret
stars1 endp

db 'fudowarez!^2o10'

end main