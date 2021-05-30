.386
.model flat, stdcall
option casemap :none   ; case sensitive

include \masm32\include\windows.inc 
include \masm32\include\masm32.inc

include \masm32\macros\macros.asm
include \masm32\include\user32.inc 
include \masm32\include\kernel32.inc
include \masm32\include\gdi32.inc
include \masm32\include\oleaut32.inc
include \masm32\include\ole32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\user32.lib 
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\oleaut32.lib
includelib \masm32\lib\ole32.lib

include BmpFrom.inc

    WndProc          PROTO :DWORD,:DWORD,:DWORD,:DWORD

.const
    IDB_QUIT            equ 1001
    
.data
    szTitle      db " [ Team MatStat ]",0
    dlgname      db "M",0
    ; Colour settings in the form BBGGRR
    ; Group box colour settings
    GBTextCol    dd 000000FFh
    GBBackCol    dd 00C5C5C5h
    ; Static text/Edit box colours
    STEBTextCol  dd 00FF0000h
    STEBBackCol  dd 00FFAA89h
    ; Dialog background colour
    DlgBGCol     dd 008FBCB9h
    ; Logo stuff
    ScrollSpeed  dd 10         ; Timeout (in milliseconds) for update
    LogoWidth    dd 260
    LogoHeight   dd 70
    dwX          dd 0
    dwY          dd 0
	logofrequency	   real4 15.0
	logoamplitude	   real4 3.0
    rectLogo     RECT <0,0,270,78>
    LogBrush     LOGBRUSH <>
    LFont        LOGFONT <>
    rect         RECT <>

.data?
    hInstance    dd ?
    hFinger      dd ?
    hDlgBGBrush  dd ?
    hParentWnd   dd ?
    hSTEBBGCol   dd ?

    ; Logo stuff
    hLogoBmp     dd ?
    hDCLogo      dd ?
    hOldLogo     dd ?  
    hBuf         dd ?
    hDC          dd ?
    hDCBuf       dd ?
    hOldBuf      dd ?
    hBuf2        dd ?
    hDCBuf2      dd ?
    hOldBuf2     dd ?

.code
start:
    invoke GetModuleHandle,NULL
    mov hInstance,eax
    invoke CoInitialize,NULL
    invoke DialogBoxParam,hInstance,ADDR dlgname,0,ADDR WndProc,0  ; load the main window
    invoke CoUninitialize           ; all done with COM
    ; ret won't do here, as we need to make sure the threads
    ; created for the browse for file dialog get killed
    invoke ExitProcess,eax

