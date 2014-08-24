                sub_402C7B      proc near               ; CODE XREF: sub_4021D8+376p
                                                        ; sub_4021D8:loc_402A73p ...
                                push    ebx
                                push    ecx
                                push    edx
                                push    edi
                                push    esi
                                push    74C40h
                                push    dword_4070BB
                                push    dword_4070B7
                                call    sub_401000;yes
                                call    sub_401FA3;yes
                                cmp     dword_40703D, 2
                                jz      short loc_402CCC
                                push    0Ch
                                push    0Ch
                                push    0Eh
                                push    154h
                                push    1Ah
                                push    2Ah
                                call    sub_40305E;yes
                                push    1Ah
                                push    0Ch
                                push    7
                                push    0F6h
                                push    2Fh
                                push    59h
                                call    sub_40305E;yes

                loc_402CCC:                             ; CODE XREF: sub_402C7B+27j
                                cmp     dword_40703D, 1
                                jz      short loc_402CFE
                                cmp     byte_407042, 1
                                jnz     short loc_402CFE
                                dec     byte_407042

                               ; push    0               ; nCmdShow
                                ;push    hWnd            ; hWnd
                               ; call    ShowWindow
                               ; push    0               ; nCmdShow
                               ; push    dword_4073DD    ; hWnd
                               ; call    ShowWindow


                loc_402CFE:                             ; CODE XREF: sub_402C7B+58j
                                                        ; sub_402C7B+61j
                                push    1               ; int
                                push    dword_4070B3    ; HDC
                                call    SetBkMode
                                push    0               ; COLORREF
                                push    dword_4070B3    ; HDC
                                call    SetTextColor
                               ; push    dword ptr aCheatGuruV1_0+0Fh ; int
                                ;push    offset aCheatGuruV1_0 ; "Cheat Guru v1.0"
                                ;push    0E5h            ; int
                                ;push    17h             ; int
                                ;push    dword_4070B3    ; HDC
                                ;call    TextOutA
                                push    0B9B9B9h        ; COLORREF
                                push    dword_4070B3    ; HDC
                                call    SetTextColor
                                ;push    dword ptr aCheatGuruV1_0+0Fh ; int
                                ;push    offset aCheatGuruV1_0 ; "Cheat Guru v1.0"
                                ;push    0E4h            ; int
                               ; push    16h             ; int
                               ; push    dword_4070B3    ; HDC
                               ; call    TextOutA
                                cmp     dword_40703D, 1
                                jnz     loc_402E2A; jmp
                                push    0F9h
                                push    0F5h
                                push    1
                                push    36h
                                push    0F9h
                                push    41h
                                call    sub_40305E
                                push    91h
                                push    0Ch
                                push    0Eh
                                push    36h
                                push    52h
                                push    34h
                                call    sub_40305E
                                push    0ADh
                                push    0Ch
                                push    15h
                                push    110h
                                push    60h
                                push    2Ch
                                call    sub_40305E
                                push    9Fh
                                push    0Ch
                                push    0Eh
                                push    4Bh
                                push    83h
                                push    34h
                                call    sub_40305E
                                push    0ADh
                                push    0Ch
                                push    15h
                                push    110h
                                push    91h
                                push    2Ch
                                call    sub_40305E
                                push    75h
                                push    0Ch
                                push    7
                                push    157h
                                push    0D2h
                                push    26h
                                call    sub_40305E
                                mov     eax, 0Ch
                                cmp     dword_407039, 6
                                jnz     short loc_402E0F
                                mov     eax, 36h

                loc_402E0F:                             ; CODE XREF: sub_402C7B+18Dj
                                push    7Bh
                                push    eax
                                push    12h
                                push    2Bh
                                push    0AAh
                                push    154h
                                call    sub_40305E
                                jmp     loc_402F07
                ; ---------------------------------------------------------------------------

                loc_402E2A:                             ; CODE XREF: sub_402C7B+EEj
                                cmp     dword_40703D, 2
                                jnz     loc_402EB9;jmp------------------------------------
                                mov     eax, 1A8h
                                mul     rcUpdate.top
                                add     eax, rcUpdate.left
                                add     eax, 8
                                shl     eax, 2
                                mov     edi, eax
                                add     edi, dword_4070B7
                                mov     eax, 190h
                                mul     dword_407080
                                shl     eax, 2
                                mov     esi, eax
                                add     esi, dword_4070BF
                                xor     ecx, ecx
                                jmp     short loc_402E95
                ; ---------------------------------------------------------------------------

                loc_402E70:                             ; CODE XREF: sub_402C7B+220j
                                xor     edx, edx
                                jmp     short loc_402E80
                ; ---------------------------------------------------------------------------

                loc_402E74:                             ; CODE XREF: sub_402C7B+20Bj
                                mov     eax, [esi+edx*4]
                                cmp     eax, 0
                                jz      short loc_402E7F
                                mov     [edi+edx*4], eax

                loc_402E7F:                             ; CODE XREF: sub_402C7B+1FFj
                                inc     edx

                loc_402E80:                             ; CODE XREF: sub_402C7B+1F7j
                                cmp     edx, 188h
                                jb      short loc_402E74
                                add     edi, 6A0h
                                add     esi, 640h
                                inc     ecx

                loc_402E95:                             ; CODE XREF: sub_402C7B+1F3j
                                cmp     ecx, 0D2h
                                jb      short loc_402E70
                                push    0F9h
                                push    0F5h
                                push    1
                                push    36h
                                push    0F9h
                                push    7Dh
                                call    sub_40305E
                                jmp     short loc_402F07
                ; ---------------------------------------------------------------------------

                loc_402EB9:                             ; CODE XREF: sub_402C7B+1B6j
                                cmp     dword_40703D, 3
                                jnz     short loc_402F07
                                push    0F9h
                                push    0F5h
                                push    1
                                push    36h
                                push    0F9h
                                push    0B9h
                                call    sub_40305E
                                push    21h
                                push    0Ch
                                push    54h
                                push    78h
                                push    52h
                                push    44h
                                call    sub_40305E
                                push    21h
                                push    83h
                                push    54h
                                push    78h
                                push    52h
                                push    0ECh
                                call    sub_40305E

                loc_402F07:                             ; CODE XREF: sub_402C7B+1AAj
                                                        ; sub_402C7B+23Cj ...
                                cmp     dword_407039, 1
                                jnz     short loc_402F2C
                                push    0C2h
                                push    0Ch
                                push    1Ch
                                push    3Ah
                                push    0FBh
                                push    3Fh
                                call    sub_40305E
                                jmp     loc_402FC4
                ; ---------------------------------------------------------------------------

                loc_402F2C:                             ; CODE XREF: sub_402C7B+293j
                                cmp     dword_407039, 2
                                jnz     short loc_402F4E
                                push    0C2h
                                push    46h
                                push    1Ch
                                push    3Ah
                                push    0FBh
                                push    7Bh
                                call    sub_40305E
                                jmp     short loc_402FC4
                ; ---------------------------------------------------------------------------

                loc_402F4E:                             ; CODE XREF: sub_402C7B+2B8j
                                cmp     dword_407039, 3
                                jnz     short loc_402F76
                                push    0C2h
                                push    80h
                                push    1Ch
                                push    3Ah
                                push    0FBh
                                push    0B7h
                                call    sub_40305E
                                jmp     short loc_402FC4
                ; ---------------------------------------------------------------------------

                loc_402F76:                             ; CODE XREF: sub_402C7B+2DAj
                                cmp     dword_407039, 4
                                jnz     short loc_402F9E
                                push    0C2h
                                push    0BAh
                                push    1Ch
                                push    3Ah
                                push    0FBh
                                push    0F3h
                                call    sub_40305E
                                jmp     short loc_402FC4
                ; ---------------------------------------------------------------------------

                loc_402F9E:                             ; CODE XREF: sub_402C7B+302j
                                cmp     dword_407039, 5
                                jnz     short loc_402FC4
                                push    0C2h
                                push    0F4h
                                push    1Ch
                                push    3Ah
                                push    0FBh
                                push    12Fh
                                call    sub_40305E

                loc_402FC4:                             ; CODE XREF: sub_402C7B+2ACj
                                                        ; sub_402C7B+2D1j ...
                                cmp     byte_407041, 0
                                jnz     short loc_402FEA
                                push    0DDh
                                push    12Fh
                                push    1
                                push    36h
                                push    0F9h
                                push    0F5h
                                call    sub_40305E

                loc_402FEA:                             ; CODE XREF: sub_402C7B+350j
                                pop     esi
                                pop     edi
                                pop     edx
                                pop     ecx
                                pop     ebx
                                retn
                sub_402C7B      endp



                sub_401000      proc near               ; CODE XREF: sub_401FA3+A2p
                                                        ; sub_4021D8+10Ap ...

                arg_0           = dword ptr  8
                arg_4           = dword ptr  0Ch
                arg_8           = dword ptr  10h

                                push    ebp
                                mov     ebp, esp
                                push    ecx
                                push    esi
                                push    edi
                                mov     ecx, [ebp+arg_8]
                                mov     esi, [ebp+arg_4]
                                mov     edi, [ebp+arg_0]
                                push    ecx
                                shr     ecx, 2
                                rep movsd
                                pop     ecx
                                and     ecx, 3
                                rep movsb
                                pop     edi
                                pop     esi
                                pop     ecx
                                leave
                                retn    0Ch
                sub_401000      endp


                sub_401FA3      proc near               ; CODE XREF: sub_402C7B+1Bp
                                push    ebp
                                mov     ebp, esp
                                add     esp, 0FFFFFFF8h
                                push    esi
                                push    edi
                                push    ebx
                                push    ecx
                                push    edx
                                call    sub_401DE7
                                call    sub_401E84
                                xor     esi, esi
                                xor     edx, edx
                                jmp     short loc_402022
                ; ---------------------------------------------------------------------------

                loc_401FBE:                             ; CODE XREF: sub_401FA3+82j
                                xor     ebx, ebx
                                jmp     short loc_40201C
                ; ---------------------------------------------------------------------------

                loc_401FC2:                             ; CODE XREF: sub_401FA3+7Cj
                                mov     eax, 32h
                                mul     esi
                                add     eax, ebx
                                lea     edi, [eax+eax*2]
                                add     edi, offset dword_4079A8
                                cmp     byte ptr [edi+1], 0
                                jz      short loc_40201B
                                cmp     byte ptr [edi+2], 0
                                jbe     short loc_401FE7
                                push    33EE33h
                                jmp     short loc_401FEC
                ; ---------------------------------------------------------------------------

                loc_401FE7:                             ; CODE XREF: sub_401FA3+3Bj
                                push    118811h

                loc_401FEC:                             ; CODE XREF: sub_401FA3+42j
                                xor     eax, eax
                                mov     al, [edi]
                                push    eax
                                mov     eax, 7
                                mul     esi
                                push    eax
                                mov     eax, 8
                                mul     ebx
                                push    eax
                                call    sub_402066
                                mov     byte ptr [edi+1], 0
                                cmp     byte ptr [edi+2], 0
                                jbe     short loc_40201B
                                mov     cl, [edi+2]
                                dec     ecx
                                mov     [edi+2], cl
                                mov     byte ptr [edi+1], 1

                loc_40201B:                             ; CODE XREF: sub_401FA3+35j
                                                        ; sub_401FA3+6Bj
                                inc     ebx

                loc_40201C:                             ; CODE XREF: sub_401FA3+1Dj
                                cmp     ebx, 32h
                                jb      short loc_401FC2
                                inc     esi

                loc_402022:                             ; CODE XREF: sub_401FA3+19j
                                cmp     esi, 1Eh
                                jb      short loc_401FBE
                                mov     eax, 4FB0h
                                mov     edi, dword_4070B7
                                add     edi, eax
                                mov     esi, dword_4076A9
                                xor     ecx, ecx
                                jmp     short loc_402057
                ; ---------------------------------------------------------------------------

                loc_40203E:                             ; CODE XREF: sub_401FA3+BAj
                                push    640h
                                push    esi
                                push    edi
                                call    sub_401000
                                add     edi, 6A0h
                                add     esi, 640h
                                inc     ecx

                loc_402057:                             ; CODE XREF: sub_401FA3+99j
                                cmp     ecx, 0D2h
                                jnz     short loc_40203E
                                pop     edx
                                pop     ecx
                                pop     ebx
                                pop     edi
                                pop     esi
                                leave
                                retn
                sub_401FA3      endp

                sub_401DE7      proc near               ; CODE XREF: sub_401FA3+Bp
                                push    esi
                                push    ebx
                                push    ecx
                                push    edx
                                xor     esi, esi
                                jmp     loc_401E76
                ; ---------------------------------------------------------------------------

                loc_401DF2:                             ; CODE XREF: sub_401DE7+92j
                                mov     eax, 0Ch
                                mul     esi
                                mov     ebx, eax
                                add     ebx, offset dword_407750
                                xor     ecx, ecx
                                cmp     dword ptr [ebx+4], 0
                                jbe     short loc_401E12
                                mov     ecx, [ebx+4]
                                dec     ecx
                                mov     [ebx+4], ecx
                                jmp     short loc_401E55
                ; ---------------------------------------------------------------------------

                loc_401E12:                             ; CODE XREF: sub_401DE7+20j
                                cmp     byte ptr [ebx], 0
                                jbe     short loc_401E3D
                                push    47h
                                call    sub_401022
                                inc     eax
                                push    dword ptr [ebx+8]
                                push    esi
                                push    eax
                                call    sub_401D2D
                                mov     ecx, [ebx]
                                dec     ecx
                                mov     [ebx], ecx
                                cmp     dword ptr [ebx+8], 0
                                jb      short loc_401E55
                                mov     ecx, [ebx+8]
                                inc     ecx
                                mov     [ebx+8], ecx
                                jmp     short loc_401E55
                ; ---------------------------------------------------------------------------

                loc_401E3D:                             ; CODE XREF: sub_401DE7+2Ej
                                push    dword ptr [ebx+8]
                                push    esi
                                push    0
                                call    sub_401D2D
                                cmp     dword ptr [ebx+8], 0
                                jb      short loc_401E55
                                mov     ecx, [ebx+8]
                                inc     ecx
                                mov     [ebx+8], ecx

                loc_401E55:                             ; CODE XREF: sub_401DE7+29j
                                                        ; sub_401DE7+4Bj ...
                                push    0Ah
                                call    sub_401022
                                or      eax, eax
                                jnz     short loc_401E75
                                push    5
                                call    sub_401022
                                mov     ecx, eax
                                push    5
                                call    sub_401022
                                add     eax, ecx
                                mov     [ebx+4], eax

                loc_401E75:                             ; CODE XREF: sub_401DE7+77j
                                inc     esi

                loc_401E76:                             ; CODE XREF: sub_401DE7+6j
                                cmp     esi, 32h
                                jb      loc_401DF2
                                pop     edx
                                pop     ecx
                                pop     ebx
                                pop     esi
                                retn
                sub_401DE7      endp



                sub_401022      proc near               ; CODE XREF: sub_401D2D+A2p
                                                        ; sub_401DE7+32p ...

                arg_0           = dword ptr  8

                                push    ebp
                                mov     ebp, esp
                                push    ecx
                                push    edx
                                mov     eax, dword_40769B
                                rol     eax, 11h
                                mov     ecx, 40h

                loc_401034:                             ; CODE XREF: sub_401022:loc_40103Dj
                                rol     eax, cl
                                jnb     short loc_40103D
                                xor     eax, 89515980h

                loc_40103D:                             ; CODE XREF: sub_401022+14j
                                loop    loc_401034
                                mov     dword_40769B, eax
                                xor     edx, edx
                                div     [ebp+arg_0]
                                mov     eax, edx
                                pop     edx
                                pop     ecx
                                leave
                                retn    4
                sub_401022      endp



                sub_401D2D      proc near               ; CODE XREF: sub_401DE7+3Dp
                                                        ; sub_401DE7+5Cp

                arg_0           = byte ptr  8
                arg_4           = dword ptr  0Ch
                arg_8           = dword ptr  10h

                                push    ebp
                                mov     ebp, esp
                                push    edi
                                push    esi
                                push    ebx
                                push    ecx
                                push    edx
                                cmp     [ebp+arg_8], 1Eh
                                jb      short loc_401D4D
                                cmp     [ebp+arg_8], 0FFh
                                jnb     short loc_401D4D
                                pop     edx
                                pop     ecx
                                pop     ebx
                                pop     esi
                                pop     edi
                                leave
                                retn    0Ch
                ; ---------------------------------------------------------------------------

                loc_401D4D:                             ; CODE XREF: sub_401D2D+Cj
                                                        ; sub_401D2D+15j
                                cmp     [ebp+arg_8], 0
                                jb      short loc_401D72
                                cmp     [ebp+arg_8], 0FFh
                                jnb     short loc_401D72
                                mov     eax, 32h
                                mul     [ebp+arg_8]
                                add     eax, [ebp+arg_4]
                                lea     edi, [eax+eax*2]
                                add     edi, offset dword_4079A8
                                jmp     short loc_401DB7
                ; ---------------------------------------------------------------------------

                loc_401D72:                             ; CODE XREF: sub_401D2D+24j
                                                        ; sub_401D2D+2Dj
                                mov     ebx, 1Eh
                                dec     ebx
                                jmp     short loc_401DA6
                ; ---------------------------------------------------------------------------

                loc_401D7A:                             ; CODE XREF: sub_401D2D+7Cj
                                mov     eax, 32h
                                mul     ebx
                                add     eax, [ebp+arg_4]
                                lea     edi, [eax+eax*2]
                                add     edi, offset dword_4079A8
                                mov     esi, edi
                                sub     esi, 96h
                                xor     ecx, ecx
                                mov     cl, [esi]
                                mov     [edi], cl
                                mov     byte ptr [edi+1], 1
                                mov     cl, [esi+2]
                                mov     [edi+2], cl
                                dec     ebx

                loc_401DA6:                             ; CODE XREF: sub_401D2D+4Bj
                                cmp     ebx, 0
                                ja      short loc_401D7A
                                mov     eax, [ebp+arg_4]
                                lea     edi, [eax+eax*2]
                                add     edi, offset dword_4079A8

                loc_401DB7:                             ; CODE XREF: sub_401D2D+43j
                                mov     al, [ebp+arg_0]
                                mov     [edi], al
                                mov     byte ptr [edi+1], 1
                                cmp     byte ptr [edi], 0
                                jnz     short loc_401DC7
                                jmp     short loc_401DDE
                ; ---------------------------------------------------------------------------

                loc_401DC7:                             ; CODE XREF: sub_401D2D+96j
                                cmp     [ebp+arg_8], 0
                                jb      short loc_401DDA
                                push    2
                                call    sub_401022
                                inc     eax
                                mov     [edi+2], al
                                jmp     short loc_401DDE
                ; ---------------------------------------------------------------------------

                loc_401DDA:                             ; CODE XREF: sub_401D2D+9Ej
                                mov     byte ptr [edi+2], 0

                loc_401DDE:                             ; CODE XREF: sub_401D2D+98j
                                                        ; sub_401D2D+ABj
                                pop     edx
                                pop     ecx
                                pop     ebx
                                pop     esi
                                pop     edi
                                leave
                                retn    0Ch
                sub_401D2D      endp


               


                sub_401E84      proc near               ; CODE XREF: sub_401FA3+10p
                                push    esi
                                push    edi
                                push    ebx
                                push    ecx
                                push    edx
                                cmp     byte_4076A8, 0
                                jnz     short loc_401EE8
                                mov     eax, 32h
                                shr     eax, 1
                                push    eax
                                call    sub_401022
                                mov     esi, eax
                                jmp     short loc_401EE3
                ; ---------------------------------------------------------------------------

                loc_401EA3:                             ; CODE XREF: sub_401E84+62j
                                push    32h
                                call    sub_401022
                                mov     ebx, eax
                                push    1Eh
                                call    sub_401022
                                mov     edx, 32h
                                mul     edx
                                add     ebx, eax
                                lea     ebx, [ebx+ebx*2]
                                add     ebx, offset dword_4079A8
                                cmp     byte ptr [ebx], 0
                                jz      short loc_401ED0
                                cmp     byte ptr [ebx+2], 0
                                jnz     short loc_401EE2

                loc_401ED0:                             ; CODE XREF: sub_401E84+44j
                                push    dword_4076A3
                                call    sub_401022
                                mov     [ebx+2], al
                                mov     byte ptr [ebx+1], 1

                loc_401EE2:                             ; CODE XREF: sub_401E84+4Aj
                                dec     esi

                loc_401EE3:                             ; CODE XREF: sub_401E84+1Dj
                                cmp     esi, 0
                                ja      short loc_401EA3

                loc_401EE8:                             ; CODE XREF: sub_401E84+Cj
                                xor     esi, esi
                                jmp     loc_401F94
                ; ---------------------------------------------------------------------------

                loc_401EEF:                             ; CODE XREF: sub_401E84+113j
                                mov     eax, 0Ch
                                mul     esi
                                mov     ebx, eax
                                add     ebx, offset dword_407750
                                cmp     dword ptr [ebx], 0
                                ja      loc_401F93
                                push    dword_40769F
                                call    sub_401022
                                cmp     eax, 0
                                jnz     short loc_401F93
                                push    1Eh
                                call    sub_401022
                                add     eax, 3
                                mov     [ebx], eax
                                push    5
                                call    sub_401022
                                mov     ecx, eax
                                push    5
                                call    sub_401022
                                add     eax, ecx
                                mov     [ebx+4], eax
                                push    4
                                call    sub_401022
                                or      eax, eax
                                jz      short loc_401F49
                                mov     dword ptr [ebx], 0

                loc_401F49:                             ; CODE XREF: sub_401E84+BDj
                                push    6
                                call    sub_401022
                                cmp     byte_4076A7, 0
                                jz      short loc_401F6F
                                cmp     byte_4076A8, 0
                                jz      short loc_401F6F
                                or      eax, eax
                                jnz     short loc_401F6F
                                push    2
                                call    sub_401022
                                jmp     short loc_401F76
                ; ---------------------------------------------------------------------------

                loc_401F6F:                             ; CODE XREF: sub_401E84+D3j
                                                        ; sub_401E84+DCj ...
                                xor     eax, eax
                                mov     al, byte_4076A8

                loc_401F76:                             ; CODE XREF: sub_401E84+E9j
                                cmp     al, 1
                                jnz     short loc_401F8C
                                mov     ecx, 1Eh
                                shr     ecx, 1
                                push    ecx
                                call    sub_401022
                                mov     [ebx+8], eax
                                jmp     short loc_401F93
                ; ---------------------------------------------------------------------------

                loc_401F8C:                             ; CODE XREF: sub_401E84+F4j
                                mov     dword ptr [ebx+8], 0FFh

                loc_401F93:                             ; CODE XREF: sub_401E84+7Dj
                                                        ; sub_401E84+91j ...
                                inc     esi

                loc_401F94:                             ; CODE XREF: sub_401E84+66j
                                cmp     esi, 32h
                                jb      loc_401EEF
                                pop     edx
                                pop     ecx
                                pop     ebx
                                pop     edi
                                pop     esi
                                retn
                sub_401E84      endp


                sub_402066      proc near               ; CODE XREF: sub_401FA3+5Ep

                var_C           = dword ptr -0Ch
                var_8           = dword ptr -8
                var_4           = dword ptr -4
                arg_0           = dword ptr  8
                arg_4           = dword ptr  0Ch
                arg_8           = byte ptr  10h
                arg_C           = dword ptr  14h

                                push    ebp
                                mov     ebp, esp
                                add     esp, 0FFFFFFF4h
                                push    esi
                                push    edi
                                push    ebx
                                push    ecx
                                push    edx
                                push    [ebp+arg_0]
                                pop     [ebp+var_4]
                                push    [ebp+arg_4]
                                pop     [ebp+var_8]
                                xor     eax, eax
                                mov     al, [ebp+arg_8]
                                mov     esi, eax
                                shl     esi, 3
                                sub     esi, eax
                                add     esi, offset byte_4074A3
                                xor     ecx, ecx
                                jmp     short loc_4020DB
                ; ---------------------------------------------------------------------------

                loc_402093:                             ; CODE XREF: sub_402066+78j
                                xor     ebx, ebx
                                mov     dl, [esi]
                                jmp     short loc_4020CB
                ; ---------------------------------------------------------------------------

                loc_402099:                             ; CODE XREF: sub_402066+68j
                                shl     dl, 1
                                jnb     short loc_4020A5
                                push    [ebp+arg_C]
                                pop     [ebp+var_C]
                                jmp     short loc_4020AC
                ; ---------------------------------------------------------------------------

                loc_4020A5:                             ; CODE XREF: sub_402066+35j
                                mov     [ebp+var_C], 0

                loc_4020AC:                             ; CODE XREF: sub_402066+3Dj
                                pusha
                                mov     eax, 190h
                                mul     [ebp+var_8]
                                add     eax, [ebp+var_4]
                                shl     eax, 2
                                add     eax, dword_4076A9
                                push    [ebp+var_C]
                                pop     dword ptr [eax]
                                popa
                                inc     ebx
                                inc     [ebp+var_4]

                loc_4020CB:                             ; CODE XREF: sub_402066+31j
                                cmp     ebx, 8
                                jb      short loc_402099
                                inc     esi
                                inc     ecx
                                push    [ebp+arg_0]
                                pop     [ebp+var_4]
                                inc     [ebp+var_8]

                loc_4020DB:                             ; CODE XREF: sub_402066+2Bj
                                cmp     ecx, 7
                                jb      short loc_402093
                                pop     edx
                                pop     ecx
                                pop     ebx
                                pop     edi
                                pop     esi
                                leave
                                retn    10h
                sub_402066      endp

                sub_40305E      proc near               ; CODE XREF: sub_402C7B+38p
                                                        ; sub_402C7B+4Cp ...

                arg_0           = dword ptr  8
                arg_4           = dword ptr  0Ch
                arg_8           = dword ptr  10h
                arg_C           = dword ptr  14h
                arg_10          = dword ptr  18h
                arg_14          = dword ptr  1Ch

                                push    ebp
                                mov     ebp, esp
                                push    ebx
                                push    ecx
                                push    edx
                                push    edi
                                push    esi
                                mov     ebx, 1A8h
                                mov     eax, [ebp+arg_4]
                                mul     ebx
                                add     eax, [ebp+arg_0]
                                shl     eax, 2
                                mov     edi, dword_4070B7
                                add     edi, eax
                                mov     eax, [ebp+arg_14]
                                mul     ebx
                                add     eax, [ebp+arg_10]
                                shl     eax, 2
                                mov     esi, dword_4070BB
                                add     esi, eax
                                mov     edx, [ebp+arg_8]
                                shl     edx, 2
                                xor     ecx, ecx
                                jmp     short loc_4030B0
                ; ---------------------------------------------------------------------------

                loc_40309B:                             ; CODE XREF: sub_40305E+55j
                                push    edx
                                push    esi
                                push    edi
                                call    sub_401000
                                add     edi, 6A0h
                                add     esi, 6A0h
                                inc     ecx

                loc_4030B0:                             ; CODE XREF: sub_40305E+3Bj
                                cmp     ecx, [ebp+arg_C]
                                jnz     short loc_40309B
                                pop     esi
                                pop     edi
                                pop     edx
                                pop     ecx
                                pop     ebx
                                leave
                                retn    18h
                sub_40305E      endp
