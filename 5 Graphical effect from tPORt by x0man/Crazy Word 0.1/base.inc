include \masm32\include\windows.inc

include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\gdi32.inc  
include	\masm32\include\oleaut32.inc
include	\masm32\include\ole32.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib 	\masm32\lib\gdi32.lib
includelib  \masm32\lib\oleaut32.lib
includelib 	\masm32\lib\ole32.lib

DlgProc		PROTO :DWORD,:DWORD,:DWORD,:DWORD

IDC_OK 			equ	1003
IDC_IDCANCEL 	equ	1004

.data?
hInstance		dd		?	;dd can be written as dword    
hBitmap		dd	?  

.const
IDD_ABOUTBOX	equ	2000
p00p		equ	1453
