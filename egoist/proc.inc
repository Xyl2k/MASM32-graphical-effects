              ; Attributes: bp-based frame

               ; DWORD __stdcall StartAddress(LPVOID)
               StartAddress    proc near               ; DATA XREF: sub_401900+9o


                               push    ebp
                               mov     ebp, esp
                               add     esp, 0FFFFFFD0h
                              
                               push    @hWnd            ; hWnd
                               call    GetDC
                               mov     [ebp-4], eax
                               push    0               ; hWnd
                               call    GetDC
                               push    eax             ; HDC
                               call    CreateCompatibleDC
                               mov     dword_4073BB, eax
                               
                               
                               push    2000            ; lpBitmapName
                               push    hInstance
                               call    LoadBitmapA
                               
                               mov    dword_4073BF, eax
                               push    eax             ; HGDIOBJ
                               push    dword_4073BB    ; HDC
                               call    SelectObject

                               push    offset stru_4073C3 ; LOGFONTA *
                               call    CreateFontIndirectA
                               mov     dword_4073B7, eax
                               push    eax             ; HGDIOBJ
                               push    dword_4073BB    ; HDC
                               call    SelectObject
                               push    0               ; COLORREF
                               push    dword_4073BB    ; HDC
                               call    SetTextColor
                               push    0FFFFFFh        ; COLORREF
                               push    dword_4073BB    ; HDC
                               call    SetBkColor
                               push    1               ; int
                               push    dword_4073BB    ; HDC
                               call    SetBkMode
                               push    1               ; int
                               push    dword ptr[ebp+var_4]     ; HDC
                               call    SetBkMode
                               mov     dword ptr[ebp-8], 9Ch
                               lea     eax,dword ptr [ebp-18h]
                               push    eax             ; LPSIZE
                               push    dword ptr[ebp-8]     ; int
                               push    offset aTsrhTeamPresen ; "TSRh TeaM Presents: PaperBall 1.04 *keY"...
                               push    dword_4073BB    ; HDC
                               call    GetTextExtentPoint32A
                               
                               push    122h
                               pop     [ebp-0Ch]
                               
                               
                               lea     eax, [ebp-18h]
                               push    dword ptr [eax]
                               pop     dword ptr[ebp-1Ch]
                               neg     dword ptr[ebp-1Ch]
                               sub     dword ptr[ebp-1Ch], 14h
                               push    dword ptr[ebp-0Ch]
                               pop     dword ptr[ebp-10h]
                               push    dword_4073BF    ; HBITMAP
                               call    CreatePatternBrush
                               mov     hbr, eax
                               push    offset stru_407403 ; LPPOINT
                               push    dword_4073BB    ; HDC
                               call    GetBrushOrgEx
                               push    offset stru_407403 ; LPPOINT
                               push    0FFFFFFFCh      ; int
                               push    0FFFFFFE7h      ; int
                               push    dword_4073BB    ; HDC
                               call    SetBrushOrgEx
                               mov     dword ptr[ebp-30h], 0
                               mov     dword ptr[ebp-2ch], 0
                               mov     dword ptr[ebp-28h], 136h
                               mov     dword ptr[ebp-24h], 28h

               loc_401875:                             ; CODE XREF: StartAddress:loc_4018F9j
                               lea     eax, dword ptr[ebp-30h]
                               push    hbr             ; hbr
                               push    eax             ; lprc
                               push    dword_4073BB    ; hDC
                               call    FillRect
                               push    dword ptr[ebp-8]     ; int
                               push    offset aTsrhTeamPresen ; "TSRh TeaM Presents: PaperBall 1.04 *keY"...
                               push    2               ; int
                               push    dword ptr[ebp-10h]    ; int
                               push    dword_4073BB    ; HDC
                               call    TextOutA
                               push    0FFFFFFh        ; int
                               push    0               ; int
                               push    10Eh            ; int
                               push    0               ; int
                               push    14h             ; int
                               push    14h             ; int
                               push    dword_4073BB    ; HDC
                               call    sub_401580
                               push    0CC0020h        ; DWORD
                               push    0               ; int
                               push    0               ; int
                               push    dword_4073BB    ; HDC
                               push    14h             ; int
                               push    122h            ; int
                               push    4               ; int
                               push    19h             ; int
                               push    dword ptr[ebp-4]     ; HDC
                               call    BitBlt
                               push    15h             ; dwMilliseconds
                               call    Sleep
                               dec     dword ptr[ebp-10h]
                               mov     eax,dword ptr [ebp-10h]
                               cmp     eax,dword ptr [ebp-1Ch]
                               jnz     short loc_4018F9
                               push    dword ptr[ebp-0Ch]
                               pop     dword ptr[ebp-10h]

               loc_4018F9:                             ; CODE XREF: StartAddress+1D7j
                               jmp     loc_401875
               
                               leave
                               retn

               StartAddress    endp
               
               
               
               
               ; --------------- S U B R O U T I N E ---------------------------------------

               ; Attributes: bp-based frame

               ; int __stdcall sub_401580(HDC,int,int,int,int,int,int)
               sub_401580      proc near               ; CODE XREF: StartAddress+1A0p

               var_11          = byte ptr -11h
               var_10          = dword ptr -10h
               var_C           = dword ptr -0Ch
               var_6           = byte ptr -6
               var_5           = byte ptr -5
               var_4           = byte ptr -4
               var_3           = byte ptr -3
               var_2           = byte ptr -2
               var_1           = byte ptr -1
               arg_0           = dword ptr  8
               arg_4           = dword ptr  0Ch
               arg_8           = dword ptr  10h
               arg_C           = dword ptr  14h
               arg_10          = dword ptr  18h
               arg_14          = dword ptr  1Ch
               arg_18          = dword ptr  20h

                               push    ebp
                               mov     ebp, esp
                               add     esp, 0FFFFFFECh
                               mov     eax, [ebp+arg_14]
                               mov     ebx, [ebp+arg_18]
                               mov     ecx, [ebp+arg_4]
                               mov     [ebp+var_4], bl
                               ror     ebx, 8
                               mov     [ebp+var_5], bl
                               ror     ebx, 8
                               mov     [ebp+var_6], bl
                               rol     ebx, 10h
                               sub     al, bl
                               jnb     short loc_4015A7
                               neg     al

               loc_4015A7:                             ; CODE XREF: sub_401580+23j
                               mov     esi, eax
                               xor     ah, ah
                               div     cl
                               mov     [ebp+var_1], al
                               mov     eax, esi
                               shr     eax, 8
                               shr     ebx, 8
                               sub     al, bl
                               jnb     short loc_4015BE
                               neg     al

               loc_4015BE:                             ; CODE XREF: sub_401580+3Aj
                               mov     esi, eax
                               xor     ah, ah
                               div     cl
                               mov     [ebp+var_2], al
                               mov     eax, esi
                               shr     eax, 8
                               shr     ebx, 8
                               sub     al, bl
                               jnb     short loc_4015D5
                               neg     al

               loc_4015D5:                             ; CODE XREF: sub_401580+51j
                               mov     esi, eax
                               xor     ah, ah
                               div     cl
                               mov     [ebp+var_3], al
                               mov     eax, esi
                               mov     [ebp+var_C], 0
                               mov     [ebp+var_10], 0
                               mov     [ebp+var_11], 0

               loc_4015F2:                             ; CODE XREF: sub_401580+16Dj
                                                       ; sub_401580:loc_401711j
                               cmp     [ebp+var_11], 0
                               jnz     short loc_401600
                               mov     eax, [ebp+arg_C]
                               add     eax, [ebp+var_C]
                               jmp     short loc_401606
               ; ---------------------------------------------------------------------------

               loc_401600:                             ; CODE XREF: sub_401580+76j
                               mov     eax, [ebp+arg_10]
                               add     eax, [ebp+var_C]

               loc_401606:                             ; CODE XREF: sub_401580+7Ej
                               push    [ebp+var_10]    ; int
                               push    eax             ; int
                               push    [ebp+arg_0]     ; HDC
                               call    GetPixel
                               cmp     eax, [ebp+arg_14]
                               jnz     loc_4016E3
                               xor     edx, edx
                               cmp     al, [ebp+var_6]
                               jz      short loc_40164E
                               push    eax
                               cmp     [ebp+var_11], 0
                               jnz     short loc_401631
                               mov     ebx, [ebp+arg_4]
                               sub     ebx, [ebp+var_C]
                               jmp     short loc_401634
               ; ---------------------------------------------------------------------------

               loc_401631:                             ; CODE XREF: sub_401580+A7j
                               mov     ebx, [ebp+var_C]

               loc_401634:                             ; CODE XREF: sub_401580+AFj
                               mov     al, [ebp+var_3]
                               xor     ah, ah
                               mul     bl
                               mov     bl, al
                               pop     eax
                               cmp     al, [ebp+var_6]
                               jnb     short loc_401647
                               add     al, bl
                               jmp     short loc_40164E
               ; ---------------------------------------------------------------------------

               loc_401647:                             ; CODE XREF: sub_401580+C1j
                               cmp     al, [ebp+var_6]
                               jbe     short loc_40164E
                               sub     al, bl

               loc_40164E:                             ; CODE XREF: sub_401580+A0j
                                                       ; sub_401580+C5j ...
                               or      dl, al
                               shl     edx, 8
                               shr     eax, 8
                               cmp     al, [ebp+var_5]
                               jz      short loc_401687
                               push    eax
                               cmp     [ebp+var_11], 0
                               jnz     short loc_40166A
                               mov     ebx, [ebp+arg_4]
                               sub     ebx, [ebp+var_C]
                               jmp     short loc_40166D
               ; ---------------------------------------------------------------------------

               loc_40166A:                             ; CODE XREF: sub_401580+E0j
                               mov     ebx, [ebp+var_C]

               loc_40166D:                             ; CODE XREF: sub_401580+E8j
                               mov     al, [ebp+var_2]
                               xor     ah, ah
                               mul     bl
                               mov     bl, al
                               pop     eax
                               cmp     al, [ebp+var_5]
                               jnb     short loc_401680
                               add     al, bl
                               jmp     short loc_401687
               ; ---------------------------------------------------------------------------

               loc_401680:                             ; CODE XREF: sub_401580+FAj
                               cmp     al, [ebp+var_5]
                               jbe     short loc_401687
                               sub     al, bl

               loc_401687:                             ; CODE XREF: sub_401580+D9j
                                                       ; sub_401580+FEj ...
                               or      dl, al
                               shl     edx, 8
                               shr     eax, 8
                               cmp     al, [ebp+var_4]
                               jz      short loc_4016C0
                               push    eax
                               cmp     [ebp+var_11], 0
                               jnz     short loc_4016A3
                               mov     ebx, [ebp+arg_4]
                               sub     ebx, [ebp+var_C]
                               jmp     short loc_4016A6
               ; ---------------------------------------------------------------------------

               loc_4016A3:                             ; CODE XREF: sub_401580+119j
                               mov     ebx, [ebp+var_C]

               loc_4016A6:                             ; CODE XREF: sub_401580+121j
                               mov     al, [ebp+var_1]
                               xor     ah, ah
                               mul     bl
                               mov     bl, al
                               pop     eax
                               cmp     al, [ebp+var_4]
                               jnb     short loc_4016B9
                               add     al, bl
                               jmp     short loc_4016C0
               ; ---------------------------------------------------------------------------

               loc_4016B9:                             ; CODE XREF: sub_401580+133j
                               cmp     al, [ebp+var_4]
                               jbe     short loc_4016C0
                               sub     al, bl

               loc_4016C0:                             ; CODE XREF: sub_401580+112j
                                                       ; sub_401580+137j ...
                               or      dl, al
                               cmp     [ebp+var_11], 0
                               jnz     short loc_4016D0
                               mov     eax, [ebp+arg_C]
                               add     eax, [ebp+var_C]
                               jmp     short loc_4016D6
               ; ---------------------------------------------------------------------------

               loc_4016D0:                             ; CODE XREF: sub_401580+146j
                               mov     eax, [ebp+arg_10]
                               add     eax, [ebp+var_C]

               loc_4016D6:                             ; CODE XREF: sub_401580+14Ej
                               push    edx             ; COLORREF
                               push    [ebp+var_10]    ; int
                               push    eax             ; int
                               push    [ebp+arg_0]     ; HDC
                               call    SetPixel

               loc_4016E3:                             ; CODE XREF: sub_401580+95j
                               xor     [ebp+var_11], 1
                               cmp     [ebp+var_11], 1
                               jnz     short loc_4016F2
                               jmp     loc_4015F2
               ; ---------------------------------------------------------------------------

               loc_4016F2:                             ; CODE XREF: sub_401580+16Bj
                               inc     [ebp+var_C]
                               mov     eax, [ebp+var_C]
                               cmp     eax, [ebp+arg_4]
                               jnz     short loc_401711
                               mov     [ebp+var_C], 0
                               inc     [ebp+var_10]
                               mov     eax, [ebp+var_10]
                               cmp     eax, [ebp+arg_8]
                               jnz     short loc_401711
                               jmp     short locret_401716
               ; ---------------------------------------------------------------------------

               loc_401711:                             ; CODE XREF: sub_401580+17Bj
                                                       ; sub_401580+18Dj
                               jmp     loc_4015F2
               ; ---------------------------------------------------------------------------

               locret_401716:                          ; CODE XREF: sub_401580+18Fj
                               leave
                               retn    1Ch
               sub_401580      endp

