              ; DWORD __stdcall sub_401864(LPVOID)
              sub_401864      proc near               ; DATA XREF: sub_401760+77o

              var_2C          = dword ptr -2Ch
              var_28          = dword ptr -28h
              var_24          = dword ptr -24h
              var_20          = dword ptr -20h
              var_1C          = dword ptr -1Ch
              var_14          = dword ptr -14h
              var_10          = dword ptr -10h
              var_C           = dword ptr -0Ch
              hDC             = dword ptr -8
              var_4           = dword ptr -4
              hWnd            = dword ptr  8

                              push    ebp
                              mov     ebp, esp
                              add     esp, 0FFFFFFD4h
                              push    offset aTerminal ; "Terminal"
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    0FFh            ; DWORD
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    0               ; DWORD
                              push    190h            ; int
                              push    0               ; int
                              push    0               ; int
                              push    6               ; int
                              push    8               ; int
                              call    CreateFontA
                              mov     [ebp+var_10], eax
                              push    [ebp+hWnd]      ; hWnd
                              call    GetDC
                              mov     [ebp+var_4], eax
                              xor     esi, esi
                              dec     esi
                              mov     edi, offset aTeam ; "\r\n\r\n\r\n\r\n\r\n\r\n\r\n -- -- ---- --team  -----"...
                              mov     ecx, 5CEh
                              mov     al, 0Dh

              loc_4018B1:                             ; CODE XREF: sub_401864+50j
                              inc     esi
                              repne scasb
                              jz      short loc_4018B1
                              lea     esi, ds:0B4h[esi*8]
                              mov     [ebp+var_2C], esi
                              push    0               ; HDC
                              call    CreateCompatibleDC
                              mov     [ebp+hDC], eax
                              push    [ebp+var_10]    ; HGDIOBJ
                              push    [ebp+hDC]       ; HDC
                              call    SelectObject
                              xor     edx, edx
                              lea     edi, stru_40711B
                              mov     dword ptr [edi], 28h
                              mov     dword ptr [edi+4], 14Ah
                              mov     eax, [ebp+var_2C]
                              not     eax
                              mov     [edi+8], eax
                              mov     word ptr [edi+0Ch], 1
                              mov     word ptr [edi+0Eh], 20h
                              push    edx             ; DWORD
                              push    edx             ; HANDLE
                              lea     eax, [ebp+var_C]
                              push    eax             ; void **
                              push    edx             ; UINT
                              push    edi             ; BITMAPINFO *
                              push    [ebp+hDC]       ; HDC
                              call    CreateDIBSection
                              mov     [ebp+var_28], eax
                              push    eax             ; HGDIOBJ
                              push    [ebp+hDC]       ; HDC
                              call    SelectObject
                              mov     eax, [ebp+var_C]
                              mov     ecx, 14Ah
                              imul    ecx, [ebp+var_2C]

              loc_401926:                             ; CODE XREF: sub_401864+CBj
                              mov     dword ptr [eax], 448C60h;<---bg color
                              add     eax, 4
                              loop    loc_401926
                              push    0               ; HDC
                              call    CreateCompatibleDC
                              mov     [ebp+var_20], eax
                              push    0               ; DWORD
                              push    0               ; HANDLE
                              lea     eax, [ebp+var_1C]
                              push    eax             ; void **
                              push    0               ; UINT
                              push    edi             ; BITMAPINFO *
                              push    [ebp+var_20]    ; HDC
                              call    CreateDIBSection
                              mov     [ebp+var_24], eax
                              push    eax             ; HGDIOBJ
                              push    [ebp+var_20]    ; HDC
                              call    SelectObject
                              push    0               ; COLORREF
                              push    [ebp+hDC]       ; HDC
                              call    SetTextColor
                              push    1               ; int
                              push    [ebp+hDC]       ; HDC
                              call    SetBkMode
                              mov     stru_407147.top, 2
                              mov     stru_407147.left, 3
                              push    [ebp+var_2C]
                              pop     stru_407147.bottom
                              mov     stru_407147.right, 14Ah
                              push    1               ; uFormat
                              push    offset stru_407147 ; lpRect
                              push    5CEh            ; nCount
                              push    offset aTeam    ; "\r\n\r\n\r\n\r\n\r\n\r\n\r\n -- -- ---- --team  -----"...
                              push    [ebp+hDC]       ; hDC
                              call    DrawTextA
                              push    0FFFFFFh        ; COLORREF
                              push    [ebp+hDC]       ; HDC
                              call    SetTextColor
                              mov     stru_407147.top, 0
                              mov     stru_407147.left, 0
                              push    1               ; uFormat
                              push    offset stru_407147 ; lpRect
                              push    5CEh            ; nCount
                              push    offset aTeam    ; "\r\n\r\n\r\n\r\n\r\n\r\n\r\n -- -- ---- --team  -----"...
                              push    [ebp+hDC]       ; hDC
                              call    DrawTextA

              loc_4019E8:                             ; CODE XREF: sub_401864+2BDj
                              mov     eax, [ebp+var_1C]
                              mov     ecx, 14Ah
                              imul    ecx, [ebp+var_2C]

              loc_4019F4:                             ; CODE XREF: sub_401864+199j
                              mov     dword ptr [eax], 448C60h
                              add     eax, 4
                              loop    loc_4019F4
                              mov     esi, 0

              loc_401A04:                             ; CODE XREF: sub_401864+205j
                              call    timeGetTime
                              push    eax
                              push    esi
                              push    [ebp+var_2C]
                              push    14Ah
                              push    [ebp+var_C]
                              push    0
                              push    0
                              push    14Ah
                              push    [ebp+var_1C]
                              call    sub_402266
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    [ebp+var_20]    ; HDC
                              push    96h             ; int
                              push    14Ah            ; int
                              push    0               ; int
                              push    0               ; int
                              push    [ebp+var_4]     ; HDC
                              call    BitBlt
                              cmp     ds:dword_415944, 1
                              jz      loc_401B26

              loc_401A56:                             ; CODE XREF: sub_401864+1FEj
                              
                              invoke Sleep,1;Free CPU--------------------------------------
                              call    timeGetTime
                              pop     ebx
                              push    ebx
                              sub     eax, ebx
                              cmp     eax, 3Eh
                              jb      short loc_401A56
                              pop     ebx
                              inc     esi
                              cmp     esi, 46h
                              jnz     short loc_401A04
                              push    1F4h            ; dwMilliseconds
                              call    Sleep
                              mov     eax, [ebp+var_1C]
                              mov     ecx, 14Ah
                              imul    ecx, [ebp+var_2C]

              loc_401A81:                             ; CODE XREF: sub_401864+226j
                              mov     dword ptr [eax], 448C60h
                              add     eax, 4
                              loop    loc_401A81
                              mov     [ebp+var_14], 0
                              push    28h
                              push    448C60h;<------- bg color
                              push    93h
                              push    14Ah
                              push    [ebp+var_1C]
                              push    [ebp+var_14]
                              push    [ebp+var_C]
                              call    sub_4022AD

              loc_401AB2:                             ; CODE XREF: sub_401864+2BBj
                              call    timeGetTime
                              push    eax
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    [ebp+var_20]    ; HDC
                              push    96h             ; int
                              push    14Ah            ; int
                              push    0               ; int
                              push    0               ; int
                              push    [ebp+var_4]     ; HDC
                              call    BitBlt
                              push    2Ah
                              push    448C60h;<--- bg color
                              push    93h
                              push    14Ah
                              push    [ebp+var_1C]
                              push    [ebp+var_14]
                              push    [ebp+var_C]
                              call    sub_4022AD

              loc_401AF9:                             ; CODE XREF: sub_401864+2A1j
                              
                              invoke Sleep,1;Free CPU--------------------------------
                              call    timeGetTime
                              pop     ebx
                              push    ebx
                              sub     eax, ebx
                              cmp     eax, 3Eh
                              jb      short loc_401AF9
                              pop     ebx
                              cmp     ds:dword_415944, 1
                              jz      short loc_401B26
                              inc     [ebp+var_14]
                              mov     eax, [ebp+var_2C]
                              sub     eax, 0B4h
                              cmp     [ebp+var_14], eax
                              jnz     short loc_401AB2
                              jmp     loc_4019E8
              ; ---------------------------------------------------------------------------

              loc_401B26:                             ; CODE XREF: sub_401864+1ECj
                                                      ; sub_401864+2ABj
                              push    [ebp+hDC]       ; HDC
                              call    DeleteDC
                              push    [ebp+var_20]    ; HDC
                              call    DeleteDC
                              push    [ebp+var_28]    ; HGDIOBJ
                              call    DeleteObject
                              push    [ebp+var_24]    ; HGDIOBJ
                              call    DeleteObject
                              push    [ebp+var_10]    ; HGDIOBJ
                              call    DeleteObject
                              mov     ds:dword_415944, 0
                              leave
                              retn    4
              sub_401864      endp


              sub_402266      proc near               ; CODE XREF: sub_401864+1BEp

              arg_0           = dword ptr  8
              arg_4           = dword ptr  0Ch
              arg_8           = dword ptr  10h
              arg_C           = dword ptr  14h
              arg_10          = dword ptr  18h
              arg_14          = dword ptr  1Ch
              arg_18          = dword ptr  20h
              arg_1C          = dword ptr  24h

                              push    ebp
                              mov     ebp, esp
                              pusha
                              mov     esi, [ebp+arg_10]
                              mov     edx, [ebp+arg_4]
                              mov     edi, [ebp+arg_C]
                              imul    edi, edx
                              add     edi, [ebp+arg_8]
                              shl     edi, 2
                              add     edi, [ebp+arg_0]
                              sub     edx, [ebp+arg_14]
                              shl     edx, 2
                              mov     ecx, [ebp+arg_18]

              loc_402288:                             ; CODE XREF: sub_402266+40j
                              push    ecx
                              mov     ecx, [ebp+arg_14]
                              shl     ecx, 2

              loc_40228F:                             ; CODE XREF: sub_402266+3Bj
                              xor     eax, eax
                              lodsb
                              movzx   ebx, byte ptr [edi]
                              sub     eax, ebx
                              imul    eax, [ebp+arg_1C]
                              shr     eax, 8
                              add     eax, ebx
                              stosb
                              loop    loc_40228F
                              pop     ecx
                              add     edi, edx
                              loop    loc_402288
                              popa
                              leave
                              retn    20h
              sub_402266      endp


              sub_4022AD      proc near               ; CODE XREF: sub_401864+249p
                                                      ; sub_401864+290p

              var_8           = dword ptr -8
              var_4           = dword ptr -4
              arg_0           = dword ptr  8
              arg_4           = dword ptr  0Ch
              arg_8           = dword ptr  10h
              arg_C           = dword ptr  14h
              arg_10          = dword ptr  18h
              arg_14          = dword ptr  1Ch
              arg_18          = dword ptr  20h

                              push    ebp
                              mov     ebp, esp
                              add     esp, 0FFFFFFF8h
                              pusha
                              mov     esi, [ebp+arg_4]
                              imul    esi, [ebp+arg_C]
                              shl     esi, 2
                              add     esi, [ebp+arg_0]
                              mov     edi, [ebp+arg_8]
                              xor     edx, edx
                              mov     eax, 0FFh
                              idiv    [ebp+arg_18]
                              mov     [ebp+var_4], eax
                              mov     edx, [ebp+arg_14]
                              mov     ecx, [ebp+arg_10]

              loc_4022D7:                             ; CODE XREF: sub_4022AD+76j
                              push    ecx
                              mov     eax, [ebp+arg_10]
                              sub     eax, ecx
                              cmp     eax, [ebp+arg_18]
                              ja      short loc_4022EB
                              imul    eax, [ebp+var_4]
                              mov     [ebp+var_8], eax
                              jmp     short loc_402305
              ; ---------------------------------------------------------------------------

              loc_4022EB:                             ; CODE XREF: sub_4022AD+33j
                              sub     eax, [ebp+arg_10]
                              not     eax
                              cmp     eax, [ebp+arg_18]
                              ja      short loc_4022FE
                              imul    eax, [ebp+var_4]
                              mov     [ebp+var_8], eax
                              jmp     short loc_402305
              ; ---------------------------------------------------------------------------

              loc_4022FE:                             ; CODE XREF: sub_4022AD+46j
                              mov     [ebp+var_8], 0FFh

              loc_402305:                             ; CODE XREF: sub_4022AD+3Cj
                                                      ; sub_4022AD+4Fj
                              mov     ecx, [ebp+arg_C]
                              shl     ecx, 2

              loc_40230B:                             ; CODE XREF: sub_4022AD+73j
                              xor     eax, eax
                              lodsb
                              movzx   ebx, dl
                              sub     eax, ebx
                              imul    eax, [ebp+var_8]
                              shr     eax, 8
                              add     eax, ebx
                              stosb
                              ror     edx, 8
                              loop    loc_40230B
                              pop     ecx
                              loop    loc_4022D7
                              popa
                              leave
                              retn    1Ch
              sub_4022AD      endp
