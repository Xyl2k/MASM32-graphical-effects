include	/masm32/include/windows.inc 
include	/masm32/include/kernel32.inc 
include	/masm32/include/user32.inc 
include /masm32/include/gdi32.inc
include	/masm32/include/masm32.inc
include	/masm32/include/msvcrt.inc
include	/masm32/include/comctl32.inc
include /masm32/macros/macros.asm

includelib	/masm32/lib/kernel32.lib
includelib	/masm32/lib/user32.lib 
includelib 	/masm32/lib/gdi32.lib
includelib 	/masm32/lib/masm32.lib
includelib	/masm32/lib/msvcrt.lib
includelib	/masm32/lib/comctl32.lib

include /masm32/include/msimg32.inc
includelib /masm32/lib/msimg32.lib

DlgProc		PROTO	:DWORD,:DWORD,:DWORD,:DWORD

.const
IDD_MAIN	equ	1000

.data
WindowTitle	db	"Graphical effect from REVENGE keygen by lord_Phoenix",0
;Newfont LOGFONT <12,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'terminal'>
r3kt		RECT	<>

.data?
hInstance	dd	?
hIMG 		dd	?
hBrush		dd  ?
hFont		dd	?
hStatic	dd	?
WndRect	RECT	<>
StaticRect	RECT	<>