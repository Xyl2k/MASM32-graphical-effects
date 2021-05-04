AboutProc PROTO :DWORD,:DWORD,:DWORD,:DWORD


.data
;these should match dialog size in pixels
xStarzPos 		EQU 2
yStarzPos 		EQU 20
nWidth 	  		EQU 300
nHeight   		EQU 166

nStarzSlow 		EQU 100
nStarzNorm 		EQU 100
nStarzFast 		EQU 100
StarColSlow 	EQU 777777h
StarColNorm 	EQU 0AAAAAAh
StarColFast 	EQU 0FFFFFFh

CapBgColor 		EQU 000000h
CapTxtColor 	EQU 0FFFFFFh
FormColor 		EQU 000000C6h

AboutFont 		db "Terminal",0
CaptionFont		db	"Courier",0
AboutTextColor 	EQU 0FFFFFFh
FontHeight 		EQU 12 
FontWidth 		EQU 8 ; 0 for default width.
LineHeight 		EQU 15 ; this needs to be updated in case if you wanna change the font size.

ScrollMsg   	db ' ', 0 ; <-- this one is added in order to scroll the first page when the aboutbox is clicked ( sometimes it won't show after reaches the scroller end
						; after clicking it the 3rd/4th time but don't worry , i've also met this kind of bug in most of tPORt's releases from 2004-2006 )
				db '    P E R Y F E R i A H   t E A M',0Dh
				db '    p r o u d l y   p r e s e n t',0
              ;---------------------------------------------
                db '   tARGEt    : Ardamax Keylogger 2.9',0Dh
                db '   CracKeR   : B@TRyNU',0Dh
                db '   pr0tecti0n: custom',0Dh
                db '   rls date  : o 1 . o 5 . 2 o 2 1',0Dh
                db '   tune      : the radix point',0
              ;---------------------------------------------
                db '   Gr33tz fly out 2 Al0hA,r0ger,',0Dh
                db '   ShTEFY,DAViiiiDDDDDDD,r0bica,',0Dh
                db '   GRUiA,MaryNello,yMRAN,WeeGee,',0Dh
                db '   sabYn,NoNNy,QueenAntonia,',0Dh
                db '   7epTaru`,m3mu and otherz :)',0
              ;---------------------------------------------
                db '   But also to Roentgen,Cachito,',0Dh
                db '   Xylitol,TeddyRogers,kao,HcH,',0Dh
                db '   GioTiN,SKG-1010,Bl4ckCyb3rEnigm4',0Dh
                db '   GlacialManDoUtDes,nuttertools,',0Dh
                db '   Tux528,udg,TeRcO,atom0s,KesMezar,',0Dh
                db '   Jowy,mrT4ntr4,Goppit and others ;)',0
              ;---------------------------------------------
                db '            sh0ut 0ut 2 :',0Dh,0Dh
                db '   Drozerix for the CooL music',0Dh
                db '   UfO-Pu55y for the BASSMOD lib',0Dh
                db '   kao for helping r0ger to',0Dh
                db '    recode this whole aboutbox :)',0Dh
                db '   CERBER[tPORt] for coding this',0Dh
                db '    aboutbox effect initially.',0  
              ;---------------------------------------------
                db '         you can find us at :',0Dh,0Dh
                db '           yt : MC Roger',0Dh
                db '           fb : Darius Dan',0Dh
                db '           ig : @r0gerica',0Dh
                db '         @peryferiah.artpack',0Dh
                db '             @allexx_bt',0
              ;---------------------------------------------
                db '     or in other sites + discord :',0Dh,0Dh
                db '         discord : r0gerica#2649',0Dh
                db '         devArt  : r0gerica',0Dh
                db '         furaff  : r0gerica',0Dh
                db '         github  : r0gerica',0
              ;---------------------------------------------
                db '        fuck da ripperz .   :E',0
              ;---------------------------------------------
                db 0	
                
ScrollerSpeed EQU 15

nStarCount EQU nStarzSlow + nStarzNorm + nStarzFast

.data?
pbmi            BITMAPINFO <>
ppvBits         dd ?
randomSeed      dw ?
randomMaxVal    dw ?
starArrayX      dw nStarCount dup(?)
starArrayY      dw nStarCount dup(?)
scrollerCurrentY dd ?
freezeCounter   dd ?
ThreadID        dd ?
hDlgWnd         dd ?
hStarsDC        dd ?
hTextDC         dd ?
hThread         dd ?
hCapColor   	dd ?
hFormColor    dd ?
ptrCurrentString dd ?
hAboutFont   	dd ?
hCaptionFont	dd ?
hCaption		dd	?

.code

Draw proc near uses ebx edi esi lpThreadParameter:DWORD 
    invoke  GetDC, hDlgWnd
    mov     hStarsDC, eax

    invoke  CreateCompatibleDC, eax
    mov     hTextDC, eax
    mov     edi, eax

    invoke  SetBkMode, edi, TRANSPARENT

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

    ; render text scroller 
    invoke  SelectObject, edi, hAboutFont
    invoke  SetTextColor, edi, AboutTextColor
    call    TextInit

    ; have we scrolled our text to the middle of window?
    mov     ecx, nHeight / 2
    sub     ecx, eax
    cmp     scrollerCurrentY, ecx
    jnz     @afterFreeze

    ; if so, freeze text for (text height*2 + 20) cycles.
    ; the more lines of text, the longer is stays frozen.
    mov     ecx, eax
    shl     ecx, 2
    add     ecx, 14h
    cmp     freezeCounter, ecx
    jnb     @enoughFreeze
    ; keep frozen a bit more
    inc     freezeCounter
    inc     scrollerCurrentY
    jmp     @afterFreeze
@enoughFreeze:
    mov     freezeCounter, 0
@afterFreeze:
    ; scroll up 1 pixel
    dec     scrollerCurrentY

    ; was all text scrolled out of the window?
    add     eax, eax
    not     eax
    cmp     scrollerCurrentY, eax
    jnz     @notScrolledToTop

    ; if so, switch to next string
    mov     edi, ptrCurrentString
    xor     eax, eax
    or      ecx, 0FFFFFFFFh
    cld
    repne   scasb
    cmp     byte ptr [edi], 0
    jz      @restartFromBeginning
    mov     ptrCurrentString, edi
    jmp     @resetScrollerY
@restartFromBeginning:
    push    offset ScrollMsg
    pop     ptrCurrentString
@resetScrollerY:
    mov     scrollerCurrentY, nHeight
@notScrolledToTop:

    ; draw the rendered scene
    xor     edx, edx
    invoke  BitBlt, hStarsDC, xStarzPos, yStarzPos, nWidth, nHeight, hTextDC, edx, edx, SRCCOPY

    ; erase old scroller text
    invoke  PatBlt, hTextDC, 0, 0, nWidth, nHeight, BLACKNESS

    ; erase old stars from star bitmap
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

AboutProc proc hDlg:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
    .if [uMsg] == WM_INITDIALOG
        mov     eax, hDlg
        mov     hDlgWnd, eax

        mov     randomMaxVal, 0
        mov     randomSeed, 0
        mov     eax, offset ScrollMsg
        mov     ptrCurrentString, eax

        invoke  CreateSolidBrush, CapBgColor
        mov     hCapColor, eax

        invoke  CreateSolidBrush, FormColor
        mov     hFormColor, eax

        invoke  CreateFont, FontHeight, FontWidth, 0, 0, FW_DONTCARE, 0, 0, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, 0, offset AboutFont
        mov     hAboutFont,eax

	    invoke  CreateFont,13,0,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY, 0,addr CaptionFont
	    mov     hCaptionFont,eax
	    invoke  GetDlgItem,hDlg,2001
	    mov     hCaption,eax
	    invoke  SendMessage,eax,WM_SETFONT,hCaptionFont,1
        invoke  CreateThread, 0, 0, offset Draw, 0, 0, offset ThreadID
        mov     hThread, eax
        jmp     @return1
    .elseif [uMsg] == WM_LBUTTONDOWN
        invoke  ReleaseCapture
        invoke  SendMessageA, hDlgWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0
        jmp     @return1
    .elseif [uMsg] == WM_RBUTTONDOWN
        invoke  TerminateThread, hThread, 0
        invoke  EndDialog, hDlg, 0
        jmp     @return1
    .elseif [uMsg] == WM_CTLCOLORSTATIC
        invoke  SetBkMode, wParam, TRANSPARENT
        invoke  SetTextColor, wParam, CapTxtColor
        mov     eax, hCapColor
        ret
    .elseif [uMsg] == WM_CTLCOLORDLG
        mov     eax, hFormColor
        ret
    .endif
    mov     eax, 0
    ret
@return1:
    mov     eax, 1
    ret
AboutProc endp

TextInit proc near uses esi edi ebx
    LOCAL localScrollerCurrentY:DWORD

    mov     esi, ptrCurrentString

    ; calculate length of the current string + trailing zero
    invoke  lstrlenA, esi
    mov     ebx, eax
    inc     ebx

    ; get current Y
    push    scrollerCurrentY
    pop     localScrollerCurrentY

    ; draw each line of the string
    mov     edi, esi
@loopFindEndOfSingleLine:
    cmp     byte ptr [esi], 0Dh
    jz      @foundEOL
    cmp     byte ptr [esi], 0
    jnz     @checkNextByte

@foundEOL:
    ; replace last char of single line with 0x0
    mov     cl, [esi]
    push    ecx
    mov     byte ptr [esi], 0

    ; draw single line of text
    invoke  lstrlenA, edi
    invoke  TextOutA, hTextDC, 0, localScrollerCurrentY, edi, eax
    add     localScrollerCurrentY, LineHeight

    ; restore last char of the line
    pop     ecx
    mov     edi, esi
    inc     edi
    mov     [esi], cl
@checkNextByte:
    lodsb
    dec     ebx
    jnz     @loopFindEndOfSingleLine

    ; return (number of Y pixels used)/2
    mov     eax, localScrollerCurrentY
    sub     eax, scrollerCurrentY
    shr     eax, 1
    ret
TextInit endp
