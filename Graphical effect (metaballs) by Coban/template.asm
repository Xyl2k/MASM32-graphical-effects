
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
Random 				proto :dword
BallSize 				proto :dword,:dword
BallFpu 				proto
;******************************************************************************
;* DATA & CONSTANTS                                                           *
;******************************************************************************
.const
BTN_ABOUT			equ 102

.data
AboutFont			LOGFONT <14, 7, 0, 0, FW_BOLD, FALSE, FALSE, FALSE, ANSI_CHARSET, OUT_CHARACTER_PRECIS, 										CLIP_DEFAULT_PRECIS,PROOF_QUALITY,DEFAULT_PITCH,"courier new">

szAboutText 		db " Your TeaM Proudly Presents a keYgen for:",13
			db "Program name here 1.0",13,13,13,13
			db "Coded by:",13
			db "FudoWarez",13,13,13
			db "Greetz to:",13
			db "greetz",13
			db "greetz",13
			db "greetz",13
			db "greetz",13
			db "greetz",13
			db "greetz",13
			db "greetz",13
			db "greetz",13,13,13
			db "----------------",13
			db "Team ICU",13
			db "Forever :)",13
			db "----------------",13,13,13
			db "Home Page:",13
			db "www.tuts4you.com",0

			
nrandom_seed dd "O63."

.data?

szbla	dd 30 dup (?)

WX	equ 314
WY	equ 124
top	equ 0
left	equ 0

ppv	dd ?
srcdc	dd ?
hdcx	dd ?
thread	dd ?
threadID	dd ?
;******************************************************************************
;* CODE                                                                       *
;******************************************************************************
.code

include music.asm

divisor:
dd 700.000
dd 25.00000
dd 435.000
dd 22.00000
dd 480.000
dd 42.00000
dd 412.000
dd 22.00000
dd 450.000
dd 25.00000
dd 435.000
dd 41.00000
dd 410.000
dd 65.00000
dd 475.000
dd 21.00000

position:
dd WX/2
dd WX/5
dd WY
dd WX/4
dd WX/2
dd WX/6
dd WX/2
dd WX/5

main:
	invoke InitCommonControls
	invoke GetModuleHandle,0
	 invoke DialogBoxParam,eax,1,0,addr DialogProc,0
	 ;invoke DialogBoxParam, hInstance, 102, hWnd, offset Aboutproc, 0
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
		invoke SetWindowPos,hwnd,HWND_TOP,edi,esi, WX,WY,0
		invoke CreateTVBox,hwnd
		invoke uFMOD_PlaySong,OFFSET xm,xm_length,XM_MEMORY
	.elseif eax==WM_COMMAND

	.elseif eax == WM_LBUTTONDOWN
		invoke  SendMessage,hwnd,WM_CLOSE,0,0

	.elseif eax==WM_CLOSE
		invoke TerminateThread,threadID,0
		invoke DeleteDC,srcdc
		invoke uFMOD_PlaySong,0,0,0
		invoke EndDialog,hwnd,0
	.endif
	xor eax,eax
	ret 	                         
AboutProc endp

align 4
UpdateScroller proc 
	local rect:RECT
	local int_position:dword
	local local_match:dword

	mov int_position, WY
	mov local_match,2

	@@:

      	invoke UpdateTVBox
	invoke SetRect,addr rect, left,  int_position, WX, WY
	invoke lstrlen,addr szAboutText
	mov edi,eax
	invoke DrawText,srcdc,addr szAboutText,edi,addr rect,DT_CENTER or DT_TOP
	invoke  BitBlt, hdcx, left, top, WX, WY, srcdc, 0, 0, SRCCOPY

        	.if int_position == -0190h
	mov int_position, WY
	.endif

	dec local_match

	 .if local_match == 1
	dec int_position
	mov local_match,4
	.endif

	invoke Sleep,10

	jmp @B
	ret
UpdateScroller endp

