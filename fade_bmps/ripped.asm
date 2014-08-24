
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
include data_opt.inc



.DATA?
; Буферы для преобразования
; -------------------------
MAX_B64   EQU 260
MAX_ASCII EQU MAX_B64 * 2 / 3
buffer1   db MAX_B64 dup (?)
buffer2   db MAX_ASCII dup (?)

hInst dd ?
hWin dd ?
_uMsg dd ?



inDC dd ?


.CODE
include proc.inc

start:
     invoke GetModuleHandle,0
     mov hInstance,eax
     
     invoke DialogBoxParam,eax,101,0,OFFSET DlgProc,0
     invoke ExitProcess,0

DlgProc PROC hWnd:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
 LOCAL ps:PAINTSTRUCT    
     
     
     
     
     mov eax,uMsg
     .IF eax == WM_COMMAND
         mov eax,wParam
         cmp ax,1002
         je @exit
         
         cmp ax,1003
         je @exit
         
         
     
     .elseif eax==WM_INITDIALOG
     
    
    
    
     pushad
     
     push hWnd
     call my_init
     popad   
         
    
         
  .elseif eax==WM_PAINT      

                                lea eax,ps
                                push eax
                                push hWnd
                                call BeginPaint
                                mov esi,eax
                                
                                
                                xor ebx,ebx                 
                                 push hWnd
                                 call    GetDC
                                 mov edi,eax


                                  

                                  push    0CC0020h        ; DWORD
                                  push    ebx             ; int
                                  push    ebx             ; int
                                  mov     edi, eax
                                  push    hDC             ; HDC
                                  push    dword_401E84    ; int
                                  push    dword_401E80    ; int
                                  push    1Eh             ; int
                                  push    0Eh             ; int
                                  push    edi             ; HDC
                                  call    BitBlt
                                  push    esi             ; HDC
                                  call    DeleteDC
                                  push    edi             ; hDC
                                  push    [hWnd]          ; hWnd
                                  call    ReleaseDC
 
     
     
     
     
     
     
     .ELSEIF eax == WM_CLOSE
@exit:   invoke EndDialog,hWnd,0
     .ENDIF
@R:  xor eax,eax
     ret
DlgProc ENDP

END start