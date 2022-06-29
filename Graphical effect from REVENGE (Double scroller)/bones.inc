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
IDD_MAIN	equ	1000
IDB_EXIT	equ	1001

.data
r3kt		RECT	<>

.data?
hInstance	dd	?
hIMG dd	?
hBrush	dd ?