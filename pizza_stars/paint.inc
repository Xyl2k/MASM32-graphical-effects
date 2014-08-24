
PAINT proc @hWnd:dword


LOCAL Paint   :PAINTSTRUCT 
LOCAL var_4$    :dword 




                               lea     eax, [Paint]
                                push    eax             ; lpPaint
                                push    [@hWnd]      ; hWnd
                                call    BeginPaint
                                mov     [var_4$], eax
                                push    0               ; UINT
                                push    hMem            ; BITMAPINFO *
                                push    dword_404574    ; void *
                                push    25h             ; UINT
                                push    0               ; UINT
                                push    0               ; int
                                push    0               ; int
                                push    25h             ; DWORD
                                push    0FFh            ; DWORD
                                push    0B3h               ; int
                                push    11h             ; int
                                push    [var_4$]     ; HDC
                                call    SetDIBitsToDevice
                                ;push    [var_4]     ; HDC
                                ;push    [@hWnd]      ; int
                                ;call    sub_401E8E ; risuet knopki
                                lea     eax, [Paint]
                                push    eax             ; lpPaint
                                push    [@hWnd]      ; hWnd
                                call    EndPaint
                                leave
                                retn 4


PAINT endp

	
		
