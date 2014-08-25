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
;                          BMP FONT ALGO#3 Scroll
;                         Author: CyberDoom
        .486
        .model flat,stdcall
        option casemap:none   ; case sensitive

; ####################################################

        include \masm32\include\windows.inc
        include \masm32\include\user32.inc
        include \masm32\include\kernel32.inc
        include \masm32\include\gdi32.inc
        include \masm32\include\comctl32.inc

        includelib \masm32\lib\user32.lib
        includelib \masm32\lib\kernel32.lib
        includelib \masm32\lib\gdi32.lib
        includelib \masm32\lib\comctl32.lib

; ####################################################
       
    
        ID_BUTTON   equ 300
        CHAR_W equ 8
        CHAR_H equ 14

FCHAR_DD struct
_cX dd ?
_cY dd ?
_cW dd ?
_cH dd ?
FCHAR_DD ends


; ----------------------------------------------------

        DlgProc  PROTO :DWORD,:DWORD,:DWORD,:DWORD
        
        

; ----------------------------------------------------

    .data        



;---------------------------------------------------------------------------
fTable db ' ABCDEFGHIJKLMNOPQRSTUVWXYZ'
       DB '0123456789:;/-().,?!"',27H,'#@',0
t_sz =$-fTable  
 
       
fc FCHAR_DD <0,0,CHAR_W,CHAR_H>



; message here:

mess\
      db ' THE CYBERDOOM SYSTEMS PRESENTS:  BMP FONT ALGO#3 NO DIB SHIT ARE USED!  TEST: (35067942),@       ',0


; --------------------------------------------------------------------------

    .data?
hInstance   dd ?
FontDC      dd ?
MessDC      dd ?
hbr         dd ?
tmpDC       dd ?
MessLen     dd ?


; --------------------------------------------------------------------------

    .code

start:

; ###############################################################

        invoke GetModuleHandle,NULL
        mov hInstance,eax
        
; -------------------------------------------
; Call the dialog box stored in resource file
; -------------------------------------------
        invoke DialogBoxParam,hInstance,100,0,ADDR DlgProc,0
        invoke ExitProcess,0

; ###############################################################

DlgProc proc hWin:DWORD,uMsg:DWORD,aParam:DWORD,bParam:DWORD

    LOCAL Ps:PAINTSTRUCT
   
    
    
    
        .if uMsg ==   WM_INITDIALOG
                   
                   ; create bitmap fon from bg.bmp
                   invoke LoadBitmap,hInstance,2
                   push eax
                   invoke CreatePatternBrush,eax
                   mov hbr,eax
                   pop eax
                   invoke DeleteObject,eax
                   
                   
                       ; create DC for bmp font
                       invoke LoadBitmap,hInstance,1
                       mov edi,eax
                       invoke GetDC,hWin
                       mov ebx,eax
                       invoke CreateCompatibleDC,eax
                       mov FontDC,eax
                       invoke SelectObject,eax,edi
                       invoke DeleteObject,edi
                       
                       ; crete DC for message
                    invoke GetDC,hWin
                    mov ebx,eax
                    invoke CreateCompatibleDC,eax
                    mov MessDC ,eax
                    invoke CreateCompatibleBitmap,ebx,800,800
                    invoke SelectObject,MessDC ,eax
                       
                       
                        ; crete  temporaly DC
                    invoke GetDC,hWin
                    mov ebx,eax
                    invoke CreateCompatibleDC,eax
                    mov tmpDC ,eax
                    invoke CreateCompatibleBitmap,ebx,800,800
                    invoke SelectObject,tmpDC ,eax
                   
                   push offset mess
                   call parser
                   
                   push offset mess
                   call lstrlen
                   mov ebx,CHAR_W
                   mul bx
                   neg eax
                   mov MessLen,eax
                   
                   invoke SetTimer,hWin,1,100,0
                   

        .elseif uMsg == WM_COMMAND
                        mov eax,aParam
                        .if eax == ID_BUTTON
                            invoke SendMessage,hWin,WM_CLOSE,NULL,NULL
                        .endif

        .ELSEIF uMsg == WM_CTLCOLORDLG
                        mov eax, hbr; apply bg.bmp as fon
                        ret
         
         .ELSEIF uMsg == WM_LBUTTONDOWN      
                        INVOKE SendMessage, hWin, WM_NCLBUTTONDOWN, HTCAPTION, 0
         
         
         .elseif uMsg == WM_TIMER
                         push hWin
                         call scroll
                       
        ;.elseif uMsg == WM_PAINT
                       ; invoke BeginPaint,hWin,ADDR Ps
                       ; invoke BitBlt,eax,70,40,800,800,MessDC ,0,0,SRCPAINT; draw message
                       ; invoke EndPaint,hWin,ADDR Ps

        .elseif uMsg == WM_CLOSE
                        invoke DeleteDC,tmpDC
                        invoke DeleteDC,FontDC
                        invoke DeleteDC,MessDC 
                        invoke EndDialog,hWin,0           
        
        .endif

                         xor eax,eax
                         ret
                    
DlgProc endp

.data
rc RECT <0,0,800,800>

DestX dd 400
.code

scroll proc hWnd:dword
LOCAL hDC:dword


             invoke FillRect,tmpDC,addr rc,hbr
             invoke BitBlt,tmpDC,DestX,40,800,800,MessDC ,0,0,SRCPAINT; draw message

             sub DestX,CHAR_W/2
             mov eax,MessLen
             add eax,-140;wait before  restart

             cmp eax,DestX
             jl @F
             mov DestX,400


          @@:
            invoke GetDC,hWnd
            mov hDC,eax
            invoke BitBlt,eax,0,0,800,800,tmpDC,0,0,SRCCOPY;apply message
            invoke ReleaseDC,hWnd,hDC
            ret
scroll endp






parser proc mSg:dword
    
     local StringX:dword
     local StringY:dword
                    
                    mov StringY,0
                    mov StringX,0
                    
                    mov esi,mSg
                   
          next_char: 
                    lodsb
                    or al,al
                    jz _ok
                    cmp al,13
                    jne @F
                    add StringY,CHAR_H+5
                    mov StringX,0
                    jmp next_char
                    
                    @@:
                    mov edi,offset fTable
                    mov edx,edi
                    mov ecx,t_sz
                    repne scasb
                    jne _ok
                    dec edi
                   
                    sub edi,edx
                    mov eax,CHAR_W
                    mul edi
                    mov fc._cX,eax
                    
                    add StringX,CHAR_W
                    
                    
                    push SRCCOPY
                    push fc._cY; y pos
                    push fc._cX; x pos
                    push FontDC
                    push CHAR_H; char height
                    push CHAR_W; char widht  
                    push StringY
                    push StringX
                    push MessDC 
                    call BitBlt; copy char in DC
                    
                   
                    jmp next_char
                    
                    _ok:

                    ret



parser endp



; ###############################################################

end start
