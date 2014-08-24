                  ; BOOL __stdcall DialogFunc(HWND,UINT,WPARAM,LPARAM)
                  DialogFunc      proc near               

                  hWnd            = dword ptr  8
                  arg_4           = dword ptr  0Ch
                  arg_8           = dword ptr  10h

                                  push    ebp
                                  mov     ebp, esp
                                  mov     eax, [ebp+arg_4]
                                  
                                  cmp     eax,WM_INITDIALOG;= 110h
                                  jnz     loc_401BFB
                                  push    384h            ; lpIconName
                                  push    hInstance       ; hInstance
                                  call    LoadIconA
                                  push    eax             ; lParam
                                  push    1               ; wParam
                                  push    80h             ; Msg
                                  push    [ebp+hWnd]      ; hWnd
                                  call    SendMessageA
                                  push    0               ; lpParam
                                  push    hInstance       ; hInstance
                                  push    0A0h            ; hMenu
                                  push    [ebp+hWnd]      ; hWndParent
                                  push    0               ; nHeight
                                  push    0               ; nWidth
                                  push    122h            ; Y
                                  push    132h            ; X
                                  push    5000010Eh       ; dwStyle
                                  push    0               ; lpWindowName
                                  push    offset aStatic  ; "STATIC"
                                  push    0               ; dwExStyle
                                  call    CreateWindowExA
                                  mov     dword_457D18, eax
                                  push    0F0h            ; lpBitmapName
                                  push    hInstance       ; hInstance
                                  call    LoadBitmapA
                                  mov     dword_457D1C, eax
                                  push    eax             ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    dword_457D18    ; hWnd
                                  call    SendMessageA
                                  push    0F1h            ; lpBitmapName
                                  push    hInstance       ; hInstance
                                  call    LoadBitmapA
                                  mov     dword_457D20, eax
                                  push    offset sub_401874 ; dwNewLong
                                  push    0FFFFFFFCh      ; nIndex
                                  push    dword_457D18    ; hWnd
                                  call    SetWindowLongA
                                  mov     lpPrevWndFunc, eax
                                  xor     ebx, ebx
                                  
                                  
                                  
                                  
                                  IF RES_NFO
                                  mov     esi,word_4066EE
                                  ELSE
                                  mov     esi, offset word_4066EE
                                  ENDIF
                  
                  loc_401AA4:                             
                                  lodsb
                                  cmp     al, 0Dh
                                  jnz     short loc_401AAA
                                  inc     ebx

                  loc_401AAA:                             
                                  or      al, al
                                  jnz     short loc_401AA4
                                  inc     ebx
                                  shl     ebx,3
                                  
                                  mov     eax, ebx
                                  mov     stru_4060A4.nMax, ebx
                                  mov     stru_4060A4.nPos, 0
                                  
                                  shl eax,1;<---fix bug if size greater
                                  
                                  neg     eax
                                  sub     ebx, 100h
                                  mov     stru_406060.bmiHeader.biHeight, eax
                                  mov     dword_457D44, ebx
                                  
                                  push    6Eh             ; nIDDlgItem
                                  push    [ebp+hWnd]      ; hDlg
                                  call    GetDlgItem
                                  mov     dword_457D40, eax
                                  push    1               ; BOOL
                                  push    offset stru_4060A4 ; LPCSCROLLINFO
                                  push    2               ; int
                                  push    dword_457D40    ; HWND
                                  call    SetScrollInfo
                                  push    [ebp+hWnd]      ; hWnd
                                  call    GetDC
                                  push    eax             ; hDC
                                  push    eax             ; HDC
                                  call    CreateCompatibleDC
                                  mov     dword_457D38, eax
                                  
                                  push    0               ; DWORD
                                  push    0               ; HANDLE
                                  push    offset dword_457D7C ; void **
                                  push    0               ; UINT
                                  push    offset stru_406060 ; BITMAPINFO *
                                  push    eax             ; HDC
                                  call    CreateDIBSection
                                  
                                  mov     dword_457D3C, eax
                                  push    eax             ; HGDIOBJ
                                  push    dword_457D38    ; HDC
                                  call    SelectObject
                                  push    [ebp+hWnd]      ; hWnd
                                  call    ReleaseDC
                                  xor     eax, eax
                                  mov     ebx, dword_457D7C
                                  
                                  IF RES_NFO
                                  mov     esi, word_4066EE
                                  ELSE
                                  mov     esi, offset word_4066EE
                                  ENDIF
                                  
                                  mov     edi, ebx

                  loc_401B4C:                             
                                                          
                                  lodsb
                                  or      al, al
                                  jz      loc_401BFB
                                  cmp     al, 0Ah
                                  jz      short loc_401B4C
                                  cmp     al, 0Dh
                                  jnz     short loc_401B67
                                  add     ebx, 0A00h
                                  mov     edi, ebx
                                  jmp     short loc_401B4C
                  ; ---------------------------------------------------------------------------

                  loc_401B67:                             
                                  mov     dl, byte_44CE03[eax*8]
                                  call    sub_401DCC
                                  mov     [edi], edx
                                  mov     dl, byte_44CE04[eax*8]
                                  call    sub_401DCC
                                  mov     [edi+140h], edx
                                  mov     dl, byte_44CE05[eax*8]
                                  call    sub_401DCC
                                  mov     [edi+280h], edx
                                  mov     dl, byte_44CE06[eax*8]
                                  call    sub_401DCC
                                  mov     [edi+3C0h], edx
                                  mov     dl, byte_44CE07[eax*8]
                                  call    sub_401DCC
                                  mov     [edi+500h], edx
                                  mov     dl, byte_44CE08[eax*8]
                                  call    sub_401DCC
                                  mov     [edi+640h], edx
                                  mov     dl, byte_44CE09[eax*8]
                                  call    sub_401DCC
                                  mov     [edi+780h], edx
                                  mov     dl, byte_44CE0A[eax*8]
                                  call    sub_401DCC
                                  mov     [edi+8C0h], edx
                                  add     edi, 4
                                  jmp     loc_401B4C
                  ; ---------------------------------------------------------------------------

                  loc_401BFB:                             
                                                          
                                  cmp     eax,WM_PAINT;= 0Fh
                                  jz      short loc_401C6E
                                  cmp     eax,WM_CLOSE  ;= 10h
                                  jz      loc_401CB1
                                  cmp     eax,WM_MOUSEMOVE;= 200h
                                  jz      loc_401CD3
                                  cmp     eax,WM_CTLCOLORDLG ;= 136h
                                  jz      loc_401D03
                                  cmp     eax, WM_CTLCOLORSTATIC;=138h
                                  jz      loc_401D03
                                  cmp     eax, WM_VSCROLL;=115h
                                  jz      loc_401D23
                                  
                                  cmp     eax, 20Ah;=?
                                  jz      loc_401DA4
                                  
                                  cmp     eax,WM_COMMAND ;= 111h
                                  jnz     short loc_401C50
                                  cmp     [ebp+arg_8], 0A0h
                                  jz      short loc_401CB1

                  loc_401C50:                             ; CODE XREF: DialogFunc+263j
                                  cmp     eax, 201h
                                  jnz     short loc_401C68
                                  push    0               ; lParam
                                  push    2               ; wParam
                                  push    0A1h            ; Msg
                                  push    [ebp+hWnd]      ; hWnd
                                  call    SendMessageA

                  loc_401C68:                             ; CODE XREF: DialogFunc+273j
                                                          ; DialogFunc+2CDj ...
                                  xor     eax, eax
                                  leave
                                  retn    10h
                  ; ---------------------------------------------------------------------------

                  loc_401C6E:                             ; CODE XREF: DialogFunc+21Cj
                                  push    offset stru_4BD89C ; lpPaint
                                  push    [ebp+hWnd]      ; hWnd
                                  call    BeginPaint
                                  push    0CC0020h        ; DWORD
                                  push    stru_4060A4.nPos ; int
                                  push    0               ; int
                                  push    dword_457D38    ; HDC
                                  push    100h            ; int
                                  push    280h            ; int
                                  push    18h             ; int
                                  push    0               ; int
                                  push    eax             ; HDC
                                  call    BitBlt
                                  push    offset stru_4BD89C ; lpPaint
                                  push    [ebp+hWnd]      ; hWnd
                                  call    EndPaint
                                  jmp     short loc_401C68
                  ; ---------------------------------------------------------------------------

                  loc_401CB1:                             ; CODE XREF: DialogFunc+221j
                                                          ; DialogFunc+26Cj
                                  push    0               ; nResult
                                  push    [ebp+hWnd]      ; hDlg
                                  call    EndDialog
                                  push    dword_457D38    ; HDC
                                  call    DeleteDC
                                  push    dword_457D3C    ; HGDIOBJ
                                  call    DeleteObject
                                  jmp     short loc_401C68
                  ; ---------------------------------------------------------------------------

                  loc_401CD3:                             ; CODE XREF: DialogFunc+22Cj
                                  cmp     dword_457D48, 0
                                  jz      short loc_401C68
                                  mov     dword_457D48, 0
                                  push    dword_457D1C    ; lParam
                                  push    0               ; wParam
                                  push    172h            ; Msg
                                  push    dword_457D18    ; hWnd
                                  call    SendMessageA
                                  jmp     loc_401C68
                  ; ---------------------------------------------------------------------------

                  loc_401D03:                             ; CODE XREF: DialogFunc+237j
                                                          ; DialogFunc+242j
                                  push    0               ; COLORREF
                                  push    [ebp+arg_8]     ; HDC
                                  call    SetBkColor
                                  push    0FFFFFFh        ; COLORREF
                                  push    [ebp+arg_8]     ; HDC
                                  call    SetTextColor
                                  invoke GetStockObject,BLACK_BRUSH
                                  
                                  
                                  ;mov     eax, dword_457D28
                                  leave
                                  retn    10h
                  ; ---------------------------------------------------------------------------

                  loc_401D23:                             ; CODE XREF: DialogFunc+24Dj
                                  mov     eax, [ebp+arg_8]
                                  mov     ebx, stru_4060A4.nPos
                                  cmp     ax, 5
                                  jnz     short loc_401D37
                                  mov     ebx, eax
                                  shr     ebx, 10h

                  loc_401D37:                             ; CODE XREF: DialogFunc+34Ej
                                  cmp     ax, 1
                                  jnz     short loc_401D40
                                  add     ebx, 8

                  loc_401D40:                             ; CODE XREF: DialogFunc+359j
                                  cmp     ax, 0
                                  jnz     short loc_401D49
                                  sub     ebx, 8

                  loc_401D49:                             ; CODE XREF: DialogFunc+362j
                                  cmp     ax, 3
                                  jnz     short loc_401D55
                                  add     ebx, 80h

                  loc_401D55:                             ; CODE XREF: DialogFunc+36Bj
                                  cmp     ax, 2
                                  jnz     short loc_401D61
                                  sub     ebx, 80h

                  loc_401D61:                             ; CODE XREF: DialogFunc+377j
                                  or      ebx, ebx
                                  jge     short loc_401D67
                                  xor     ebx, ebx

                  loc_401D67:                             ; CODE XREF: DialogFunc+381j
                                  cmp     ebx, dword_457D44
                                  jle     short loc_401D75
                                  mov     ebx, dword_457D44

                  loc_401D75:                             ; CODE XREF: DialogFunc+38Bj
                                  mov     stru_4060A4.nPos, ebx
                                  push    1               ; BOOL
                                  push    offset stru_4060A4 ; LPCSCROLLINFO
                                  push    2               ; int
                                  push    dword_457D40    ; HWND
                                  call    SetScrollInfo
                                  push    1               ; flags
                                  push    0               ; hrgnUpdate
                                  push    offset rcUpdate ; lprcUpdate
                                  push    [ebp+hWnd]      ; hWnd
                                  call    RedrawWindow
                                  leave
                                  retn    10h
                  ; ---------------------------------------------------------------------------

                  loc_401DA4:                             ; CODE XREF: DialogFunc+258j
                                  mov     eax, [ebp+arg_8]
                                  mov     ebx, 2
                                  test    eax, 80000000h
                                  jz      short loc_401DB8
                                  mov     ebx, 3

                  loc_401DB8:                             ; CODE XREF: DialogFunc+3CFj
                                  push    0               ; lParam
                                  push    ebx             ; wParam
                                  push    115h            ; Msg
                                  push    [ebp+hWnd]      ; hWnd
                                  call    SendMessageA
                                  leave
                                  retn    10h
                  DialogFunc      endp

