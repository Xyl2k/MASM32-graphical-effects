comment /*
/

.686p
.model flat, stdcall
option casemap :none ; case sensitive

include                 \masm32\include\windows.inc ; main windows include file
include                 \masm32\include\kernel32.inc
include                 \masm32\include\user32.inc
include                 \masm32\include\gdi32.inc
include                 \masm32\include\masm32.inc

includelib              \masm32\lib\kernel32.lib
includelib              \masm32\lib\user32.lib
includelib              \masm32\lib\gdi32.lib
includelib              \masm32\lib\masm32.lib

include                 \masm32\macros\macros.asm

DlgProc        PROTO :DWORD,:DWORD,:DWORD,:DWORD

DoScrolltxt    PROTO :DWORD

.const
; Dialog members
ICON_APP            equ 101

IDB_QUIT            equ 1003
IDB_BITMAP1			equ 108
IDC_IMAGE1019		equ 1019

.data

    ; Colour settings in the form BBGGRR
    ; Group box colour settings
    GBTextCol    dd 000000FFh
    GBBackCol    dd 000000h
    ; Static text/Edit box colours
    STEBTextCol  dd 00FF0000h
    STEBBackCol  dd 000000h
    ; Dialog background colour
    DlgBGCol     dd 000000h

; Dialog details

szTitle                 db "Another graphical effect",0
                
	;------------------------------- Scroll Text data
	WX				equ 346
	WY				equ 133
	top				equ 38
	left			equ 0
	ppv				dd ?
	hBackgrndBitMap dd 0
	hPictureDC		dd 0
	hMemScrolltxtDC	dd ?
	hMemBackgrndDC	dd ?
	thread			dd ?
	threadID		dd ?

	pScrolltxtFont2 LOGFONT <0,0,0,0,FW_NORMAL,FALSE,FALSE,FALSE,ANSI_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,DEFAULT_PITCH,"Fixedsys">

	szScrolltxtText	db 13
					db 'Enjoy this nice scroller',13,13,13
					db 'Over a nice bitmap',13,13
					db 'Greeting to',13
					db 'all my assembly coder friends!',13
					db 'r0ger/PRF and other positives ppl',13,13
					db 'blablablabla',13
					db 'blabla',13,13,13,13,13
					db '                      ',13,13,13,13,13,13,13
					db 'scroller restart :)',0
                
.data?

    hInstance    dd ?
    hFinger      dd ?
    hDlgBGBrush  dd ?
    hParentWnd   dd ?
    hSTEBBGCol   dd ?

	hBrushBack			HWND ?
	hPictureCtrl		HWND ?

$invoke MACRO Fun:REQ, A:VARARG
  IFB <A>
    invoke Fun
  ELSE
    invoke Fun, A
  ENDIF
  EXITM <eax>
ENDM


; Program code section
.code
start:
    ; This function is the entrypoint of the program. 
    invoke GetModuleHandle,NULL
    mov hInstance,eax
    invoke DialogBoxParam,hInstance,101,0,addr DlgProc,0
    invoke ExitProcess,eax

DlgProc proc    hWin    :DWORD,
                uMsg    :DWORD,
                wParam  :DWORD,
                lParam  :DWORD
    LOCAL off_set:DWORD
    LOCAL pFileMem:DWORD

    .if uMsg == WM_INITDIALOG
        mov eax,hWin
        mov hParentWnd,eax   ; Store the main window handle for global use
        invoke DoScrolltxt,hWin


        invoke SetWindowText,hWin,addr szTitle ; Set the window title text
        invoke LoadIcon,hInstance,ICON_APP
        invoke SendMessage, hWin, WM_SETICON, 1, eax

  .elseif uMsg == WM_COMMAND
            mov eax,wParam
            mov edx,eax
            shr edx,16
            and eax,0FFFFh
        .if wParam == IDB_QUIT
            invoke SendMessage,hWin,WM_CLOSE,0,0
        .endif
    .elseIF uMsg == WM_CTLCOLORDLG
            invoke CreateSolidBrush,000000h
            ret
    .elseif uMsg == WM_CTLCOLORSTATIC || uMsg==WM_CTLCOLOREDIT
            invoke SetBkColor,wParam,000000h
            invoke SetTextColor,wParam,0000FF00h
            invoke CreateSolidBrush,000000h
            ret
            
    .elseif uMsg == WM_CTLCOLORLISTBOX
            invoke SetBkColor,wParam,0000000h
            invoke SetTextColor,wParam,0000FF00h
            invoke CreateSolidBrush,0000000h
            ret 
    .elseif uMsg == WM_CTLCOLORBTN
            invoke CreateSolidBrush, 0000000h
            ret
    .elseIf uMsg== WM_LBUTTONDOWN
            invoke ReleaseCapture
            invoke SendMessage,hWin,WM_NCLBUTTONDOWN,HTCAPTION,0

    .elseif uMsg == WM_DESTROY
        
			invoke TerminateThread,threadID,0
			invoke DeleteDC,hMemScrolltxtDC
			invoke DeleteObject,hBackgrndBitMap
			invoke DeleteObject,hPictureDC
			invoke DeleteDC,hMemBackgrndDC
    .elseif uMsg == WM_CLOSE
        invoke EndDialog,hWin,0
    .endif
    xor eax,eax
    ret
DlgProc endp

align 4
	;------------------------------- Scroll Text Thread
	ScrolltxtThread proc
		local rect3:RECT
		local int_position:dword
		local local_match:dword

		mov int_position, WY
		mov local_match,2

		@ScrolltxtLoop:
		invoke BitBlt, hMemScrolltxtDC, 0, 0, WX, WY, hMemBackgrndDC, 0, 0, SRCCOPY	; Copy Background
		invoke SetRect,addr rect3, left,  int_position, WX, WY
		invoke lstrlen,addr szScrolltxtText
		mov edi,eax
		invoke DrawText, hMemScrolltxtDC, addr szScrolltxtText, edi, addr rect3, DT_TOP or DT_EXPANDTABS or DT_CENTER
		invoke BitBlt, hPictureDC, 0, 0, WX, WY, hMemScrolltxtDC, 0, 0, SRCCOPY ; Picture Device Control

		.if int_position == -1A0h ;-0190h
			mov int_position, WY
		.endif

		dec local_match

		.if local_match == 1
			dec int_position
			mov local_match,4
		.endif

		invoke Sleep,10
		jmp @ScrolltxtLoop
		ret
	ScrolltxtThread endp

	align 4

	;------------------------------- Init and Run Scroll Text
	DoScrolltxt proc hWnd:dword
		local bmpi:BITMAPINFO
		;------------------------------- Load Background
		invoke CreateCompatibleDC, NULL				; Creates a memory device context (DC) compatible with the application's current screen (NULL).
		mov hMemBackgrndDC, eax
		invoke LoadBitmap,hInstance,108
		mov hBackgrndBitMap,eax
		invoke SelectObject,hMemBackgrndDC,hBackgrndBitMap
		;------------------------------- Get Picture Control DC
		invoke GetDlgItem,hWnd,IDC_IMAGE1019		; Retrieves a handle to a control in the specified dialog box. 
		mov hPictureCtrl, eax
		invoke GetDC, hPictureCtrl					; Get Device Context of the control
		mov hPictureDC, eax
		invoke CreateCompatibleDC, hPictureDC		; Creates a memory device context (DC) compatible with the specified device.
		mov hMemScrolltxtDC, eax
		;-------------------------------
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
		invoke CreateDIBSection, hMemScrolltxtDC, addr bmpi, DIB_RGB_COLORS, addr ppv, 0, 0
		invoke SelectObject, hMemScrolltxtDC, eax
		invoke CreateFontIndirect,addr pScrolltxtFont2
		invoke SelectObject, hMemScrolltxtDC, eax
		invoke SetBkMode, hMemScrolltxtDC, TRANSPARENT
		invoke SetTextColor, hMemScrolltxtDC, 0FEFEFEh
		;-------------------------------
		invoke CreateThread, 0, 0, offset ScrolltxtThread, 0, 0, addr thread
		mov threadID,eax
		invoke SetThreadPriority,eax,THREAD_PRIORITY_LOWEST
		ret
	DoScrolltxt endp

end start