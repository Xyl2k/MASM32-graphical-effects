; Zorke's DIB Shell
; Example : Razor 1911 Cracktro
; *********************

.486
.model  flat, stdcall  
option  casemap :none 

include gfx.inc
include sine.inc

; includes
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc
include \masm32\include\winmm.inc
include inc\ufmod.inc
; libraries
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\winmm.lib
includelib lib\ufmod.lib

; function prototypes
DlgProc		PROTO :DWORD, :DWORD, :DWORD, :DWORD

; STAR structure
STAR Struct
		color dd ?	; color (unused)
		xpos  dd ?	; x-position
		ypos  dd ?	; y-position
		speed dd ?	; speed (how many pixels to add)
STAR ends

; constants
.const
	sWidth			equ	672 ; Constant for ScreenWidth of DIB Section
	sHeight			equ	481 ; Constant for ScreenHeight of DIB Section
	starlen			equ 10	; Star Length (unused)
.data
	include 		DATA\razor.asm
	include			DATA\font.asm
	rcDraw			RECT 	<0> ; RECT Structure
	Section			db 0
	; MESSAGES!
	rzr_msg			DB " RAZOR 1911 URESENTS ... ",0AAH
					DB " SOME SIERRA GAME CRACK! ",0AAH
					DB " ----------------------- ",0AAH
					DB " THIS IS AN EXAMPLE OF   ",0AAH
					DB " A DEMO IN DIB SECTIONS  ",0AAH
					DB " ----------------------- ",0AAH
					DB " POISE ........... LOGO  ",0AAH
					DB " DUBMOOD ......... TUNE  ",0AAH
					DB " SOURCE CODE INCLUDED !  ",0AAH
					DB " ----------------------- ",0AAH
					DB " CODE BY ZORKE .         ",0
 	scroller		DB "                                     "
 					DB " RAZOR 1911 PRESENTS : AN OLD CRACKTRO ! "
 					DB " AN EXAMPLE OF A DEMO IN A DIB SECTION ! "
 					DB " TUNE BY DUBMOOD ---- LOGO BY POISE ---- "
 					DB " CODE BY ZORKE --------------------------"
 					DB "---------------------- FEEL FREE TO USE  "
 					DB "THE INCLUDED SOURCE CODE IN YOUR OWN PROD"
 					DB "S ---------------------------------------"
 					DB "                                     ",0
.data?
	hInstance		dd		?
	canvasDC		dd		?
	canvasBmp		dd		?
	hDC				dd		?
	cBuffer			dd		?	; Canvas Buffer for DIB section
	ps				PAINTSTRUCT	<>
	canvas			BITMAPINFO	<>
.code

start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	invoke	DialogBoxParam, hInstance, 101, 0, ADDR DlgProc, 0
	invoke	ExitProcess, eax
DlgProc	proc	hWnd	:DWORD,
		uMsg	:DWORD,
		wParam	:DWORD,
		lParam	:DWORD
		LOCAL rect:RECT
		LOCAL bpr:DWORD
	.if uMsg == WM_INITDIALOG
		mov canvas.bmiHeader.biSize,sizeof canvas.bmiHeader ; initialize dib section
		mov canvas.bmiHeader.biWidth,sWidth					; here we are just mov'ing
		mov canvas.bmiHeader.biHeight,-sHeight				; data into a BITMAPINFO structure
		mov canvas.bmiHeader.biPlanes,1						; so we can create DIB section
		mov canvas.bmiHeader.biBitCount,32					; to draw our demo
		invoke GetDC, hWnd
		mov hDC, eax
		invoke CreateCompatibleDC, eax
		mov canvasDC, eax
		invoke CreateDIBSection, hDC, addr canvas, DIB_RGB_COLORS, addr cBuffer, 0, 0	; Creating DIB Section
		mov [canvasBmp],eax
		invoke SelectObject, [canvasDC], eax				; object selected is canvasBmp
		invoke ReleaseDC, hWnd, hDC							; release the DC
		invoke SetTimer, hWnd, 1, 15, 0 					; set up timer to animate stars
		invoke SetTimer, hWnd, 2, 100, 0					; ESC monitor
		invoke SetTimer, hWnd, 3, 2000, 0					; Section Timer
		call initstars
		invoke uFMOD_PlaySong, 400, hInstance, XM_RESOURCE	; play the music!
	.elseif	uMsg == WM_COMMAND
	.elseif uMsg == WM_PAINT
		mov	eax, [hWnd]
		invoke BeginPaint, [hWnd], addr ps
		invoke BitBlt, eax, -32, 0, sWidth, sHeight,canvasDC,0 ,0, SRCCOPY	; we want to bitblt at xP(-32) 
																			; since the stars seed at xP(0)
																			; and we want them to move smoothly
		invoke EndPaint, hWnd, Offset ps
	.elseif uMsg == WM_LBUTTONDOWN
	.elseif	uMsg == WM_CLOSE
		invoke	EndDialog,hWnd,0
	.elseif uMsg == WM_TIMER
		.if wParam == 1
			mov edi, [cBuffer]
			mov ecx,sWidth*sHeight
			xor eax, eax
			rep stosd
			mov edi, [cBuffer]
			;// here go our drawing calls
			.if Section == 0			; Section is flag for which section of demo to play
				invoke DecrunchFX
				invoke Noise, 0, 0 , sWidth-1, sHeight-1, 30000
				invoke ScanLines, 022h
			.elseif Section == 1
				invoke MoveStars, 22h
				invoke DXYCPSineScroll, 320, offset scroller, offset font_pal, offset font_img, 960, 16, 16, cBuffer
				invoke BlitImg, 81, 0, offset razor_pal, offset razor_img, 564, 104, 0
				invoke DYCPSineText, 140, 120, offset rzr_msg, offset font_pal, offset font_img, cBuffer, 960, 16,16
				invoke Noise, 0, 0 , sWidth-1, sHeight-1, 30000
				invoke ScanLines, 22h
			.endif
			;\\ now we invalidate our DIB Section
			invoke GetClientRect, hWnd, addr rect			; get client RECT
			invoke InvalidateRect, hWnd, addr rect, FALSE	; invalidate RECT
		.elseif wParam == 2
			invoke GetKeyState, VK_ESCAPE
			.if eax > 1
				invoke SendMessage, hWnd, WM_CLOSE, 0, 0
			.endif
		.elseif wParam == 3
			.if Section == 0
				inc Section
			.endif
		.endif
	.endif
	xor	eax,eax
	ret
DlgProc	endp

end start