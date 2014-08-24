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
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\masm32.lib
INCLUDE \masm32\MACROS\MACROS.ASM

INCLUDE    \masm32\INCLUDE\oleaut32.inc
INCLUDELIB \masm32\LIB\oleaut32.lib

INCLUDE    \masm32\INCLUDE\ole32.inc
INCLUDELIB \masm32\LIB\ole32.lib

WinMain proto :HINSTANCE,:HINSTANCE,:LPSTR ,:SDWORD;:DWORD,:DWORD,:DWORD,:DWORD
TopXY PROTO   :DWORD,:DWORD

tagPOINT struct
              x dd ?
              y dd ?
tagPOINT ends

tagSIZE STRUCT
        _cx   dd ?
        cy    dd ?
tagSIZE ENDS     

                unicode         macro page,string,zero
                                irpc c,<string>
                                db '&c', page
                                endm
                                ifnb <zero>
                                dw zero
                                endif
                endm



RGB macro red,green,blue
        xor eax,eax
        mov ah,blue
        shl eax,8
        mov ah,green
        mov al,red
endm

.data
ClassName   db "SimpleWinClass",0
AppName     db "Our First Window",0
TestString  db "Win32 assembly is great and easy!",0
FontName    db "Terminal",0;"script",0

hWin dd 0
include data.inc
;===============================
.data?
hInstance HINSTANCE ?
CommandLine LPSTR ?
hFont dd ?
hBrush dd ?
;hbr dd ?
hbmp dd ?
my_dc dd ?

logoDC dd ?
.code
include init.inc
include timer.inc


 start:
    assume fs:nothing
    
    invoke GetModuleHandle, NULL
    mov    hInstance,eax
    invoke GetCommandLine
    invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
    invoke ExitProcess,eax

WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR ,CmdShow:SDWORD
    
  
        LOCAL wc:WNDCLASSEX
        LOCAL msg:MSG
        LOCAL hwnd:HWND
        LOCAL Wwd:DWORD
        LOCAL Wht:DWORD
        LOCAL Wtx:DWORD
        LOCAL Wty:DWORD
        mov   wc.cbSize,SIZEOF WNDCLASSEX
        mov   wc.style,CS_HREDRAW or CS_VREDRAW or CS_BYTEALIGNWINDOW
        mov   wc.lpfnWndProc, OFFSET WndProc
        mov   wc.cbClsExtra,NULL
        mov   wc.cbWndExtra,NULL
        push  hInst
        pop   wc.hInstance
        

        
                                ; push    2000            ; lpBitmapName
                            ;  push    hInstance
                            ;  call    LoadBitmapA
                            ;  mov hbmp,eax
                              
                             ; invoke CreatePatternBrush,eax
                             ; mov hbr,eax
;       mov dword_407BF4,eax
        
        
        mov   wc.hbrBackground,COLOR_WINDOW+1
        mov   wc.lpszMenuName,NULL
        mov   wc.lpszClassName,OFFSET ClassName
        invoke LoadIcon,NULL,IDI_APPLICATION
        mov   wc.hIcon,eax
        mov   wc.hIconSm,eax
        invoke LoadCursor,NULL,IDC_ARROW
        mov   wc.hCursor,eax
        invoke RegisterClassEx, addr wc
        ;================================
    ; Centre window at following size
    ;================================

    mov Wwd,600
    mov Wht,400

    invoke GetSystemMetrics,SM_CXSCREEN
    invoke TopXY,Wwd,eax
    mov Wtx, eax

    invoke GetSystemMetrics,SM_CYSCREEN
    invoke TopXY,Wht,eax
    mov Wty, eax
; ########################################################################
        
        INVOKE CreateWindowEx,0,ADDR ClassName,ADDR AppName,\
           WS_VISIBLE or WS_SYSMENU,Wtx,\ 
           Wty,Wwd,Wht,NULL,NULL,\
           hInst,NULL
        mov   hwnd,eax
        INVOKE ShowWindow, hwnd,SW_SHOWNORMAL
    
    
    
    invoke UpdateWindow, hwnd
        .WHILE TRUE
                invoke GetMessage, ADDR msg,NULL,0,0
                .BREAK .IF (!eax)
                invoke TranslateMessage, ADDR msg
                invoke DispatchMessage, ADDR msg
        .ENDW
        mov     eax,msg.wParam
        ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    
    LOCAL hdc:HDC
    LOCAL ps:PAINTSTRUCT
    LOCAL hfont:HFONT
    LOCAL hDC:DWORD
    mov   eax,uMsg
    .IF eax==WM_DESTROY
        invoke PostQuitMessage,NULL
    
    .ELSEIF eax==WM_CREATE
    
    push hWnd
    call init
     
     fn CreateWindowEx,0,"BUTTON","NFO", \
                WS_CHILD or WS_VISIBLE or BS_FLAT, \
                60,300,60,25,hWnd,999, \
                hInstance,NULL
    
    	.elseif uMsg == WM_COMMAND
		.if wParam == 999
    cmp     dword_40703D, 2
    jne @F
    mov     dword_40703D, 0
   
    
    jmp ok
    @@:
    mov     dword_40703D, 2
    ok:
    .endif
    .ELSEIF eax==WM_TIMER
    
                                cmp     dword_40703D, 2
                                jnz     short loc_402AE5
                                cmp     dword_407088, 0
                                jnz     short loc_402AE5
                                mov     ebx, dword_407073
                                sub     ebx, 0D3h
                                mov     eax, dword_407084
                                add     dword_407080, eax
                                cmp     dword_407080, ebx
                                ja      short loc_402ADF
                                cmp     dword_407080, 0
                                ja      short loc_402AE5

                loc_402ADF:                             ; CODE XREF: sub_4021D8+8FCj
                                neg     dword_407084

                loc_402AE5:                             ; CODE XREF: sub_4021D8+8D4j
                                                        ; sub_4021D8+8DDj
                
                
                
                
                
                call    sub_402C7B
                 push    1               ; flags
                 push    0               ; hrgnUpdate
                 push    0               ; lprcUpdate
                 push    [hWnd]      ; hWnd
                 call    RedrawWindow
              
    
    
    
    .ELSEIF eax==WM_PAINT
      lea eax,ps
      push eax
      push hWnd
      call BeginPaint
      mov edi,eax
      push 0cc0020h
      push 0
      push 0
      push dword_4070B3
      push 11ah
      push 1a8h
      push 0
      push 0
      push edi
      call BitBlt
      lea eax,ps
      push eax
      push hWnd
      call EndPaint
      
    
    .ELSE
        invoke DefWindowProc,hWnd,uMsg,wParam,lParam
        ret
    .ENDIF
    xor    eax,eax
    ret
WndProc endp

;##########################################################################


; ########################################################################

TopXY proc wDim:DWORD, sDim:DWORD

    shr sDim, 1      ; divide screen dimension by 2
    shr wDim, 1      ; divide window dimension by 2
    mov eax, wDim    ; copy window dimension into eax
    sub sDim, eax    ; sub half win dimension from half screen dimension
        mov eax,sDim
        ret
        
TopXY endp

end start