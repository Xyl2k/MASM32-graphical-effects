.686
.model flat, stdcall
option casemap: none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\gdi32.lib

mbCreate            PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
mbDestroy           PROTO :DWORD
mbSetFont           PROTO :DWORD, :DWORD
mbSetText           PROTO :DWORD, :DWORD
mbSetTextColor      PROTO :DWORD, :DWORD
mbSetInnerColor     PROTO :DWORD, :DWORD
mbSetBorderColor    PROTO :DWORD, :DWORD
mbSetOuterColor     PROTO :DWORD, :DWORD
mbSetSizeBalls      PROTO :DWORD, :DWORD
mbSetSizeBorders    PROTO :DWORD, :DWORD
mbThreadProc        PROTO
mbRender            PROTO :DWORD
mbPixelColor        PROTO :DWORD
mbRandom            PROTO :DWORD

mbPlainColor    EQU 01000000h 
mbDarker        EQU 02000000h
lpMETABALLS     TYPEDEF PTR METABALLS 
METABALLS STRUCT
    hMetaBalls      HANDLE ?
    dwOuterColor    DWORD ?
    dwInnerColor    DWORD ?
    dwBorderColor   DWORD ?
    lpText          DWORD ?
    dwTextPos       DWORD ?
    dwTextHeight    DWORD ?
    SizeBall        REAL4 ?
    SizeBorder      REAL4 ?
    dwWidth         DWORD ?
    dwHeight        DWORD ?
    ThreadID        DWORD ?
    ScreenDC        DWORD ?
    MemDC           DWORD ?
    ppvBits         DWORD ?
METABALLS ENDS

.data
ALIGN 4
szAuthor	BYTE "Coded by PeterPunk [TSRh TeaM]",0
mbClassName     BYTE "MetaBalls",0
r4_0012         REAL4 0.0012
r4_0010         REAL4 0.0010
r4_0000007      REAL4 0.0000007
mbDefaultFont   LOGFONT <10h, 0, 0, 0, FW_DONTCARE, FALSE, FALSE, FALSE, ANSI_CHARSET, \
                    OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, "Verdana">

.data?
dwMBTemp        DWORD ?
mbRandomSeed    DWORD ?

.code
ALIGN 4
LibMain proc hInstDLL:DWORD, reason:DWORD, unused:DWORD
LOCAL wc: WNDCLASSEX
    .if reason == DLL_PROCESS_ATTACH
        invoke GetTickCount
        mov mbRandomSeed, eax
        mov wc.cbSize, sizeof WNDCLASSEX
        mov wc.style, CS_BYTEALIGNWINDOW
        mov wc.lpfnWndProc, offset MetaBallsProc
        mov wc.cbClsExtra, NULL
        mov wc.cbWndExtra, NULL
        invoke GetModuleHandle, NULL
        mov wc.hInstance, eax
        mov wc.hbrBackground, NULL
        mov wc.lpszMenuName, NULL
        mov wc.lpszClassName, offset mbClassName
        mov wc.hIcon, NULL
        mov wc.hCursor, NULL
        mov wc.hIconSm, NULL
        invoke RegisterClassEx, ADDR wc
        mov eax, TRUE
    .elseif reason == DLL_PROCESS_DETACH
        invoke GetModuleHandle, NULL
        invoke UnregisterClass, ADDR mbClassName, eax
    .elseif reason == DLL_THREAD_ATTACH

    .elseif reason == DLL_THREAD_DETACH

    .endif
    ret
LibMain endp

ALIGN 4
mbCreate proc uses ebx esi edi mbAddrMetaBall:DWORD, mbHWND:DWORD, mbLeft:DWORD, mbTop:DWORD, \
                               mbWidth:DWORD, mbHeight:DWORD, mbNumBalls:DWORD
