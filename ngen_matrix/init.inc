
.data?
bi BITMAPINFO <>

.code
init proc hWnd:dword
                                
                                call GetRes
                                
                                invoke BitmapFromResource,hInstance,1
                                mov  dword_4070AF,eax
                                
                                mov esi,eax
                                push hWnd
                                call GetWindowDC
                                mov edi,eax
                                push eax
                                call CreateCompatibleDC
                                mov     dword_4070B3, eax
                                push esi
                                push eax
                                call SelectObject
                                push    74C40h          ; dwBytes
                                push    40h             ; uFlags
                                call    GlobalAlloc
                                mov     dword_4070BB, eax
                                xor     esi, esi
                                lea     edx, bi;[ebp+var_7C];var_7C          = tagBITMAPINFO ptr -7Ch
                                mov     dword ptr [edx], 28h
                                mov     dword ptr [edx+4], 1A8h
                                mov     dword ptr [edx+8], 11Ah
                                neg     dword ptr [edx+8]
                                mov     word ptr [edx+0Ch], 1
                                mov     word ptr [edx+0Eh], 20h
                                mov     dword ptr [edx+10h], 0
                                mov     [edx+14h], esi
                                mov     [edx+18h], esi
                                mov     [edx+18h], esi
                                mov     [edx+20h], esi
                                mov     [edx+24h], esi
                                mov     [edx+28h], esi
                                push    esi             ; DWORD
                                push    esi             ; HANDLE
                                push    offset dword_4070B7 ; void **
                                push    0               ; UINT
                                push    edx             ; BITMAPINFO *
                                push    dword_4070B3    ; HDC
                                call    CreateDIBSection
                                push    eax             ; HGDIOBJ
                                push    dword_4070B3    ; HDC
                                call    SelectObject
                                push    0               ; UINT
                                lea     eax,bi ;[ebp+var_7C]
                                push    eax             ; LPBITMAPINFO
                                push    dword_4070BB    ; LPVOID
                                push    11Ah            ; UINT
                                push    esi             ; UINT
                                push    dword_4070AF    ; HBITMAP
                                push    edi;[ebp+var_4]     ; HDC
                                call    GetDIBits
                                 push   dword_4070AF
                                 call    DeleteObject
                                call sub_401051
                                
                                call sub_401D07
                                call sub_402C7B
                                
                                
                                
                                push    0               ; lpTimerFunc
                                push    3Ch             ; uElapse
                                push    1               ; nIDEvent
                                push    [hWnd]      ; hWnd
                                call    SetTimer
                                
                           
                                ret
                                
                                init endp


GetRes proc 
        LOCAL hResource         :DWORD
        LOCAL ResSize           :DWORD
        LOCAL lpResBuffer       :DWORD

        invoke FindResource,hInstance,1,RT_RCDATA ;get handle of resource
                mov hResource,eax                               ;preserve handle
        ;       invoke SizeofResource,hInstance,hResource       ;get size of resource
        ;       mov ResSize,eax
                invoke LoadResource,hInstance,hResource
push eax
call LockResource
  mov     dword_40709B, eax
invoke SizeofResource,hInstance,hResource
mov dword_40709F,eax

                                xor     ecx, ecx
                                mov     edx, dword_40709B
                                jmp     short loc_402267
                ; ---------------------------------------------------------------------------

                loc_40224E:                             ; CODE XREF: sub_4021D8+95j
                                cmp     word ptr [edx], 0D0Ah
                                jz      short loc_40225C
                                cmp     word ptr [edx], 0A0Dh
                                jnz     short loc_402265

                loc_40225C:                             ; CODE XREF: sub_4021D8+7Bj
                                add     dword_407073, 8
                                inc     ecx
                                inc     edx

                loc_402265:                             ; CODE XREF: sub_4021D8+82j
                                inc     ecx
                                inc     edx

                loc_402267:                             ; CODE XREF: sub_4021D8+74j
                                cmp     ecx, dword_40709F
                                jnz     short loc_40224E



ret 
                
