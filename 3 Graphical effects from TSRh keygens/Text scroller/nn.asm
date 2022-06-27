


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
Text            db "Keygen For Anything v1.3 By KAT",0
namalowano dd 0
hWin dd 0
include data_opt.inc
;===============================
.data?
;hInstance HINSTANCE ?
CommandLine LPSTR ?
hFont dd ?
hBrush dd ?
;hbr dd ?
hbmp dd ?
my_dc dd ?
.code
include proc.inc



 start:
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
	mov   wc.style, CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc, OFFSET WndProc
	mov   wc.cbClsExtra,NULL
	mov   wc.cbWndExtra,NULL
	push  hInst
	pop   wc.hInstance
	

	
	                         push    2000            ; lpBitmapName
                              push    hInstance
                              call    LoadBitmapA
                              mov hbmp,eax
                              
                              ;invoke CreatePatternBrush,eax
                              ;mov hbr,eax
	
	
	
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

    mov Wwd,365 ;600
    mov Wht,270 ;400

    invoke GetSystemMetrics,SM_CXSCREEN
    invoke TopXY,Wwd,eax
    mov Wtx, eax

    invoke GetSystemMetrics,SM_CYSCREEN
    invoke TopXY,Wht,eax
    mov Wty, eax
; ########################################################################
	
	INVOKE CreateWindowEx,WS_EX_CLIENTEDGE,ADDR ClassName,ADDR AppName,\
           WS_OVERLAPPEDWINDOW,Wtx,\ 
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
     pop @hWnd
                       
    push hWnd
    call GetDC
    
    push eax
    call CreateCompatibleDC
    mov my_dc,eax
    push hbmp
    push my_dc
    call SelectObject
    
    invoke	CreateThread,0,0,addr StartAddress,0,0,esp
    push 2
    push eax
    call SetThreadPriority
    
    
    
    ;.ELSEIF eax==WM_TIMER
    
    
    
    .ELSEIF eax==WM_PAINT
      lea eax,ps
      push eax
      push hWnd
      call BeginPaint
      mov edi,eax
      
     
      
      push SRCCOPY
      push 0
      push 0
      push my_dc
      push 0f0h
      push 15eh
      push 0
      push 0
      push edi
      call BitBlt
      push 1
      push edi
      call SetBkMode
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