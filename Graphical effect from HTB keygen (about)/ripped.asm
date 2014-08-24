;                                                                           
;[= THE ===========================================================================]  
;[] _________ ____   ____ _______  _____  _____  _____                 ____  ____ []  
;[] \       / \   | |   / \      \ \    \ \    \ \    \     /\     /\  \   \/   / []  
;[] /   ___/   |  | |  |   |   > / /   > \ |  > \ |    \   /  \   /  \  |      |  []  
;[] \   \___   |  |_|  |   |   > \ \  ___/ | |  / |  >  \ / /\ \ / /\ \ | |\/| |  []  
;[]  \____  \   \_   _/    |___  /  \___ \ |_|\ \ |___  / \__  / \__  / |_|  | |  []  
;[]       \/      | |          \/       \/     \/     \/     \/     \/        \|  []  
;[=============== |/ =============================================== SYSTEMS ======]  
;                             Presents:                                               
;                            Ripped code
;                     Ripped/modifed by CyberDoom



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

INCLUDE    \masm32\INCLUDE\winmm.inc
INCLUDELIB \masm32\LIB\winmm.lib



tagRECT STRUCT
 left    dd ?
 top     dd ?
 right   dd ?
 bottom  dd ?
tagRECT ENDS    



DlgProc   PROTO :DWORD,:DWORD,:DWORD,:DWORD
.data

include data.inc

.DATA?


hInstance dd ?
ps PAINTSTRUCT <>
mdc dd ?
hbr dd ?

.CODE
include proc.inc
include dlg.inc
start:
     invoke GetModuleHandle,0
     mov hInstance,eax
     
     invoke DialogBoxParam,eax,134,0,OFFSET sub_401760,0
     invoke ExitProcess,0


END start