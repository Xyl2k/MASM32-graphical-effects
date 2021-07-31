  .686              
 .MMX               
                
                ; DWORD __stdcall StartAddress(LPVOID)
                StartAddress    proc near               ; DATA XREF: sub_401133+76o

                hWnd$            = dword ptr  8

                                push    ebp
                                mov     ebp, esp
                                push    esi
                                push    edi
                                push    ebx

                loc_401B19:                             ; CODE XREF: StartAddress+7Fj
                                call    GdiFlush
                                mov     ecx, 32h
                                mov     edi, offset dword_404588

                loc_401B28:                             ; CODE XREF: StartAddress+67j
                                mov     eax, [edi+10h]
                                xadd    [edi], eax
                                cmp     eax, 0FAh
                                jb      short loc_401B45
                                push    22h
                                call    sub_401BDC
                                mov     [edi+4], eax
                                mov     dword ptr [edi], 3

                loc_401B45:                             ; CODE XREF: StartAddress+20j
                                push    ecx
                                push    dword ptr [edi+10h]
                                push    0
                                push    dword ptr [edi+0Ch]
                                push    dword ptr [edi+8]
                                call    sub_401B94
                                push    dword ptr [edi]
                                push    dword ptr [edi+4]
                                pop     dword ptr [edi+0Ch]
                                pop     dword ptr [edi+8]
                                imul    eax, [edi+10h], 555555h
                                push    dword ptr [edi+10h]
                                push    eax
                                push    dword ptr [edi+4]
                                push    dword ptr [edi]
                                call    sub_401B94
                                pop     ecx
                                add     edi, 14h
                                loop    loc_401B28
                                push    0               ; bErase
                                push    offset Rect     ; lpRect
                                push    [ebp+hWnd$]      ; hWnd
                                call    InvalidateRect
                                push    32h             ; dwMilliseconds
                                call    Sleep
                                jmp     short loc_401B19
                StartAddress    endp


                ; --------------- S U B R O U T I N E ---------------------------------------

                ; Attributes: bp-based frame

                sub_401BDC      proc near               ; CODE XREF: sub_401ADD+Fp
                                                        ; sub_401ADD+1Bp ...

                arg_0           = dword ptr  8

                                push    ebp
                                mov     ebp, esp
                                push    edi
                                push    esi
                                push    ebx
                                push    ecx
                                mov     ecx, [ebp+arg_0]
                                mov     eax, dword_4044A9
                                mov     ebx, dword_4044A5
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
                                mov     dword_4044A5, ebx
                                mov     dword_4044A9, eax
                                xor     edx, edx
                                div     ecx
                                mov     eax, edx
                                jnz     short loc_401C28
                                inc     eax

                loc_401C28:                             ; CODE XREF: sub_401BDC+49j
                                pop     ecx
                                pop     ebx
                                pop     esi
                                pop     edi
                                leave
                                retn    4
                sub_401BDC      endp



                sub_401B94      proc near               ; CODE XREF: StartAddress+3Ep
                                                        ; StartAddress+5Ep

                arg_0           = dword ptr  8
                arg_4           = dword ptr  0Ch
                arg_8           = dword ptr  10h
                arg_C           = dword ptr  14h

                                push    ebp
                                mov     ebp, esp
                                push    [ebp+arg_8]
                                push    [ebp+arg_4]
                                push    [ebp+arg_0]
                                push    dword_404574
                                call    sub_401ABA
                                mov     edx, [ebp+arg_8]
                                mov     [eax+4], edx
                                mov     [eax-4], edx
                                mov     [eax+3FCh], edx
                                mov     [eax-3FCh], edx
                                cmp     [ebp+arg_C], 3
                                jb      short locret_401BD8
                                mov     [eax+8], edx
                                mov     [eax-8], edx
                                mov     [eax+7F8h], edx
                                mov     [eax-7F8h], edx

                locret_401BD8:                          ; CODE XREF: sub_401B94+30j
                                leave
                                retn    10h
                sub_401B94      endp



               sub_401ABA      proc near               ; CODE XREF: sub_401B94+12p

                arg_0           = dword ptr  8
                arg_4           = dword ptr  0Ch
                arg_8           = dword ptr  10h
                arg_C           = dword ptr  14h

                                push    ebp
                                mov     ebp, esp
                                mov     eax, 25h
                                sub     eax, [ebp+arg_8]
                                imul    eax, 0FFh
                                add     eax, [ebp+arg_4]
                                mov     ebx, [ebp+arg_0]
                                mov     ecx, [ebp+arg_C]
                                lea     eax, [ebx+eax*4]
                                mov     [eax], ecx
                                leave
                                retn    10h
                sub_401ABA      endp

