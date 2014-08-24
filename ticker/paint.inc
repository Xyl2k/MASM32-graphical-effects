                              ;wm_paint

              sub_403051      proc near               ; CODE XREF: sub_402DBF+12Cp

              Paint           =  -40h

              ;LOCAL Paint:PAINTSTRUCT                
                              
                              enter   40h, 0
                              mov     ds:dword_40EF00, ebx
                              lea     eax, [ebp+Paint]
                              push    eax             ; lpPaint
                              push    ds:dword_40EF00 ; hWnd
                              call    BeginPaint
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    ds:dword_40EEF4 ; HDC
                              push    42h             ; int
                              push    0D2h            ; int
                              push    0               ; int
                              push    0               ; int
                              push    ds:dword_40EEF0 ; HDC
                              call    BitBlt
                              lea     eax, [ebp+Paint]
                              push    eax             ; lpPaint
                              push    ds:dword_40EF00 ; hWnd
                              call    EndPaint
                              xor     eax, eax
                              leave
                              retn
              sub_403051      endp

                              
   