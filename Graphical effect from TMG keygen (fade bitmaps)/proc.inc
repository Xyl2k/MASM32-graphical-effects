                                  
my_init proc hWnd:DWORD;,uMsg:DWORD;,wParam:DWORD,lParam:DWORD                      
                                  
          hDlg            = dword ptr  8
          arg_4           = dword ptr  0Ch
          arg_8           = dword ptr  10h
          arg_C           = dword ptr  14h
                        
                                  
                                  xor     ebx,ebx
                                  call    GetTickCount
                                  test    al, 1
                                  jz      short loc_401AE4
                                  push    6Ah             ; lpBitmapName
                                  push    hInstance       ; hInstance
                                  call     LoadBitmapA
                                  mov     dword_401EB0, eax
                                  mov     dword_401E84, 52h
                                  jmp     short loc_401AFD
                  ; ---------------------------------------------------------------------------

                  loc_401AE4:                             ; CODE XREF: sub_4018D3+1F4j
                                  push    7Ah             ; lpBitmapName
                                  push    hInstance       ; hInstance
                                  call     LoadBitmapA
                                  mov     dword_401EB0, eax
                                  mov     dword_401E84, 5Ah

                  loc_401AFD:                             ; CODE XREF: sub_4018D3+20Fj
                                  push    [ebp+hDlg]      ; hWnd
                                  call    GetDC
                                  push    eax             ; HDC
                                  mov     [ebp+arg_8], eax
                                  call    CreateCompatibleDC
                                  push    dword_401EB0    ; HGDIOBJ
                                  mov     hDC, eax
                                  push    eax             ; HDC
                                  call    SelectObject
                                  mov     eax, dword_401E84
                                  imul    eax, 366h
                                  mov     edi, 1000h
                                  push    40h             ; flProtect
                                  push    edi             ; flAllocationType
                                  push    eax             ; dwSize
                                  push    ebx             ; lpAddress
                                  mov     dword_401E80, 122h
                                  call    VirtualAlloc
                                  mov     lpAddress, eax
                                  mov     eax, dword_401E80
                                  imul    eax, dword_401E84
                                  push    40h             ; flProtect
                                  push    edi             ; flAllocationType
                                  lea     eax, [eax+eax*2]
                                  push    eax             ; dwSize
                                  push    ebx             ; lpAddress
                                  call    VirtualAlloc
                                  push    2Ch
                                  push    ebx
                                  push    offset stru_401E40
                                  mov     dword_401EBC, eax
                                  call    sub_401D60
                                  push    28h
                                  mov     esi, offset dword_401E00
                                  pop     edi
                                  push    edi
                                  push    ebx
                                  push    esi
                                  call    sub_401D60
                                  mov     eax, dword_401E80
                                  imul    eax, dword_401E84
                                  lea     eax, [eax+eax*2]
                                  push    eax
                                  push    ebx
                                  push    lpAddress
                                  call    sub_401D60
                                  mov     eax, dword_401E80
                                  add     esp, 24h
                                  mov     dword_401E04, eax
                                  mov     eax, dword_401E84
                                  push    0Eh             ; int
                                  mov     dword_401E00, edi
                                  push    [ebp+arg_8]     ; HDC
                                  mov     dword_401E08, eax
                                  call    GetDeviceCaps
                                  push    0Ah
                                  mov     edi, offset stru_401E40
                                  pop     ecx
                                  mov     word_401E0C, ax
                                  mov     word_401E0E, 18h
                                  mov     dword_401E10, ebx
                                  rep movsd
                                  mov     esi, offset stru_401E40
                                  push    ebx             ; UINT
                                  push    esi             ; LPBITMAPINFO
                                  push    dword_401EBC    ; LPVOID
                                  push    dword_401E84    ; UINT
                                  push    ebx             ; UINT
                                  push    dword_401EB0    ; HBITMAP
                                  push    hDC             ; HDC
                                  call    GetDIBits
                                  mov     ecx, dword_401E84
                                  cmp     eax, ecx
                                  jnz     loc_40190B
                                  push    ebx             ; UINT
                                  push    esi             ; BITMAPINFO *
                                  push    lpAddress       ; void *
                                  push    ecx             ; UINT
                                  push    ebx             ; UINT
                                  push    dword_401EB0    ; HBITMAP
                                  push    hDC             ; HDC
                                  call    SetDIBits
                                  push    0CC0020h        ; DWORD
                                  push    ebx             ; int
                                  push    ebx             ; int
                                  push    hDC             ; HDC
                                  push    dword_401E84    ; int
                                  push    dword_401E80    ; int
                                  push    1Eh             ; int
                                  push    1Eh             ; int
                                  push    [ebp+arg_8]     ; HDC
                                  call    BitBlt
                                  push    offset TimerFunc ; lpTimerFunc
                                  push    28h             ; uElapse
                                  push    1               ; nIDEvent
                                  push    [ebp+hDlg]      ; hWnd
                                  call    SetTimer
                                  
                  loc_40190B:    
                                  
                                  ret
