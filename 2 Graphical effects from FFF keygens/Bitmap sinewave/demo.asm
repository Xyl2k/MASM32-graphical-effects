.486
.model flat, stdcall
option casemap:none   ; case sensitive

; ####################################################

include		/masm32/include/windows.inc
include		/masm32/include/kernel32.inc
include		/masm32/include/user32.inc
include     /masm32/include/comdlg32.inc
include     /masm32/include/gdi32.inc
include     /masm32/include/masm32.inc

includelib /masm32/lib/user32.lib
includelib /masm32/lib/kernel32.lib
includelib /masm32/lib/comdlg32.lib
includelib /masm32/lib/gdi32.lib
includelib /masm32/lib/masm32.lib
; ####################################################

.DATA
        RandomSeed      dd 0
        aMain           db 'MAIN',0
        align 4
        tbyte_40CA00    dt 0.078537900000000000001

.DATA?
        hModule         dd ?
        hBmpBackground  dd ?
        rectWindowClient RECT <?>
        ddWindowClientWidth dd ?
        ddBitmapHeight  dd ?
        infoBmpToScroll BITMAP<?>
        hBmpToScroll    dd ?
        ddScrollerVar1  dd ?
        ddScrollerVar2  dd ?
        ddScrollerVar3  dd ?
        ddBitmapXPos    dd ?
        tableSineValues dq 261 dup(?)  ; FIXME - if you use much larger bitmap, perhaps you might need to update this too

.CODE

; ---------------------------------------------------------------------------
;
; ---------------------------------------------------------------------------
DialogProc      proc near hWnd:DWORD, arg_4:DWORD, hdc:DWORD, dummy:DWORD
        LOCAL hSavedBitmap1 : DWORD
        LOCAL hSavedBitmap2 : DWORD
        LOCAL hSavedBitmap3 : DWORD
        LOCAL hPaint : DWORD
        LOCAL hDC1 : DWORD
        LOCAL hDC2 : DWORD
        LOCAL hDC3 : DWORD
        LOCAL hFinalBitmap : DWORD
        LOCAL counter : DWORD
        LOCAL structPaint : PAINTSTRUCT
        LOCAL tmpDword : DWORD

        push    ebx
        push    esi
        push    edi

        ; load the most commonly used vars into registers
        mov     ebx, [hdc]
        mov     esi, [hWnd]

        ; handle specific window messages
        mov     eax, [arg_4]
        .if eax == WM_INITDIALOG
            ; get information about window size
            invoke  GetClientRect, esi, offset rectWindowClient

            ; load bitmap that will be sine-scrolled
            invoke  GetModuleHandleA, 0
            invoke  LoadImageA, eax, 66h, 0, 0, 0, LR_CREATEDIBSECTION
            mov     [hBmpToScroll], eax

            ; get bitmap dimensions
            invoke  GetObjectA, [hBmpToScroll], 18h, offset infoBmpToScroll

            ; save width & height
            mov     eax, [rectWindowClient].right
            mov     [ddWindowClientWidth], eax
            mov     eax, [infoBmpToScroll].bmHeight
            mov     [ddBitmapHeight], eax

            ; calculate X pos of the bitmap, if bitmap is smaller than window client rec
            ; WARNING! this causes problems, if your bitmap is larger than the window.
            mov     eax, [ddWindowClientWidth]
            sub     eax, [infoBmpToScroll].bmWidth
            shr     eax, 5
            mov     [ddBitmapXPos], eax

            ; initialize PRNG
            call    Randomize

            ; start the timer
            invoke  SetTimer, esi, 1, 0Ch, 0

        .elseif eax == WM_TIMER
            ; update scroller variables
            mov     eax, [ddScrollerVar1]
            inc     eax
            inc     eax
            mov     [ddScrollerVar1], eax
            mov     eax, [ddScrollerVar1]
            mov     ecx, 5
            cdq
            idiv    ecx
            test    edx, edx
            jnz     @F
            mov     eax, [ddScrollerVar3]
            add     [ddScrollerVar2], eax
