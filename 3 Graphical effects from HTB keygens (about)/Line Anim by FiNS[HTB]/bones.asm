.686
.model	flat, stdcall
option	casemap :none

include		bones.inc
include     lineanim.asm

;width = 15Eh (350) - 15Dh
;height = 9Fh (159) - 9Eh

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
 
 		push hDlg
 		pop xWnd
		mov eax, 350
		mov nHeight, eax
		mov eax, 159
		mov nWidth, eax                
		invoke GetSystemMetrics,0                
		sub eax, nHeight
		shr eax, 1
		mov [X], eax
		invoke GetSystemMetrics,1               
		sub eax, nWidth
		shr eax, 1
		mov [Y], eax
		invoke SetWindowPos,xWnd,0,X,Y,nHeight,nWidth,40h
            	
		invoke	LoadIcon,hInstance,200
		invoke	SendMessage, xWnd, WM_SETICON, 1, eax
		invoke  SetWindowText,xWnd,addr WindowTitle
		invoke CreateFontIndirect,addr TxtFont
		mov hFont,eax
		invoke GetDlgItem,xWnd,IDC_STATIC1002
		mov hStatic,eax
		invoke SendMessage,eax,WM_SETFONT,hFont,1
		invoke CreateThread,0,0,offset LineAnim,xWnd,0,offset hAnim
		mov xThread, eax

	.elseif [uMessg] == WM_LBUTTONDOWN

		invoke SendMessage, xWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0
	
	.elseif [uMessg] == WM_RBUTTONUP

		invoke SendMessage, xWnd, WM_CLOSE, 0, 0

	.elseif [uMessg] == WM_CTLCOLORDLG

		return hBrush

	.elseif [uMessg] == WM_PAINT
                
		invoke BeginPaint,xWnd,addr BmpBackground
		mov edi,eax
		lea ebx,r3kt
		assume ebx:ptr RECT
                
		invoke GetClientRect,xWnd,ebx
		invoke CreateSolidBrush,0
		invoke FrameRect,edi,ebx,eax
		invoke EndPaint,xWnd,addr BmpBackground                   
     
	.elseif [uMessg] == WM_CTLCOLORSTATIC
	
		invoke SetBkMode,wParams,TRANSPARENT
		invoke SetTextColor,wParams,White
		invoke GetWindowRect,xWnd,addr WndRect
		invoke GetDlgItem,xWnd,IDC_STATIC1002
		invoke GetWindowRect,eax,addr StaticRect
		mov edi,WndRect.left
		mov esi,StaticRect.left
		sub edi,esi
		mov ebx,WndRect.top
		mov edx,StaticRect.top
		sub ebx,edx
		invoke SetBrushOrgEx,wParams,edi,ebx,0
		mov eax,hBrush
		ret
             
	.elseif [uMessg] == WM_CLOSE    
		invoke TerminateThread,xThread,0
		invoke EndDialog,xWnd,0     
	.endif
         xor eax,eax
         ret
DlgProc endp


end start