my_init endp


;#########################################################################################

                  sub_401D60      proc near               ; CODE XREF: sub_4018D3+29Ep
                                                          ; sub_4018D3+2AEp ...

                  arg_0           = dword ptr  4
                  arg_4           = byte ptr  8
                  arg_8           = dword ptr  0Ch

                                  mov     edx, [esp+arg_8]
                                  mov     ecx, [esp+arg_0]
                                  test    edx, edx
                                  jz      short loc_401DB3
                                  xor     eax, eax
                                  mov     al, [esp+arg_4]
                                  push    edi
                                  mov     edi, ecx
                                  cmp     edx, 4
                                  jb      short loc_401DA7
                                  neg     ecx
                                  and     ecx, 3
                                  jz      short loc_401D89
                                  sub     edx, ecx

                  loc_401D83:                             ; CODE XREF: sub_401D60+27j
                                  mov     [edi], al
                                  inc     edi
                                  dec     ecx
                                  jnz     short loc_401D83

                  loc_401D89:                             ; CODE XREF: sub_401D60+1Fj
                                  mov     ecx, eax
                                  shl     eax, 8
                                  add     eax, ecx
                                  mov     ecx, eax
                                  shl     eax, 10h
                                  add     eax, ecx
                                  mov     ecx, edx
                                  and     edx, 3
                                  shr     ecx, 2
                                  jz      short loc_401DA7
                                  rep stosd
                                  test    edx, edx
                                  jz      short loc_401DAD

                  loc_401DA7:                             ; CODE XREF: sub_401D60+18j
                                                          ; sub_401D60+3Fj ...
                                  mov     [edi], al
                                  inc     edi
                                  dec     edx
                                  jnz     short loc_401DA7

                  loc_401DAD:                             ; CODE XREF: sub_401D60+45j
                                  mov     eax, [esp+4+arg_0]
                                  pop     edi
                                  retn
                  ; ---------------------------------------------------------------------------

                  loc_401DB3:                             ; CODE XREF: sub_401D60+Aj
                                  mov     eax, [esp+arg_0]
                                  retn
                  sub_401D60      endp

