                              
              init proc hWnd:dword                
                              
                              push    hWnd;esi             ; hWnd
                              call    GetWindowDC
                              mov     dword_407BFC, eax
                              mov     eax, dword_407BFC
                              push    eax             ; HDC
                              call    CreateCompatibleDC
                              mov     dword_407BF8, eax
                              
                              mov     eax, dword_407BF4; hBmp
                              push    eax             ; HGDIOBJ
                              mov     eax, dword_407BF8
                              push    eax             ; HDC
                              call    SelectObject
                              mov     eax, dword_407BF8
                              push    offset aCourierNew ; "Courier New"
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    2BCh            ; int
                              push    0               ; int
                              push    0               ; int
                              push    0               ; int
                              push    0FFFFFFF4h      ; int
                              call    CreateFontA
                              mov     dword_407BF0, eax
                              push    0               ; lpTimerFunc
                              push    1Eh             ; uElapse
                              push    0               ; nIDEvent
                              push     hWnd
                              call    SetTimer
mov byte_4074DC,1


ret
init endp