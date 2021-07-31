              TimerFunc       proc near               ; DATA XREF: sub_4033A6+8o
                              cmp     byte_40605C, 0
                              jnz     short loc_403CC9
                              mov     byte_40605C, 1
                              push    dword_40FFC5    ; hDlg
                              call    sub_401000

              loc_403CC9:                             ; CODE XREF: TimerFunc+7j
                              call    sub_40107D
                              retn
              TimerFunc       endp

              ; int __stdcall sub_401000(HWND hDlg)
              sub_401000      proc near               ; CODE XREF: TimerFunc+16p

              hDlg            = dword ptr  8

                              enter   0, 0
                              push    offset off_4066A5 ; lpBitmapName
                              push    hInstance       ; hInstance
                              call    LoadBitmapA
                              mov     dword_406048, eax
                              push    7A69h           ; nIDDlgItem
                              push    [ebp+hDlg]      ; hDlg
                              call    GetDlgItem
                              mov     ds_hWnd, eax
                              push    offset dword_406000 ; LPVOID
                              push    dword_40601C    ; int
                              push    dword_406048    ; HGDIOBJ
                              call    GetObjectA
                              mov     eax, dword_406004
                              mov     ecx, 4
                              xor     edx, edx
                              div     ecx
                              mov     dword_406020, eax
                              mov     dword_406028, edx
                              mov     eax, dword_406008
                              mov     ecx, 1
                              xor     edx, edx
                              div     ecx
                              mov     dword_406024, eax
                              mov     eax, dword_406008
                              sub     eax, edx
                              mov     dword_40602C, eax
                              leave
                              retn    4
              sub_401000      endp

              sub_40107D      proc near               ; CODE XREF: TimerFunc:loc_403CC9p
                              cmp     byte_40FFC4, 1
                              jnz     short loc_401091
                              mov     dword_406050, 0
                              retn
              ; ---------------------------------------------------------------------------

              loc_401091:                             ; CODE XREF: sub_40107D+7j
                              push    ds_hWnd            ; hWnd
                              call    GetDC
                              mov     hDC, eax
                              cmp     dword_406050, 0
                              jnz     short loc_4010F9
                              mov     dword_406050, 32h
                              mov     ecx, 32h
                              shr     ecx, 1
                              mov     edi, offset byte_406065

              loc_4010C0:                             ; CODE XREF: sub_40107D+60j
                              call    sub_40117F
                              mov     eax, dword_406030
                              stosd
                              mov     eax, dword_406034
                              stosd
                              mov     eax, dword_406038
                              stosd
                              mov     eax, dword_40603C
                              stosd
                              loop    loc_4010C0
                              mov     esi, edi
                              sub     esi, 10h
                              mov     ecx, dword_406050
                              shr     ecx, 1

              loc_4010EC:                             ; CODE XREF: sub_40107D+7Aj
                              lodsd
                              stosd
                              lodsd
                              stosd
                              lodsd
                              stosd
                              lodsd
                              stosd
                              sub     esi, 20h
                              loop    loc_4010EC

              loc_4010F9:                             ; CODE XREF: sub_40107D+2Bj
                              dec     dword_406050
                              mov     ecx, dword_406050
                              shl     ecx, 4
                              add     ecx, offset byte_406065
                              mov     eax, [ecx]
                              mov     dword_406030, eax
                              mov     eax, [ecx+4]
                              mov     dword_406034, eax
                              mov     eax, [ecx+8]
                              mov     dword_406038, eax
                              mov     eax, [ecx+0Ch]
                              mov     dword_40603C, eax
                              call    sub_401234
                              call    sub_40129F
                              call    sub_40130A
                              call    sub_40133D
                              push    dword_406054    ; HDC
                              call    DeleteDC
                              push    dword_406058    ; HDC
                              call    DeleteDC
                              push    hDC             ; hDC
                              push    ds_hWnd            ; hWnd
                              call    ReleaseDC
                              push    dword_40605D    ; HGDIOBJ
                              call    DeleteObject
                              push    dword_406061    ; HGDIOBJ
                              call    DeleteObject
                              retn
              sub_40107D      endp



              sub_40117F      proc near               ; CODE XREF: sub_40107D:loc_4010C0p
                              push    eax
                              push    ebx
                              push    ecx
                              push    edx
                              mov     eax, 4
                              push    eax
                              call    sub_401214
                              mov     ecx, dword_406020
                              mul     cx
                              add     eax, dword_406028
                              mov     dword_406030, eax
                              mov     eax, 1
                              push    eax
                              call    sub_401214
                              mov     ecx, dword_406024
                              mul     cx
                              mov     dword_406034, eax

              loc_4011BB:                             ; CODE XREF: sub_40117F+8Ej
                              mov     eax, 4
                              push    eax
                              call    sub_401214
                              mov     ecx, dword_406020
                              mul     cx
                              add     eax, dword_406028
                              mov     dword_406038, eax
                              mov     eax, 1
                              push    eax
                              call    sub_401214
                              mov     ecx, dword_406024
                              mul     cx
                              mov     dword_40603C, eax
                              mov     eax, dword_406030
                              cmp     eax, dword_406038
                              jnz     short loc_40120F
                              mov     eax, dword_406034
                              cmp     eax, dword_40603C
                              jnz     short loc_40120F
                              jmp     short loc_4011BB
              ; ---------------------------------------------------------------------------

              loc_40120F:                             ; CODE XREF: sub_40117F+7Fj
                                                      ; sub_40117F+8Cj
                              pop     edx
                              pop     ecx
                              pop     ebx
                              pop     eax
                              retn
              sub_40117F      endp

              sub_401214      proc near               ; CODE XREF: sub_40117F+Ap
                                                      ; sub_40117F+29p ...

              arg_0           = dword ptr  8

                              enter   0, 0
                              push    ecx
                              push    ebx
                              push    edx
                              call    GetTickCount
                              mov     cl, al
                              rol     eax, cl
                              xor     edx, edx
                              mov     ecx, [ebp+arg_0]
                              div     ecx
                              mov     eax, edx
                              pop     edx
                              pop     ebx
                              pop     ecx
                              leave
                              retn    4
              sub_401214      endp


              sub_401234      proc near               ; CODE XREF: sub_40107D+B0p
                              push    hDC             ; HDC
                              call    CreateCompatibleDC
                              mov     dword_406054, eax
                              push    dword_406024    ; int
                              push    dword_406020    ; int
                              push    hDC             ; HDC
                              call    CreateCompatibleBitmap
                              mov     dword_40605D, eax
                              push    eax             ; HGDIOBJ
                              push    dword_406054    ; HDC
                              call    SelectObject
                              push    0CC0020h        ; DWORD
                              push    dword_406034    ; int
                              push    dword_406030    ; int
                              push    hDC             ; HDC
                              push    dword_406024    ; int
                              push    dword_406020    ; int
                              push    0               ; int
                              push    0               ; int
                              push    dword_406054    ; HDC
                              call    BitBlt
                              retn
              sub_401234      endp



              sub_40129F      proc near               ; CODE XREF: sub_40107D+B5p
                              push    hDC             ; HDC
                              call    CreateCompatibleDC
                              mov     dword_406058, eax
                              push    dword_406024    ; int
                              push    dword_406020    ; int
                              push    hDC             ; HDC
                              call    CreateCompatibleBitmap
                              mov     dword_406061, eax
                              push    eax             ; HGDIOBJ
                              push    dword_406058    ; HDC
                              call    SelectObject
                              push    0CC0020h        ; DWORD
                              push    dword_40603C    ; int
                              push    dword_406038    ; int
                              push    hDC             ; HDC
                              push    dword_406024    ; int
                              push    dword_406020    ; int
                              push    0               ; int
                              push    0               ; int
                              push    dword_406058    ; HDC
                              call    BitBlt
                              retn
              sub_40129F      endp



              sub_40130A      proc near               ; CODE XREF: sub_40107D+BAp
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    dword_406054    ; HDC
                              push    dword_406024    ; int
                              push    dword_406020    ; int
                              push    dword_40603C    ; int
                              push    dword_406038    ; int
                              push    hDC             ; HDC
                              call    BitBlt
                              retn
              sub_40130A      endp



              sub_40133D      proc near               ; CODE XREF: sub_40107D+BFp
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    dword_406058    ; HDC
                              push    dword_406024    ; int
                              push    dword_406020    ; int
                              push    dword_406034    ; int
                              push    dword_406030    ; int
                              push    hDC             ; HDC
                              call    BitBlt
                              retn
              sub_40133D      endp

