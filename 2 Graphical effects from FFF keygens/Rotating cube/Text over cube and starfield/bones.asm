.686
.model	flat, stdcall
option	casemap :none

include		resID.inc
include 	rotatingcube.asm

.data?

$invoke MACRO Fun:REQ, A:VARARG
  IFB <A>
    invoke Fun
  ELSE
    invoke Fun, A
  ENDIF
  EXITM <eax>
ENDM

AllowSingleInstance MACRO lpTitle
        invoke FindWindow,NULL,lpTitle
        cmp eax, 0
        je @F
          push eax
          invoke ShowWindow,eax,SW_RESTORE
          pop eax
          invoke SetForegroundWindow,eax
          mov eax, 0
          ret
        @@:
ENDM

.code
start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	AllowSingleInstance addr szTitle
	invoke	InitCommonControls
	invoke	DialogBoxParam, hInstance, IDD_KEYGEN, 0, offset DlgProc, 0
	invoke	ExitProcess, eax

DlgProc proc hDlg:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
local hDrawEffects:HANDLE
    .if [uMsg] == WM_INITDIALOG  
        mov eax,hDlg
        mov hDlgWnd,eax
        invoke LoadIcon,hInstance,200
		invoke SendMessage,hDlg,WM_SETICON,1,eax
		invoke SetWindowText,hDlg,addr szTitle
mov PausedOrRunning,1
        invoke CreateThread, 0, 0, offset Draw, 0, 0, offset ThreadID
        mov hThread,eax
        invoke SetThreadPriority,hThread,THREAD_PRIORITY_NORMAL

        jmp @return1
    .elseif [uMsg] == WM_LBUTTONDOWN
        invoke ReleaseCapture
        invoke SendMessageA,hDlgWnd,WM_NCLBUTTONDOWN,HTCAPTION,0
        jmp @return1
    .elseif [uMsg] ==WM_CTLCOLOREDIT || uMsg==WM_CTLCOLORSTATIC
        invoke SetBkMode,wParam,TRANSPARENT
        invoke SetBkColor,wParam,000000h
            invoke SetTextColor,wParam,0000FF00h
        invoke GetStockObject,BLACK_BRUSH
        ret
    .elseif [uMsg] == WM_CTLCOLORDLG
        mov eax,wParam
        invoke SetBkColor,eax,Black
        invoke GetStockObject,BLACK_BRUSH
        ret
    .elseif [uMsg] == WM_CTLCOLORLISTBOX
            invoke SetBkColor,wParam,0000000h
            invoke SetTextColor,wParam,0000FF00h
            invoke CreateSolidBrush,0000000h
        ret
    .elseif [uMsg] == WM_COMMAND
        mov eax,wParam
        mov edx,eax
        shr edx,16
        and eax,0FFFFh

            .if eax== IDB_ABOUT
			inc PausedOrRunning
			mov eax,PausedOrRunning
			and eax,1
			.if eax == FALSE
            	invoke	SuspendThread,hThread
				invoke	CreateTVBox,hDlg
				mov	AboutActive,TRUE
			.elseif eax == TRUE
			;	invoke	TerminateThread,threadID,0
			;	invoke	DeleteDC,srcdc
			    invoke DeleteObject,cubeDC
		        invoke TerminateThread,CubeThread,0
			
				invoke	ResumeThread,hThread
				mov	AboutActive,FALSE
			.endif

        ;	invoke DialogBoxParam,0,IDD_ABOUT,hDlg,addr AboutProc,0
            .elseif eax== IDB_QUIT
                invoke SendMessage,hDlg,WM_CLOSE,0,0
            .endif
    .elseif [uMsg] == WM_CLOSE
        invoke TerminateThread,hThread,0
        invoke DeleteObject,hBlackBrush
		 invoke DeleteObject,cubeDC
		 invoke TerminateThread,CubeThread,0
        invoke EndDialog,hDlg,0
    .endif
    mov eax, 0
    ret
@return1:
    mov eax, 1
    ret
DlgProc endp

Draw proc near uses ebx edi esi ThreadParam:DWORD 
LOCAL var_888:DWORD
LOCAL pv[18h]:BYTE
    
    invoke  GetDlgItem,hDlgWnd,2009
    invoke  GetDC, eax
    mov     hStarsDC, eax

    invoke  CreateCompatibleDC, eax
    mov     hLogoDC, eax
    mov     edi, eax

    invoke  SetBkMode, edi, TRANSPARENT
	
	invoke GetModuleHandle,0
    invoke LoadBitmap,eax,123
    push eax
    invoke CreateCompatibleDC,0
    mov BitmapDC,eax
	pop var_888
	invoke SelectObject,BitmapDC,var_888
	lea eax,pv
	push eax             ; pv                               
	push 18h             ; c                                
	push var_888    ; h                                
	call GetObjectA                                         
	invoke SetBkMode,hDC,1
	
    lea     esi, pbmi
    xor     edx, edx
    mov     pbmi.bmiHeader.biSize, sizeof BITMAPINFOHEADER
    mov     pbmi.bmiHeader.biWidth, nWidth
    mov     pbmi.bmiHeader.biHeight, not nHeight
    mov     pbmi.bmiHeader.biPlanes, 1
    mov     pbmi.bmiHeader.biBitCount, 32
    mov     pbmi.bmiHeader.biCompression, 0
    mov     pbmi.bmiHeader.biSizeImage, edx
    mov     pbmi.bmiHeader.biXPelsPerMeter, edx
    mov     pbmi.bmiHeader.biYPelsPerMeter, edx
    mov     pbmi.bmiHeader.biClrUsed, edx
    mov     pbmi.bmiHeader.biClrImportant, edx
    mov     dword ptr pbmi.bmiColors.rgbBlue, edx

    invoke  CreateDIBSection, hStarsDC, esi, edx, offset ppvBits, edx, edx
    invoke  SelectObject, edi, eax

    ; generate random X coords for the stars
    mov     ecx, nStarCount
    xor     ebx, ebx
    mov     randomMaxVal, nWidth
