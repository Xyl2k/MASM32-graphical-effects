              sub_402CD6      proc near               ; CODE XREF: DialogFunc+8Dp

              var_4           = dword ptr -4
              arg_0           = dword ptr  8

                              enter   4, 0
                              push    ebx
                              push    esi
                              push    edi
                              mov     edi, [ebp+arg_0]
                              cmp     dword ptr [edi], 4
                              jnz     short loc_402D3D
                              mov     esi, [edi+18h]
                              push    esi             ; HDC
                              call    CreateCompatibleDC
                              mov     [ebp+var_4], eax
                              mov     eax, [edi+10h]
                              and     eax, 1
                              jz      short loc_402D09
                              push    ds:dword_40EEC8 ; HGDIOBJ
                              push    [ebp+var_4]     ; HDC
                              call    SelectObject
                              jmp     short loc_402D17
              ; ---------------------------------------------------------------------------

              loc_402D09:                             ; CODE XREF: sub_402CD6+21j
                              push    ds:dword_40EEC4 ; HGDIOBJ
                              push    [ebp+var_4]     ; HDC
                              call    SelectObject

              loc_402D17:                             ; CODE XREF: sub_402CD6+31j
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    [ebp+var_4]     ; HDC
                              push    dword ptr [edi+28h] ; int
                              push    dword ptr [edi+24h] ; int
                              push    dword ptr [edi+20h] ; int
                              push    dword ptr [edi+1Ch] ; int
                              push    esi             ; HDC
                              call    BitBlt
                              push    [ebp+var_4]     ; HDC
                              call    DeleteDC

              loc_402D3D:                             ; CODE XREF: sub_402CD6+Dj
                              pop     edi
                              pop     esi
                              pop     ebx
                              leave
                              retn    0Ch
              sub_402CD6      endp


              ; Attributes: bp-based frame

              sub_402854      proc near               ; CODE XREF: DialogFunc+133p

              var_2C          = dword ptr -2Ch
              var_28          = dword ptr -28h
              hDC             = dword ptr -18h
              _rc              = dword ptr -14h
              var_4           = dword ptr -4

                              enter   18h, 0
                              push    ebx
                              push    esi
                              push    edi
                              push    ds:dword_40EEDC ; hWnd
                              call    GetDC
                              mov     [ebp+hDC], eax
                              
                         
                              
                              add     ds:dword_40EE7C, 1
                              cmp     ds:dword_40EE7C, 14h
                              jl      loc_402900
                              and     ds:dword_40EE7C, 0

              
              
              loc_402884:                             ; CODE XREF: sub_402854+4Aj
                              mov     edi, ds:dword_40EE80
                              cmp     byte ptr [edi], 0FFh
                              jz      short loc_4028AE
                              cmp     byte ptr [edi], 0FEh
                              jnz     short loc_4028A0
                              mov     ds:dword_40EE80, offset unk_409839
                              jmp     short loc_402884
             
             
              ; ---------------------------------------------------------------------------

              loc_4028A0:                             ; CODE XREF: sub_402854+3Ej
                              mov     esi, edi
                              xor     eax, eax
                              lea     ecx, [eax-1]
                              repne scasb
                              not     ecx
                              dec     ecx
                              jmp     short loc_4028E3
              ; ---------------------------------------------------------------------------

              loc_4028AE:                             ; CODE XREF: sub_402854+39j
                              inc     edi
                              inc     edi
                              mov     ds:dword_40EE80, edi
                              movzx   eax, byte ptr [edi-1]
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    eax             ; int
                              push    ds:dword_40EEB0 ; HDC
                              push    0Fh             ; int
                              push    0Fh             ; int
                              push    0A7h            ; int
                              push    86h             ; int
                              push    ds:dword_40EE94 ; HDC
                              call    BitBlt
                              jmp     short loc_402900
              ; ---------------------------------------------------------------------------


              
              loc_4028E3:                             ; CODE XREF: sub_402854+58j
                              mov     ds:dword_40EE80, edi
                              push    ecx             ; int
                              push    esi             ; LPCSTR
                              push    0A7h            ; int
                              push    8Dh             ; int
                              push    ds:dword_40EE94 ; HDC
                              call    TextOutA

              loc_402900:                             ; CODE XREF: sub_402854+23j
                                                      ; sub_402854+8Dj
                              push    0CC0020h        ; DWORD
                              push    0Ah             ; int
                              push    0               ; int
                              push    ds:dword_40EE94 ; HDC
                              push    0BAh            ; int
                              push    11Ah            ; int
                              push    9               ; int
                              push    0               ; int
                              push    ds:dword_40EE94 ; HDC
                              call    BitBlt
                              lea     edx, [ebp+_rc]
                              mov     dword ptr [edx], 0
                              mov     dword ptr [edx+4], 0
                              mov     dword ptr [edx+8], 11Ah
                              mov     dword ptr [edx+0Ch], 0A5h
                              push    ds:hbr          ; hbr
                              push    edx             ; lprc
                              push    ds:dword_40EE98 ; hDC
                              call    FillRect
                              
                           
                              
                              mov     esi, offset unk_40EADC
                              mov     [ebp+var_4], 96h

              loc_402964:                             ; CODE XREF: sub_402854+12Aj
                                                      ; sub_402854+196j
                              movsx   eax, word ptr [esi+2]
                              cdq
                              movzx   ebx, word ptr [esi+4]
                              sub     word ptr [esi+4], 1
                              and     word ptr [esi+4], 7Fh
                              jnz     short loc_402980
                              call    sub_4027BD
                              jmp     short loc_402964
              
            
              
              ; ---------------------------------------------------------------------------

              loc_402980:                             ; CODE XREF: sub_402854+123j
                              mov     ecx, ebx
                              shl     ecx, 1
                              mov     ch, cl
                              shl     ecx, 8
                              mov     cl, ch
                              push    0FFFFFFFFh      ; COLORREF
                              sub     [esp+28h+var_28], ecx
                              and     [esp+28h+var_28], 0FFFFFFh
                              test    ebx, ebx
                              jnz     short loc_40299C
                              inc     ebx

              loc_40299C:                             ; CODE XREF: sub_402854+145j
                              idiv    ebx
                              add     eax, 50h
                              push    eax             ; int
                              movsx   eax, word ptr [esi]
                              cdq
                              movzx   ebx, word ptr [esi+4]
                              test    ebx, ebx
                              jnz     short loc_4029AF
                              inc     ebx

              loc_4029AF:                             ; CODE XREF: sub_402854+158j
                              idiv    ebx
                              add     eax, 8Ch
                              push    eax             ; int
                              push    ds:dword_40EE98 ; HDC
                              mov     ebx, [esp+34h+var_2C]
                              cmp     eax, 0
                              jle     short loc_4029E1
                              cmp     eax, 10Eh
                              jge     short loc_4029E1
                              cmp     ebx, 0
                              jle     short loc_4029E1
                              cmp     ebx, 0A0h
                              jge     short loc_4029E1
                              call    SetPixel
                              jmp     short loc_4029E4
              ; ---------------------------------------------------------------------------

              loc_4029E1:                             ; CODE XREF: sub_402854+170j
                                                      ; sub_402854+177j ...
                              add     esp, 10h

              loc_4029E4:                             ; CODE XREF: sub_402854+18Bj
                              add     esi, 6
                              dec     [ebp+var_4]
                              jg      loc_402964
                           
                              
                        

              loc_402A7A:                             ; CODE XREF: sub_402854+2D9j
                              
                              
                          
                             
                              
                              push    0EE0086h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    ds:dword_40EE94 ; HDC
                              push    9Eh             ; int
                              push    11Ah            ; int
                              push    1               ; int
                              push    0               ; int
                              push    ds:dword_40EE98 ; HDC
                              call    BitBlt
                              
                             ifdef LUNA
                              push    0EE0086h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    ds:lunaDC       ; HDC
                              push    9Eh             ; int
                              push    11Ah            ; int
                              push    1               ; int
                              push    0               ; int
                              push    ds:dword_40EE98 ; HDC
                              call    BitBlt
                             
                             endif
                             
                              
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    ds:dword_40EE98 ; HDC
                              push    0A5h            ; int
                              push    11Ah            ; int
                              push    19h             ; int
                              push    2               ; int
                              push    [ebp+hDC]       ; HDC
                              call    BitBlt
                              push    [ebp+hDC]       ; hDC
                              push    ds:dword_40EEDC ; hWnd
                              call    ReleaseDC
                              pop     edi
                              pop     esi
                              pop     ebx
                              leave
                              retn
              sub_402854      endp


              ; int __stdcall sub_402C4D(HWND hWnd,int nIDDlgItem,HDC hDC,HBRUSH hbr,int,int dy,int,int,int,int)
              sub_402C4D      proc near               ; CODE XREF: DialogFunc+169p

              var_18          = dword ptr -18h
              var_10          = dword ptr -10h
              hWnd            = dword ptr  8
              nIDDlgItem      = dword ptr  0Ch
              hDC             = dword ptr  10h
              _hbr             = dword ptr  14h
              arg_10          = dword ptr  18h
              dy              = dword ptr  1Ch
              arg_18          = dword ptr  20h
              arg_1C          = dword ptr  24h
              arg_20          = dword ptr  28h
              arg_24          = dword ptr  2Ch

                              enter   18h, 0
                              push    ebx
                              push    esi
                              push    edi
                              lea     edi, [ebp+var_10]
                              cmp     [ebp+nIDDlgItem], 0FFFFFFFFh
                              jnz     short loc_402C76
                              mov     eax, [ebp+arg_18]
                              mov     ebx, [ebp+arg_1C]
                              mov     ecx, [ebp+arg_20]
                              mov     edx, [ebp+arg_24]
                              mov     [edi+4], eax
                              mov     [edi], ebx
                              mov     [edi+8], ecx
                              mov     [edi+0Ch], edx
                              jmp     short loc_402CC3
              ; ---------------------------------------------------------------------------

              loc_402C76:                             ; CODE XREF: sub_402C4D+Ej
                              lea     esi, [ebp+var_18]
                              push    [ebp+nIDDlgItem] ; nIDDlgItem
                              push    [ebp+hWnd]      ; hDlg
                              call    GetDlgItem
                              push    eax
                              push    edi             ; lpRect
                              push    eax             ; hWnd
                              call    GetWindowRect
                              mov     eax, [edi]
                              mov     ebx, [edi+4]
                              mov     [esi], eax
                              mov     [esi+4], ebx
                              push    esi             ; lpPoint
                              push    [ebp+hWnd]      ; hWnd
                              call    ScreenToClient
                              pop     eax
                              push    edi             ; lpRect
                              push    eax             ; hWnd
                              call    GetClientRect
                              mov     eax, [esi]
                              mov     ebx, [esi+4]
                              add     [edi], eax
                              add     [edi+8], eax
                              add     [edi+4], ebx
                              add     [edi+0Ch], ebx
                              push    [ebp+dy]        ; dy
                              push    [ebp+arg_10]    ; dx
                              push    edi             ; lprc
                              call    InflateRect

              loc_402CC3:                             ; CODE XREF: sub_402C4D+27j
                              push    [ebp+_hbr]       ; hbr
                              push    edi             ; lprc
                              push    [ebp+hDC]       ; hDC
                              call    FrameRect
                              pop     edi
                              pop     esi
                              pop     ebx
                              leave
                              retn    28h
              sub_402C4D      endp



              ; int __stdcall sub_4025E0(HWND hWnd)
              sub_4025E0      proc near               ; CODE XREF: DialogFunc+205p

              var_14          = dword ptr -14h
              _rc              = dword ptr -10h
              hWnd            = dword ptr  8

                              enter   14h, 0
                              mov     [ebp+var_14], 0Ch
                              mov     edi, offset dword_40EE84
                              mov     dword ptr [edi], 2
                              mov     dword ptr [edi+4], 19h
                              mov     dword ptr [edi+8], 11Fh
                              mov     dword ptr [edi+0Ch], 0BEh
                              push    [ebp+hWnd]      ; hWnd
                              call    GetDC
                              mov     ebx, eax
                              push    ebx             ; HDC
                              call    CreateCompatibleDC
                              mov     ds:dword_40EEB0, eax
                              push    ds:dword_40EE9C ; HGDIOBJ
                              push    eax             ; HDC
                              call    SelectObject
                              push    ebx             ; HDC
                              call    CreateCompatibleDC
                              mov     ds:dword_40EEAC, eax
                              
                             ifdef LUNA
                             
                              invoke GetDC,[ebp+hWnd]
                              invoke CreateCompatibleDC,eax
                              mov lunaDC,eax
                              invoke SelectObject,lunaDC,hLuna
                              
                              
                              endif
                              
                              
                            
                              push    ebx             ; HDC
                              call    CreateCompatibleDC
                              mov     ds:dword_40EE94, eax
                              push    0CDh            ; int
                              push    11Ah            ; int
                              push    ebx             ; HDC
                              call    CreateCompatibleBitmap
                              mov     ds:dword_40EE70, eax
                              push    eax             ; HGDIOBJ
                              push    ds:dword_40EE94 ; HDC
                              call    SelectObject
                              push    ebx             ; HDC
                              call    CreateCompatibleDC
                              mov     ds:dword_40EE98, eax
                              push    0A5h            ; int
                              push    11Ah            ; int
                              push    ebx             ; HDC
                              call    CreateCompatibleBitmap
                              mov     ds:dword_40EE74, eax
                              push    eax             ; HGDIOBJ
                              push    ds:dword_40EE98 ; HDC
                              call    SelectObject
                              push    ds:dword_40EE64 ; HGDIOBJ
                              push    ds:dword_40EE94 ; HDC
                              call    SelectObject
                              push    6               ; UINT
                              push    ds:dword_40EE94 ; HDC
                              call    SetTextAlign
                              lea     edx, [ebp+_rc]
                              mov     dword ptr [edx], 0
                              mov     dword ptr [edx+4], 0
                              mov     dword ptr [edx+8], 11Ah
                              mov     dword ptr [edx+0Ch], 0CDh
                              push    ds:hbr          ; hbr
                              push    edx             ; lprc
                              push    ds:dword_40EE94 ; hDC
                              call    FillRect
                              lea     edx, [ebp+_rc]
                              mov     dword ptr [edx], 0
                              mov     dword ptr [edx+4], 0
                              mov     dword ptr [edx+8], 11Ah
                              mov     dword ptr [edx+0Ch], 0A5h
                              push    ds:hbr          ; hbr
                              push    edx             ; lprc
                              push    ds:dword_40EE98 ; hDC
                              call    FillRect
                              push    0CECECEh        ; COLORREF
                              push    ds:dword_40EE94 ; HDC
                              call    SetTextColor
                              push    0               ; COLORREF
                              push    ds:dword_40EE94 ; HDC
                              call    SetBkColor
                              push    ebx             ; hDC
                              push    [ebp+hWnd]      ; hWnd
                              call    ReleaseDC
                              and     ds:dword_40EE78, 0
                              mov     ds:dword_40EE7C, 14h
                              mov     ds:dword_40EE80, offset unk_409839
                              and     ds:dword_40EE6C, 0
                              push    0               ; lpTimerFunc
                              push    1Eh             ; uElapse
                              push    3               ; nIDEvent
                              push    [ebp+hWnd]      ; hWnd
                              call    SetTimer
                              mov     ds:dword_40EE6C, eax
                              leave
                              retn    4
              sub_4025E0      endp


              sub_402528      proc near               ; CODE XREF: DialogFunc+20Ap

              var_4           = dword ptr -4

                              enter   4, 0
                              push    ebx
                              push    esi
                              push    edi
                              mov     [ebp+var_4], 96h
                              mov     edi, offset unk_40EADC
                              call    GetTickCount
                              lea     esi, ds:15F8E773h[eax*4]
                              rol     esi, 3

              loc_40254A:                             ; CODE XREF: sub_402528+ADj
                              mov     eax, esi
                              imul    eax, 13A71h
                              xor     eax, 78983458h
                              rol     eax, 5
                              imul    eax, 83F3A0h
                              lea     esi, ds:123AA678h[eax*4]
                              xor     ds:dword_40EE60, esi
                              xor     edx, edx
                              mov     ebx, 0FFFh
                              div     ebx
                              mov     eax, edx
                              test    eax, 1
                              jnz     short loc_402586
                              neg     ax
                              jnz     short loc_402586
                              dec     ax

              loc_402586:                             ; CODE XREF: sub_402528+55j
                                                      ; sub_402528+5Aj
                              stosw
                              mov     eax, esi
                              imul    eax, 13333h
                              xor     eax, 11884422h
                              rol     eax, 5
                              imul    eax, 72231h
                              lea     esi, ds:42345678h[eax*4]
                              xor     ds:dword_40EE60, esi
                              xor     edx, edx
                              mov     ebx, 0FFFh
                              div     ebx
                              mov     eax, edx
                              test    eax, 1
                              jnz     short loc_4025C4
                              neg     ax
                              jnz     short loc_4025C4
                              dec     ax

              loc_4025C4:                             ; CODE XREF: sub_402528+93j
                                                      ; sub_402528+98j
                              stosw
                              mov     ax, si
                              rol     ax, 5
                              and     eax, 7Fh
                              stosw
                              dec     [ebp+var_4]
                              jg      loc_40254A
                              pop     edi
                              pop     esi
                              pop     ebx
                              leave
                              retn
              sub_402528      endp


              
              
              sub_4027BD      proc near               ; CODE XREF: sub_402854+125p
                              pusha
                              mov     edi, esi
                              mov     esi, ds:dword_40EE60
                              mov     eax, esi
                              imul    eax, 98AF11h
                              xor     eax, 11884422h
                              rol     eax, 5
                              imul    eax, 222831h
                              lea     esi, ds:8823771h[eax*4]
                              rol     esi, 3
                              add     ds:dword_40EE60, esi
                              xor     edx, edx
                              mov     ebx, 0FFFh
                              div     ebx
                              mov     eax, edx
                              test    eax, 1
                              jnz     short loc_402805
                              neg     ax
                              jnz     short loc_402805
                              dec     ax

              loc_402805:                             ; CODE XREF: sub_4027BD+3Fj
                                                      ; sub_4027BD+44j
                              stosw
                              mov     eax, esi
                              imul    eax, 13273h
                              xor     eax, 11884422h
                              rol     eax, 5
                              imul    eax, 728BC1h
                              lea     esi, ds:12345678h[eax*4]
                              rol     esi, 1
                              xor     ds:dword_40EE60, esi
                              xor     edx, edx
                              mov     ebx, 0FFFh
                              div     ebx
                              mov     eax, edx
                              test    eax, 1
                              jnz     short loc_402845
                              neg     ax
                              jnz     short loc_402845
                              dec     ax

              loc_402845:                             ; CODE XREF: sub_4027BD+7Fj
                                                      ; sub_4027BD+84j
                              stosw
                              mov     ax, si
                              rol     ax, 1
                              and     eax, 7Fh
                              stosw
                              popa
                              retn
              sub_4027BD      endp


              sub_402BC0      proc near               ; CODE XREF: DialogFunc+229p

              hWnd            = dword ptr  8

                              enter   0, 0
                              push    offset stru_40AA0C ; lpPoint
                              call    GetCursorPos
                              push    offset stru_40981C ; lpRect
                              push    [ebp+hWnd]      ; hWnd
                              call    GetWindowRect
                              mov     eax, ds:stru_40AA0C.x
                              mov     ebx, ds:stru_40AA0C.y
                              push    ebx
                              push    eax
                              sub     eax, ds:Point.x
                              sub     ebx, ds:Point.y
                              add     eax, ds:stru_40981C.left
                              add     ebx, ds:stru_40981C.top
                              pop     ecx
                              pop     edx
                              mov     ds:Point.x, ecx
                              mov     ds:Point.y, edx
                              push    1               ; uFlags
                              push    0               ; cy
                              push    0               ; cx
                              push    ebx             ; Y
                              push    eax             ; X
                              push    0               ; hWndInsertAfter
                              push    [ebp+hWnd]      ; hWnd
                              call    SetWindowPos
                              leave
                              retn    4
              sub_402BC0      endp


              ; int __stdcall sub_402B93(HDC,COLORREF,int)
              sub_402B93      proc near               ; CODE XREF: DialogFunc+26Dp

              arg_0           = dword ptr  8
              arg_4           = dword ptr  0Ch
              arg_8           = dword ptr  10h

                              enter   0, 0
                              push    2               ; int
                              push    [ebp+arg_0]     ; HDC
                              call    SetBkMode
                              push    0CECECEh        ; COLORREF
                              push    [ebp+arg_0]     ; HDC
                              call    SetBkColor
                              push    [ebp+arg_4]     ; COLORREF
                              push    [ebp+arg_0]     ; HDC
                              call    SetTextColor
                              mov     eax, [ebp+arg_8]
                              leave
                              retn    0Ch
              sub_402B93      endp