;##########################################################################################
                  ; void __stdcall TimerFunc(HWND,UINT,UINT,DWORD)
                  TimerFunc       proc near               ; DATA XREF: sub_4018D3+38Co

                  @hWnd            = dword ptr  4

                                  test    byte_401DBC, 1
                                  jnz     short loc_40143D
                                  mov     eax, dword_401E84
                                  or      byte_401DBC, 1
                                  imul    eax, dword_401E80
                                  lea     eax, [eax+eax*2]
                                  mov     dword_401DF8, eax

                  loc_40143D:                             ; CODE XREF: TimerFunc+7j
                                  push    ebx
                                  push    ebp
                                  mov     ebp, [esp+8+@hWnd]
                                  push    esi
                                  push    edi
                                  push    ebp             ; hWnd
                                  call    GetDC
                                  xor     edi, edi
                                  xor     esi, esi
                                  cmp     dword_401DF8, edi
                                  mov     dword_401E38, eax
                                  mov     dword_401DE8, esi
                                  jle     short loc_4014AD

                  loc_401463:                             ; CODE XREF: TimerFunc+92j
                                  mov     eax, dword_401EBC
                                  mov     bl, [eax+esi]
                                  movzx   ecx, bl
                                  mov     eax, ecx
                                  cdq
                                  idiv    dword_401294
                                  mov     edx, lpAddress
                                  add     esi, edx
                                  mov     dl, [esi]
                                  mov     [esp+10h+@hWnd], eax
                                  sub     ecx, eax
                                  movzx   eax, dl
                                  cmp     eax, ecx
                                  jge     short loc_401496
                                  add     dl, byte ptr [esp+10h+@hWnd]
                                  mov     [esi], dl
                                  jmp     short loc_401498
                  ; ---------------------------------------------------------------------------

                  loc_401496:                             ; CODE XREF: TimerFunc+73j
                                  mov     [esi], bl

                  loc_401498:                             ; CODE XREF: TimerFunc+7Bj
                                  mov     esi, dword_401DE8
                                  inc     esi
                                  cmp     esi, dword_401DF8
                                  mov     dword_401DE8, esi
                                  jl      short loc_401463

                  loc_4014AD:                             ; CODE XREF: TimerFunc+48j
                                  mov     eax, dword_401294
                                  inc     dword_401EC0
                                  mov     ebx, ReleaseDC
                                  add     eax, eax
                                  cmp     dword_401EC0, eax
                                  jle     short loc_401525
                                  push    1               ; uIDEvent
                                  push    ebp             ; hWnd
                                  call    KillTimer
                                  
                                  mov     eax, dword_401E84
                                  mov     esi, VirtualFree
                                  imul    eax, dword_401E80
                                  mov     edi, 4000h
                                  lea     eax, [eax+eax*2]
                                  push    edi             ; dwFreeType
                                  push    eax             ; dwSize
                                  push    lpAddress       ; lpAddress
                                  call    esi ; VirtualFree
                                  mov     eax, dword_401E84
                                  push    edi             ; dwFreeType
                                  imul    eax, dword_401E80
                                  lea     eax, [eax+eax*2]
                                  push    eax             ; dwSize
                                  push    dword_401EBC    ; lpAddress
                                  call    esi ; VirtualFree
                                  push    dword_401EB0    ; HGDIOBJ
                                  call    DeleteObject
                                  push    hDC             ; hDC
                                  push    ebp             ; hWnd
                                  call    ebx ; ReleaseDC
                                  xor     edi, edi

                  loc_401525:                             ; CODE XREF: TimerFunc+ADj
                                  push    edi             ; UINT
                                  push    offset stru_401E40 ; BITMAPINFO *
                                  push    lpAddress       ; void *
                                  push    dword_401E84    ; UINT
                                  push    edi             ; UINT
                                  push    dword_401EB0    ; HBITMAP
                                  push    hDC             ; HDC
                                  call    SetDIBits
                                  push    0CC0020h        ; DWORD
                                  push    edi             ; int
                                  push    edi             ; int
                                  push    hDC             ; HDC
                                  push    dword_401E84    ; int
                                  push    dword_401E80    ; int
                                  push    1Eh             ; int
                                  push    0Eh             ; int
                                  push    dword_401E38    ; HDC
                                  call    BitBlt
                                  push    dword_401E38    ; hDC
                                  push    ebp             ; hWnd
                                  call    ebx ; ReleaseDC
                                  pop     edi
                                  pop     esi
                                  pop     ebp
                                  pop     ebx
                                  retn    10h
                  TimerFunc       endp


                  ; --------------- S U B R O U T I N E ---------------------------------------

