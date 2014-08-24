

.386
.model flat,stdcall
option casemap:none


;include \masm32\include\masm32.inc
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc
include \masm32\include\kernel32.inc


includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\masm32.lib
INCLUDE \masm32\MACROS\MACROS.ASM
WinMain proto :HINSTANCE,:HINSTANCE,:LPSTR ,:SDWORD;:DWORD,:DWORD,:DWORD,:DWORD
TopXY PROTO   :DWORD,:DWORD

tETickerProc proto :HWND, :UINT, :WPARAM, :LPARAM

RGB macro red,green,blue
        xor eax,eax
        mov ah,blue
        shl eax,8
        mov ah,green
        mov al,red
endm

.data

wname  db "tE",0
ClassName   db "SimpleWinClass",0
AppName     db "Our First Window",0
TestString  db "Win32 assembly is great and easy!",0
FontName    db "Terminal",0;"script",0

hWin dd 0
include data_opt.inc
;===============================
.data?
;wc WNDCLASSEX <?>

hwnd HWND ?
hInstance HINSTANCE ?
CommandLine LPSTR ?
hFont dd ?
hBrush dd ?
lpOldProc dd ?


.code
include proc.inc
include paint.inc


 start:
    invoke GetModuleHandle, NULL
    mov    hInstance,eax
    invoke GetCommandLine
    invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
    invoke ExitProcess,eax

WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR ,CmdShow:SDWORD
    
  
    	LOCAL wc:WNDCLASSEX
	LOCAL msg:MSG
	;LOCAL hwnd:HWND
	LOCAL Wwd:DWORD
	LOCAL Wht:DWORD
	LOCAL Wtx:DWORD
	LOCAL Wty:DWORD
	mov   wc.cbSize,SIZEOF WNDCLASSEX
	mov   wc.style, 23h;CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc, OFFSET WndProc
	mov   wc.cbClsExtra,NULL
	mov   wc.cbWndExtra,NULL
	push  hInst
	pop   wc.hInstance
	
	;PUSH BLACK_BRUSH
    ;CALL GetStockObject
	mov   wc.hbrBackground,COLOR_WINDOW+1
	mov   wc.lpszMenuName,NULL
	mov   wc.lpszClassName,OFFSET ClassName
	invoke LoadIcon,NULL,IDI_APPLICATION
	mov   wc.hIcon,eax
	mov   wc.hIconSm,eax
	invoke LoadCursor,NULL,IDC_ARROW
	mov   wc.hCursor,eax
	invoke RegisterClassEx, addr wc
	
	push wc.hInstance
	call new_class
	
	
	;================================
    ; Centre window at following size
    ;================================

    mov Wwd, 600
    mov Wht, 400

    invoke GetSystemMetrics,SM_CXSCREEN
    invoke TopXY,Wwd,eax
    mov Wtx, eax

    invoke GetSystemMetrics,SM_CYSCREEN
    invoke TopXY,Wht,eax
    mov Wty, eax
; ########################################################################
	
	INVOKE CreateWindowEx,WS_EX_STATICEDGE,ADDR ClassName,ADDR AppName,\
           0ce0000h,Wtx,\ 
           Wty,Wwd,Wht,NULL,NULL,\
           hInst,NULL
	mov   hwnd,eax
	INVOKE ShowWindow, hwnd,SW_SHOWNORMAL
    
    ;invoke SetTimer,hwnd,33,70,0
    
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
    
                         
                         PUSH 00H
                          PUSH DWORD PTR  hInstance  
                            PUSH 079H
                          PUSH DWORD PTR  hWnd 
                           PUSH 042H
                          PUSH 00D2H
                          PUSH 0AH;y
                          PUSH 015H;x
                          PUSH WS_CHILD or WS_VISIBLE;040000000H
                          PUSH 00H
                          PUSH offset aTetickerclass;L  L09A6E                                ;  ASCII "tETickerClass"
                          PUSH 0;20000H
                          ;CALL EDI
                          call CreateWindowEx
    
    
    .ELSE
        invoke DefWindowProc,hWnd,uMsg,wParam,lParam
        ret
    .ENDIF
    xor    eax,eax
    ret
