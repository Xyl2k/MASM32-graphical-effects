              ; BOOL __stdcall sub_401760(HWND,UINT,WPARAM,LPARAM)
              sub_401760      proc near               ; DATA XREF: DialogFunc+568o

              hWnd            = dword ptr  8
              arg_4           = dword ptr  0Ch
              arg_8           = dword ptr  10h

                              push    ebp
                              mov     ebp, esp
                              push    esi
                              push    edi
                              push    ebp
                              push    ebx
                              cmp     [ebp+arg_4], 110h
                              jz      short loc_4017B0
                              cmp     [ebp+arg_4], 10h
                              jz      loc_401802
                              cmp     [ebp+arg_4], 200h
                              jz      loc_401830
                              cmp     [ebp+arg_4], 111h
                              jz      loc_401859
                              cmp     [ebp+arg_4], 205h
                              jz      short loc_401802
                              cmp     [ebp+arg_4], 136h
                              jz      short loc_401821

              loc_4017A6:                             ; CODE XREF: sub_401760+A0j
                                                      ; sub_401760+BFj ...
                              xor     eax, eax
                              pop     ebx
                              pop     ebp
                              pop     edi
                              pop     esi
                              leave
                              retn    10h
              ; ---------------------------------------------------------------------------

              loc_4017B0:                             ; CODE XREF: sub_401760+Ej
                              push    1Eh             ; lpIconName
                              push    ds:hInstance    ; hInstance
                              call    LoadIconA
                              push    eax             ; lParam
                              push    1               ; wParam
                              push    80h             ; Msg
                              push    [ebp+hWnd]      ; hWnd
                              call    SendMessageA
                              push    offset dword_415924 ; lpThreadId
                              push    0               ; dwCreationFlags
                              push    [ebp+hWnd]      ; lpParameter
                              push    offset sub_401864 ; lpStartAddress
                              push    0               ; dwStackSize
                              push    0               ; lpThreadAttributes
                              call    CreateThread
                              mov     ds:dword_415928, eax
                              mov     ds:dword_415938, 957050h
                              push    ds:dword_415938
                              pop     ds:dword_41593C
                              jmp     short loc_4017A6
              ; ---------------------------------------------------------------------------

              loc_401802:                             ; CODE XREF: sub_401760+14j
                                                      ; sub_401760+3Bj ...
                              mov     ds:dword_415944, 1

              loc_40180C:                             ; CODE XREF: sub_401760+B3j
                              cmp     ds:dword_415944, 0
                              jnz     short loc_40180C
                              push    0               ; nResult
                              push    [ebp+hWnd]      ; hDlg
                              call    EndDialog
                              jmp     short loc_4017A6
              ; ---------------------------------------------------------------------------

              loc_401821:                             ; CODE XREF: sub_401760+44j
                              push    5               ; int
                              call    GetStockObject
                              pop     ebx
                              pop     ebp
                              pop     edi
                              pop     esi
                              leave
                              retn    10h
              ; ---------------------------------------------------------------------------

              loc_401830:                             ; CODE XREF: sub_401760+21j
                              cmp     [ebp+arg_8], 1
                              jz      short loc_40183B
                              jmp     loc_4017A6
              ; ---------------------------------------------------------------------------

              loc_40183B:                             ; CODE XREF: sub_401760+D4j
                              call    ReleaseCapture
                              push    0               ; lParam
                              push    0F012h          ; wParam
                              push    112h            ; Msg
                              push    [ebp+hWnd]      ; hWnd
                              call    SendMessageA
                              jmp     loc_4017A6
              ; ---------------------------------------------------------------------------

              loc_401859:                             ; CODE XREF: sub_401760+2Ej
                              cmp     [ebp+arg_8], 2
                              jz      short loc_401802
                              jmp     loc_4017A6
              sub_401760      endp

