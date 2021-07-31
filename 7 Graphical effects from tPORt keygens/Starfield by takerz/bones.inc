include \masm32\INCLUDE\windows.inc
include \masm32\INCLUDE\user32.inc
include \masm32\INCLUDE\kernel32.inc
include \masm32\INCLUDE\shell32.inc
include \masm32\INCLUDE\comctl32.inc
include \masm32\INCLUDE\comdlg32.inc
include \masm32\INCLUDE\winmm.inc

includelib \masm32\LIB\user32.lib
includelib \masm32\LIB\kernel32.lib
includelib \masm32\LIB\shell32.lib
includelib \masm32\LIB\comctl32.lib
includelib \masm32\LIB\comdlg32.lib
includelib \masm32\LIB\winmm.lib

INCLUDE    \masm32\INCLUDE\gdi32.inc
INCLUDELIB \masm32\LIB\gdi32.lib
INCLUDE    \masm32\INCLUDE\oleaut32.inc
INCLUDELIB \masm32\LIB\oleaut32.lib

include ufmod.inc
includelib ufmod.lib

DlgProc		PROTO	:DWORD,:DWORD,:DWORD,:DWORD

.const
IDD_MAIN	equ	1000
IDD_ABOUTBOX	equ	2000
IDB_EXIT	equ	1001
IDB_ABOUT	equ	1002
.data
include crocoprinter.inc

.data?
hInstance	dd	?