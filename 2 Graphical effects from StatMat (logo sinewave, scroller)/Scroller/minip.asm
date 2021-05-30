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
    GfxCharWidth        equ 16
    NumStars            equ 140
    IDB_QUIT            equ 1001

.data
szScrollText db "***  STATMAT PRESENTS GAME JACKAL V2.6.9.262 - THIS PATCH REMOVES THE 30-DAY TRIAL.  ***  "
             db "GREETS GO OUT TO: GIBBERGIBB, LEETY, BLACK-EYE, TRSH, FAIRLIGHT, ORION, THE NEMESIS, BIW REVERSING AND ALL THE OTHERS!  ***  "
             db "DEVELOPER BLURB - PLAY ALL YOUR FAVORITE GAMES WITHOUT INSERTING A SINGLE CD! GAME JACKAL, "
             db "THE ULTIMATE ""MUST HAVE"" KILLER APP FOR THE PC GAMER, ALLOWS YOU TO PLAY ALL YOUR FAVORITE "
             db "GAMES WITHOUT INSERTING THE ORIGINAL CD-ROM. GAME JACKAL ACHIEVES THIS WITHOUT MODIFYING ANY "
             db "PART OF THE GAME INSTALLED ON YOUR COMPUTER, NOR DOES IT CREATE LARGE IMAGE FILES THAT REQUIRE "
             db "A VIRTUAL DRIVE.  ***",0

    szTitle      db " [ Team MatStat ]",0
    dlgname      db "M",0

    ; Scroller stuff
    ScrollYPos   dd 1         ; Scroller's Y position on the dialog
    ScrollSpeed  dd 10         ; Timeout (in milliseconds) for scroller update
	  frequency	   real4 25.0
	  amplitude	   real4 10.0
    rectScroll   RECT <-(GfxCharWidth + 1),0,270,52>
	  ScrollLenPixels dd 0
	  chrmap       db "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789""'(),.;:+-!?*",0
    StarList     dd 0
    MoveStarsNow dd 0

    LogBrush     LOGBRUSH <>
    LFont        LOGFONT <>
    rect         RECT <>

.data?
    hInstance    dd ?
    hFinger      dd ?
    hDlgBGBrush  dd ?
    hParentWnd   dd ?
    hSTEBBGCol   dd ?

    ; Scroller stuff
    hDC          dd ?
    hDCScroll    dd ?
    hBmp         dd ?
    hOld         dd ?
    hOldGfxBmp   dd ?
    dwScrollX    dd ?
    hDCGfxScroll dd ?
    hGfxScrollBmp dd ?

Star STRUCT
  x SDWORD ?
  y SDWORD ?
  speed SDWORD ?
  colour SDWORD ?
