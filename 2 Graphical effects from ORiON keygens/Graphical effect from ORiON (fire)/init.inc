              ; int __cdecl sub_4010F0(LPVOID lpParameter)
              sub_4010F0      proc near               ; CODE XREF: sub_401590+361p

              var_C           = dword ptr -0Ch
              var_8           = dword ptr -8
              hDC             = dword ptr -4
              lpParameter     = dword ptr  4

                              sub     esp, 0Ch
                              mov     eax,[esp+0Ch+lpParameter]
                              push    ebx
                              push    ebp
                              push    esi
                              push    edi
                              push    eax             ; hWnd
                              call    GetDC
                              mov     esi, eax
                              mov     ecx, 0Bh
                              xor     eax, eax
                              mov     edi, offset stru_4204E8
                              xor     ebp, ebp
                              push    esi             ; HDC
                              rep stosd
                              mov     [esp+20h+hDC], esi
                              mov     stru_4204E8.bmiHeader.biSize, 28h
                              mov     stru_4204E8.bmiHeader.biWidth, 14Ah
                              mov     stru_4204E8.bmiHeader.biHeight, 0FFFFFF9Ch
                              mov     stru_4204E8.bmiHeader.biPlanes, 1
                              mov     stru_4204E8.bmiHeader.biBitCount, 20h
                              mov     stru_4204E8.bmiHeader.biCompression, ebp
                              call    CreateCompatibleDC
                              push    ebp             ; DWORD
                              push    ebp             ; HANDLE
                              push    offset dword_420350 ; void **
                              push    ebp             ; UINT
                              push    offset stru_4204E8 ; BITMAPINFO *
                              push    esi             ; HDC
                              mov     dword_420538, eax
                              call    CreateDIBSection
                              mov     ecx, dword_420538
                              push    eax             ; HGDIOBJ
                              push    ecx             ; HDC
                              mov     dword_420514, eax
                              call    SelectObject
                              mov     eax, dword_420350
                              mov     dword_420354, eax
                              mov     dword_420358, eax
                              mov     eax, offset dword_42035C

              loc_401195:                             ; CODE XREF: sub_4010F0+B9j
                              mov     edx, [eax-4]
                              add     eax, 4
                              add     edx, 528h
                              cmp     eax, offset stru_4204E8
                              mov     [eax-4], edx
                              jl      short loc_401195
                              mov     edx, dword_415094
                              mov     ebx, dword_41509C
                              mov     ecx, 2751h
                              xor     eax, eax
                              mov     edi, offset dword_41660C
                              mov     dword_4161B8, ebx
                              rep stosd
                              mov     eax, dword_415098
                              xor     ecx, ecx
                              mov     dword_4161BC, eax
                              mov     eax, dword_4150A0
                              xor     edi, edi
                              inc     edx
                              mov     dword_4161B0, eax
                              mov     esi, offset dword_41620C
                              mov     [esp+1Ch+var_8], edx

              loc_4011ED:                             ; CODE XREF: sub_4010F0+1B8j
                              mov     edx, eax
                              and     edx, 0FFFFFC00h
                              cmp     edx, 3FC00h
                              jnb     short loc_401202
                              shr     eax, 0Ah
                              jmp     short loc_401207
              ; ---------------------------------------------------------------------------

              loc_401202:                             ; CODE XREF: sub_4010F0+10Bj
                              mov     eax, 0FFh

              loc_401207:                             ; CODE XREF: sub_4010F0+110j
                              mov     edx, ebx
                              and     edx, 0FFFFFC00h
                              cmp     edx, 3FC00h
                              jnb     short loc_401220
                              shr     ebx, 0Ah
                              mov     [esp+1Ch+var_C], ebx
                              jmp     short loc_401228
              ; ---------------------------------------------------------------------------

              loc_401220:                             ; CODE XREF: sub_4010F0+125j
                              mov     [esp+1Ch+var_C], 0FFh

              loc_401228:                             ; CODE XREF: sub_4010F0+12Ej
                              mov     edx, dword_4161BC
                              mov     ebx, edx
                              and     ebx, 0FFFFFC00h
                              cmp     ebx, 3FC00h
                              jnb     short loc_401243
                              shr     edx, 0Ah
                              jmp     short loc_401248
              ; ---------------------------------------------------------------------------

              loc_401243:                             ; CODE XREF: sub_4010F0+14Cj
                              mov     edx, 0FFh

              loc_401248:                             ; CODE XREF: sub_4010F0+151j
                              xor     ebx, ebx
                              and     eax, 0FFh
                              mov     bh, dl
                              mov     edx, dword_4161BC
                              mov     bl, byte ptr [esp+1Ch+var_C]
                              add     edx, edi
                              shl     ebx, 8
                              or      ebx, eax
                              mov     eax, dword_4161B0
                              mov     dword_4161BC, edx
                              mov     edx, dword_415098
                              mov     [esi], ebx
                              mov     ebx, dword_4161B8
                              add     edi, edx
                              mov     edx, dword_41509C
                              add     ebx, ebp
                              add     ebp, edx
                              mov     edx, dword_4150A0
                              add     eax, ecx
                              add     ecx, edx
                              mov     edx, [esp+1Ch+var_8]
                              add     esi, 4
                              dec     edx
                              mov     dword_4161B8, ebx
                              mov     dword_4161B0, eax
                              mov     [esp+1Ch+var_8], edx
                              jnz     loc_4011ED
                              mov     esi,[esp+1Ch+lpParameter]
                              push    offset ThreadId ; lpThreadId
                              push    0               ; dwCreationFlags
                              push    esi             ; lpParameter
                              push    offset StartAddress ; lpStartAddress
                              push    0               ; dwStackSize
                              push    0               ; lpThreadAttributes
                              call    CreateThread
                              push    0
                              push    eax
                              call    SetThreadPriority
                              
                              mov     dword_420528, eax
                              mov     eax, [esp+1Ch+hDC]
                              push    eax             ; hDC
                              push    esi             ; hWnd
                              call    ReleaseDC
                              push    0               ; bErase
                              push    0               ; lpRect
                              push    esi             ; hWnd
                              call    InvalidateRect
                              pop     edi
                              pop     esi
                              pop     ebp
                              pop     ebx
                              add     esp, 0Ch
                              retn
              sub_4010F0      endp