GetRes endp             
                 


                sub_401051      proc near               ; CODE XREF: sub_4021D8+247p

                var_C           = dword ptr -0Ch
                var_8           = dword ptr -8
                var_4           = dword ptr -4

                                push    ebp
                                mov     ebp, esp
                                add     esp, 0FFFFFFF4h
                                push    esi
                                push    edi
                                push    ebx
                                push    ecx
                                push    edx
                                mov     eax, dword_40706F
                                mul     dword_407073
                                shl     eax, 2
                                push    eax             ; dwBytes
                                push    40h             ; uFlags
                                call    GlobalAlloc
                                mov     dword_4070BF, eax
                                mov     ebx, dword_40709B
                                xor     eax, eax
                                xor     ecx, ecx
                                xor     edx, edx
                                mov     [ebp+var_4], 666666h
                                mov     [ebp+var_8], eax
                                mov     [ebp+var_C], eax
                                jmp     loc_401131
                ; ---------------------------------------------------------------------------

                loc_401095:                             ; CODE XREF: sub_401051+E6j
                                mov     dl, [ebx]
                                cmp     dl, 21h
                                jb      short loc_4010BA
                                cmp     dl, 80h
                                jnb     short loc_4010BA
                                push    [ebp+var_4]
                                mov     al, dl
                                movzx   eax, al
                                push    eax
                                push    [ebp+var_C]
                                push    [ebp+var_8]
                                call    sub_401144
                                add     [ebp+var_8], eax
                                jmp     short loc_40112F
                ; ---------------------------------------------------------------------------

                loc_4010BA:                             ; CODE XREF: sub_401051+49j
                                                        ; sub_401051+4Ej
                                cmp     dl, 20h
                                jnz     short loc_4010C5
                                add     [ebp+var_8], 7
                                jmp     short loc_40112F
                ; ---------------------------------------------------------------------------

                loc_4010C5:                             ; CODE XREF: sub_401051+6Cj
                                cmp     dl, 0A7h
                                jnz     short loc_401117
                                cmp     byte ptr [ebx+1], 30h
                                jnz     short loc_4010D9
                                mov     [ebp+var_4], 0B9B9B9h
                                jmp     short loc_401113
                ; ---------------------------------------------------------------------------

                loc_4010D9:                             ; CODE XREF: sub_401051+7Dj
                                cmp     byte ptr [ebx+1], 31h
                                jnz     short loc_4010E8
                                mov     [ebp+var_4], 0FFFFFFh
                                jmp     short loc_401113
                ; ---------------------------------------------------------------------------

                loc_4010E8:                             ; CODE XREF: sub_401051+8Cj
                                cmp     byte ptr [ebx+1], 32h
                                jnz     short loc_4010F7
                                mov     [ebp+var_4], 0FF0044h
                                jmp     short loc_401113
                ; ---------------------------------------------------------------------------

                loc_4010F7:                             ; CODE XREF: sub_401051+9Bj
                                cmp     byte ptr [ebx+1], 33h
                                jnz     short loc_401106
                                mov     [ebp+var_4], 0FF00h
                                jmp     short loc_401113
                ; ---------------------------------------------------------------------------

                loc_401106:                             ; CODE XREF: sub_401051+AAj
                                cmp     byte ptr [ebx+1], 34h
                                jnz     short loc_401113
                                mov     [ebp+var_4], 6488FFh

                loc_401113:                             ; CODE XREF: sub_401051+86j
                                                        ; sub_401051+95j ...
                                inc     ebx
                                inc     ecx
                                jmp     short loc_40112F
                ; ---------------------------------------------------------------------------

                loc_401117:                             ; CODE XREF: sub_401051+77j
                                cmp     dl, 0Dh
                                jnz     short loc_40112F
                                cmp     byte ptr [ebx+1], 0Ah
                                jnz     short loc_40112F
                                inc     ebx
                                inc     ecx
                                mov     [ebp+var_8], 0
                                add     [ebp+var_C], 8

                loc_40112F:                             ; CODE XREF: sub_401051+67j
                                                        ; sub_401051+72j ...
                                inc     ebx
                                inc     ecx

                loc_401131:                             ; CODE XREF: sub_401051+3Fj
                                cmp     ecx, dword_40709F
                                jnz     loc_401095
                                pop     edx
                                pop     ecx
                                pop     ebx
                                pop     edi
                                pop     esi
                                leave
                                retn
                sub_401051      endp


                sub_401144      proc near               ; CODE XREF: sub_401051+5Fp

                var_8           = dword ptr -8
                var_4           = dword ptr -4
                arg_0           = dword ptr  8
                arg_4           = dword ptr  0Ch
                arg_8           = word ptr  10h
                arg_C           = dword ptr  14h

                                push    ebp
                                mov     ebp, esp
                                add     esp, 0FFFFFFF8h
                                push    esi
                                push    edi
                                push    ebx
                                push    ecx
                                push    edx
                                xor     eax, eax
                                xor     ebx, ebx
                                push    [ebp+arg_0]
                                pop     [ebp+var_4]
                                push    [ebp+arg_4]
                                pop     [ebp+var_8]
                                mov     al, byte ptr [ebp+arg_8]
                                sub     eax, 21h
                                mov     esi, eax
                                shl     esi, 3
                                sub     esi, eax
                                add     esi, offset byte_4070C3
                                xor     ebx, ebx
                                jmp     short loc_4011B5
                ; ---------------------------------------------------------------------------

                loc_401176:                             ; CODE XREF: sub_401144+74j
                                xor     edi, edi
                                mov     dl, [esi]
                                jmp     short loc_4011A5
                ; ---------------------------------------------------------------------------

                loc_40117C:                             ; CODE XREF: sub_401144+64j
                                shl     dl, 1
                                jnb     short loc_40119B
                                pusha
                                mov     eax, 190h
                                mul     [ebp+var_8]
                                add     eax, [ebp+var_4]
                                shl     eax, 2
                                add     eax, dword_4070BF
                                push    [ebp+arg_C]
                                pop     dword ptr [eax]
                                popa

                loc_40119B:                             ; CODE XREF: sub_401144+3Aj
                                or      dl, dl
                                jnz     short loc_4011A1
                                jmp     short loc_4011AA
                ; ---------------------------------------------------------------------------

                loc_4011A1:                             ; CODE XREF: sub_401144+59j
                                inc     edi
                                inc     [ebp+var_4]

                loc_4011A5:                             ; CODE XREF: sub_401144+36j
                                cmp     edi, 8
                                jb      short loc_40117C

                loc_4011AA:                             ; CODE XREF: sub_401144+5Bj
                                inc     esi
                                inc     ebx
                                push    [ebp+arg_0]
                                pop     [ebp+var_4]
                                inc     [ebp+var_8]

                loc_4011B5:                             ; CODE XREF: sub_401144+30j
                                cmp     ebx, 7
                                jb      short loc_401176
                                cmp     [ebp+arg_8], 21h
                                jz      short loc_401207
                                cmp     [ebp+arg_8], 27h
                                jz      short loc_401207
                                cmp     [ebp+arg_8], 2Ch
                                jz      short loc_401207
                                cmp     [ebp+arg_8], 2Eh
                                jz      short loc_401207
                                cmp     [ebp+arg_8], 2Ah
                                jz      short loc_401207
                                cmp     [ebp+arg_8], 3Ah
                                jz      short loc_401207
                                cmp     [ebp+arg_8], 3Bh
                                jz      short loc_401207
                                cmp     [ebp+arg_8], 49h
                                jz      short loc_401207
                                cmp     [ebp+arg_8], 69h
                                jz      short loc_401207
                                cmp     [ebp+arg_8], 6Ch
                                jz      short loc_401207
                                cmp     [ebp+arg_8], 7Ch
                                jnz     short loc_401211

                loc_401207:                             ; CODE XREF: sub_401144+7Bj
                                                        ; sub_401144+82j ...
                                mov     eax, 3
                                jmp     loc_4012EE
                ; ---------------------------------------------------------------------------

                loc_401211:                             ; CODE XREF: sub_401144+C1j
                                cmp     [ebp+arg_8], 31h
                                jnz     short loc_401222
                                mov     eax, 4
                                jmp     loc_4012EE
                ; ---------------------------------------------------------------------------

                loc_401222:                             ; CODE XREF: sub_401144+D2j
                                cmp     [ebp+arg_8], 28h
                                jz      short loc_401261
                                cmp     [ebp+arg_8], 29h
                                jz      short loc_401261
                                cmp     [ebp+arg_8], 3Ch
                                jz      short loc_401261
                                cmp     [ebp+arg_8], 3Eh
                                jz      short loc_401261
                                cmp     [ebp+arg_8], 5Bh
                                jz      short loc_401261
                                cmp     [ebp+arg_8], 5Dh
                                jz      short loc_401261
                                cmp     [ebp+arg_8], 5Eh
                                jz      short loc_401261
                                cmp     [ebp+arg_8], 60h
                                jz      short loc_401261
                                cmp     [ebp+arg_8], 6Ah
                                jnz     short loc_40126B

                loc_401261:                             ; CODE XREF: sub_401144+E3j
                                                        ; sub_401144+EAj ...
                                mov     eax, 5
                                jmp     loc_4012EE
                ; ---------------------------------------------------------------------------

                loc_40126B:                             ; CODE XREF: sub_401144+11Bj
                                cmp     [ebp+arg_8], 22h
                                jz      short loc_4012A3
                                cmp     [ebp+arg_8], 23h
                                jz      short loc_4012A3
                                cmp     [ebp+arg_8], 2Ah
                                jz      short loc_4012A3
                                cmp     [ebp+arg_8], 2Bh
                                jz      short loc_4012A3
                                cmp     [ebp+arg_8], 2Dh
                                jz      short loc_4012A3
                                cmp     [ebp+arg_8], 7Bh
                                jz      short loc_4012A3
                                cmp     [ebp+arg_8], 7Dh
                                jz      short loc_4012A3
                                cmp     [ebp+arg_8], 7Eh
                                jnz     short loc_4012AA

                loc_4012A3:                             ; CODE XREF: sub_401144+12Cj
                                                        ; sub_401144+133j ...
                                mov     eax, 6
                                jmp     short loc_4012EE
                ; ---------------------------------------------------------------------------

                loc_4012AA:                             ; CODE XREF: sub_401144+15Dj
                                cmp     [ebp+arg_8], 26h
                                jnz     short loc_4012B8
                                mov     eax, 8
                                jmp     short loc_4012EE
                ; ---------------------------------------------------------------------------

                loc_4012B8:                             ; CODE XREF: sub_401144+16Bj
                                cmp     [ebp+arg_8], 24h
                                jz      short loc_4012E2
                                cmp     [ebp+arg_8], 40h
                                jz      short loc_4012E2
                                cmp     [ebp+arg_8], 4Dh
                                jz      short loc_4012E2
                                cmp     [ebp+arg_8], 57h
                                jz      short loc_4012E2
                                cmp     [ebp+arg_8], 6Dh
                                jz      short loc_4012E2
                                cmp     [ebp+arg_8], 77h
                                jnz     short loc_4012E9

                loc_4012E2:                             ; CODE XREF: sub_401144+179j
                                                        ; sub_401144+180j ...
                                mov     eax, 9
                                jmp     short loc_4012EE
                ; ---------------------------------------------------------------------------

                loc_4012E9:                             ; CODE XREF: sub_401144+19Cj
                                mov     eax, 7

                loc_4012EE:                             ; CODE XREF: sub_401144+C8j
                                                        ; sub_401144+D9j ...
                                pop     edx
                                pop     ecx
                                pop     ebx
                                pop     edi
                                pop     esi
                                leave
                                retn    10h
                sub_401144      endp


                sub_401D07      proc near               ; CODE XREF: sub_4021D8+371p
                                push    edi
                                push    esi
                                push    ebx
                                push    ecx
                                push    edx
                                push    52080h          ; dwBytes
                                push    40h             ; uFlags
                                call    GlobalAlloc
                                mov     dword_4076A9, eax
                                call    GetTickCount
                                mov     dword_40769B, eax
                                pop     edx
                                pop     ecx
                                pop     ebx
                                pop     esi
                                pop     edi
                                retn
                sub_401D07      endp

                
                
                
