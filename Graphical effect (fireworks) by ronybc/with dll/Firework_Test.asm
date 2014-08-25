include \masm32\include\masm32rt.inc
include Firework.inc
includelib Firework.lib

WndProc PROTO :DWORD, :DWORD, :DWORD, :DWORD

.data
.data?
    hInstance   dd ?
    hWnd        dd ?
    FW0         dd ?
    FW1         dd ?
    FW2         dd ?

.code

start:
    invoke GetModuleHandle, NULL
    mov hInstance, eax
    invoke DialogBoxParam, hInstance, 1001, 0, ADDR WndProc, 0
    invoke ExitProcess, eax
    
WndProc proc hWin: DWORD, uMsg: DWORD, wParam: DWORD, lParam: DWORD
LOCAL dwColor: DWORD	
    .if uMsg == WM_INITDIALOG
        push hWin
        pop hWnd
        invoke FCreate, hWin, ADDR FW0, 0, 0, 200, 200
        invoke FCreate, hWin, ADDR FW1, 200, 0, 200, 200
        invoke FCreate, hWin, ADDR FW2, 0, 200, 400, 200
    .elseif uMsg == WM_CLOSE
        invoke EndDialog, hWin, 0
    .elseif uMsg == WM_LBUTTONDOWN
        invoke Explode, FW0
        invoke Explode, FW1
        invoke Explode, FW2
    .elseif uMsg == WM_RBUTTONDOWN
        nop
    .endif
    xor eax, eax
    ret
WndProc endp

end start