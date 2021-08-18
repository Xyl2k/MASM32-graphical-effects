.486
.model	flat, stdcall
option	casemap :none   ; case sensitive

include		base.inc
include		fadebmp.asm

.code
start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	invoke	DialogBoxParam, hInstance, 101, 0, ADDR DlgProc, 0
	invoke	ExitProcess, eax
; -----------------------------------------------------------------------
DlgProc	proc	hWin	:DWORD,
		uMsg	:DWORD,
		wParam	:DWORD,
		lParam	:DWORD
		LOCAL ps:PAINTSTRUCT
 mov	    eax,uMsg
 
 	.if	uMsg == WM_INITDIALOG
		pushad
		push    hWin
		call    FadeBmp 
		popad
	.elseif	uMsg == WM_COMMAND
		.if	wParam  == IDB_QUIT
			invoke EndDialog,hWin,0
		.endif
	.elseif uMsg == WM_PAINT
		lea 	eax,ps
		invoke 	BeginPaint,hWin,eax
		mov 	esi,eax
		xor 	ebx,ebx                 
		invoke 	GetDC,hWin
		mov 	edi,eax
		push    0CC0020h        
		push    ebx             
		push    ebx             
		mov     edi, eax
		push    hDC             
		push    LogoHeight    
		push    LogoWidth
		push    yImgPos             
		push    xImgPos         
		push    edi            
		call    BitBlt
		invoke 	DeleteDC,esi
		invoke 	ReleaseDC,[hWin],edi
	.elseif	uMsg == WM_CLOSE
		invoke	EndDialog,hWin,0
	.endif

	xor	eax,eax
	ret
DlgProc	endp

end start
