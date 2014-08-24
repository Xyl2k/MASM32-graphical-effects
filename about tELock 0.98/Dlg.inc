              ; BOOL __stdcall DialogFunc(HWND,UINT,WPARAM,LPARAM)
              DialogFunc      proc near               ; DATA XREF: sub_401CA7+3FAo

              hDC             = dword ptr -44h
              Paint           = dword ptr -40h
              hWnd            = dword ptr  8
              arg_4           = dword ptr  0Ch
              arg_8           = dword ptr  10h
              arg_C           = dword ptr  14h

                              enter   44h, 0
                              push    ebx
                              push    esi
                              push    edi
                              mov     eax, [ebp+arg_4]
                              cmp     eax, WM_DRAWITEM ;=2Bh
                              jz      short loc_40232F
                              cmp     eax,WM_TIMER ;= 113h
                              jz      loc_4023CE
                              cmp     eax, WM_PAINT ;=0Fh
                              jz      loc_4023EE
                              cmp     eax,WM_MOUSEMOVE ;= 200h
                              jz      loc_4024CA
                              cmp     eax,WM_LBUTTONDOWN; 201h
                              jz      loc_4024F5
                              cmp     eax,WM_LBUTTONUP;= 202h
                              jz      loc_4024E4
                              cmp     eax, WM_CTLCOLORSTATIC;=138h
                              jz      loc_402513
                              cmp     eax,WM_CTLCOLORDLG;= 136h
                              jz      loc_402513
                              cmp     eax,WM_CLOSE;= 10h
                              jz      short loc_402345
                              cmp     eax, WM_COMMAND ;=111h
                              jz      loc_40246C
                              cmp     eax,WM_INITDIALOG;= 110h
                              jz      loc_40247E

              loc_402326:                             ; CODE XREF: DialogFunc+82j
                                                      ; DialogFunc+92j ...
                              xor     eax, eax

              loc_402328:                             ; CODE XREF: DialogFunc+272j
                              pop     edi
                              pop     esi
                              pop     ebx
                              leave
                              retn    10h
              ; ---------------------------------------------------------------------------

              loc_40232F:                             ; CODE XREF: DialogFunc+Dj
                              cmp     [ebp+arg_8], 0
                              jz      short loc_402326
                              push    [ebp+hWnd]
                              push    [ebp+arg_8]
                              push    [ebp+arg_C]
                              call    sub_402CD6
                              jmp     short loc_402326
              ; ---------------------------------------------------------------------------

              loc_402345:                             ; CODE XREF: DialogFunc+5Dj
                                                      ; DialogFunc+1C8j
                              push    ds:dword_40EE6C ; uIDEvent
                              push    [ebp+hWnd]      ; hWnd
                              call    KillTimer
                              and     ds:dword_40EE6C, 0
                              push    ds:dword_40EE94 ; HDC
                              call    DeleteDC
                              push    ds:dword_40EE98 ; HDC
                              call    DeleteDC
                              push    ds:dword_40EE70 ; HGDIOBJ
                              call    DeleteObject
                              push    ds:dword_40EE74 ; HGDIOBJ
                              call    DeleteObject
                              push    ds:dword_40EEB0 ; HDC
                              call    DeleteDC
                              push    ds:dword_40EEAC ; HDC
                              call    DeleteDC
                              push    ds:dword_40EEA8 ; HDC
                              call    DeleteDC
                              push    ds:dword_40EEB8 ; HDC
                              call    DeleteDC
                              push    ds:dword_40EEC0 ; HDC
                              call    DeleteDC
                              push    0               ; nResult
                              push    [ebp+hWnd]      ; hDlg
                              call    EndDialog
                              pop     edi
                              pop     esi
                              pop     ebx
                              leave
                              retn    10h
              ; ---------------------------------------------------------------------------

              loc_4023CE:                             ; CODE XREF: DialogFunc+14j
                              mov     eax, [ebp+arg_8]
                              cmp     eax, ds:dword_40EE6C
                              jnz     loc_402326
                              cmp     ds:dword_40982C, 0
                              call    sub_402854
                              jmp     loc_402326
              ; ---------------------------------------------------------------------------

              loc_4023EE:                             ; CODE XREF: DialogFunc+1Dj
                              lea     eax, [ebp+Paint]
                              push    eax             ; lpPaint
                              push    [ebp+hWnd]      ; hWnd
                              call    BeginPaint
                              mov     [ebp+hDC], eax
                              push    16h             ; int
                              push    11Dh            ; int
                              push    1               ; int
                              push    1               ; int
                              push    0               ; dy
                              push    0               ; int
                              push    ds:dword_40EED4 ; hbr
                              push    [ebp+hDC]       ; hDC
                              push    0FFFFFFFFh      ; nIDDlgItem
                              push    [ebp+hWnd]      ; hWnd
                              call    sub_402C4D
                              mov     eax, ds:dword_40EE8C
                              mov     ebx, ds:dword_40EE90
                              sub     eax, ds:dword_40EE84
                              sub     ebx, ds:dword_40EE88
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    ds:dword_40EE98 ; HDC
                              push    ebx             ; int
                              push    eax             ; int
                              push    ds: dword_40EE88 ; int
                              push    ds:dword_40EE84 ; int
                              push    [ebp+hDC]       ; HDC
                              call    BitBlt
                              lea     eax, [ebp+Paint]
                              push    eax             ; lpPaint
                              push    [ebp+hWnd]      ; hWnd
                              call    EndPaint
                              jmp     loc_402326
              ; ---------------------------------------------------------------------------

              loc_40246C:                             ; CODE XREF: DialogFunc+64j
                              mov     eax, [ebp+arg_8]
                              cmp     ax, 82h
                              jnz     loc_402326
                              jmp     loc_402345
              ; ---------------------------------------------------------------------------

              loc_40247E:                             ; CODE XREF: DialogFunc+6Fj
                              
                              
                              
                              
                              
                              invoke LoadIcon,0,7F03h
                              push eax
	                          push 1
	                          push WM_SETICON
                              push [ebp+hWnd]
                              call SendMessage
                              
                              invoke SetWindowText,[ebp+hWnd],SADD("About..")
                              mov     eax, [ebp+hWnd]
                              mov     ds:dword_40EEDC, eax
                              push    1               ; lParam
                              push    ds:dword_40EE68 ; wParam
                              push    30h             ; Msg
                              push    81h             ; nIDDlgItem
                              push    [ebp+hWnd]      ; hDlg
                              call    SendDlgItemMessageA
                              push    offset aAbout___ ; "About..."
                              push    0               ; wParam
                              push    0Ch             ; Msg
                              push    81h             ; nIDDlgItem
                              push    [ebp+hWnd]      ; hDlg
                              call    SendDlgItemMessageA
                              push    [ebp+hWnd]      ; hWnd
                              call    sub_4025E0
                              call    sub_402528
                              push    1
                              pop     eax
                              pop     edi
                              pop     esi
                              pop     ebx
                              leave
                              retn    10h
              ; ---------------------------------------------------------------------------

              loc_4024CA:                             ; CODE XREF: DialogFunc+28j
                              cmp     ds:dword_40982C, 0
                              jz      loc_402326
                              push    [ebp+hWnd]      ; hWnd
                              call    sub_402BC0
                              jmp     loc_402326
              ; ---------------------------------------------------------------------------

              loc_4024E4:                             ; CODE XREF: DialogFunc+3Ej
                              and     ds:dword_40982C, 0
                              call    ReleaseCapture
                              jmp     loc_402326
              ; ---------------------------------------------------------------------------

              loc_4024F5:                             ; CODE XREF: DialogFunc+33j
                              push    offset Point    ; lpPoint
                              call    GetCursorPos
                              push    [ebp+hWnd]      ; hWnd
                              call    SetCapture
                              or      ds:dword_40982C, 1
                              jmp     loc_402326
              ; ---------------------------------------------------------------------------

              loc_402513:                             ; CODE XREF: DialogFunc+49j
                                                      ; DialogFunc+54j
                              push    ds:dword_40EED8 ; int
                              push    0               ; COLORREF
                              push    [ebp+arg_8]     ; HDC
                              call    sub_402B93
                              jmp     loc_402328
              DialogFunc      endp
