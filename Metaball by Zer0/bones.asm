.386
.model	flat, stdcall
option	casemap :none

include		bones.inc
include		meatballz_by_Zer0.asm

.code
start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	invoke	InitCommonControls
	invoke	DialogBoxParam, hInstance, IDD_MAIN, 0, offset DlgProc, 0
	invoke	ExitProcess, eax

DlgProc proc hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
LOCAL ps:PAINTSTRUCT
	mov	eax,uMsg
	
	.if	eax == WM_INITDIALOG
		invoke	LoadIcon,hInstance,200
		invoke	SendMessage, hWin, WM_SETICON, 1, eax
		invoke SetWindowText,hWin,addr WindowTitle
		invoke LoadBitmap,hInstance,300
		mov hIMG,eax
		invoke CreatePatternBrush,hIMG
		mov hBrush,eax
		invoke CreateFontIndirect,addr Newfont
		mov hFont,eax
		invoke GetDlgItem,hWin,1001
		mov hStatic,eax
		invoke SendMessage,eax,WM_SETFONT,hFont,1
		invoke MeatballzInit,hWin
	.elseif eax == WM_CTLCOLORDLG
		return hBrush
	.elseif eax == WM_PAINT
		invoke BeginPaint,hWin,addr ps
		mov edi,eax
		lea ebx,r3kt
		assume ebx:ptr RECT
	
		invoke GetClientRect,hWin,ebx
		invoke CreateSolidBrush,0
		invoke FrameRect,edi,ebx,eax
		invoke EndPaint,hWin,addr ps
	.elseif eax == WM_CTLCOLORSTATIC
	
		invoke SetBkMode,wParam,TRANSPARENT
		invoke SetTextColor,wParam,White
		invoke GetWindowRect,hWin,addr WndRect
		invoke GetDlgItem,hWin,1001
		invoke GetWindowRect,eax,addr StaticRect
		mov edi,WndRect.left
		mov esi,StaticRect.left
		sub edi,esi
		mov ebx,WndRect.top
		mov edx,StaticRect.top
		sub ebx,edx
		invoke SetBrushOrgEx,wParam,edi,ebx,0
		mov eax,hBrush
		ret
	.elseif eax == WM_LBUTTONDOWN
		invoke SendMessage,hWin,WM_NCLBUTTONDOWN,HTCAPTION,0
	.elseif eax == WM_RBUTTONUP
		invoke SendMessage,hWin,WM_CLOSE,0,0
	.elseif	eax == WM_CLOSE
		invoke	EndDialog, hWin, 0
	.endif

	xor	eax,eax
	ret
DlgProc endp

end start