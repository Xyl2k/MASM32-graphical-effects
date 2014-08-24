
                             ;wm_create
                               
       my_init proc hWnd:DWORD                        
         LOCAL var_48:DWORD
         LOCAL @hDC:DWORD             
                      
                      
                      
                      
                      
                              push    1000            ; lpBitmapName
                              push    hInstance
                              call    LoadBitmapA
                              
                              mov dword_40B904,eax
                              invoke CreatePatternBrush,eax
                              
	                           mov dword_40B900,eax
                               
                               push    [hWnd]      ; hWnd
                               call    GetDC
                               mov     [@hDC], eax
                               push    [@hDC]       ; HDC
                               call    CreateCompatibleDC
                               mov     dword_40B908, eax
                               push    84h             ; int
                               push    111h            ; int
                               push    [@hDC]       ; HDC
                               call    CreateCompatibleBitmap
                               mov     dword_40B904, eax
                               push    dword_40B904    ; HGDIOBJ
                               push    dword_40B908    ; HDC
                               call    SelectObject
                               push    dword_40B900    ; HGDIOBJ
                               push    dword_40B908    ; HDC
                               call    SelectObject
                               push    0F00021h        ; DWORD
                               push    84h             ; int
                               push    111h            ; int
                               push    0               ; int
                               push    0               ; int
                               push    dword_40B908    ; HDC
                               call    PatBlt
                               push    offset stru_40B66D ; LOGFONTA *
                               call    CreateFontIndirectA
                               mov     [var_48], eax
                               push    [var_48]    ; HGDIOBJ
                               push    dword_40B908    ; HDC
                               call    SelectObject
                               push    1               ; int
                               push    dword_40B908    ; HDC
                               call    SetBkMode
                               push    0FFFFFFh        ; COLORREF
                               push    dword_40B908    ; HDC
                               call    SetTextColor
                               push    0CC0020h        ; DWORD
                               push    0               ; int
                               push    0               ; int
                               push    dword_40B908    ; HDC
                               push    84h             ; int
                               push    111h            ; int
                               push    0               ; int
                               push    0               ; int
                               push    dword_40B908    ; HDC
                               call    BitBlt
                               push    dword_40B904    ; HGDIOBJ
                               call    DeleteObject
                               push    [@hDC]       ; hDC
                               push    [hWnd]      ; hWnd
                               call    ReleaseDC
                               push    0               ; bErase
                               push    0               ; lpRect
                               push    [hWnd]      ; hWnd
                               call    InvalidateRect
                               mov     dword_40B910, 22h
                               mov     dword_40B918, 111h
                               mov     dword_40B90C, 12Ch
                               ;push    0               ; lpTimerFunc
                               ;push    3Ch             ; uElapse
                               ;push    4D2h            ; nIDEvent
                               ;push    [ebp+hWnd]      ; hWnd
                               ;call    SetTimer
                               ret
my_init endp