WndProc endp

;##########################################################################



tETickerProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    
   
    mov   eax,uMsg
    
    .IF eax==WM_DESTROY
        invoke PostQuitMessage,NULL
    ret
    .ELSEIF eax==WM_CREATE
    
    PUSH 4
    CALL GetStockObject
    mov dword_40EEEC,eax
    
    
    
     
     
                              call    sub_402D44
                              push    [hWnd]      ; hWnd
                              call    GetDC
                              mov     ds:dword_40EEF0, eax
                              push    ds:dword_40EEF0 ; HDC
                              call    CreateCompatibleDC
                              mov     ds:dword_40EEF4, eax
                              push    42h             ; int
                              push    0D2h            ; int
                              push    ds:dword_40EEF0 ; HDC
                              call    CreateCompatibleBitmap
                              mov     ds:dword_40EEF8, eax
                              push    eax             ; HGDIOBJ
                              push    ds:dword_40EEF4 ; HDC
                              call    SelectObject
                              mov     ds:dword_40EF10, eax
                              mov     ds:rc.left, 0
                              mov     ds:rc.top, 0
                              mov     ds:rc.right, 0D2h
                              mov     ds:rc.bottom, 42h
                              push    ds:dword_40EEEC ; hbr
                              push    offset rc       ; lprc
                              push    ds:dword_40EEF4 ; hDC
                              call    FillRect
                              push    7Ah             ; lpBitmapName
                              push    hInstance
                              call    LoadBitmapA
                              mov     ds:dword_40EEE0, eax
                              push    ds:dword_40EEF0 ; HDC
                              call    CreateCompatibleDC
                              mov     ds:dword_40EF08, eax
                              push    ds:dword_40EEE0 ; HGDIOBJ
                              push    eax             ; HDC
                              call    SelectObject
                              mov     ds:dword_40EF0C, eax
                              push    ds:dword_40EEF0 ; hDC
                              push    [hWnd]      ; hWnd
                              call    ReleaseDC
                              push    1               ; int
                              push    ds:dword_40EEF4 ; HDC
                              call    SetBkMode
                              push    0D000h          ; COLORREF
                              push    ds:dword_40EEF4 ; HDC
                              call    SetTextColor
                              push    ds:dword_40EFB4 ; HGDIOBJ
                              push    ds:dword_40EEF4 ; HDC
                              call    SelectObject
                             
                              invoke SetTimer,hWnd,33,70,0
        .ELSEIF eax==WM_TIMER
                              mov ebx,hWnd
                              call sub_402F0C
                              
        .ELSEIF eax==WM_PAINT
        
                              mov ebx,hWnd
                              call sub_403051
                             
    
    .ELSE
        
        
        invoke DefWindowProc,hWnd,uMsg,wParam,lParam
        ret
    .ENDIF
    xor    eax,eax
    ret
tETickerProc endp

;##########################################################################
new_class proc hInst:DWORD
LOCAL wc:WNDCLASSEX
	mov   wc.cbSize,SIZEOF WNDCLASSEX
	mov   wc.style, 23h;CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc,offset tETickerProc ;OFFSET WndProc
	mov   wc.cbClsExtra,NULL
	mov   wc.cbWndExtra,NULL
	push  hInst
	pop   wc.hInstance
	
	PUSH BLACK_BRUSH
    CALL GetStockObject
	mov   wc.hbrBackground,eax;COLOR_WINDOW+1
	mov   wc.lpszMenuName,NULL
	mov   wc.lpszClassName,offset aTetickerclass;OFFSET ClassName
	invoke LoadIcon,NULL,IDI_APPLICATION
	mov   wc.hIcon,eax
	mov   wc.hIconSm,eax
	invoke LoadCursor,NULL,IDC_ARROW
	mov   wc.hCursor,eax
	invoke RegisterClassEx, addr wc

	ret
new_class endp


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