@@:
            mov     edx, 3Ch
            mov     eax, 1Eh
            call    RandomRange
            cmp     eax, [ddScrollerVar2]
            jge     @F
            mov     [ddScrollerVar3], 0FFFFFFFEh
@@:
            cmp     [ddScrollerVar2], 2
            jge     @F
            mov     [ddScrollerVar3], 1
@@:

            ; calculate sinus values based on scroller variables
            mov     eax, [ddBitmapHeight]
            test    eax, eax
            jl      short after_calculate_sine
            inc     eax
            mov     [counter], eax
            xor     edi, edi
            mov     ebx, offset tableSineValues
loop_calculate_sine:
            mov     eax, [ddScrollerVar1]
            add     eax, edi
            mov     [tmpDword], eax
            fild    [tmpDword]
            fld     [tbyte_40CA00]
            fmulp   st(1), st
            fsin
            wait
            fild    [ddScrollerVar2]
            fmulp   st(1), st
            fstp    qword ptr [ebx]
            wait
            inc     edi
            add     ebx, 8
            dec     [counter]
            jnz     short loop_calculate_sine
after_calculate_sine:

            ; invalidate main window, so it's redrawn
            invoke  InvalidateRect, esi, 0, 0

        .elseif eax == WM_DESTROY
            invoke  EndDialog, esi, 0

        .elseif eax == WM_PAINT
            invoke  BeginPaint, esi, addr structPaint
            mov     [hPaint], eax

            ; create device contexts and bitmap
            invoke  CreateCompatibleDC, [hPaint]
            mov     [hDC1], eax

            invoke  CreateCompatibleDC, [hPaint]
            mov     [hDC2], eax

            invoke  CreateCompatibleDC, [hPaint]
            mov     [hDC3], eax

            invoke  CreateCompatibleBitmap, [hPaint], [ddWindowClientWidth], [ddBitmapHeight]
            mov     [hFinalBitmap], eax

            ; select bitmaps onto each HDC. Save old bitmaps, as they are needed for cleanup
            invoke  SelectObject, [hDC1], [hBmpToScroll]
            mov     [hSavedBitmap1], eax

            invoke  SelectObject, [hDC2], [hFinalBitmap]
            mov     [hSavedBitmap2], eax

            invoke  SelectObject, [hDC3], [hBmpBackground]
            mov     [hSavedBitmap3], eax

            ; draw background BMP first
            invoke  BitBlt, [hDC2], 0, 0, [ddWindowClientWidth], [ddBitmapHeight], [hDC3], 0, 0, 0CC0020h

            ; then move and draw each line in the loop
            mov     eax, [ddBitmapHeight]
            test    eax, eax
            jl      short after_draw
            inc     eax
            mov     [counter], eax
            xor     edi, edi
            mov     ebx, offset tableSineValues
loop_draw_adjusted_line:
            push    0CC0020h        ; rop
            push    edi             ; y1
            push    0               ; x1
            mov     eax, [hDC1]
            push    eax             ; hdcSrc
            push    1               ; cy
            fld     qword ptr [ebx]
            call    DoubleToInt64
            mov     edx, [rectWindowClient].right
            sub     edx, eax
            push    edx             ; cx
            push    edi             ; y
            fld     qword ptr [ebx]
            call    DoubleToInt64
            add     eax, [ddBitmapXPos]
            push    eax             ; x
            mov     eax, [hDC2]
            push    eax             ; hdc
            call    BitBlt
            inc     edi
            add     ebx, 8
            dec     [counter]
            jnz     short loop_draw_adjusted_line
