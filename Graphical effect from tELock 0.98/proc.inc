              sub_402F0C      proc near               ; CODE XREF: sub_402DBF+14p

              _hWnd            = dword ptr -4

                              enter   4, 0
                              mov     [ebp+_hWnd], ebx
                              push    ebx             ; hWnd
                              call    GetDC
                              mov     ds:dword_40EEF0, eax
                              cmp     ds:dword_409A5E, 0
                              jnz     short loc_402F34
                              dec     ds:dword_409A5A
                              jle     short loc_402F90
                              jmp     loc_40303F
              ; ---------------------------------------------------------------------------

              loc_402F34:                             ; CODE XREF: sub_402F0C+19j
                              dec     ds:dword_409A6A
                              jg      short loc_402F4B
                              mov     ds:dword_409A6A, 3
                              call    sub_4030A2

              loc_402F4B:                             ; CODE XREF: sub_402F0C+2Ej
                              dec     ds:dword_409A5E
                              jg      loc_40301A
                              call    sub_4030CD
                              mov     ds:dword_409A52, 5
                              cmp     ds:dword_409A66, 2
                              jz      short loc_402F86
                              add     ds:dword_409A56, 14h
                              call    sub_4030A2
                              inc     ds:dword_409A66
                              jmp     loc_40301A
              ; ---------------------------------------------------------------------------

              loc_402F86:                             ; CODE XREF: sub_402F0C+61j
                              call    sub_40310B
                              jmp     loc_40301A
              ; ---------------------------------------------------------------------------

              loc_402F90:                             ; CODE XREF: sub_402F0C+21j
                              mov     ds:dword_409A5A, 1
                              mov     esi, offset unk_409A7C
                              add     esi, ds:dword_409A62
                              mov     al, [esi]
                              and     eax, 0FFh
                              jnz     short loc_402FB5
                              call    sub_402D44
                              jmp     short loc_40301A
              ; ---------------------------------------------------------------------------

              loc_402FB5:                             ; CODE XREF: sub_402F0C+A0j
                              cmp     al, 0Dh
                              jnz     short loc_402FCA
                              add     ds:dword_409A62, 2
                              mov     al, [esi+1]
                              mov     ds:dword_409A5E, eax
                              jmp     short loc_40301A
              ; ---------------------------------------------------------------------------

              loc_402FCA:                             ; CODE XREF: sub_402F0C+ABj
                              inc     ds:dword_409A62
                              call    sub_4030CD
                              push    offset stru_409B04 ; LPSIZE
                              push    1               ; int
                              push    esi             ; LPCSTR
                              push    ds:dword_40EEF4 ; HDC
                              call    GetTextExtentPoint32A
                              mov     eax, ds:dword_409A52
                              mov     ebx, ds:dword_409A56
                              sub     ebx, ds:stru_409B04.cy
                              mov     ecx, ds:stru_409B04._cx
                              add     ds:dword_409A52, ecx
                              push    1               ; int
                              push    esi             ; LPCSTR
                              push    ebx             ; int
                              push    eax             ; int
                              push    ds:dword_40EEF4 ; HDC
                              call    TextOutA
                              call    sub_4030A2

              loc_40301A:                             ; CODE XREF: sub_402F0C+45j
                                                      ; sub_402F0C+75j ...
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

              loc_40303F:                             ; CODE XREF: sub_402F0C+23j
                              push    ds:dword_40EEF0 ; hDC
                              push    [ebp+_hWnd]      ; hWnd
                              call    ReleaseDC
                              xor     eax, eax
                              leave
                              retn
              sub_402F0C      endp


              sub_4030A2      proc near               ; CODE XREF: sub_402F0C+3Ap
                                                      ; sub_402F0C+6Ap ...
                              push    660046h         ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    ds:dword_40EF08 ; HDC
                              push    2               ; int
                              push    8               ; int
                              push    ds:dword_409A56 ; int
                              push    ds:dword_409A52 ; int
                              push    ds:dword_40EEF4 ; HDC
                              call    BitBlt
                              retn
              sub_4030A2      endp


              sub_4030CD      proc near               ; CODE XREF: sub_402F0C+4Bp
                                                      ; sub_402F0C+C4p
                              mov     eax, ds:dword_409A52
                              mov     ebx, ds:dword_409A56
                              mov     ds:rc.left, eax
                              mov     ds:rc.top, ebx
                              add     eax, 8
                              add     ebx, 2
                              mov     ds:rc.right, eax
                              mov     ds:rc.bottom, ebx
                              push    ds:dword_40EEEC ; hbr
                              push    offset rc       ; lprc
                              push    ds:dword_40EEF4 ; hDC
                              call    FillRect
                              retn
              sub_4030CD      endp

              sub_40310B      proc near               ; CODE XREF: sub_402F0C:loc_402F86p
                              push    0CC0020h        ; DWORD
                              push    14h             ; int
                              push    0               ; int
                              push    ds:dword_40EEF4 ; HDC
                              push    28h             ; int
                              push    0D2h            ; int
                              push    0               ; int
                              push    0               ; int
                              push    ds:dword_40EEF4 ; HDC
                              call    BitBlt
                              mov     ds:rc.left, 0
                              mov     ds:rc.top, 28h
                              mov     ds:rc.right, 0D2h
                              mov     ds:rc.bottom, 3Ch
                              push    ds:dword_40EEEC ; hbr
                              push    offset rc       ; lprc
                              push    ds:dword_40EEF4 ; hDC
                              call    FillRect
                              retn
              sub_40310B      endp

              sub_402D44      proc near               ; CODE XREF: sub_401CA7:loc_40228Bp
                                                      ; sub_402DBF+29p ...
                              mov     ds:dword_409A52, 5
                              mov     ds:dword_409A56, 14h
                              mov     ds:dword_409A62, 0
                              mov     ds:dword_409A66, 0
                              mov     ds:dword_409A5E, 0
                              mov     ds:dword_409A6A, 3
                              mov     ds:rc.left, 0
                              mov     ds:rc.top, 0
                              mov     ds:rc.right, 0D2h
                              mov     ds:rc.bottom, 42h
                              push    ds:dword_40EEEC ; hbr
                              push    offset rc       ; lprc
                              push    ds:dword_40EEF4 ; hDC
                              call    FillRect
                              retn
              sub_402D44      endp
