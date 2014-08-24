
.386
.model flat,stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

INCLUDE    \masm32\INCLUDE\gdi32.inc
INCLUDELIB \masm32\LIB\gdi32.lib

INCLUDE    \masm32\INCLUDE\oleaut32.inc
INCLUDELIB \masm32\LIB\oleaut32.lib

INCLUDE \masm32\MACROS\MACROS.ASM


LUNA =1;DRAW MOON? if not comment this!



DlgProc   PROTO :DWORD,:DWORD,:DWORD,:DWORD
.data
include data.inc



.DATA?


hInstance dd ?


.CODE

include dlg.inc
include proc.inc
include proc2.inc
start:
     invoke GetModuleHandle,0
     mov hInstance,eax
     
     call init
     
     
     invoke DialogBoxParam,hInstance,128,0,OFFSET DialogFunc ,0
     invoke ExitProcess,0



END start