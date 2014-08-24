
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






; Определение дочерних контролов из RC
; ------------------------------------
IDE_TXT   EQU 201
IDB_B64   EQU 202
IDB_ASCII EQU 203
IDB_EXIT  EQU 204

DlgProc   PROTO :DWORD,:DWORD,:DWORD,:DWORD
.data
include data.inc



.DATA?
; Буферы для преобразования
; -------------------------
MAX_B64   EQU 260
MAX_ASCII EQU MAX_B64 * 2 / 3
buffer1   db MAX_B64 dup (?)
buffer2   db MAX_ASCII dup (?)

hInstance dd ?


.CODE

include proc.inc
include proc1.inc
include proc2.inc

start:
     invoke GetModuleHandle,0
     mov hInstance,eax
     
     
     
     
     invoke DialogBoxParam,eax,744,0,OFFSET DlgProc,0
     invoke ExitProcess,0



END start