LOCAL dwReturn: DWORD
LOCAL dwRndNum: DWORD
    mov dwReturn, 0
    mov esi, mbAddrMetaBall
    .if dword ptr [esi] == 0
        .if mbWidth > 0 && mbHeight > 0
            .if mbNumBalls < 2
                mov mbNumBalls, 2
            .endif
            invoke GetProcessHeap
            .if eax != NULL
                mov edx, mbNumBalls
                imul edx, 16
                add edx, 4
                add edx, SIZEOF METABALLS
                invoke HeapAlloc, eax, HEAP_ZERO_MEMORY, edx
                .if eax != NULL
                    mov dwReturn, eax
                .endif
            .endif
        .endif
        .if dwReturn != 0
            mov ebx, dwReturn
            assume ebx: lpMETABALLS
            mov eax, mbWidth
            mov [ebx].dwWidth, eax
            mov eax, mbHeight
            mov [ebx].dwHeight, eax
            mov [ebx].dwOuterColor, 0969696h
            mov [ebx].dwInnerColor, mbDarker
            mov [ebx].dwBorderColor, Black
            push r4_0012
            pop [ebx].SizeBall
            push r4_0010 
            pop [ebx].SizeBorder
            assume ebx: nothing
            add ebx, SIZEOF METABALLS
            mov ecx, mbNumBalls
            mov [ebx], ecx
            add ebx, 4
            .repeat
                mov eax, mbWidth
                inc eax
                invoke mbRandom, eax
                mov [ebx], eax
                fild dword ptr [ebx]
                fstp dword ptr [ebx]
                add ebx, 4
                mov eax, mbHeight
                inc eax
                invoke mbRandom, eax
                mov [ebx], eax
                fild dword ptr [ebx]
                fstp dword ptr [ebx]
                add ebx, 4
                invoke mbRandom, 10000
                mov dwRndNum, eax
                fild dword ptr [dwRndNum]
                fimul dword ptr [mbWidth]
                fmul r4_0000007
                invoke mbRandom, 2
                .if eax == 0
                    fchs
                .endif
                fstp dword ptr [ebx]
                add ebx, 4
                invoke mbRandom, 10000
                mov dwRndNum, eax
                fild dword ptr [dwRndNum]
                fimul dword ptr [mbHeight]
                fmul r4_0000007
                invoke mbRandom, 2
                .if eax == 0
                    fchs
                .endif
                fstp dword ptr [ebx]
                add ebx, 4
                dec ecx
            .until ecx == 0
            push dwReturn
            pop dwMBTemp
            invoke GetModuleHandle, NULL
            invoke CreateWindowEx, WS_EX_TRANSPARENT, ADDR mbClassName, NULL, WS_CHILD or WS_VISIBLE, \
                mbLeft, mbTop, mbWidth, mbHeight, mbHWND, NULL, eax, NULL
            .if eax == NULL
                invoke GetProcessHeap
                .if eax != NULL
                    invoke HeapFree, eax, NULL, dwReturn
                .endif
                mov dwReturn, 0
            .else
                mov ebx, dwReturn
                assume ebx: lpMETABALLS
                mov [ebx].hMetaBalls, eax
                invoke CreateThread, 0, 0, ADDR mbThreadProc, 0, 0, 0
                mov [ebx].ThreadID, eax
                assume ebx: nothing
                invoke SetThreadPriority, eax, THREAD_PRIORITY_NORMAL
                invoke Sleep, 10
            .endif
        .endif
        mov eax, dwReturn
        mov dword ptr [esi], eax
    .endif
    ret
mbCreate endp

ALIGN 4
mbDestroy proc uses ebx esi mbAddrMetaBall:DWORD
    mov esi, mbAddrMetaBall
    .if dword ptr [esi] != 0
        mov ebx, [esi]
        assume ebx: lpMETABALLS
        invoke TerminateThread, [ebx].ThreadID, 0
        invoke DeleteDC, [ebx].ScreenDC
        invoke DeleteDC, [ebx].MemDC
        invoke SendMessage, [ebx].hMetaBalls, WM_CLOSE, NULL, NULL
        invoke GetProcessHeap
        .if eax != NULL
            push eax
            .if [ebx].lpText != 0
                invoke HeapFree, eax, NULL, [ebx].lpText
            .endif
            pop eax
            invoke HeapFree, eax, NULL, ebx
        .endif
        assume ebx: nothing
        mov dword ptr [esi], 0
    .endif
    ret
mbDestroy endp

