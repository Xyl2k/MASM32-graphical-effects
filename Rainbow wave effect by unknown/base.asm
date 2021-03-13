; «Low-level programming is good for the programmer's soul.» - John Carmack
; ---- skeleton -----------------------------------------------------------
.686
.mmx			
.model flat, stdcall
option casemap :none

; ---- Include ------------------------------------------------------------
include		\masm32\include\windows.inc
include		\masm32\include\user32.inc
include		\masm32\include\kernel32.inc
include		\masm32\include\comctl32.inc
include		\masm32\include\gdi32.inc
include		\masm32\macros\macros.asm
include		Libs\XXControls.inc

include 	Libs\Aboutb0x.inc

includelib	\masm32\lib\gdi32.lib
includelib	\masm32\lib\winmm.lib
includelib	\masm32\lib\user32.lib
includelib	\masm32\lib\kernel32.lib
includelib	\masm32\lib\comctl32.lib
includelib	Libs\XXControls.lib


; ---- Prototypes ---------------------------------------------------------
DlgProc					PROTO :DWORD,:DWORD,:DWORD,:DWORD
CenterWindow			PROTO :DWORD
DrawXXControlButtons	PROTO :DWORD
DrawEffects				PROTO :HWND

; ---- constants ----------------------------------------------------------
.const
IDD_MAIN    	equ	1337
IDC_TITLE		equ	1010
IDC_NAME		equ	1013
IDC_CANCEL equ	1004
IDC_OK equ	1003
IDC_SERIAL		equ	1014
EFFECTS_HEIGHT	equ	207
EFFECTS_WIDTH	equ	344

; ---- Initialized data ---------------------------------------------------
.data
szTitle						db "Enjoy that rainbow wave effect on a black background :)",0
pIntroBackBufferThreadID	dd 0
screenHeight				dd 0
screenWidth					dd 0
wDC1 						dd 0
wDC2 						dd 0
y 							dd 0
x 							dd 0
x1							dd 0
R							dd 0
G							dd 0
B							dd 0
B1							dd 0
B2							dd 0
B3							dd 0
B4							dd 0
B5							dd 0
B6							dd 0

; ---- Uninitialized data -------------------------------------------------
.data? 
iHWND		dd 			?
hInstance	dd			?
hBlackBrush	HBRUSH		?
hExit		BOOL		?
hMatrix		DWORD		?
hDC			HANDLE		?

; ---- Macro --------------------------------------------------------------
$invoke MACRO Fun:REQ, A:VARARG
  IFB <A>
    invoke Fun
  ELSE
    invoke Fun, A
  ENDIF
  EXITM <eax>
ENDM

; ---- Code ---------------------------------------------------------------
.code
start: 
	invoke	InitCommonControls
	mov hBlackBrush,$invoke	(CreateSolidBrush,Black)
	mov	hInstance,$invoke	(GetModuleHandle, NULL)
	
	invoke	DialogBoxParam, hInstance, IDD_MAIN, NULL, offset DlgProc, 0
	invoke	ExitProcess,NULL
	
DlgProc proc uses esi edi hWnd:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
local rect:RECT,hDrawEffects:HANDLE
		PUSHAD
		mov EAX,hWnd
		mov iHWND,EAX
		PUSHAD
		mov	eax,uMsg
		push hWnd
		
	.if	uMsg == WM_INITDIALOG
		invoke GetParent,hWnd
		mov ecx,eax
		invoke GetWindowRect,ecx,addr rect
		mov edi,rect.left
		mov esi, rect.top
		add edi,25
		add esi,100
		invoke	LoadIcon,hInstance,200
		invoke	SendMessage, hWnd, WM_SETICON, 1, eax
		invoke	SetDlgItemText,hWnd,IDC_TITLE,addr szTitle
		invoke	SetWindowText,iHWND,chr$('Matrix bar scroller')
		invoke	SetDlgItemText,iHWND,IDC_NAME,chr$('https://github.com/Xyl2k/MASM32-graphical-effects')
		invoke	CenterWindow,hWnd
		invoke	DrawXXControlButtons,hWnd
		
		mov hMatrix,$invoke	(VirtualAlloc,NULL,0*EFFECTS_WIDTH+100,MEM_COMMIT,PAGE_READWRITE)
		invoke	BuildMatrix
		mov hDrawEffects,$invoke (CreateThread,NULL,0,addr DrawEffects,hWnd,0,addr pIntroBackBufferThreadID)
		invoke	SetThreadPriority,hDrawEffects,THREAD_PRIORITY_NORMAL
	.elseIF uMsg == WM_CTLCOLORDLG
		mov eax,wParam
		invoke SetBkColor,eax,Black
		invoke GetStockObject,BLACK_BRUSH
		ret
	.elseif uMsg==WM_CTLCOLOREDIT || uMsg==WM_CTLCOLORSTATIC
		invoke SetBkMode,wParam,OPAQUE
		invoke SetBkColor,wParam,000000h
		invoke SetTextColor,wParam,0FCDC7Ch
		invoke GetStockObject,BLACK_BRUSH
		ret
	.elseif uMsg == WM_CTLCOLORBTN
      invoke CreateSolidBrush, 000000FFh
      ret
	.elseif	uMsg == WM_COMMAND
		MOV EAX,wParam
			.IF ax==IDC_CANCEL
			invoke EndDialog,hWnd,0
		.endif
	.elseif	eax == WM_CLOSE
		invoke	EndDialog,hWnd,0
	.endif

	xor	eax,eax
	ret