after_draw:

            ; perform paint operation onto window itself
            push    0CC0020h        ; rop
            push    0               ; y1
            push    0               ; x1
            mov     eax, [hDC2]
            push    eax             ; hdcSrc
            mov     eax, [infoBmpToScroll].bmHeight
            push    eax             ; cy
            mov     eax, [rectWindowClient].right
            push    eax             ; cx
            push    0               ; y
            push    0               ; x
            mov     eax, [hPaint]
            push    eax             ; hdc
            call    BitBlt

            ; you MUST restore old objects to prevent memory leaks
            ; https://stackoverflow.com/questions/27845782/memory-loss-from-wm-paints-beginpaint-function
            invoke  SelectObject, [hDC2], [hSavedBitmap2]
            invoke  SelectObject, [hDC1], [hSavedBitmap1]
            invoke  SelectObject, [hDC3], [hSavedBitmap3]

            ; and then clean up
            invoke  DeleteObject, [hFinalBitmap]
            invoke  DeleteDC, [hPaint]		; not sure this actually needs to be deleted.
            invoke  DeleteDC, [hDC2]
            invoke  DeleteDC, [hDC1]
            invoke  DeleteDC, [hDC3]

            ; finally call EndPaint
            invoke  EndPaint, esi, ADDR structPaint
        .elseif eax == WM_CLOSE
            invoke  DeleteObject, [hBmpToScroll]
            invoke  KillTimer, esi, 1
            invoke  EndDialog, esi, 0
        .endif

        mov     eax, 0
        pop     edi
        pop     esi
        pop     ebx
        ret
DialogProc      endp

; ---------------------------------------------------------------------------
; initializes random number generator
; ---------------------------------------------------------------------------
Randomize      proc near
        add     esp, 0FFFFFFF8h
        push    esp
        call    QueryPerformanceCounter
        test    eax, eax
        jz      @F
        mov     eax, [esp]
        mov     [RandomSeed], eax
        pop     ecx
        pop     edx
        retn
@@:
        call    GetTickCount
        mov     [RandomSeed], eax
        pop     ecx
        pop     edx
        retn
Randomize      endp

; ---------------------------------------------------------------------------
; generates random integer from 0 to EAX
; ---------------------------------------------------------------------------
RandomInt      proc near
        push    ebx
        xor     ebx, ebx
        imul    edx, [RandomSeed][ebx], 8088405h
        inc     edx
        mov     [RandomSeed][ebx], edx
        mul     edx
        mov     eax, edx
        pop     ebx
        retn
RandomInt      endp

; ---------------------------------------------------------------------------
; generates random integer in range EAX-EDX
; ---------------------------------------------------------------------------
RandomRange     proc near
        push    ebx
        push    esi
        mov     esi, edx
        mov     ebx, eax
        cmp     esi, ebx
        jge     short @F
        mov     eax, ebx
        sub     eax, esi
        call    RandomInt
        add     eax, esi
        pop     esi
        pop     ebx
        retn
@@:
        mov     eax, esi
        sub     eax, ebx
        call    RandomInt
        add     eax, ebx
        pop     esi
        pop     ebx
        retn
RandomRange     endp

; ---------------------------------------------------------------------------
; converts double from FPU ST0 register to int64 in EDX:EAX
; ---------------------------------------------------------------------------
DoubleToInt64   proc near
        sub     esp, 0Ch
        fnstcw  word ptr [esp]
        fnstcw  word ptr [esp+2]
        wait
        or      word ptr [esp+2], 0F00h
        fldcw   word ptr [esp+2]
        fistp   qword ptr [esp+4]
        wait
        fldcw   word ptr [esp]
        pop     ecx
        pop     eax
        pop     edx
        retn
DoubleToInt64   endp

; ---------------------------------------------------------------------------
;
; ---------------------------------------------------------------------------
start:
        invoke  GetModuleHandleA, 0
        mov     [hModule], eax

        ; this bitmap will be a background behind the sine wave. 
        ; FFF keygen used a different bitmap for the entire window
        invoke  LoadBitmapA, [hModule], 66h
        mov     [hBmpBackground], eax

        ; initialize some constants for sine wave. Not sure of the meaning yet
        xor     eax, eax
        mov     [ddScrollerVar1], eax
        mov     [ddScrollerVar2], 2
        mov     [ddScrollerVar3], 6

        ; show dialog box
        invoke  DialogBoxParamA, [hModule], offset aMain, 0, offset DialogProc, 0

        ; job's done, thanks for watching
        invoke  ExitProcess, 0


end start