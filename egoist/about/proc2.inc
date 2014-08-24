              ; --------------- S U B R O U T I N E ---------------------------------------


               sub_40210C      proc near               ; CODE XREF: DialogFunc+61p
                               push    edi
                               push    esi
                               push    ebx
                               cld
                               mov     edi, dword_40779F
                               mov     ecx, 0A6A0h
                               xor     ebx, ebx
                               xor     esi, esi

               loc_40211F:                             ; CODE XREF: sub_40210C+4Cj
                               or      ebx, ebx
                               jz      short loc_402134
                               or      esi, esi
                               jz      short loc_402134
                               cmp     ebx, 157h
                               jz      short loc_402134
                               cmp     esi, 7Bh
                               jnz     short loc_402138

               loc_402134:                             ; CODE XREF: sub_40210C+15j
                                                       ; sub_40210C+19j ...
                               xor     eax, eax
                               jmp     short loc_40214A
               ; ---------------------------------------------------------------------------

               loc_402138:                             ; CODE XREF: sub_40210C+26j
                               push    ecx
                               push    28h
                               call    sub_401B0B
                               add     al, 9
                               mov     ah, al
                               shl     eax, 8
                               mov     al, ah
                               pop     ecx

               loc_40214A:                             ; CODE XREF: sub_40210C+2Aj
                               stosd
                               inc     ebx
                               cmp     ebx, 158h
                               jnz     short loc_402157
                               xor     ebx, ebx
                               inc     esi

               loc_402157:                             ; CODE XREF: sub_40210C+46j
                               dec     ecx
                               jnz     short loc_40211F
                               call    sub_4021F2
                               xor     ecx, ecx
                               cmp     dword_4077AF, ecx
                               jnb     short loc_402177
                               inc     dword_4077AF
                               inc     dword_4077A7
                               jmp     short loc_402181
               ; ---------------------------------------------------------------------------

               loc_402177:                             ; CODE XREF: sub_40210C+5Bj
                               mov     dword_4077AF, 0

               loc_402181:                             ; CODE XREF: sub_40210C+69j
                               cld
                               dec     dword_4077A7
                               add     eax, eax
                               not     eax
                               cmp     dword_4077A7, eax
                               jnz     short loc_4021CD
                               mov     edi, lpString
                               xor     eax, eax
                               or      ecx, 0FFFFFFFFh
                               repne scasb
                               cmp     byte ptr [edi], 0
                               jz      short loc_4021AE
                               mov     lpString, edi
                               jmp     short loc_4021C3
               ; ---------------------------------------------------------------------------

               loc_4021AE:                             ; CODE XREF: sub_40210C+98j
                               push    offset aTsrhTeamProudl ; "   TSRh TeaM Proudly Presents a keYgen "...
                               pop     lpString
                               mov     dword_4077AB, 0

               loc_4021C3:                             ; CODE XREF: sub_40210C+A0j
                               mov     dword_4077A7, 7Ch

               loc_4021CD:                             ; CODE XREF: sub_40210C+86j
                               pop     ebx
                               pop     esi
                               pop     edi
                               retn
               sub_40210C      endp




               sub_401B0B      proc near               ; CODE XREF: sub_40210C+2Fp
                                                       ; sub_4022D0+47p ...

               arg_0           = dword ptr  8

                               push    ebp
                               mov     ebp, esp
                               push    edx
                               push    ecx
                               mov     eax, dword_407436
                               xor     edx, edx
                               mov     ecx, 1F31Dh
                               div     ecx
                               mov     ecx, eax
                               mov     eax, 41A7h
                               mul     edx
                               mov     edx, ecx
                               mov     ecx, eax
                               mov     eax, 0B14h
                               mul     edx
                               sub     ecx, eax
                               xor     edx, edx
                               mov     eax, ecx
                               mov     dword_407436, ecx
                               div     [ebp+arg_0]
                               mov     eax, edx
                               pop     ecx
                               pop     edx
                               leave
                               retn    4
               sub_401B0B      endp


              sub_4021F2      proc near               ; CODE XREF: sub_40210C+4Ep

               var_4           = dword ptr -4

                               push    ebp
                               mov     ebp, esp
                               add     esp, 0FFFFFFFCh
                               push    esi
                               push    edi
                               push    ebx
                               mov     esi, lpString
                               push    esi             ; lpString
                               call    lstrlenA
                               mov     ebx, eax
                               inc     ebx
                               push    dword_4077A7
                               pop     [ebp+var_4]
                               mov     edi, esi

               loc_402215:                             ; CODE XREF: sub_4021F2+57j
                               cmp     byte ptr [esi], 0Dh
                               jz      short loc_40221F
                               cmp     byte ptr [esi], 0
                               jnz     short loc_402247

               loc_40221F:                             ; CODE XREF: sub_4021F2+26j
                               mov     cl, [esi]
                               push    ecx
                               mov     byte ptr [esi], 0
                               push    edi             ; lpString
                               call    lstrlenA
                               push    eax             ; int
                               push    edi             ; LPCSTR
                               push    [ebp+var_4]     ; int
                               push    0Ah             ; int
                               push    dword_4077A3    ; HDC
                               call    TextOutA
                               add     [ebp+var_4], 0Fh
                               pop     ecx
                               mov     edi, esi
                               inc     edi
                               mov     [esi], cl

               loc_402247:                             ; CODE XREF: sub_4021F2+2Bj
                               lodsb
                               dec     ebx
                               jnz     short loc_402215
                               mov     eax, [ebp+var_4]
                               sub     eax, dword_4077A7
                               shr     eax, 1
                               pop     ebx
                               pop     edi
                               pop     esi
                               leave
                               retn
               sub_4021F2      endp
