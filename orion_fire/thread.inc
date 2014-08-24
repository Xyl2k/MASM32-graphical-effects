              ; DWORD __stdcall StartAddress(LPVOID)
              StartAddress    proc near               ; DATA XREF: sub_4010F0+1CAo

              var_4           = dword ptr -4
              hWnd$            = dword ptr  4

                              push    ecx
                              mov     eax,[esp+4+hWnd$]
                              push    ebx
                              push    ebp
                              push    esi
                              push    edi
                              xor     ebx, ebx
                              push    eax             ; hWnd
                              mov     [esp+18h+var_4], ebx
                              call    GetDC
                              ;mov     ebp, StretchBlt
                              mov     [esp+14h+hWnd$], eax

              loc_401310:                             ; CODE XREF: StartAddress+1AAj
                              test    bl, 7
                              jz      loc_401452

              loc_401319:                             ; CODE XREF: StartAddress+15Cj
                              mov     edi, offset dword_420358
                              mov     eax, offset word_416756

              loc_401323:                             ; CODE XREF: StartAddress+AEj
                              
                            
                             
                              
                              xor     esi, esi

              loc_401325:                             ; CODE XREF: StartAddress+A4j
                              xor     ecx, ecx
                              xor     edx, edx
                              mov     cl, [eax+294h]
                              mov     dl, [eax+295h]
                              add     esi, 4
                              lea     ecx, [edx+ecx*8]
                              xor     edx, edx
                              mov     dl, [eax+293h]
                              add     ecx, edx
                              xor     edx, edx
                              mov     dl, [eax+14Bh]
                              add     ecx, edx
                              xor     edx, edx
                              mov     dl, [eax+149h]
                              add     ecx, edx
                              xor     edx, edx
                              mov     dl, [eax-1]
                              add     ecx, edx
                              xor     edx, edx
                              mov     dl, [eax]
                              add     ecx, edx
                              xor     edx, edx
                              mov     dl, [eax+1]
                              add     ecx, edx
                              xor     edx, edx
                              mov     dl, [eax+14Ah]
                              add     ecx, edx
                              mov     edx, [edi]
                              shr     ecx, 4
                              mov     [eax+14Ah], cl
                              inc     eax
                              mov     ecx, dword_41620C[ecx*4]
                              cmp     esi, 528h
                              mov     [esi+edx-4], ecx
                              jl      short loc_401325
                              add     edi, 4
                              cmp     eax, offset word_41E83E
                              jl       loc_401323
                              mov     eax, offset word_41E83E

              loc_4013A5:                             ; CODE XREF: StartAddress+11Bj
                            
                              mov     esi, 14Ah

              loc_4013AA:                             ; CODE XREF: StartAddress+114j
                              xor     edx, edx
                              xor     ecx, ecx
                              mov     dl, [eax+294h]
                              mov     cl, [eax+295h]
                              lea     edx, [ecx+edx*8]
                              xor     ecx, ecx
                              mov     cl, [eax+293h]
                              add     edx, ecx
                              xor     ecx, ecx
                              mov     cl, [eax+14Bh]
                              add     edx, ecx
                              xor     ecx, ecx
                              mov     cl, [eax+149h]
                              add     edx, ecx
                              xor     ecx, ecx
                              mov     cl, [eax-1]
                              add     edx, ecx
                              xor     ecx, ecx
                              mov     cl, [eax+1]
                              add     edx, ecx
                              xor     ecx, ecx
                              mov     cl, [eax+14Ah]
                              add     edx, ecx
                              xor     ecx, ecx
                              mov     cl, [eax]
                              add     edx, ecx
                              shr     edx, 4
                              mov     [eax+14Ah], dl
                              inc     eax
                              dec     esi
                              jnz     short loc_4013AA
                              cmp     eax, offset dword_41FE28
                              jl      short loc_4013A5
                              mov     eax, [esp+14h+var_4]
                              mov     edx, dword_420538
                              mov     ecx, dword_41508C
                              push    0CC0020h        ; DWORD
                              inc     eax
                              push    64h             ; int
                              push    14Ah            ; int
                              mov     [esp+20h+var_4], eax
                              mov     eax, dword_415090
                              push    0               ; int
                              push    0               ; int
                              push    edx             ; HDC
                              mov     edx, [esp+2Ch+hWnd$]
                              push    eax             ; int
                              push    ecx             ; int
                              push    50;0A2h  y pos          ; int
                              push    0  ;    x pos             ; int
                              push    edx             ; HDC
                              call    StretchBlt
                              inc     ebx
                              test    bl, 7
                              jnz     loc_401319

              loc_401452:                             ; CODE XREF: StartAddress+23j
                              inc     ebx
                              mov     esi, 1

              loc_401458:                             ; CODE XREF: StartAddress+1A8j
                              
                             
                              call    _rand
                              test    al, 8
                              jz      short loc_401489
                              and     eax, 7
                              mov     ecx, eax
                              dec     eax
                              test    ecx, ecx
                              jz      short loc_401491
                              mov     cl, byte ptr dword_415094

              loc_401471:                             ; CODE XREF: StartAddress+195j
                              cmp     esi, 14Ah
                              jge     short loc_401491
                              mov     byte_41FF72[esi], cl
                              inc     esi
                              mov     edx, eax
                              dec     eax
                              test    edx, edx
                              jnz     short loc_401471
                              jmp     short loc_401491
              ; ---------------------------------------------------------------------------

              loc_401489:                             ; CODE XREF: StartAddress+16Fj
                              mov     byte_41FF72[esi], 0
                              inc     esi

              loc_401491:                             ; CODE XREF: StartAddress+179j
                                                      ; StartAddress+187j ...
                              inc     esi
                              cmp     esi, 14Ah
                              jb      short loc_401458
                              
                              invoke Sleep,10;<-------- free CPU
                              jmp     loc_401310
              StartAddress    endp

              

              _rand           proc near               ; CODE XREF: StartAddress:loc_401458p
                                                      ; sub_4075F0+14A0p ...
                              mov     eax, dword_4152EC
                              imul    eax, 343FDh
                              add     eax, 269EC3h
                              mov     dword_4152EC, eax
                              sar     eax, 10h
                              and     eax, 7FFFh
                              retn
              _rand           endp