align 4
CreateTVBox proc hwnd:dword
	local bmpi:BITMAPINFO

	invoke GetWindowDC,hwnd
	mov hdcx,eax
	invoke CreateCompatibleDC, eax
	mov srcdc, eax
	invoke RtlZeroMemory,addr bmpi, sizeof BITMAPINFO
	mov bmpi.bmiHeader.biSize, sizeof bmpi.bmiHeader
	mov bmpi.bmiHeader.biBitCount, 32
	mov eax,WX
	imul eax,eax,4
	imul eax,eax,WY
	mov bmpi.bmiHeader.biSizeImage, eax
	mov bmpi.bmiHeader.biPlanes, 1
	mov bmpi.bmiHeader.biWidth, WX
	mov bmpi.bmiHeader.biHeight, WY
 	invoke  CreateDIBSection, srcdc, addr bmpi, DIB_RGB_COLORS, addr ppv, 0, 0
	invoke  SelectObject, srcdc, eax
	invoke CreateFontIndirect,addr AboutFont
	invoke  SelectObject, srcdc, eax
	invoke  SetBkMode, srcdc, TRANSPARENT
	invoke  SetTextColor, srcdc, 0FEFEFEh
	invoke CreateThread,0,0,offset UpdateScroller,0,0,addr thread
	mov threadID,eax
	invoke SetThreadPriority,eax,THREAD_PRIORITY_LOWEST
	ret
CreateTVBox endp

align 4
UpdateTVBox proc uses edi esi ebx

	mov edi,ppv
        	xor ecx,ecx
	xor esi,esi

	.while ecx != WX*WY

		.if ebx  == 1 && esi  == 0  &&  ebx == WX-1 && esi == WY-1
		xor eax, eax
		.else
		push ecx
		invoke Random, 150
		add al, 9
		mov ah, al
		shl eax, 8
		mov al, ah
		pop ecx
		.endif
		stosd
		inc ebx
		.if ebx == WX
		xor ebx, ebx
		inc esi
		.endif
		inc ecx
		.endw

	invoke BallFpu
	mov edi,ppv
	xor  ecx, ecx
	xor ebx,ebx
	xor esi,esi

	.while ecx != WX*WY

		inc ebx

		.if ebx == WX
		xor ebx,ebx
		inc esi
		.endif

		.if ebx  > 1 && esi  > 0  &&  ebx < WX-1 && esi < WY-1

		push ecx
		invoke BallSize,ebx,esi

		.if eax > 500

		mov eax,dword ptr [edi]
		and eax,0FEFEFEh
		shr eax,1
		mov dword ptr [edi],eax

		.else

		.if eax > 400

		mov eax,dword ptr [edi]
		and eax,1
		add eax,1
		shr eax,1
		mov dword ptr [edi],eax

		.endif
		.endif

		pop ecx

		.endif

		add edi,4
		inc ecx
	.endw
	ret
UpdateTVBox endp

align 4
Random proc uses edx ecx, base:dword

	mov eax, nrandom_seed
	xor edx, edx
	mov ecx, 127773
	div ecx
	mov ecx, eax
	mov eax, 16807
	mul edx
	mov edx, ecx
	mov ecx, eax
	mov eax, 2836
	mul edx
	sub ecx, eax
	xor edx, edx
	mov eax, ecx
	mov nrandom_seed, ecx
	div base
	mov eax, edx
	ret
Random endp

align 4
BallFpu proc
	local local_match:dword
	local local_result:dword

	invoke GetTickCount
	mov local_match,eax
	mov local_result,0
	xor edi,edi
	xor edx,edx
       
	.while edi != 16
		fild local_match
		fdiv dword ptr [divisor+edi*4]
		fcos
		inc edi	
		fmul dword ptr [divisor+edi*4]
		fistp local_result
		push local_result
		pop dword ptr [szbla+edx*4]
		mov eax,dword ptr [position+edx*4]
		add dword ptr [szbla+edx*4],eax
		fild local_match
		inc edi
		fdiv  dword ptr [divisor+edi*4]
		fsin
		inc edi
		fmul  dword ptr [divisor+edi*4]
		fistp local_result
		push local_result
		inc edx
		pop dword ptr [szbla+edx*4]
		mov eax,dword ptr [position+edx*4]
		add dword ptr [szbla+edx*4],eax
		inc edi
		inc edx
	.endw

	ret

BallFpu endp

align 4
BallSize proc uses esi edi ebx a:dword,b:dword

	mov esi,offset szbla
	xor edi,edi
	xor ebx,ebx

	.while edi != 4
		mov eax,dword ptr [esi]
		sub eax,a
		cdq
		mul eax
		mov ecx,eax
		mov eax,dword ptr [esi+4]
		sub eax,b
		cdq
		mul eax
		add eax,ecx
		.if !eax
		mov eax,-1
		ret
		.endif
		xor edx,edx
		mov ecx,eax
		mov eax,0445C0h
		div ecx
		add ebx,eax
		add esi,8
		inc edi
	.endw
	mov eax,ebx
	ret
BallSize endp

db 'fudowarez!^2o10'
end main