@loopRandomStarX:
    mov     dx, randomSeed
    add     dx, 9248h
    ror     dx, 3
    mov     randomSeed, dx
    mov     ax, randomMaxVal
    mul     dx
    mov     starArrayX[ebx], dx
    add     ebx, 2
    loop    @loopRandomStarX

    ; generate random Y coords for the stars
    mov     ecx, nStarCount
    xor     ebx, ebx
    mov     randomMaxVal, nHeight
@loopRandomStarY:
    mov     dx, randomSeed
    add     dx, 9248h
    ror     dx, 3
    mov     randomSeed, dx
    mov     ax, randomMaxVal
    mul     dx
    mov     starArrayY[ebx], dx
    add     ebx, 2
    loop    @loopRandomStarY

    ; never-ending loop begins here ---------------------------
loop_draw:
    ; draw slow stars
    xor     ecx, ecx
    mov     eax, ppvBits
@loopDrawSlowStars:
    movzx   ebx, starArrayY[ecx*2]
    imul    ebx, nWidth
    movzx   edx, starArrayX[ecx*2]
    add     edx, ebx
    mov     dword ptr [eax+edx*4], StarColSlow
    inc     ecx
    cmp     ecx, nStarzSlow
    jnz     @loopDrawSlowStars

    ; draw normal stars
@loopDrawNormStars:
    movzx   ebx, starArrayY[ecx*2]
    imul    ebx, nWidth
    movzx   edx, starArrayX[ecx*2]
    add     edx, ebx
    mov     dword ptr [eax+edx*4], StarColNorm
    inc     ecx
    cmp     ecx, nStarzSlow + nStarzNorm
    jnz     @loopDrawNormStars

    ; draw fast stars
@loopDrawFastStars:
    movzx   ebx, starArrayY[ecx*2]
    imul    ebx, nWidth
    movzx   edx, starArrayX[ecx*2]
    add     edx, ebx
    mov     dword ptr [eax+edx*4], StarColFast
    inc     ecx
    cmp     ecx, nStarCount
    jnz     @loopDrawFastStars

@notScrolledToTop:

    xor     edx, edx
    
    invoke  BitBlt, hStarsDC, 0, 0, nWidth, nHeight, hLogoDC, edx, edx, SRCCOPY
	invoke BitBlt,hLogoDC,3,35,dword ptr [pv+4],dword ptr [pv+8],BitmapDC,0,0,SRCPAINT
    xor     ecx, ecx
    mov     eax, ppvBits
@loopEraseStars:
    movzx   ebx, starArrayY[ecx*2]
    imul    ebx, nWidth
    movzx   edx, starArrayX[ecx*2]
    add     edx, ebx
    mov     dword ptr [eax+edx*4], 0
    inc     ecx
    cmp     ecx, nStarCount
    jnz     @loopEraseStars

    ; move slowest stars
    xor     ebx, ebx
@loopMoveSlowStars:
    inc     starArrayX[ebx]
    cmp     starArrayX[ebx], nWidth-2
    jb      @F
    mov     starArrayX[ebx], 0
@@:
    add     ebx, 2
    cmp     ebx, nStarzSlow * 2
    jb      @loopMoveSlowStars

    ; move normal stars
@loopMoveNormStars:
    add     starArrayX[ebx], 2
    cmp     starArrayX[ebx], nWidth-2
    jb      @F
    mov     starArrayX[ebx], 0
@@:
    add     ebx, 2
    cmp     ebx, (nStarzSlow + nStarzNorm) * 2
    jb      @loopMoveNormStars

    ; move the fastest stars
@loopMoveFastStars:
    add     starArrayX[ebx], 3
    cmp     starArrayX[ebx], nWidth-2
    jb      @F
    mov     starArrayX[ebx], 0
@@:
    add     ebx, 2
    cmp     ebx, nStarCount * 2
    jb      @loopMoveFastStars

    ; sleep a bit and repeat
    invoke  Sleep, ScrollerSpeed
    jmp     loop_draw

    ; thread never returns
Draw endp

CreateTVBox proc hwNd:dword

LOCAL X:DWORD
LOCAL Y:DWORD
LOCAL Aboutrkt:RECT
		invoke GetParent, hwNd
		mov ecx, eax

		invoke GetWindowRect, ecx, addr Aboutrkt
		mov edi, Aboutrkt.left
		mov esi, Aboutrkt.top
		add edi, 3
		add esi, 3
	;	invoke SetWindowPos,hwNd,HWND_TOP,edi,esi,DCWidth,DCHeight,SWP_SHOWWINDOW
		invoke GetClientRect,hwNd,offset CubeRekt
		invoke CreateThread,0,0,offset CubeProc,0,0,offset ThreadId
		mov CubeThread,eax
		invoke SetThreadPriority,offset CubeThread,THREAD_PRIORITY_ABOVE_NORMAL
	ret
CreateTVBox endp

end start