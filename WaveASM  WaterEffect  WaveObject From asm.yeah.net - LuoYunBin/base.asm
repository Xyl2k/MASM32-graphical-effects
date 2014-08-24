.486
.model  flat, stdcall
option  casemap :none   ; case sensitive

include         windows.inc
include         user32.inc
include         kernel32.inc
include         gdi32.inc
include         C:\masm32\macros\macros.asm
include         WaveObject.asm
includelib      user32.lib
includelib      kernel32.lib
includelib      gdi32.lib

DlgProc     PROTO :DWORD,:DWORD,:DWORD,:DWORD
szTitle     db  'Error',0
szError     db  'An error has occured',0

.data?
hInstance   dd  ?
stWaveObj   WAVE_OBJECT <?>
xWin dd ?
hBitmap dd ?
bitmp dd ?

.const
IDC_EXIT   equ     1005

.code
start:
    invoke  GetModuleHandle, NULL
    mov hInstance, eax
    invoke  DialogBoxParam, hInstance, 101, 0, ADDR DlgProc, 0
    invoke  ExitProcess, eax
; -----------------------------------------------------------------------
DlgProc proc hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
        local   @stPs:PAINTSTRUCT,@hDc,@stRect:RECT
        local   @stBmp:BITMAP
   LOCAL hMemDC:HDC
    .if uMsg==WM_INITDIALOG
invoke LoadBitmap,hInstance,1
        mov hBitmap,eax
        invoke  GetDlgItem,hWin,1008
        push    hBitmap
        invoke  _WaveInit,addr stWaveObj,eax,hBitmap,30,0
        .if eax
            invoke  MessageBox,hWin,addr szError,addr szTitle,MB_OK or MB_ICONSTOP
            call    _Quit
        .else
        .endif
        pop hBitmap
        invoke  DeleteObject,hBitmap
        invoke  _WaveEffect,addr stWaveObj,1,5,4,250
    .elseif uMsg == WM_PAINT
      invoke BeginPaint,hWin,addr @stPs
      mov @hDc,eax
      invoke CreateCompatibleDC,@hDc
      mov hMemDC,eax
      invoke SelectObject,hMemDC,hBitmap
      invoke GetClientRect,hWin,addr @stRect
      invoke BitBlt,@hDc,10,10,@stRect.right,@stRect.bottom,hMemDC,0,0,MERGECOPY
      invoke DeleteDC,hMemDC
      invoke _WaveUpdateFrame,addr stWaveObj,eax,TRUE
      invoke EndPaint,hWin,addr @stPs
            xor eax,eax
            ret
    .elseif uMsg==WM_COMMAND
        mov eax,wParam
        .if eax==IDC_EXIT
            invoke SendMessage,hWin,WM_CLOSE,0,0
        .endif    
    .elseif uMsg == WM_LBUTTONDOWN
            mov eax,lParam
            movzx   ecx,ax      ; x
            shr eax,16      ; y
            invoke  _WaveDropStone,addr stWaveObj,ecx,eax,2,256
;   .elseif uMsg== WM_MOUSEMOVE
;           mov eax,lParam
;           movzx   ecx,ax      ; x
;           shr eax,16      ; y
;           invoke  _WaveDropStone,addr stWaveObj,ecx,eax,2,256
    .elseif uMsg == WM_CLOSE
        call    _Quit
        invoke EndDialog,xWin,0
    .elseif uMsg==WM_DESTROY
      invoke DeleteObject,hBitmap
        invoke PostQuitMessage,NULL
        .endif
    xor eax,eax
    ret
DlgProc endp
_Quit proc
invoke  _WaveFree,addr stWaveObj
invoke  DestroyWindow,xWin
invoke  PostQuitMessage,NULL
ret
_Quit endp
end start