ALIGN 4
MetaBallsProc proc uses ebx hWin:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
LOCAL bmpi: BITMAPINFO
LOCAL rect: RECT
    .if uMsg == WM_CREATE
        mov ebx, dwMBTemp
        assume ebx: lpMETABALLS
        invoke GetWindowDC, hWin
        mov [ebx].ScreenDC, eax
        invoke CreateCompatibleDC, eax
        mov [ebx].MemDC, eax
        invoke RtlZeroMemory, ADDR bmpi, SIZEOF BITMAPINFO
        mov bmpi.bmiHeader.biSize, SIZEOF bmpi.bmiHeader
        mov bmpi.bmiHeader.biBitCount, 32
        mov eax, [ebx].dwWidth
        imul eax, eax, 4
        mov edx, [ebx].dwHeight
        imul eax, edx
        mov bmpi.bmiHeader.biSizeImage, eax
        mov bmpi.bmiHeader.biPlanes, 1
        mov eax, [ebx].dwWidth
        mov bmpi.bmiHeader.biWidth, eax
        mov eax, [ebx].dwHeight
        mov bmpi.bmiHeader.biHeight, eax
        invoke CreateDIBSection, [ebx].MemDC, ADDR bmpi, DIB_RGB_COLORS, ADDR [ebx].ppvBits, 0, 0
        invoke SelectObject, [ebx].MemDC, eax
        invoke CreateFontIndirect, ADDR mbDefaultFont
        invoke SelectObject, [ebx].MemDC, eax
        invoke SetBkMode, [ebx].MemDC, TRANSPARENT
        invoke SetTextColor, [ebx].MemDC, White
        assume ebx: nothing
    .elseif uMsg == WM_LBUTTONDOWN
        invoke GetWindowRect, hWin, ADDR rect
        mov edx, rect.top
        shl edx, 16
        mov eax, rect.left
        or edx, eax
        add edx, lParam
        push edx
        invoke GetParent, hWin
        pop edx
        invoke SendMessage, eax, WM_LBUTTONDOWN, wParam, edx
    .elseif uMsg == WM_RBUTTONDOWN 
        invoke GetWindowRect, hWin, ADDR rect
        mov edx, rect.top
        shl edx, 16
        mov eax, rect.left
        or edx, eax
        add edx, lParam
        push edx
        invoke GetParent, hWin
        pop edx
        invoke SendMessage, eax, WM_RBUTTONDOWN, wParam, edx
    .elseif uMsg == WM_CLOSE
        invoke DestroyWindow, hWin
    .else
        invoke DefWindowProc, hWin, uMsg, wParam, lParam
        ret
    .endif
    xor eax, eax
    ret
MetaBallsProc endp

ALIGN 4
mbThreadProc proc uses ebx esi esi
LOCAL rect: RECT
LOCAL dwSlowDown: DWORD
    mov ebx, dwMBTemp
    assume ebx: lpMETABALLS
@@:
    invoke mbRender, ebx
    invoke SetRect, ADDR rect, 0, [ebx].dwTextPos, [ebx].dwWidth, [ebx].dwHeight
    invoke DrawText, [ebx].MemDC, [ebx].lpText, -1, ADDR rect, DT_CENTER or DT_TOP
    invoke  BitBlt, [ebx].ScreenDC, 0, 0, [ebx].dwWidth, [ebx].dwHeight, [ebx].MemDC, 0, 0, SRCCOPY
    mov eax, [ebx].dwTextHeight
    .if [ebx].dwTextPos == eax
        push [ebx].dwHeight
        pop [ebx].dwTextPos
    .endif
    inc dwSlowDown
    .if dwSlowDown > 2
        dec [ebx].dwTextPos
        mov dwSlowDown, 0
    .endif
    assume ebx: nothing     
    invoke Sleep, 10
    jmp @B
    ret
mbThreadProc endp

