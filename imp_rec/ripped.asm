
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


hInst dd ?


.CODE
include proc.inc

start:
     invoke GetModuleHandle,0
     mov hInst,eax
     
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
         
        
     
     .elseif eax==WM_INITDIALOG
     
     
     
     
     
     
                         mov eax,hInst
                         mov     edi, ds:LoadBitmapA
                         mov     esi, eax
                         push    8Ch
                         push    esi
                         call    edi ; LoadBitmapA
                         push    8Bh
                         push    esi
                         mov     dword_441654, eax
                         call    edi ; LoadBitmapA
                         test    ebx, ebx
                         mov     dword_441664, eax
                         jnz     short loc_401A8F
                         xor     eax, eax
                         jmp     short loc_401A92
         
         
         
         
         
         ; ---------------------------------------------------------------------------
         
         loc_401A8F:                             ; CODE XREF: sub_401780+309j
                         mov     eax,hWnd ;[ebx+1Ch]
         
         loc_401A92:                             ; CODE XREF: sub_401780+30Dj
                         push    44h;Height->CreateCompatibleBitmap
                         push    158h;Width->CreateCompatibleBitmap
                         push    eax
                         call    ds:GetDC
                         push    eax;hDC
                         call    ds:CreateCompatibleBitmap
                         mov     dword_44165C, eax
                         mov     ecx,hWnd;[ebx+1Ch]
                         push    offset loc_401000
                         push    28h
                         push    1
                         push    ecx
                         call    ds:SetTimer


     
     
     
     
     
     
     
     .ELSEIF eax == WM_CLOSE
@exit:   invoke EndDialog,hWnd,0
     .ENDIF
@R:  xor eax,eax
     ret
DlgProc ENDP

END start