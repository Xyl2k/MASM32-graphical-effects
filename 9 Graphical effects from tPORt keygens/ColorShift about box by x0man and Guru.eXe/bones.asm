.386
.model	flat, stdcall
option	casemap :none

include		bones.inc
include	aboutbox.asm

.code
start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	invoke	InitCommonControls
	invoke	DialogBoxParam, hInstance, IDD_MAIN, 0, offset DlgProc, 0
	invoke	ExitProcess, eax

DlgProc proc hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
	mov	eax,uMsg
	
	.if	eax == WM_INITDIALOG
		invoke	LoadIcon,hInstance,200
		invoke	SendMessage, hWin, WM_SETICON, 1, eax
	.elseif eax == WM_COMMAND
		mov	eax,wParam
		.if eax == IDB_ABOUT
			invoke  DialogBoxParam,0,IDD_ABOUTBOX,hWin,offset AboutProc,0
		.elseif	eax == IDB_EXIT
			invoke	SendMessage, hWin, WM_CLOSE, 0, 0
		.endif
	.elseif	eax == WM_CLOSE
		invoke	EndDialog, hWin, 0
	.endif

	xor	eax,eax
	ret
DlgProc endp

end start