ALIGN 4
mbRender proc uses ebx esi edi MetaBalls:DWORD
LOCAL dwWidth: DWORD, dwHeight: DWORD
LOCAL dwNumBalls: DWORD
LOCAL InnerColor: DWORD, BorderColor: DWORD, OuterColor: DWORD
LOCAL m: REAL4
LOCAL r4Temp: REAL4
    mov ebx, MetaBalls
    call mbMove
    assume ebx: lpMETABALLS
    .if [ebx].dwInnerColor >= mbDarker
        mov edx, [ebx].dwOuterColor
        shr dl, 1
        shr dh, 1
        ror edx, 16
        shr dl, 1
        mov eax, [ebx].dwInnerColor
        rol eax, 16
        mov dh, ah   
        rol edx, 16
    .else
        mov edx, [ebx].dwInnerColor
    .endif
    bswap edx
    ror edx, 8
    mov InnerColor, edx
    mov edx, [ebx].dwBorderColor
    bswap edx
    ror edx, 8
    mov BorderColor, edx
    mov edx, [ebx].dwOuterColor
    bswap edx
    ror edx, 8
    mov OuterColor, edx
    push [ebx].dwWidth
    pop dwWidth
    push [ebx].dwHeight
    pop dwHeight
    lea eax, [ebx + SIZEOF METABALLS]
    mov eax, [eax]
    mov dwNumBalls, eax
    mov edi, [ebx].ppvBits
    xor ecx, ecx
    .repeat
        xor edx, edx
        .repeat
            xor esi, esi
            lea eax, [ebx + SIZEOF METABALLS]
            add eax, 4
            mov m, 0
            .repeat
                mov r4Temp, edx
                fild dword ptr [r4Temp]
                fsub dword ptr [eax]
                fmul st, st
                add eax, 4
                mov r4Temp, ecx
                fild dword ptr [r4Temp]
                fsub dword ptr [eax]
                fmul st, st
                faddp st(1), st
                add eax, 12
                push eax
                ftst
                fstsw ax
                fwait
                sahf
                jnz @F
                    fld1
                    fadd m
                    fstp m
                    jmp @mbRenderExit1
                @@:
                    fld1
                    fdivrp st(1), st
                    fadd m
                    fst m
                @mbRenderExit1:
                ffree st
                pop eax  
                inc esi
            .until esi == dwNumBalls
            fld m
            fld dword ptr [ebx].SizeBall
            fcomip st, st(1)
            ja @F
                test InnerColor, mbPlainColor
                jnz @PlainInner
                    invoke mbPixelColor, InnerColor
                    jmp @mbRenderExit2
                @PlainInner:
                    mov eax, InnerColor
                    jmp @mbRenderExit2
            @@:
                fld dword ptr [ebx].SizeBorder
                fcomip st, st(1)
                ja @F
                    test BorderColor, mbPlainColor
                    jnz @PlainBorder
                        invoke mbPixelColor, BorderColor
                        jmp @mbRenderExit2
                    @PlainBorder:
                        mov eax, BorderColor
                        jmp @mbRenderExit2
                @@:
                    test OuterColor, mbPlainColor
                    jnz @PlainOuter
                        invoke mbPixelColor, OuterColor
                        jmp @mbRenderExit2
                    @PlainOuter:
                        mov eax, OuterColor
            @mbRenderExit2:
            ffree st
            stosd
            inc edx
        .until edx == dwWidth
        inc ecx
    .until ecx == dwHeight
    assume ebx: nothing
    ret
mbRender endp

ALIGN 4
mbMove proc
    assume ebx: lpMETABALLS
    lea eax, [ebx + SIZEOF METABALLS]
    mov ecx, [eax]
    add eax, 4
    xor edx, edx
    .repeat
        fld dword ptr [eax]
        fadd dword ptr [eax + 8]
        fldz
        fcomip st, st(1)
        jb @F
        fld dword ptr [eax + 8]
        fchs
        fstp dword ptr [eax + 8]
        jmp @bmMoveExit1
@@:
        fild [ebx].dwWidth
        fcomip st, st(1)
        ja @bmMoveExit1
        fld dword ptr [eax + 8]
        fchs
        fstp dword ptr [eax + 8]
@bmMoveExit1:
        fstp dword ptr [eax]        
        add eax, 4
        fld dword ptr [eax]
        fadd dword ptr [eax + 8]
        fldz
        fcomip st, st(1)
        jb @F
        fld dword ptr [eax + 8]
        fchs
        fstp dword ptr [eax + 8]
        jmp @bmMoveExit2
@@:
        fild [ebx].dwHeight
        fcomip st, st(1)
        ja @bmMoveExit2
        fld dword ptr [eax + 8]
        fchs
        fstp dword ptr [eax + 8]
@bmMoveExit2:
        fstp dword ptr [eax]
        add eax, 12
        inc edx
    .until edx == ecx
    assume ebx: nothing
    ret
mbMove endp

ALIGN 4
mbPixelColor proc uses edx ecx mbColor:DWORD
    invoke mbRandom, 256
    mov edx, mbColor
    movzx ecx, dl
    imul ecx, eax
    shr ecx, 8
    mov dl, cl
    ror edx, 8
    movzx ecx, dl
    imul ecx, eax
    shr ecx, 8
    mov dl, cl
    ror edx, 8
    movzx ecx, dl
    imul ecx, eax
    shr ecx, 8
    mov dl, cl
    rol edx, 16
    mov eax, edx
    ret
mbPixelColor endp

ALIGN 4
mbRandom proc uses edx ecx mbBase:DWORD
    mov eax, mbRandomSeed
    xor edx, edx
    mov ecx, 127773
    div ecx
    mov ecx, eax
    mov eax, 16807
    mul edx
    mov edx, ecx
    mov ecx, eax
    mov eax, 2836
    mul edx
    sub ecx, eax
    xor edx, edx
    mov eax, ecx
    mov mbRandomSeed, ecx
    div mbBase
    mov eax, edx
    ret
mbRandom endp