DlgProc	endp

DrawEffects	Proc hWnd:HWND
	local bmpi1:BITMAPINFO
; ---- Activate Vectors ---------------------------------------------------

			mov hDC,$invoke (GetDC,hWnd)
			invoke CreateCompatibleDC,hDC
			mov wDC1,eax
			mov wDC2,eax
			invoke CreateCompatibleBitmap,hDC,EFFECTS_WIDTH,1
			invoke SelectObject,wDC1,eax
			invoke DeleteObject,eax
			invoke CreateCompatibleBitmap,hDC,EFFECTS_WIDTH,1
			invoke SelectObject,wDC2,eax
			invoke DeleteObject,eax
			_back:
			invoke DrawColorScroller
			.if hExit != TRUE
				invoke	Sleep,20
				invoke BitBlt,hDC,left,29,EFFECTS_WIDTH,1,wDC1,0,0,SRCCOPY
				invoke BitBlt,hDC,344,29,EFFECTS_WIDTH,1,wDC1,0,0,SRCCOPY
			
				invoke BitBlt,hDC,left,25+EFFECTS_HEIGHT,EFFECTS_WIDTH,1,wDC2,0,0,SRCCOPY
				invoke BitBlt,hDC,344,25+EFFECTS_HEIGHT,EFFECTS_WIDTH,1,wDC2,0,0,SRCCOPY

				jmp _back
			.endif	
			mov x1,0
		invoke	DeleteDC,wDC1
		invoke	DeleteDC,wDC2
	Ret
DrawEffects endp

DrawColorScroller	Proc
	mov esi,hMatrix
	mov x,0
	; Commented commands would be useful only when we build a matrix on screen, instead of 2 scrolling vectors
	;mov y,0
	;	.repeat
			.repeat
				mov eax,x1
				add eax,x
				mov ebx,EFFECTS_WIDTH
				xor edx,edx
				idiv ebx
				push edx
				invoke SetPixel,wDC1,edx,y,dword ptr [esi]
				mov eax,EFFECTS_HEIGHT
			;	add eax,y
				pop edx
			;	add esi,EFFECTS_WIDTH*4*EFFECTS_HEIGHT-EFFECTS_WIDTH*4
			;	sub esi,20h
				invoke SetPixel,wDC2,edx,eax,dword ptr [esi]
			;	add esi,20h
			;	sub esi,EFFECTS_WIDTH*4*EFFECTS_HEIGHT-EFFECTS_WIDTH*4
				add esi,4
				inc x
			.until x == EFFECTS_WIDTH
			mov x,0
	;		inc y
	;	.until y == 1 ;EFFECTS_HEIGHT
	;	mov y,0
		add x1,5		;	Speed of wave
	Ret
DrawColorScroller endp

CenterWindow	Proc hWnd:HWND
LOCAL rc:RECT
	mov screenWidth,$invoke	(GetSystemMetrics,SM_CXSCREEN)
	mov screenHeight,$invoke (GetSystemMetrics,SM_CYSCREEN)
	invoke	GetWindowRect,hWnd,addr rc
	mov eax,rc.right
	sub eax,rc.left
	mov ecx,screenWidth
	sub ecx,eax
	shr ecx,1
	mov eax,rc.bottom
	sub eax,rc.top
	mov edx,screenHeight
	sub edx,eax
	shr edx,1
	invoke	SetWindowPos,hWnd,0,ecx,edx,0,0,5;SWP_NOZORDER || SWP_NOSIZE
	Ret
CenterWindow endp

DrawXXControlButtons	Proc	hWnd:HWND
LOCAL sButtonStructure:XXBUTTON,hSmallButtonFont:HFONT,hBtn:HWND
	mov hSmallButtonFont,$invoke	(CreateFont,8,0,0,0,FW_NORMAL,FALSE,FALSE,FALSE,DEFAULT_CHARSET,OUT_CHARACTER_PRECIS,CLIP_CHARACTER_PRECIS,PROOF_QUALITY,FF_DONTCARE,chr$('MS Sans Serif'))
	invoke	RtlZeroMemory,addr sButtonStructure,sizeof sButtonStructure
	invoke	LoadCursor,NULL,IDC_HAND
	mov sButtonStructure.hCursor_hover,eax
	mov sButtonStructure.hover_clr,White
	mov sButtonStructure.push_clr,White
	mov sButtonStructure.normal_clr,White
	mov sButtonStructure.btn_prop, 08000000Fh
	mov hBtn,$invoke	( GetDlgItem,hWnd,IDC_CANCEL )
	invoke	RedrawButton,hBtn,addr sButtonStructure
	mov sButtonStructure.push_clr,0B0B0B0h
	mov sButtonStructure.btn_prop,08000000Bh
	invoke	SetFocus,eax
	mov eax,TRUE
	Ret
DrawXXControlButtons endp

end start