.686
.model	flat, stdcall
option	casemap :none

include	bones.inc
include star_by_str.asm

.code
start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	invoke	InitCommonControls
	invoke LoadBitmap,hInstance,400
		mov hIMG,eax
		invoke CreatePatternBrush,eax
		mov hBrush,eax
	invoke	DialogBoxParam, hInstance, IDD_MAIN, 0, offset DlgProc, 0
	invoke	ExitProcess, eax

DlgProc proc hDlg:DWORD,uMessg:DWORD,wParams:WPARAM,lParam:LPARAM
LOCAL X:DWORD
LOCAL Y:DWORD
LOCAL BmpBackground:PAINTSTRUCT

	
	.if [uMessg] == WM_INITDIALOG
 
		mov eax, 373
		mov nHeight, eax
		mov eax, 202
		mov nWidth, eax                
		invoke GetSystemMetrics,0                
		sub eax, nHeight
		shr eax, 1
		mov [X], eax
		invoke GetSystemMetrics,1               
		sub eax, nWidth
		shr eax, 1
		mov [Y], eax
		invoke SetWindowPos,hDlg,0,X,Y,nHeight,nWidth,40h 	
		invoke	LoadIcon,hInstance,200
		invoke	SendMessage, hDlg, WM_SETICON, 1, eax
		invoke  SetWindowText,hDlg,addr WindowTitle
		call StarInit
		push wParams
		pop hh
		push hDlg
		pop xWnd	
		invoke CreateThread,0,0,offset StarfieldProc,0,0,offset StarfieldId
		mov dword_409840,0
		
	.elseif [uMessg] == WM_LBUTTONDOWN

		invoke SendMessage, hDlg, WM_NCLBUTTONDOWN, HTCAPTION, 0
	
	.elseif [uMessg] == WM_RBUTTONUP

		invoke SendMessage, hDlg, WM_CLOSE, 0, 0

	.elseif [uMessg] == WM_CTLCOLORDLG

		return hBrush

	.elseif [uMessg] == WM_PAINT
                
		invoke BeginPaint,hDlg,addr BmpBackground
		mov edi,eax
		lea ebx,r3kt
		assume ebx:ptr RECT
                
		invoke GetClientRect,hDlg,ebx
		invoke CreateSolidBrush,White
		invoke FrameRect,edi,ebx,eax
		invoke EndPaint,hDlg,addr BmpBackground       
             
	.elseif [uMessg] == WM_CLOSE    
		invoke EndDialog,hDlg,0     
	.endif
         xor eax,eax
         ret
DlgProc endp


end start