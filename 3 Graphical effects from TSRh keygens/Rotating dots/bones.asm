.386
.model	flat, stdcall
option	casemap :none

include		bones.inc
include	RotatingDotz.asm

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
	pop xWnd ;<-- this needs to initiate a new handle for the animation
					 ;    , so if i set the handle (from the GetDlgItem in Star
					 ;    tAddress function) to this hWin variable from the Dlg
					 ;    Proc function,might get a compile error saying hWin 
					 ;    is undefined. 
	
	.if	eax == WM_INITDIALOG
		invoke	LoadIcon,hInstance,200
		invoke	SendMessage, xWnd, WM_SETICON, 1, eax
		invoke  SetWindowText,xWnd,addr WindowTitle
		invoke 	CreateFontIndirect,addr LogFont
		mov hFont,eax
		invoke 	SendMessage,eax,WM_SETFONT,hFont,1
		invoke  GetDlgItem,xWnd,11
		mov hInfo,eax
		invoke SendMessage,eax,WM_SETFONT,hFont,1
		lea eax, [ThreadId] ;<-- changed to a global var to a local one to prevent crashing before loading. 
							;(thx 2 kao for pointing that out)
		invoke  CreateThread,0,0,offset RotatingDotz,0,0,eax                                   
		mov DottedShapezId, eax                 
		invoke  SetThreadPriority,eax,THREAD_PRIORITY_HIGHEST ; 2 = THREAD_PRIORITY_HIGHEST 
						;(in IDA pro the priority number was set to 2 so i initiated it directly.)             
	.elseif eax == WM_CTLCOLORDLG
		mov eax,wParam
		invoke  SetBkColor,eax,White
		invoke  GetStockObject,WHITE_BRUSH
		ret
	.elseif eax==WM_CTLCOLOREDIT || eax==WM_CTLCOLORSTATIC
		invoke  SetBkMode,wParam,OPAQUE
		invoke  SetBkColor,wParam,White
		invoke  SetTextColor,wParam,Black
		invoke  GetStockObject,WHITE_BRUSH
		ret
	.elseif eax==WM_LBUTTONDOWN
		invoke 	SendMessage,xWnd,WM_NCLBUTTONDOWN,HTCAPTION,0
	.elseif eax==WM_RBUTTONUP
		invoke  SendMessage,xWnd,WM_CLOSE,0,0
	.elseif	eax == WM_CLOSE
		invoke  DeleteObject,DotzDC
		invoke  TerminateThread,DottedShapezId,0
		invoke	EndDialog, hWin, 0
	.endif

	xor	eax,eax
	ret
DlgProc endp

end start