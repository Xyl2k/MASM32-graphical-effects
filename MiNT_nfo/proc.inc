                  sub_401DCC      proc near               ; CODE XREF: DialogFunc+18Cp
                                                          ; DialogFunc+19Ap ...
                                  push    eax
                                  xor     eax, eax
                                  mov     ecx, edx
                                  and     ecx, 1
                                  or      eax, ecx
                                  shl     edx, 3
                                  mov     ecx, edx
                                  and     ecx, 10h
                                  or      eax, ecx
                                  shl     edx, 3
                                  mov     ecx, edx
                                  and     ecx, 100h
                                  or      eax, ecx
                                  shl     edx, 3
                                  mov     ecx, edx
                                  and     ecx, 1000h
                                  or      eax, ecx
                                  shl     edx, 3
                                  mov     ecx, edx
                                  and     ecx, 10000h
                                  or      eax, ecx
                                  shl     edx, 3
                                  mov     ecx, edx
                                  and     ecx, 100000h
                                  or      eax, ecx
                                  shl     edx, 3
                                  mov     ecx, edx
                                  and     ecx, 1000000h
                                  or      eax, ecx
                                  shl     edx, 3
                                  mov     ecx, edx
                                  and     ecx, 10000000h
                                  or      eax, ecx
                                  shl     edx, 3
                                  bswap   eax
                                  mov     edx, eax
                                  pop     eax
                                  cmp     al, 7Fh
                                  jbe     short locret_401E3C
                                  add     edx, edx

                  locret_401E3C:                          ; CODE XREF: sub_401DCC+6Cj
                                  retn
                  sub_401DCC      endp

                  ; int __stdcall sub_401874(HWND hWnd,UINT Msg,WPARAM wParam,LPARAM lParam)
                  sub_401874      proc near               ; DATA XREF: start+176o
                                                          ; start+200o ...

                  hWnd            = dword ptr  8
                  Msg             = dword ptr  0Ch
                  wParam          = dword ptr  10h
                  lParam          = dword ptr  14h

                                  push    ebp
                                  mov     ebp, esp
                                  cmp     [ebp+Msg], 200h
                                  jnz     loc_4019C7
                                  mov     eax, [ebp+hWnd]
                                  cmp     eax, dword_457D48
                                  jz      locret_4019DE
                                  cmp     eax, hWnd
                                  jnz     short loc_4018EC
                                  mov     dword_457D48, eax
                                  push    dword_457CFC    ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    hWnd            ; hWnd
                                  call    SendMessageA
                                  push    dword_457D04    ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    dword_457D00    ; hWnd
                                  call    SendMessageA
                                  push    dword_457D10    ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    dword_457D0C    ; hWnd
                                  call    SendMessageA
                                  leave
                                  retn    10h
                  ; ---------------------------------------------------------------------------

                  loc_4018EC:                             ; CODE XREF: sub_401874+25j
                                  cmp     eax, dword_457D00
                                  jnz     short loc_401945
                                  mov     dword_457D48, eax
                                  push    lParam          ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    hWnd            ; hWnd
                                  call    SendMessageA
                                  push    dword_457D08    ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    dword_457D00    ; hWnd
                                  call    SendMessageA
                                  push    dword_457D10    ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    dword_457D0C    ; hWnd
                                  call    SendMessageA
                                  leave
                                  retn    10h
                  ; ---------------------------------------------------------------------------

                  loc_401945:                             ; CODE XREF: sub_401874+7Ej
                                  cmp     eax, dword_457D0C
                                  jnz     short loc_40199E
                                  mov     dword_457D48, eax
                                  push    lParam          ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    hWnd            ; hWnd
                                  call    SendMessageA
                                  push    dword_457D04    ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    dword_457D00    ; hWnd
                                  call    SendMessageA
                                  push    dword_457D14    ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    dword_457D0C    ; hWnd
                                  call    SendMessageA
                                  leave
                                  retn    10h
                  ; ---------------------------------------------------------------------------

                  loc_40199E:                             ; CODE XREF: sub_401874+D7j
                                  cmp     eax, dword_457D18
                                  jnz     short locret_4019DE
                                  mov     dword_457D48, eax
                                  push    dword_457D20    ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    dword_457D18    ; hWnd
                                  call    SendMessageA
                                  leave
                                  retn    10h
                  ; ---------------------------------------------------------------------------

                  loc_4019C7:                             ; CODE XREF: sub_401874+Aj
                                  push    [ebp+lParam]    ; lParam
                                  push    [ebp+wParam]    ; wParam
                                  push    [ebp+Msg]       ; Msg
                                  push    [ebp+hWnd]      ; hWnd
                                  push    lpPrevWndFunc   ; lpPrevWndFunc
                                  call    CallWindowProcA

                  locret_4019DE:                          ; CODE XREF: sub_401874+19j
                                                          ; sub_401874+130j
                                  leave
                                  retn    10h
                  sub_401874      endp


                  ; --------------- S U B R O U T I N E -------
