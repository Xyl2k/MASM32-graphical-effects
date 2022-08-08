.386
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\comctl32.inc
include \masm32\include\gdi32.inc
include \masm32\include\oleaut32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\comctl32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\oleaut32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\ole32.lib
includelib \masm32\lib\comdlg32.lib
includelib \masm32\lib\Comctl32.lib

include  FontData.inc

DlgProc                   PROTO :HWND,:UINT,:WPARAM,:LPARAM
EngineInit                PROTO :HWND
TimerProc                 PROTO :HWND
PaintProc                 PROTO :HWND
InstallMemFont            proto :DWORD,:DWORD    

.const
IDD_DIALOG                equ   101
ID_FONT                   equ   2000
rcScrollerArea            RECT  <0, 0, dwWidth, 0>
dwWidth                   equ   299
dwHeight                  equ   100
frequency                 real4 8.0
amplitude                 real4 15.7

.data
szBuf                     db MAX_PATH dup (0)
szExit                    db "Close me",0

szScroller                db "Hear ye! Hear ye! RED are back! ",
                             "This time, we give you: Ç Nothing Ç ",
                             "The excellent music was composed by: ä Unknown Artist ä ",
                             "The cool logo was created by: è Unknown Artist è ",
                             "Our best greets to RED members ",
                             "In addition, shouts to the members of team PRF ! ",0
.data?     
; OTHER STUFF
hInstance                 dd ?
hDC                       dd ?
hDCScroller               dd ?
hBmpScroller              dd ?
ps                        PAINTSTRUCT <>
x                         dd ?
szMessage                 db 256 dup (?)
rcScroller                RECT <>
rc                        RECT <>
sz                        SIZEL <>
hFont                     dd ?
hFontEx                   dd ?
hBrushWhite               dd ?
hBmp                      dd ?
hOld                      dd ?
memDC                     dd ?
hTemp                     dd ?

.code
start:
    invoke GetModuleHandle,NULL
    mov hInstance,eax
    invoke InitCommonControls
    invoke DialogBoxParam,hInstance,IDD_DIALOG,NULL,addr DlgProc,NULL
    invoke ExitProcess,0

DlgProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
    mov eax,[uMsg]
    .if eax == WM_INITDIALOG
        invoke EngineInit,[hWin]
        ret
    .elseif eax == WM_MOUSEMOVE
        mov eax,[wParam]
        cmp eax,1
        je @@MF
        xor eax,eax
        ret
    @@MF:
        invoke ReleaseCapture
        ;invoke SendMessage,[hWin],WM_SYSCOMMAND,0F012h,0 ; Magic number =)
        invoke SendMessage,[hWin], WM_SYSCOMMAND, SC_MOVE+2, 0
        xor eax,eax
        ret
    .elseif [uMsg]==WM_CTLCOLORDLG || [uMsg]==WM_CTLCOLORBTN || [uMsg]==WM_CTLCOLOREDIT || [uMsg]==WM_CTLCOLORSTATIC
        invoke SetTextColor, [wParam], 00256646h
        invoke SetBkColor, [wParam], 00FFFFFFh
        invoke SetBkMode, [wParam], OPAQUE
        mov eax, [hBrushWhite]
        ret
    .elseif eax == WM_TIMER
        invoke TimerProc,[hWin]
    .elseif eax == WM_PAINT
        invoke PaintProc,[hWin]
    .elseif eax == WM_COMMAND
        mov eax,wParam
        .if eax == 1004
            invoke SendMessage,hWin,WM_CLOSE,0,0
        .endif
    .elseif eax == WM_CLOSE
            invoke KillTimer,hWin, 1
            invoke DeleteDC, hDCScroller
            invoke DeleteObject, hBmpScroller
            invoke EndDialog,hWin,0
    .else
        mov eax,FALSE
        ret
    .endif
    mov eax,TRUE
    ret

DlgProc endp

InstallMemFont proc szFont:DWORD,iSizeOfFont:DWORD
    local hResourceFont  :HANDLE;
    local hinstLib       :HINSTANCE;
    local LibExport      :FARPROC;

.data
    dwNumberOfFontsInstalled          dd 0
    szLibName                         db "gdi32.dll",0
    szProcName                        db "AddFontMemResourceEx",0
    
