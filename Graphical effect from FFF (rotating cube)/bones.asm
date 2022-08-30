.686
.model	flat, stdcall
option	casemap :none

include		bones.inc
include 	rotatingcube.asm

.code
start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	invoke	InitCommonControls
	invoke	DialogBoxParam, hInstance, IDD_MAIN, 0, offset DlgProc, 0
	invoke	ExitProcess, eax

DlgProc proc hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
	mov	eax,uMsg

	push hWin
	pop xWnd
	
	.if	eax==WM_INITDIALOG
		invoke LoadIcon,hInstance,200
		invoke SendMessage,xWnd,WM_SETICON,1,eax
		invoke SetWindowText,xWnd,addr WindowTitle
		invoke GetClientRect,xWnd,offset CubeRekt
		invoke CreateThread,0,0,offset CubeProc,0,0,offset ThreadId
		mov CubeThread,eax
		invoke SetThreadPriority,offset CubeThread,THREAD_PRIORITY_ABOVE_NORMAL
	.elseif eax==WM_CTLCOLORDLG
		mov eax,wParam
		invoke SetBkColor,eax,Black
		invoke GetStockObject,BLACK_BRUSH
		ret
	.elseif eax==WM_CTLCOLOREDIT || eax==WM_CTLCOLORSTATIC
		invoke SetBkMode,wParam,TRANSPARENT
		invoke SetBkColor,wParam,Black
		invoke SetTextColor,wParam,White
		invoke GetStockObject,BLACK_BRUSH
		ret
	.elseif eax==WM_LBUTTONDOWN
		invoke SendMessage,xWnd,WM_NCLBUTTONDOWN,HTCAPTION,0
	.elseif eax==WM_RBUTTONUP
		invoke SendMessage,xWnd,WM_CLOSE,0,0
	.elseif	eax==WM_CLOSE
		invoke DeleteObject,cubeDC
		invoke TerminateThread,CubeThread,0
		invoke EndDialog,xWnd,0
	.endif

	xor	eax,eax
	ret
	
DlgProc endp

end start