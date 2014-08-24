         ;timer  
           sub_401DBE      proc near               ; CODE XREF: DialogFunc+13Ep

           var_2C          = dword ptr -2Ch
           var_28          = dword ptr -28h
           hDC             = dword ptr -18h
           lRect            = dword ptr -14h
           var_4           = dword ptr -4

                           push    ebp
                           mov     ebp, esp
                           add     esp, 0FFFFFFE8h
                           push    ebx
                           push    esi
                           push    edi
                           push    ds_hWnd         ; hWnd
                           call    GetDC
                           mov     [ebp+hDC], eax
                           lea     edx, [ebp+lRect]
                           mov     dword ptr [edx], 0
                           mov     dword ptr [edx+4], 0
                           mov     dword ptr [edx+8], 28Dh
                           mov     dword ptr [edx+0Ch], 14Ah
                           push    ds_hbr          ; hbr
                           push    edx             ; lprc
                           push    ds:dword_409FA8 ; hDC
                           call    FillRect
                           lea     esi, unk_4099D8
                           mov     [ebp+var_4], 0F0h

           loc_401E12:                             ; CODE XREF: sub_401DBE+6Ej
                                                   ; sub_401DBE+DCj
                           movsx   eax, word ptr [esi+2]
                           cdq
                           movzx   ebx, word ptr [esi+4]
                           sub     word ptr [esi+4], 1
                           and     word ptr [esi+4], 7Fh
                           jnz     short loc_401E2E
                           call    sub_401C72
                           jmp     short loc_401E12
           ; ---------------------------------------------------------------------------

           loc_401E2E:                             ; CODE XREF: sub_401DBE+67j
                           mov     ecx, ebx
                           shl     ecx, 1
                           mov     ch, cl
                           shl     ecx, 8
                           mov     cl, ch
                           push    0FFFFFFFFh      ; COLORREF
                           sub     [esp+28h+var_28], ecx
                           and     [esp+28h+var_28], 0FFFFFFh
                           test    ebx, ebx
                           jnz     short loc_401E4A
                           inc     ebx

           loc_401E4A:                             ; CODE XREF: sub_401DBE+89j
                           idiv    ebx
                           add     eax, 0A5h
                           push    eax             ; int
                           movsx   eax, word ptr [esi]
                           cdq
                           movzx   ebx, word ptr [esi+4]
                           test    ebx, ebx
                           jnz     short loc_401E5F
                           inc     ebx

           loc_401E5F:                             ; CODE XREF: sub_401DBE+9Ej
                           idiv    ebx
                           add     eax, 146h
                           push    eax             ; int
                           push    ds:dword_409FA8 ; HDC
                           mov     ebx, [esp+34h+var_2C]
                           cmp     eax, 0
                           jle     short loc_401E91
                           cmp     eax, 288h
                           jge     short loc_401E91
                           cmp     ebx, 0
                           jle     short loc_401E91
                           cmp     ebx, 145h
                           jge     short loc_401E91
                           call    SetPixel
                           jmp     short loc_401E94
           ; ---------------------------------------------------------------------------

           loc_401E91:                             ; CODE XREF: sub_401DBE+B6j
                                                   ; sub_401DBE+BDj ...
                           add     esp, 10h

           loc_401E94:                             ; CODE XREF: sub_401DBE+D1j
                           add     esi, 6
                           dec     [ebp+var_4]
                           jg      loc_401E12
                           call    sub_401985
                           cmp     ds:dword_407042, 2
                           jnz     loc_401F58
                           lea     esi, off_40704A
                           mov     eax, ds:dword_407006
                           mov     esi, [esi+eax*4]
                           lea     edi, unk_409524
                           lodsd
                           cmp     ds:dword_407046, 3
                           jz      short loc_401EDA
                           mov     ecx, eax
                           stosd
                           xor     eax, eax

           loc_401ED5:                             ; CODE XREF: sub_401DBE+11Aj
                           stosd
                           stosw
                           loop    loc_401ED5

           loc_401EDA:                             ; CODE XREF: sub_401DBE+110j
                           mov     edi, esi
                           lea     esi, unk_409524
                           lodsd
                           mov     ecx, eax
                           mov     ds:dword_407042, 0

           loc_401EEF:                             ; CODE XREF: sub_401DBE+156j
                           mov     edx, 3

           loc_401EF4:                             ; CODE XREF: sub_401DBE+153j
                           lodsw
                           cmp     ax, [edi]
                           jz      short loc_401F0D
                           mov     ds:dword_407042, 2
                           sub     ax, [edi]
                           call    sub_401D78

           loc_401F0D:                             ; CODE XREF: sub_401DBE+13Bj
                           add     edi, 2
                           dec     edx
                           jg      short loc_401EF4
                           dec     ecx
                           jg      short loc_401EEF
                           cmp     ds:dword_407042, 0
                           jnz     short loc_401F42
                           mov     ds:dword_407042, 0
                           mov     ds:dword_407046, 0
                           mov     ds:dword_40703E, 190h
                           jmp     loc_401FD0
           ; ---------------------------------------------------------------------------

           loc_401F42:                             ; CODE XREF: sub_401DBE+15Fj
                           mov     ds:dword_407042, 2
                           mov     ds:dword_407046, 3
                           jmp     short loc_401FD0
           ; ---------------------------------------------------------------------------

           loc_401F58:                             ; CODE XREF: sub_401DBE+EEj
                           cmp     ds:dword_407042, 1
                           jz      short loc_401F73
                           dec     ds:dword_40703E
                           jg      short loc_401FD0
                           mov     ds:dword_407042, 1

           loc_401F73:                             ; CODE XREF: sub_401DBE+1A1j
                           lea     esi, unk_409524
                           lodsd
                           mov     ecx, eax
                           mov     ds:dword_407042, 0

           loc_401F86:                             ; CODE XREF: sub_401DBE+1E7j
                           mov     edx, 3

           loc_401F8B:                             ; CODE XREF: sub_401DBE+1E4j
                           lodsw
                           test    ax, ax
                           jz      short loc_401FA1
                           mov     ds:dword_407042, 1
                           call    sub_401D78

           loc_401FA1:                             ; CODE XREF: sub_401DBE+1D2j
                           dec     edx
                           jg      short loc_401F8B
                           dec     ecx
                           jg      short loc_401F86
                           cmp     ds:dword_407042, 0
                           jnz     short loc_401FD0
                           mov     ds:dword_407042, 2
                           inc     ds:dword_407006
                           cmp     ds:dword_407006, 0Bh
                           jb      short loc_401FD0
                           and     ds:dword_407006, 0

           loc_401FD0:                             ; CODE XREF: sub_401DBE+17Fj
                                                   ; sub_401DBE+198j ...
                           lea     esi, unk_409524
                           lea     edi, unk_409070
                           lodsd
                           stosd
                           mov     ecx, eax

           loc_401FE0:                             ; CODE XREF: sub_401DBE+27Ej
                           call    sub_4021FF
                           mov     eax, ds:dword_40702A
                           mov     [edi+4], ax
                           sub     ds:dword_40702A, 140h
                           mov     eax, ds:dword_407022
                           cdq
                           imul    eax, 140h
                           mov     ebx, ds:dword_40702A
                           cdq
                           idiv    ebx
                           neg     eax
                           add     eax, 146h
                           mov     [edi], ax
                           mov     eax, ds:dword_407026
                           cdq
                           imul    eax, 140h
                           mov     ebx, ds:dword_40702A
                           cdq
                           idiv    ebx
                           add     eax, 0A5h
                           mov     [edi+2], ax
                           add     edi, 6
                           add     esi, 6
                           dec     ecx
                           jg      short loc_401FE0
                           lea     esi, unk_409070
                           lodsd
                           mov     edi, eax
                           dec     eax
                           push    eax
                           push    0
                           push    offset unk_409070
                           call    sub_40179D

           loc_402055:                             ; CODE XREF: sub_401DBE+2FFj
                           xor     eax, eax
                           lodsw
                           mov     ebx, eax
                           lodsw
                           inc     esi
                           inc     esi
                           cmp     ebx, 0
                           jl      short loc_4020BC
                           cmp     ebx, 279h
                           jg      short loc_4020BC
                           cmp     eax, 0
                           jl      short loc_4020BC
                           cmp     eax, 136h
                           jg      short loc_4020BC
                           push    eax
                           push    ebx
                           push    220326h         ; DWORD
                           push    0               ; int
                           push    0               ; int
                           push    ds:dword_407036 ; HDC
                           push    14h             ; int
                           push    14h             ; int
                           push    eax             ; int
                           push    ebx             ; int
                           push    ds:dword_409FA8 ; HDC
                           call    BitBlt
                           pop     ebx
                           pop     eax
                           push    0EE0086h        ; DWORD
                           push    0               ; int
                           push    0               ; int
                           push    ds:dword_40703A ; HDC
                           push    14h             ; int
                           push    14h             ; int
                           push    eax             ; int
                           push    ebx             ; int
                           push    ds:dword_409FA8 ; HDC
                           call    BitBlt

           loc_4020BC:                             ; CODE XREF: sub_401DBE+2A4j
                                                   ; sub_401DBE+2ACj ...
                           dec     edi
                           jnz     short loc_402055
                           
          
          
          
                           
                           mov eax,point_nfo
                           or eax,eax
                           jnz @F
                           mov eax,D_BEGIN
                           
                           @@:
                           push    eax
                           lea     edx, [ebp+lRect]
                           mov     dword ptr [edx], 0
                           mov     dword ptr [edx+4], 0
                           mov     dword ptr [edx+8], 28Dh
                           mov     dword ptr [edx+0Ch], 14Ah
                           push    ds_hbr          ; hbr
                           push    edx             ; lprc
                           push    ds:dword_409FA4 ; hDC
                           call    FillRect
                           pop     eax
                           ;lea     edx, [ebp+lRect]
                           ;mov     dword ptr [edx], 0Fh
                           ;mov     dword ptr [edx+4], 1
                           ;mov     dword ptr [edx+8], 28Dh
                           ;mov     dword ptr [edx+0Ch], 13Eh
                           push    2800h        ; uFormat
                           push    offset nfo_rect;edx             ; lpRect
                           push    0FFFFFFFFh      ; nCount
                           push    eax             ; lpString
                           push    ds:dword_409FA4 ; hDC
                           call    DrawTextA
                           push    0EE0086h        ; DWORD
                           push    0               ; int
                           push    0               ; int
                           push    ds:dword_409F90 ; HDC
                           push    0Ch             ; int
                           push    14Dh            ; int
                           push    13Eh            ; int
                           push    0A0h            ; int
                           push    ds:dword_409FA4 ; HDC
                           call    BitBlt
                           and     ds:byte_407EC6, 0

           loc_40219F:                             ; CODE XREF: sub_401DBE+333j
                           push    0EE0086h        ; DWORD
                           push    0               ; int
                           push    0               ; int
                           push    ds:dword_409FA4 ; HDC
                           push    14Ah            ; int
                           push    28Dh            ; int
                           push    0               ; int
                           push    0               ; int
                           push    ds:dword_409FA8 ; HDC
                           call    BitBlt
                           push    0CC0020h        ; DWORD
                           push    0               ; int
                           push    0               ; int
                           push    ds:dword_409FA8 ; HDC
                           push    14Ah            ; int
                           push    28Dh            ; int
                           push    19h             ; int
                           push    0               ; int
                           push    [ebp+hDC]       ; HDC
                           call    BitBlt
                           push    [ebp+hDC]       ; hDC
                           push    ds_hWnd         ; hWnd
                           call    ReleaseDC
                           pop     edi
                           pop     esi
                           pop     ebx
                           leave
                           retn
           sub_401DBE      endp

           sub_401C72      proc near               ; CODE XREF: sub_401DBE+69p
                           pusha
                           mov     edi, esi
                           mov     esi, ds:dword_409F78
                           mov     eax, esi
                           imul    eax, 98AF11h
                           xor     eax, 11884422h
                           rol     eax, 5
                           imul    eax, 222831h
                           lea     esi, ds:8823771h[eax*4]
                           rol     esi, 3
                           add     ds:dword_409F78, esi
                           xor     edx, edx
                           mov     ebx, 1F9Fh
                           div     ebx
                           mov     eax, edx
                           test    eax, 1
                           jnz     short loc_401CBA
                           neg     ax
                           jnz     short loc_401CBA
                           dec     ax

           loc_401CBA:                             ; CODE XREF: sub_401C72+3Fj
                                                   ; sub_401C72+44j
                           stosw
                           mov     eax, esi
                           imul    eax, 13273h
                           xor     eax, 11884422h
                           rol     eax, 5
                           imul    eax, 728BC1h
                           lea     esi, ds:12345678h[eax*4]
                           rol     esi, 1
                           xor     ds:dword_409F78, esi
                           xor     edx, edx
                           mov     ebx, 1F9Fh
                           div     ebx
                           mov     eax, edx
                           test    eax, 1
                           jnz     short loc_401CFA
                           neg     ax
                           jnz     short loc_401CFA
                           dec     ax

           loc_401CFA:                             ; CODE XREF: sub_401C72+7Fj
                                                   ; sub_401C72+84j
                           stosw
                           mov     ax, si
                           rol     ax, 1
                           and     eax, 7Fh
                           stosw
                           popa
                           retn
           sub_401C72      endp

           sub_401985      proc near               ; CODE XREF: sub_401DBE+E2p
                           push    ebx
                           push    esi
                           push    edi
                           lea     edi, dword_40700A
                           mov     ebx, 1FFh
                           mov     eax, ds:dword_407016
                           add     [edi], eax
                           and     [edi], ebx
                           mov     eax, ds:dword_40701A
                           add     [edi+4], eax
                           and     [edi+4], ebx
                           mov     eax, ds:dword_40701E
                           add     [edi+8], eax
                           and     [edi+8], ebx
                           pop     edi
                           pop     esi
                           pop     ebx
                           retn
           sub_401985      endp

           sub_401D78      proc near               ; CODE XREF: sub_401DBE+14Ap
                                                   ; sub_401DBE+1DEp
                           test    ax, ax
                           js      short loc_401D9E
                           cmp     ax, 0Ah
                           jg      short loc_401D8A
                           add     word ptr [esi-2], 0FFFFh
                           jmp     short locret_401DBD
           ; ---------------------------------------------------------------------------

           loc_401D8A:                             ; CODE XREF: sub_401D78+9j
                           cmp     ax, 1Eh
                           jg      short loc_401D97
                           add     word ptr [esi-2], 0FFFEh
                           jmp     short locret_401DBD
           ; ---------------------------------------------------------------------------

           loc_401D97:                             ; CODE XREF: sub_401D78+16j
                           add     word ptr [esi-2], 0FFFDh
                           jmp     short locret_401DBD
           ; ---------------------------------------------------------------------------

           loc_401D9E:                             ; CODE XREF: sub_401D78+3j
                           cmp     ax, 0FFF6h
                           jl      short loc_401DAB
                           add     word ptr [esi-2], 1
                           jmp     short locret_401DBD
           ; ---------------------------------------------------------------------------

           loc_401DAB:                             ; CODE XREF: sub_401D78+2Aj
                           cmp     ax, 0FFE2h
                           jl      short loc_401DB8
                           add     word ptr [esi-2], 2
                           jmp     short locret_401DBD
           ; ---------------------------------------------------------------------------

           loc_401DB8:                             ; CODE XREF: sub_401D78+37j
                           add     word ptr [esi-2], 3

           locret_401DBD:                          ; CODE XREF: sub_401D78+10j
                                                   ; sub_401D78+1Dj ...
                           retn
           sub_401D78      endp

           sub_4021FF      proc near               ; CODE XREF: sub_401DBE:loc_401FE0p

           var_18          = dword ptr -18h
           var_14          = dword ptr -14h
           var_10          = dword ptr -10h
           var_C           = dword ptr -0Ch
           var_8           = dword ptr -8
           var_4           = dword ptr -4

                           push    ebp
                           mov     ebp, esp
                           add     esp, 0FFFFFFE8h
                           mov     eax, ds:dword_40700A
                           mov     eax, ds:dword_408870[eax*4]
                           movsx   ebx, word ptr [esi]
                           cdq
                           imul    ebx
                           mov     [ebp+var_4], eax
                           mov     eax, ds:dword_40700A
                           mov     eax, ds:dword_408070[eax*4]
                           movsx   ebx, word ptr [esi+2]
                           cdq
                           imul    ebx
                           add     [ebp+var_4], eax
                           mov     eax, ds:dword_40700A
                           mov     eax, ds:dword_408070[eax*4]
                           movsx   ebx, word ptr [esi]
                           cdq
                           imul    ebx
                           mov     [ebp+var_8], eax
                           mov     eax, ds:dword_40700A
                           mov     eax, ds:dword_408870[eax*4]
                           movsx   ebx, word ptr [esi+2]
                           cdq
                           imul    ebx
                           sub     [ebp+var_8], eax
                           mov     eax, [ebp+var_4]
                           sar     eax, 8
                           mov     [ebp+var_4], eax
                           mov     eax, [ebp+var_8]
                           sar     eax, 8
                           mov     [ebp+var_8], eax
                           mov     eax, ds:dword_40700E
                           mov     eax, ds:dword_408870[eax*4]
                           mov     ebx, [ebp+var_4]
                           cdq
                           imul    ebx
                           mov     [ebp+var_10], eax
                           mov     eax, ds:dword_40700E
                           mov     eax, ds:dword_408070[eax*4]
                           movsx   ebx, word ptr [esi+4]
                           cdq
                           imul    ebx
                           add     [ebp+var_10], eax
                           mov     eax, ds:dword_40700E
                           mov     eax, ds:dword_408070[eax*4]
                           mov     ebx, [ebp+var_4]
                           cdq
                           imul    ebx
                           mov     [ebp+var_C], eax
                           mov     eax, ds:dword_40700E
                           mov     eax, ds:dword_408870[eax*4]
                           movsx   ebx, word ptr [esi+4]
                           cdq
                           imul    ebx
                           sub     [ebp+var_C], eax
                           mov     eax, [ebp+var_C]
                           sar     eax, 8
                           mov     [ebp+var_C], eax
                           mov     eax, ds:dword_407012
                           mov     eax, ds:dword_408870[eax*4]
                           mov     ebx, [ebp+var_8]
                           cdq
                           imul    ebx
                           mov     [ebp+var_14], eax
                           mov     eax, ds:dword_407012
                           mov     eax, ds:dword_408070[eax*4]
                           mov     ebx, [ebp+var_C]
                           cdq
                           imul    ebx
                           add     [ebp+var_14], eax
                           mov     eax, ds:dword_407012
                           mov     eax, ds:dword_408070[eax*4]
                           mov     ebx, [ebp+var_8]
                           cdq
                           imul    ebx
                           mov     [ebp+var_18], eax
                           mov     eax, ds:dword_407012
                           mov     eax, ds:dword_408870[eax*4]
                           mov     ebx, [ebp+var_C]
                           cdq
                           imul    ebx
                           sub     [ebp+var_18], eax
                           mov     eax, [ebp+var_10]
                           sar     eax, 8
                           mov     ds:dword_407022, eax
                           mov     eax, [ebp+var_14]
                           sar     eax, 8
                           mov     ds:dword_407026, eax
                           mov     eax, [ebp+var_18]
                           sar     eax, 8
                           mov     ds:dword_40702A, eax
                           leave
                           retn
           sub_4021FF      endp

           sub_40179D      proc near               ; CODE XREF: sub_40179D+CAp
                                                   ; sub_40179D+DBp ...

           var_1C          = dword ptr -1Ch
           var_18          = dword ptr -18h
           var_14          = dword ptr -14h
           var_10          = dword ptr -10h
           arg_0           = dword ptr  8
           arg_4           = dword ptr  0Ch
           arg_8           = dword ptr  10h

                           push    ebp
                           mov     ebp, esp
                           push    ebx
                           push    esi
                           push    edi
                           mov     esi, [ebp+arg_4]
                           mov     edi, [ebp+arg_8]
                           lea     ebx, [edi+esi]
                           shr     ebx, 1
                           mov     edx, [ebp+arg_0]
                           add     edx, 4
                           add     ebx, ebx
                           lea     ebx, [ebx+ebx*2]
                           movsx   ebx, word ptr [edx+ebx+4]

           loc_4017BE:                             ; CODE XREF: sub_40179D+B8j
                           dec     esi

           loc_4017BF:                             ; CODE XREF: sub_40179D+32j
                           inc     esi
                           lea     ecx, ds:0[esi*2]
                           lea     eax, [ecx+ecx*2]
                           cmp     [eax+edx+4], bx
                           jl      short loc_4017BF
                           inc     edi

           loc_4017D2:                             ; CODE XREF: sub_40179D+45j
                           dec     edi
                           lea     ecx, ds:0[edi*2]
                           lea     eax, [ecx+ecx*2]
                           cmp     [eax+edx+4], bx
                           jg      short loc_4017D2
                           cmp     esi, edi
                           jg      short loc_401853
                           lea     ecx, ds:0[edi*2]
                           lea     eax, [ecx+ecx*2]
                           movsx   ecx, word ptr [eax+edx]
                           push    ecx
                           movsx   ecx, word ptr [eax+edx+2]
                           push    ecx
                           movsx   ecx, word ptr [eax+edx+4]
                           push    ecx
                           push    eax
                           lea     ecx, ds:0[esi*2]
                           lea     eax, [ecx+ecx*2]
                           movsx   ecx, word ptr [eax+edx]
                           push    ecx
                           movsx   ecx, word ptr [eax+edx+2]
                           push    ecx
                           movsx   ecx, word ptr [eax+edx+4]
                           push    ecx
                           mov     ecx, [esp+28h+var_10]
                           mov     [eax+edx], cx
                           mov     ecx, [esp+28h+var_14]
                           mov     [eax+edx+2], cx
                           mov     ecx, [esp+28h+var_18]
                           mov     [eax+edx+4], cx
                           mov     eax, [esp+28h+var_1C]
                           pop     ecx
                           mov     [eax+edx+4], cx
                           pop     ecx
                           mov     [eax+edx+2], cx
                           pop     ecx
                           mov     [eax+edx], cx
                           add     esp, 10h
                           inc     esi
                           dec     edi

           loc_401853:                             ; CODE XREF: sub_40179D+49j
                           cmp     esi, edi
                           jl      loc_4017BE
                           cmp     edi, [ebp+arg_4]
                           jle     short loc_40186C
                           push    edi
                           push    [ebp+arg_4]
                           push    [ebp+arg_0]
                           call    sub_40179D

           loc_40186C:                             ; CODE XREF: sub_40179D+C1j
                           cmp     esi, [ebp+arg_8]
                           jge     short loc_40187D
                           push    [ebp+arg_8]
                           push    esi
                           push    [ebp+arg_0]
                           call    sub_40179D

           loc_40187D:                             ; CODE XREF: sub_40179D+D2j
                           pop     edi
                           pop     esi
                           pop     ebx
                           leave
                           retn    0Ch
           sub_40179D      endp