.code
    mov dwNumberOfFontsInstalled,0
    invoke LoadLibrary,addr szLibName
    mov hinstLib,eax
    invoke GetProcAddress,hinstLib,addr szProcName
    mov LibExport,eax
    invoke FreeLibrary,hinstLib 
    push offset dwNumberOfFontsInstalled
    push NULL
    push iSizeOfFont
    push szFont
    call LibExport
    add esp,4*4    
    .if (dwNumberOfFontsInstalled!=0)
        mov eax,1
    .else
        xor eax,eax
    .endif
    ret
InstallMemFont EndP

EngineInit proc hWnd : HWND
    invoke BitmapFromResource,hInstance,1
    mov hBmp,eax
    invoke CreateSolidBrush,00FFFFFFh
    mov [hBrushWhite], eax
    ;Load the font in memory
    invoke InstallMemFont,offset szFontDump, dwSizeOfFont 
    ;Obtain a handle for it
    invoke CreateFont,17,15,10,11,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                      DEFAULT_QUALITY,DEFAULT_PITCH or FF_DONTCARE,addr szFontName
    mov hFont,eax
    mov hFontEx, eax
    invoke GetDC,[hWnd]
    mov [hDC], eax
    invoke CreateCompatibleDC, eax
    mov [hDCScroller], eax
    invoke SelectObject, eax, [hFont]
    invoke SetTextColor, [hDCScroller], 00404040h

    invoke SetBkColor, [hDCScroller], 00FFFFFFh
    invoke SetBkMode, [hDCScroller], OPAQUE
    invoke GetTextExtentPoint32, [hDCScroller], ADDR szScroller, sizeof szScroller, ADDR rcScroller.right
    mov [x], -dwWidth
    mov [rcScroller.bottom], 50
    invoke CreateCompatibleBitmap, [hDC], [rcScroller.right], [rcScroller.bottom]
    mov [hBmpScroller], eax
    invoke SelectObject, [hDCScroller], eax
    invoke GetStockObject, WHITE_BRUSH
    invoke FillRect, [hDCScroller], ADDR rcScroller, eax
    invoke ReleaseDC, [hWnd], [hDC]
    invoke SetTimer, [hWnd], 1, 5, 0
    ret
EngineInit endp

PaintProc proc hWin :HWND
    invoke BeginPaint, [hWin], ADDR ps
    mov [hDC], eax
    invoke CreateCompatibleDC, [hDC]
    mov [memDC], eax
    invoke SelectObject, [memDC], hBmp
    mov hOld, eax
    invoke BitBlt, [hDC], 84, 85, 150, 251, [memDC], 0, 0, SRCCOPY
    invoke SelectObject, [hDC], [hOld]
    invoke DeleteDC, memDC
    invoke SetBkMode,[hDC],TRANSPARENT
    invoke GetStockObject, BLACK_BRUSH
    invoke FillRect, [hDCScroller], ADDR rcScrollerArea, eax
    push esi
    push edi
    mov esi, OFFSET rcScroller
    mov edi, OFFSET rc
    mov ecx, sizeof rc shr 2
    rep movsd
    mov esi, OFFSET szScroller
    mov ecx, sizeof szScroller
@@drch:
    push ecx
    fild [rc.left]
    fild [x]
    fadd
    fdiv [frequency]
    fsin
    fcos
    fmul [amplitude]
    fild [rcScroller.top]
    fadd
    fistp [rc.top]
    invoke DrawText, [hDCScroller], esi, 1, ADDR rc, DT_SINGLELINE OR DT_VCENTER OR DT_EXPANDTABS
    invoke GetTextExtentPoint32, [hDCScroller], esi, 1, ADDR sz
    mov eax, [sz.x]
    add [rc.left], eax
    pop ecx
    inc esi
    loopd @@drch
    pop edi
    pop esi
    invoke BitBlt, [hDC], 0, 0, dwWidth, [rcScroller.bottom], [hDCScroller], [x], 0, SRCCOPY
    invoke EndPaint, [hWin], ADDR ps

    ; 1004: Exit BUTTON
    invoke GetDlgItem,hWin,1004
    mov hTemp,eax
    invoke BeginPaint,hTemp,addr ps
    mov hDC,eax
    invoke SelectObject,hDC,hFontEx
    invoke TextOut,hDC,0,0,addr szExit,sizeof szExit-1
    invoke EndPaint,hTemp,addr ps
    ret
PaintProc endp

TimerProc proc hWin :HWND
    mov eax, [x]
    inc eax
    inc eax
    cmp eax, [rcScroller.right]
    jle @@sxok
    mov eax, -dwWidth
@@sxok:
    mov [x], eax
    invoke InvalidateRect, [hWin], ADDR rcScroller,FALSE
    ret
TimerProc endp

end start
