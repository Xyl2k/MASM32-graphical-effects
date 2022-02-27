include		\masm32\include\windows.inc 
include		\masm32\include\kernel32.inc 
include		\masm32\include\user32.inc 
include     \masm32\include\gdi32.inc  
include		\masm32\include\comctl32.inc

include     \masm32\macros\macros.asm

includelib	\masm32\lib\kernel32.lib
includelib	\masm32\lib\user32.lib 
includelib 	\masm32\lib\gdi32.lib
includelib	\masm32\lib\comctl32.lib


DlgProc		PROTO	:DWORD,:DWORD,:DWORD,:DWORD

.const
IDD_MAIN	equ	100
IDC_STATIC1002	equ	1002

.data
WindowTitle		db	"some lines animation from UnderPL and HTB keygenz",0
r3kt			RECT	<>
TxtFont		LOGFONT <12,0,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'ms sans serif'>
.data?
hInstance	dd ?
xWnd		dd ?
hIMG		dd ?
hFont		dd ?
hStatic		dd ?
hBrush		dd ?
nHeight    	dd ?
nWidth		dd ?
WndRect		RECT	<>
StaticRect	RECT	<>

; !!! necessary variables for the animation !!!
hAnim		 	dd ?
xThread 	    dd ?