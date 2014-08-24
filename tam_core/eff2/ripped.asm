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


hInstance dd ?

ps PAINTSTRUCT <>
.CODE
include timer.inc

start:
     invoke GetModuleHandle,0
     mov hInstance,eax
     
     invoke DialogBoxParam,eax,134,0,OFFSET DlgProc,0
     invoke ExitProcess,0

DlgProc PROC hWnd:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
     mov eax,uMsg
     .IF eax == WM_COMMAND
         mov eax,wParam
         cmp ax,IDB_EXIT
         je @exit
         
         cmp ax,1
         je @exit
         
         .IF ax == IDB_ASCII

            
             

         .ELSEIF ax == IDB_B64

            
            
             

         .ENDIF
     
     .elseif eax==WM_INITDIALOG
                      
                 
                      
                      
                 invoke GetStockObject,BLACK_BRUSH
     
     
     
                 mov     eax,hWnd ;[ebp+8]
                 mov     dword_40FFC5, eax
                 push    offset TimerFunc ; lpTimerFunc
                 push    64h             ; uElapse
                 push    62h             ; nIDEvent
                 push    dword_40FFC5    ; hWnd
                 call    SetTimer

     
     
     
     .elseif eax==WM_PAINT
     push ps
     push hWnd
     call BeginPaint
     
      push ps
     push hWnd
     call EndPaint   
     
    
     
     
     .ELSEIF eax == WM_CLOSE
@exit:   invoke EndDialog,hWnd,0
     .ENDIF
@R:  xor eax,eax
     ret
DlgProc ENDP

END start