ALIGN 4
mbSetFont proc uses ebx MetaBall: DWORD, mbLpLf: DWORD
    .if MetaBall != 0
        mov ebx, MetaBall
        assume ebx: lpMETABALLS
        invoke CreateFontIndirect, mbLpLf
        .if eax != NULL
            invoke SelectObject, [ebx].MemDC, eax
            .if eax != NULL
                invoke mbSetText, MetaBall, [ebx].lpText
                mov eax, 1
            .endif
        .endif
        assume ebx: nothing
    .else
        xor eax, eax
    .endif
    ret
mbSetFont endp

ALIGN 4
mbSetText proc uses ebx MetaBall: DWORD, mbLpText: DWORD
LOCAL rect: RECT
LOCAL dwLen: DWORD
LOCAL hHeap: DWORD
LOCAL lpAlloc: DWORD
    .if MetaBall != 0
        mov ebx, MetaBall
        assume ebx: lpMETABALLS
        invoke lstrlen, mbLpText
        mov dwLen, eax
        invoke GetProcessHeap
        .if eax != NULL
            mov hHeap, eax
            mov edx, dwLen
            inc edx
            invoke HeapAlloc, eax, HEAP_ZERO_MEMORY, edx
            .if eax != NULL
                mov lpAlloc, eax
                invoke lstrcpy, eax, mbLpText
                .if eax != 0
                    .if [ebx].lpText != 0
                        invoke HeapFree, hHeap, NULL, [ebx].lpText
                    .endif
                    push lpAlloc
                    pop [ebx].lpText
                    invoke DrawText, [ebx].MemDC, [ebx].lpText, dwLen, ADDR rect, DT_CALCRECT
                    not eax
                    mov [ebx].dwTextHeight, eax
                    push [ebx].dwHeight
                    pop [ebx].dwTextPos
                .endif
            .endif
        .endif
        assume edx: nothing
    .else
        xor eax, eax
    .endif
    ret
mbSetText endp

ALIGN 4
mbSetTextColor proc uses ebx MetaBall: DWORD, mbColor: DWORD
    .if MetaBall != 0
        mov ebx, MetaBall
        assume ebx: lpMETABALLS
        invoke SetTextColor, [ebx].MemDC, mbColor
        assume ebx: nothing
    .else
        mov eax, -1
    .endif
    ret
mbSetTextColor endp

ALIGN 4
mbSetInnerColor proc MetaBall: DWORD, mbColor: DWORD
    .if MetaBall != 0
        mov eax, MetaBall
        assume eax: lpMETABALLS
        push mbColor
        pop [eax].dwInnerColor
        assume eax: nothing
    .endif
    ret
mbSetInnerColor endp

ALIGN 4
mbSetBorderColor proc MetaBall: DWORD, mbColor: DWORD
    .if MetaBall != 0
        mov eax, MetaBall
        assume eax: lpMETABALLS
        push mbColor
        pop [eax].dwBorderColor
        assume eax: nothing
    .endif
    ret
mbSetBorderColor endp

ALIGN 4
mbSetOuterColor proc MetaBall: DWORD, mbColor: DWORD
    .if MetaBall != 0
        mov eax, MetaBall
        assume eax: lpMETABALLS
        push mbColor
        pop [eax].dwOuterColor
        assume eax: nothing
    .endif
    ret
mbSetOuterColor endp

ALIGN 4
mbSetSizeBalls proc MetaBall: DWORD, mbSize: DWORD
    .if MetaBall != 0
        mov eax, MetaBall
        assume eax: lpMETABALLS
        fld [eax].SizeBorder
        fld1
        fdivrp st(1), st
        fld [eax].SizeBall
        fld1
        fdivrp st(1), st
        fsubp st(1), st
        fiadd dword ptr [mbSize]
        fld1
        fdivrp st(1), st
        fstp [eax].SizeBorder
        fild dword ptr [mbSize]
        fld1
        fdivrp st(1), st
        fstp [eax].SizeBall
        assume eax: nothing
    .endif
    ret
mbSetSizeBalls endp

ALIGN 4
mbSetSizeBorders proc MetaBall: DWORD, mbSize: DWORD
    .if MetaBall != 0
        mov eax, MetaBall
        assume eax: lpMETABALLS
        fld [eax].SizeBall
        fld1
        fdivrp st(1), st
        fiadd dword ptr [mbSize]
        fld1
        fdivrp st(1), st
        fstp [eax].SizeBorder
        assume eax: nothing
    .endif
    ret
mbSetSizeBorders endp

end LibMain