Star ends

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
            invoke BmpFromResource,hInstance,100            ; Load scroll text bitmap into memory
            mov hGfxScrollBmp,eax                           ; Save it's handle
            invoke LoadIcon,hInstance,60                    ; Load icon from the resources
            invoke SendMessage,hWnd,WM_SETICON,0,eax        ; Set it on the title bar
            ; Won't work under 95, but who cares right?
            invoke LoadCursor,NULL,IDC_HAND                 ; Load finger cursor into memory
            mov hFinger,eax                                 ; Save it's handle
            invoke SetWindowText,hWnd,ADDR szTitle          ; Set the window title text
            ; Setup up our text scroller
            invoke SetTimer,hWnd,1,ScrollSpeed,0
        		invoke GetDC,hWnd
        		mov	hDC,eax
        		invoke CreateCompatibleDC,eax
        		mov	hDCScroll,eax
            invoke lstrlen,ADDR szScrollText
            imul eax,GfxCharWidth
            mov ScrollLenPixels,eax
            mov eax,rectScroll.right
            mov dwScrollX,eax
        		invoke CreateCompatibleBitmap,hDC,rectScroll.right,rectScroll.bottom
        		mov	hBmp,eax
        		invoke SelectObject,hDCScroll,eax
        		mov hOld,eax
        		invoke CreateCompatibleDC,hDC
        		mov	hDCGfxScroll,eax
        		invoke SelectObject,hDCGfxScroll,hGfxScrollBmp
        		mov hOldGfxBmp,eax
            ; Generate our stars
            invoke GlobalAlloc,GPTR,NumStars*SIZEOF Star
            mov StarList,eax
            push esi
            mov esi,eax
            assume esi: PTR Star
            invoke GetTickCount
            invoke nseed,eax
            mov off_set,0
            xor ecx,ecx
            .while ecx < NumStars
              invoke nrandom,rectScroll.right
              mov [esi].x,eax
              invoke nrandom,rectScroll.bottom          
              mov [esi].y,eax
              invoke nrandom,200
              xor edx,edx
              sub dl,al
              mov al,dl
              shl edx,8
              mov dl,al
              shl edx,8
              mov dl,al
              mov [esi].colour,edx
              and eax,3
              inc eax
              mov [esi].speed,eax
              inc off_set
              mov ecx,off_set
              add esi,SIZEOF Star
            .endw
    .elseif	uMsg == WM_COMMAND
       .if wParam == IDB_QUIT
           invoke EndDialog,hWnd,0
       .endif
    ; Use the HTCAPTION trick to allow dragging of the window
    .elseif uMsg == WM_LBUTTONDOWN
        invoke SendMessage,hWnd,WM_NCLBUTTONDOWN,HTCAPTION,lParam
    ; Update our text scroller
    .elseif uMsg == WM_TIMER
    	  mov	eax,dwScrollX

    	  add eax,ScrollLenPixels
        dec dwScrollX
    	  cmp	eax,0
    	  jge	@@skip
        mov eax,rectScroll.right
    		mov	dwScrollX,eax
    	@@skip:
        invoke GetStockObject,BLACK_BRUSH
		    invoke FillRect,hDCScroll,ADDR rectScroll,eax
        ; Draw stars
        push esi
        mov esi,StarList
        assume esi: PTR Star
        xor ebx,ebx
        .while ebx < NumStars
          .if MoveStarsNow == 1
            mov eax,[esi].speed
            add [esi].x,eax
          .endif
          mov eax,rectScroll.right
          .if [esi].x > eax
            mov [esi].x,0
          .endif
          invoke SetPixel,hDCScroll,[esi].x,[esi].y,[esi].colour
          inc ebx
          add esi,SIZEOF Star
        .endw
        assume esi: NOTHING
        .if MoveStarsNow == 1
          mov MoveStarsNow,0
        .else
          inc MoveStarsNow
        .endif
    		push edi
    		mov	esi,OFFSET rectScroll
    		mov	edi,OFFSET rect
    		mov	ecx,sizeof rect shr 2
    		rep	movsd
    		mov	esi,OFFSET szScrollText
    	  mov eax,dwScrollX
    	  mov rect.left,eax
      @@more:
    	  mov eax,rectScroll.left
    	  mov ecx,rectScroll.right
        .if SDWORD PTR rect.left >= eax && SDWORD PTR rect.left <= ecx
      		mov al,byte ptr [esi]
      		mov ebx,OFFSET chrmap
      		xor ecx,ecx
          .while byte ptr [ebx] != al
            inc ecx
 		        inc ebx
 		      .endw
          imul ecx,GfxCharWidth
          mov off_set,ecx
          mov pFileMem,0
          xor ecx,ecx
          .while ecx < GfxCharWidth
        		fild rect.left
        		fild dwScrollX
        		fadd
        		fdiv frequency
        		fsin
        		fmul amplitude
        		fild rectScroll.top
        		fadd
        		fistp rect.top
        		add rect.top,10 ; magic Y value for this font - should be tidied...
  	        invoke BitBlt,hDCScroll,rect.left,rect.top,1,rectScroll.bottom,hDCGfxScroll,off_set,0,SRCPAINT
      		  inc rect.left
      		  inc off_set
      		  inc pFileMem
      		  mov ecx,pFileMem
      	  .endw
        .else
    		  add rect.left,GfxCharWidth
    		.endif
    		inc	esi
    		cmp byte ptr [esi],0
    		jne @@more
    		pop	edi
    		pop	esi
		    invoke BitBlt,hDC,0,ScrollYPos,rect.right,rectScroll.bottom,hDCScroll,0,0,SRCCOPY
    .elseif uMsg == WM_DESTROY
        invoke GlobalFree,StarList
        invoke SelectObject,hDCGfxScroll,hOldGfxBmp
        invoke SelectObject,hDCScroll,hOld
        invoke DeleteObject,hGfxScrollBmp
        invoke DeleteObject,hDlgBGBrush   
        invoke DeleteObject,hBmp
        invoke DeleteObject,hSTEBBGCol
        invoke DeleteDC,hDCGfxScroll
        invoke DeleteDC,hDCScroll
        invoke ReleaseDC,hWnd,hDC
    .elseif uMsg == WM_CLOSE
        invoke EndDialog,hWnd,0   ; end the program
    .endif
    xor eax,eax 
    ret
WndProc endp

end start