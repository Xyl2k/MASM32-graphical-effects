                ; DWORD __stdcall StartAddress(LPVOID)
                StartAddress    proc near               ; DATA XREF: sub_401184+74o

                var_4           = dword ptr -4
                hWnd$            = dword ptr  8

                                push    ebp
                                mov     ebp, esp
                                add     esp, 0FFFFFFFCh
                                push    esi
                                push    edi
                                push    ebx
                                mov     [ebp+var_4], 0

                loc_4019FB:                             ; CODE XREF: StartAddress+EEj
                                push    offset aLegoStarwars ; "Lego Starwars"
                                push    0               ; lpClassName
                                call    FindWindowA
                                or      eax, eax
                                jnz     loc_401AD2
                                call    GdiFlush
                                cmp     [ebp+var_4], 1
                                jnz     short loc_401A26
                                call    sub_401CCD
                                mov     [ebp+var_4], 0

                loc_401A26:                             ; CODE XREF: StartAddress+2Dj
                                inc     [ebp+var_4]
                                push    offset byte_4067CD
                                call    sub_401ADE
                                call    sub_401BEA
                                push    0Fh             ; dwMilliseconds
                                call    Sleep
                                push    (offset loc_4067FF+0Ah)
                                call    sub_401ADE
                                call    sub_401BEA
                                push    0Fh             ; dwMilliseconds
                                call    Sleep
                                push    offset byte_406845
                                call    sub_401ADE
                                call    sub_401BEA
                                push    0Fh             ; dwMilliseconds
                                call    Sleep
                                push    offset byte_406881
                                call    sub_401ADE
                                call    sub_401BEA
                                push    0Fh             ; dwMilliseconds
                                call    Sleep
                                push    offset byte_4068BD
                                call    sub_401ADE
                                call    sub_401BEA
                                push    0Fh             ; dwMilliseconds
                                call    Sleep
                                push    offset byte_4068F9
                                call    sub_401ADE
                                call    sub_401BEA
                                push    0Fh             ; dwMilliseconds
                                call    Sleep
                                push    offset byte_406909
                                call    sub_401ADE
                                call    sub_401BEA
                                push    0Fh             ; dwMilliseconds
                                call    Sleep
                                push    0               ; bErase
                                push    offset Rect     ; lpRect
                                push    [ebp+hWnd$]      ; hWnd
                                call    InvalidateRect

                loc_401AD2:                             ; CODE XREF: StartAddress+1Ej
                                push    64h             ; dwMilliseconds
                                call    Sleep
                                jmp     loc_4019FB
                StartAddress    endp


               sub_401CCD      proc near               ; CODE XREF: StartAddress+2Fp

                var_1C          = dword ptr -1Ch
                var_18          = dword ptr -18h
                var_14          = dword ptr -14h
                var_10          = dword ptr -10h
                var_C           = dword ptr -0Ch
                var_8           = dword ptr -8
                var_4           = dword ptr -4

                                push    ebp
                                mov     ebp, esp
                                add     esp, 0FFFFFFE4h
                                mov     eax, 0B5h
                                mov     [ebp+var_4], eax
                                mov     eax,48h;<-bmp height
                                mov     [ebp+var_8], eax
                                mov     [ebp+var_C], 0
                                mov     [ebp+var_10], 0
                                mov     [ebp+var_14], 0
                                mov     [ebp+var_18], 0
                                mov     [ebp+var_1C], 0

                loc_401D06:                             ; CODE XREF: sub_401CCD+5Bj
                                                        ; sub_401CCD+78j
                                mov     edx, [ebp+var_4]
                                cmp     [ebp+var_18], edx
                                jnb     short loc_401D2A
                                push    [ebp+var_14]
                                push    [ebp+var_10]
                                push    [ebp+var_C]
                                push    dword_40C484
                                call    sub_4019C8
                                inc     [ebp+var_C]
                                inc     [ebp+var_18]
                                jmp     short loc_401D06
                ; ---------------------------------------------------------------------------

                loc_401D2A:                             ; CODE XREF: sub_401CCD+3Fj
                                mov     edx, [ebp+var_8]
                                cmp     [ebp+var_1C], edx
                                jnb     short locret_401D47
                                inc     [ebp+var_10]
                                inc     [ebp+var_1C]
                                mov     esi, [ebp+var_18]
                                sub     [ebp+var_C], esi
                                mov     [ebp+var_18], 0
                                jmp     short loc_401D06
                ; ---------------------------------------------------------------------------

                locret_401D47:                          ; CODE XREF: sub_401CCD+63j
                                leave
                                retn
                sub_401CCD      endp

               sub_401ADE      proc near               ; CODE XREF: StartAddress+43p
                                                        ; StartAddress+59p ...

                var_2C          = dword ptr -2Ch
                var_28          = dword ptr -28h
                var_24          = dword ptr -24h
                var_20          = dword ptr -20h
                var_1C          = dword ptr -1Ch
                var_18          = dword ptr -18h
                var_14          = dword ptr -14h
                var_10          = dword ptr -10h
                var_C           = dword ptr -0Ch
                var_8           = dword ptr -8
                var_4           = dword ptr -4
                arg_0           = dword ptr  8

                                push    ebp
                                mov     ebp, esp
                                add     esp, 0FFFFFFD4h
                                pusha
                                push    0FFFFFFh
                                call    sub_401D49
                                mov     [ebp+var_2C], eax
                                mov     edi, 32E8h
                                mov     [ebp+var_18], edi
                                push    0B5h
                                call    sub_401D49
                                sub     eax, 0Ah
                                mov     [ebp+var_10], eax
                                mov     [ebp+var_28], eax
                                push    48h;<-bmp height
                                call    sub_401D49
                                sub     eax, 6
                                mov     [ebp+var_14], eax
                                mov     [ebp+var_4], 0
                                mov     edi, [ebp+var_14]
                                imul    edi, 2D4h
                                add     [ebp+var_1C], edi
                                mov     edi, [ebp+var_10]
                                shl     edi, 2
                                add     [ebp+var_1C], edi
                                mov     [ebp+var_8], 0Ah
                                mov     [ebp+var_C], 6
                                mov     edi, [ebp+arg_0]
                                mov     [ebp+var_20], edi

                loc_401B4A:                             
                                mov     edi, [ebp+var_18]
                                xor     edi, edi
                                mov     [ebp+var_18], edi
                                mov     eax, [ebp+var_28]
                                mov     [ebp+var_10], eax

                loc_401B58:                             
                                mov     esi, [ebp+var_18]
                                mov     edi, [ebp+var_20]
                                mov     edx, [ebp+var_1C]
                                movzx   edx, byte ptr [esi+edi]
                                mov     [ebp+var_1C], edx
                                mov     edi,offset byte_406919
                                mov     [ebp+var_24], edi
                                mov     edx, [ebp+var_1C]
                                mov     esi, [ebp+var_24]
                                mov     edx, [esi+edx*4]
                                mov     [ebp+var_1C], edx
                                cmp     [ebp+var_1C], 0FF00FFh
                                jz      short loc_401BA2
                                mov     eax, [ebp+var_2C]
                                or      [ebp+var_1C], eax
                                and     [ebp+var_1C], eax
                                push    [ebp+var_1C]
                                push    [ebp+var_14]
                                push    [ebp+var_10]
                                push    dword_40C484
                                call    sub_4019C8

                loc_401BA2:                             
                                add     [ebp+var_1C], 4
                                mov     esi, [ebp+var_18]
                                inc     esi
                                mov     [ebp+var_18], esi
                                inc     [ebp+var_10]
                                mov     esi, [ebp+var_10]
                                mov     eax, [ebp+var_28]
                                sub     esi, eax
                                cmp     esi, [ebp+var_8]
                                jnz     short loc_401B58
                                mov     edi, [ebp+var_8]
                                mov     esi, 0B5h
                                sub     esi, edi
                                shl     esi, 2
                                add     [ebp+var_1C], esi
                                mov     esi, [ebp+var_8]
                                add     [ebp+var_20], esi
                                inc     [ebp+var_14]
                                inc     [ebp+var_4]
                                mov     edi, [ebp+var_C]
                                cmp     [ebp+var_4], edi
                                jnz     loc_401B4A
                                popa
                                leave
                                retn    4
                sub_401ADE      endp



               ; --------------- S U B R O U T I N E ---------------------------------------

                ; Attributes: bp-based frame

                sub_401BEA      proc near               ; CODE XREF: StartAddress+48p
                                                        ; StartAddress+5Ep ...

                var_24          = dword ptr -24h
                var_20          = dword ptr -20h
                var_1C          = dword ptr -1Ch
                var_18          = dword ptr -18h
                var_14          = dword ptr -14h
                var_10          = dword ptr -10h
                var_C           = dword ptr -0Ch
                var_8           = dword ptr -8
                var_4           = dword ptr -4

                                push    ebp
                                mov     ebp, esp
                                add     esp, 0FFFFFFDCh
                                pusha
                                mov     edi, 32E8h
                                mov     [ebp+var_18], edi
                                mov     [ebp+var_10], 8
                                mov     [ebp+var_14], 0Ah
                                mov     [ebp+var_4], 0
                                mov     edi, [ebp+var_14]
                                imul    edi, 2D4h
                                add     [ebp+var_1C], edi
                                mov     edi, [ebp+var_10]
                                shl     edi, 2
                                add     [ebp+var_1C], edi
                                mov     [ebp+var_8], 0A4h
                                mov     [ebp+var_C], 35h
                                mov     edi,byte_406D19; offset byte_406D19
                                mov     [ebp+var_20], edi

                loc_401C39:                             
                                mov     edi, [ebp+var_18]
                                xor     edi, edi
                                mov     [ebp+var_18], edi
                                mov     [ebp+var_10], 8

                loc_401C48:                             
                                mov     esi, [ebp+var_18]
                                mov     edi, [ebp+var_20]
                                mov     edx, [ebp+var_1C]
                                movzx   edx, byte ptr [esi+edi]
                                mov     [ebp+var_1C], edx
                                mov     edi, offset byte_406919
                                mov     [ebp+var_24], edi
                                mov     edx, [ebp+var_1C]
                                mov     esi, [ebp+var_24]
                                mov     edx, [esi+edx*4]
                                mov     [ebp+var_1C], edx
                                cmp     [ebp+var_1C], 0FF00FFh
                                jz      short loc_401C89
                                push    [ebp+var_1C]
                                push    [ebp+var_14]
                                push    [ebp+var_10]
                                push    dword_40C484
                                call    sub_4019C8

                loc_401C89:                             
                                add     [ebp+var_1C], 4
                                mov     esi, [ebp+var_18]
                                inc     esi
                                mov     [ebp+var_18], esi
                                inc     [ebp+var_10]
                                mov     esi, [ebp+var_10]
                                sub     esi, 8
                                cmp     esi, [ebp+var_8]
                                jnz     short loc_401C48
                                mov     edi, [ebp+var_8]
                                mov     esi,0B5h;<-------bmp widht
                                sub     esi, edi
                                shl     esi, 2
                                add     [ebp+var_1C], esi
                                mov     esi, [ebp+var_8]
                                add     [ebp+var_20], esi
                                inc     [ebp+var_14]
                                inc     [ebp+var_4]
                                mov     edi, [ebp+var_C]
                                cmp     [ebp+var_4], edi
                                jnz     loc_401C39
                                popa
                                leave
                                retn
                sub_401BEA      endp




               sub_4019C8      proc near               ; CODE XREF: sub_401ADE+BFp
                                                        ; sub_401BEA+9Ap ...

                arg_0           = dword ptr  8
                arg_4           = dword ptr  0Ch
                arg_8           = dword ptr  10h
                arg_C           = dword ptr  14h

                                push    ebp
                                mov     ebp, esp
                                mov     eax,48h;<------bmp height
                                sub     eax, [ebp+arg_8]
                                imul    eax, 0B5h;<-------bmp widht
                                add     eax, [ebp+arg_4]
                                mov     ebx, [ebp+arg_0]
                                mov     ecx, [ebp+arg_C]
                                lea     eax, [ebx+eax*4]
                                mov     [eax], ecx
                                leave
                                retn    10h
                sub_4019C8      endp


                sub_401D49      proc near               ; CODE XREF: sub_401ADE+Cp
                                                        ; sub_401ADE+21p ...

                arg_0           = dword ptr  8

                                push    ebp
                                mov     ebp, esp
                                push    edi
                                push    esi
                                push    ebx
                                push    ecx
                                mov     ecx, [ebp+arg_0]
                                mov     eax, dword_406746
                                mov     ebx, dword_406742
                                mov     esi, eax
                                mov     edi, ebx
                                mov     dl, ah
                                mov     ah, al
                                mov     al, bh
                                mov     bh, bl
                                xor     bl, bl
                                rcr     dl, 1
                                rcr     eax, 1
                                rcr     ebx, 1
                                add     ebx, edi
                                adc     eax, esi
                                add     ebx, 3B1C62E9h
                                adc     eax, 4D8F3619h
                                mov     dword_406742, ebx
                                mov     dword_406746, eax
                                xor     edx, edx
                                div     ecx
                                mov     eax, edx
                                jnz     short loc_401D95
                                inc     eax

                loc_401D95:                             ; CODE XREF: sub_401D49+49j
                                pop     ecx
                                pop     ebx
                                pop     esi
                                pop     edi
                                leave
                                retn    4
                sub_401D49      endp