WndProc proc hWnd:HWND,uMsg:DWORD,wParam:DWORD,lParam:DWORD
    LOCAL off_set:DWORD
    LOCAL pFileMem:DWORD

    .if uMsg == WM_INITDIALOG
            mov eax,hWnd
            mov hParentWnd,eax                              ; Store the main window handle for global use
            invoke BmpFromResource,hInstance,50             ; Load logo bitmap into memory
            mov hLogoBmp,eax                                ; Save it's handle
            invoke LoadIcon,hInstance,60                    ; Load icon from the resources
            invoke SendMessage,hWnd,WM_SETICON,0,eax        ; Set it on the title bar
            ; Won't work under 95, but who cares right?
            invoke LoadCursor,NULL,IDC_HAND                 ; Load finger cursor into memory
            mov hFinger,eax                                 ; Save it's handle
            invoke SetWindowText,hWnd,ADDR szTitle          ; Set the window title text

            ; Setup up our brush for the dialog background colour
            mov eax,DlgBGCol
            mov LogBrush.lbColor,eax
            invoke CreateBrushIndirect,ADDR LogBrush
            mov hDlgBGBrush,eax
            invoke SetTimer,hWnd,1,ScrollSpeed,0
        		invoke GetDC,hWnd
        		mov	hDC,eax
        		invoke CreateCompatibleDC,eax
            assume esi: NOTHING
            pop esi
            ; Setup the logo stuff
        		invoke CreateCompatibleDC,hDC
        		mov	hDCBuf,eax
        		invoke CreateCompatibleBitmap,hDC,280,90
        		mov	hBuf,eax
        		invoke SelectObject,hDCBuf,eax
        		mov hOldBuf,eax
        		invoke CreateCompatibleDC,hDC
        		mov	hDCBuf2,eax
        		invoke CreateCompatibleBitmap,hDC,280,90
        		mov	hBuf2,eax
        		invoke SelectObject,hDCBuf2,eax
        		mov hOldBuf2,eax
        		invoke CreateCompatibleDC,hDC
        		mov	hDCLogo,eax
        		invoke SelectObject,hDCLogo,hLogoBmp
        		mov hOldLogo,eax
    .elseif uMsg == WM_CTLCOLORSTATIC
        invoke GetWindowLong,lParam,GWL_ID
        ret
    .elseif uMsg == WM_ERASEBKGND
        invoke GetClientRect,hWnd,ADDR rect
        invoke FillRect,wParam,ADDR rect,hDlgBGBrush
        ret
    .elseif	uMsg == WM_COMMAND
       .if wParam == IDB_QUIT
           invoke EndDialog,hWnd,0
       .endif
    ; Use the HTCAPTION trick to allow dragging of the window
    .elseif uMsg == WM_LBUTTONDOWN
        invoke SendMessage,hWnd,WM_NCLBUTTONDOWN,HTCAPTION,lParam
    ; Update our logo
    .elseif uMsg == WM_TIMER
        push esi
        assume esi: NOTHING

  		  invoke FillRect,hDCBuf,ADDR rectLogo,hDlgBGBrush
  		  invoke FillRect,hDCBuf2,ADDR rectLogo,hDlgBGBrush
        inc dwX
        mov eax,logofrequency
		    .if dwX == eax
		      mov dwX,0
		    .endif
        xor ecx,ecx
        mov off_set,0
        .while ecx < 260
      		fild dwX
      		fild off_set
      		fadd
      		fdiv logofrequency
      		fsin
      		fmul logoamplitude
      		fistp dwY
      		add dwY,3
	        invoke BitBlt,hDCBuf,off_set,dwY,1,LogoHeight,hDCLogo,off_set,0,SRCCOPY
    		  inc off_set
    		  mov ecx,off_set
    	  .endw
        xor ecx,ecx
        mov off_set,0
        .while ecx < 78
      		fild dwX
      		fild off_set
      		fadd
      		fdiv logofrequency
      		fsin
      		fmul logoamplitude
      		fistp dwY
      		add dwY,5
	        invoke BitBlt,hDCBuf2,dwY,off_set,LogoWidth,1,hDCBuf,0,off_set,SRCCOPY
    		  inc off_set
    		  mov ecx,off_set
    	  .endw
		    invoke BitBlt,hDC,0,0,rectLogo.right,rectLogo.bottom,hDCBuf2,0,0,SRCCOPY
    .elseif uMsg == WM_DESTROY
        invoke SelectObject,hDCBuf,hOldBuf
        invoke SelectObject,hDCBuf2,hOldBuf2
        invoke SelectObject,hDCLogo,hOldLogo
        invoke DeleteObject,hLogoBmp
        invoke DeleteObject,hBuf
        invoke DeleteObject,hBuf2
        invoke DeleteObject,hDlgBGBrush   
        invoke DeleteObject,hSTEBBGCol
        invoke DeleteDC,hDCLogo
        invoke DeleteDC,hDCBuf
        invoke DeleteDC,hDCBuf2
        invoke ReleaseDC,hWnd,hDC
    .elseif uMsg == WM_CLOSE
        invoke EndDialog,hWnd,0   ; end the program
    .endif
    xor eax,eax 
    ret
WndProc endp

end start