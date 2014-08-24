           DialogFunc      proc near               ; DATA XREF: start+205o

           hDC             = dword ptr -44h
           Paint           = dword ptr -40h
           hWnd            = dword ptr  8
           arg_4           = dword ptr  0Ch
           arg_8           = dword ptr  10h
           arg_C           = dword ptr  14h

                           push    ebp
                           mov     ebp, esp
                           add     esp, 0FFFFFFBCh
                           push    ebx
                           push    esi
                           push    edi
                           mov     eax, [ebp+arg_4]
                           cmp     eax, 113h
                           jz      loc_401408
                           cmp     eax, 0Fh
                           jz      loc_401421
                           cmp     eax, 200h
                           jz      loc_40172D
                           cmp     eax, 201h;WM_LBUTTONDOWN
                           jz      loc_401758
                           cmp     eax, 202h;WM_LBUTTONUP
                           jz      loc_401747
                           cmp     eax, 138h
                           jz      loc_401785
                           cmp     eax, 136h
                           jz      loc_401785
                           cmp     eax, 10h
                           jz      short loc_401354
                           cmp     eax, 111h
                           jz      loc_4014AA
                           cmp     eax, 110h
                           jz      loc_4014ED

           loc_40134B:                             ; CODE XREF: DialogFunc+138j
                                                   ; DialogFunc+143j ...
                           xor     eax, eax

           loc_40134D:                             ; CODE XREF: DialogFunc+4BFj
                           pop     edi
                           pop     esi
                           pop     ebx
                           leave
                           retn    10h
           ; ---------------------------------------------------------------------------

           loc_401354:                             ; CODE XREF: DialogFunc+5Aj
                                                   ; DialogFunc+1D8j ...
                           push    ds:uIDEvent     ; uIDEvent
                           push    [ebp+hWnd]      ; hWnd
                           call    KillTimer
                           and     ds:uIDEvent, 0
                           ;push    ds:hhk          ; hhk
                           ;call    UnhookWindowsHookEx
                           push    ds:hMem         ; hMem
                           call    GlobalFree
                           push    ds:dword_409FA4 ; HDC
                           call    DeleteDC
                           push    ds:dword_409FA8 ; HDC
                           call    DeleteDC
                           push    ds:dword_407036 ; HDC
                           call    DeleteDC
                           push    ds:dword_40703A ; HDC
                           call    DeleteDC
                           push    ds:dword_409F90 ; HDC
                           call    DeleteDC
                           mov     esi, offset DeleteObject
                           push    ds:dword_409FC8 ; HGDIOBJ
                           call    esi ; DeleteObject
                           push    ds:dword_409FC0 ; HGDIOBJ
                           call    esi ; DeleteObject
                           push    ds:dword_409FCC ; HGDIOBJ
                           call    esi ; DeleteObject
                           push    ds:dword_409F84 ; HGDIOBJ
                           call    esi ; DeleteObject
                           push    ds:dword_409F88 ; HGDIOBJ
                           call    esi ; DeleteObject
                           push    ds:dword_409F8C ; HGDIOBJ
                           call    esi ; DeleteObject
                           ;push    0
                           ;push    0
                           ;call    sub_402B00
                           ;add     esp, 8
                           push    0               ; nResult
                           push    [ebp+hWnd]      ; hDlg
                           call    EndDialog
                           pop     edi
                           pop     esi
                           pop     ebx
                           leave
                           retn    10h
           ; ---------------------------------------------------------------------------

           loc_401408: ;WM_TIMER                            ; CODE XREF: DialogFunc+11j
                           mov     eax, [ebp+arg_8]
                           cmp     eax, ds:uIDEvent
                           jnz     loc_40134B
                           call    sub_401DBE
                           jmp     loc_40134B
           ; ---------------------------------------------------------------------------

           loc_401421: ;WM_PAINT                            ; CODE XREF: DialogFunc+1Aj
                           lea     eax, [ebp+Paint]
                           push    eax             ; lpPaint
                           push    [ebp+hWnd]      ; hWnd
                           call    BeginPaint
                           mov     [ebp+hDC], eax
                           push    [ebp+hDC]       ; hDC
                           push    [ebp+hWnd]      ; hWnd
                           call    sub_4023CF
                           push    15h             ; int
                           push    293h            ; int
                           push    1               ; int
                           push    1               ; int
                           push    0               ; dy
                           push    0               ; int
                           push    ds:dword_409FC8 ; hbr
                           push    [ebp+hDC]       ; hDC
                           push    0FFFFFFFFh      ; nIDDlgItem
                           push    [ebp+hWnd]      ; hWnd
                           call    sub_4023FA
                           mov     eax, ds:dword_409F9C
                           mov     ebx, ds:dword_409FA0
                           sub     eax, ds:dword_409F94
                           sub     ebx, ds:dword_409F98
                           push    0CC0020h        ; DWORD
                           push    0               ; int
                           push    0               ; int
                           push    ds:dword_409FA8 ; HDC
                           push    ebx             ; int
                           push    eax             ; int
                           push    ds:dword_409F98 ; int
                           push    ds:dword_409F94 ; int
                           push    [ebp+hDC]       ; HDC
                           call    BitBlt
                           lea     eax, [ebp+Paint]
                           push    eax             ; lpPaint
                           push    [ebp+hWnd]      ; hWnd
                           call    EndPaint
                           jmp     loc_40134B
           ; ---------------------------------------------------------------------------

           loc_4014AA:                             ; CODE XREF: DialogFunc+61j
                           mov     eax, [ebp+arg_8]
                           cmp     ax, 2
                           jz      loc_401354
                           cmp     ax, 0DADh
                           jnz     short loc_4014D0
                           mov     ds:byte_407EC4, 1
                           and     ds:byte_407EC5, 0
                           jmp     loc_40134B
           ; ---------------------------------------------------------------------------

           loc_4014D0:                             ; CODE XREF: DialogFunc+1E2j
                           cmp     ax, 0DAEh
                           jnz     loc_40134B
                           mov     ds:byte_407EC5, 1
                           and     ds:byte_407EC4, 0
                           jmp     loc_40134B
           ; ---------------------------------------------------------------------------

           loc_4014ED:                             ; CODE XREF: DialogFunc+6Cj
                           mov     eax, [ebp+hWnd]
                           mov     ds_hWnd, eax
                           push    offset String   ; "TMG.NFO"
                           push    [ebp+hWnd]      ; hWnd
                           call    SetWindowTextA
                           push    66h             ; lpIconName
                           push    ds:hInstance    ; hInstance
                           call    LoadIconA
                           push    eax             ; lParam
                           push    1               ; wParam
                           push    80h             ; Msg
                           push    [ebp+hWnd]      ; hWnd
                           call    SendMessageA
                           push    10000h          ; dwBytes
                           push    40h             ; uFlags
                           call    GlobalAlloc
                           mov     ds:hMem, eax
                          
                         
                           push    90h             ; lpBitmapName
                           push    ds:hInstance    ; hInstance
                           call    LoadBitmapA
                           mov     ds:dword_407032, eax
                           push    8Fh             ; lpBitmapName
                           push    ds:hInstance    ; hInstance
                           call    LoadBitmapA
                           mov     ds:dword_40702E, eax
                           push    68h             ; lpBitmapName
                           push    ds:hInstance    ; hInstance
                           call    LoadBitmapA
                           mov     ds:dword_409F8C, eax
                           push    0               ; COLORREF
                           call    CreateSolidBrush
                           mov     ds:dword_409FC0, eax
                           push    303030h         ; COLORREF
                           call    CreateSolidBrush
                           mov     ds:dword_409FCC, eax
                           push    808080h         ; COLORREF
                           call    CreateSolidBrush
                           mov     ds:dword_409FC8, eax
                           push    4               ; int
                           call    GetStockObject
                           mov     ds_hbr, eax
                           push    0Ah             ; int
                           call    GetStockObject
                           mov     ds:dword_409FD0, eax
                           
                     invoke SetTimer,[ebp+hWnd],66,10,addr scrl
           
                           push    [ebp+hWnd]      ; hWnd
                           call    sub_401A71
                           call    sub_4019B6
                           call    sub_401884
                         

           loc_4016D4:                             ; CODE XREF: DialogFunc+416j
                           push    1
                           pop     eax
                           pop     edi
                           pop     esi
                           pop     ebx
                           leave
                           retn    10h
           ; ---------------------------------------------------------------------------

           loc_4016DE:                             ; CODE XREF: DialogFunc+42Bj
                           push    0               ; lParam
                           push    0               ; wParam
                           push    10h             ; Msg
                           push    ds_hWnd         ; hWnd
                           call    SendMessageA
                           jmp     short loc_4016D4 ; lpBaseAddress
           ; ---------------------------------------------------------------------------

           loc_4016F1:                             ; CODE XREF: DialogFunc+325j
                                                   ; DialogFunc+438j
                           ;push    0               ; uType
                           ;push    offset aError   ; "Error"
                           ;push    offset aAnErrorOccured ; "An error occured while reading NFO data"...
                           ;push    0               ; hWnd
                           ;call    MessageBoxA
                           jmp     short loc_4016DE
           ; ---------------------------------------------------------------------------

           loc_401706:                             ; CODE XREF: DialogFunc+33Bj
                                                   ; DialogFunc+35Dj ...
                           push    ds:hFile        ; hObject
                           call    CloseHandle
                           jmp     short loc_4016F1
           ; ---------------------------------------------------------------------------

           loc_401713:                             ; CODE XREF: DialogFunc+378j
                                                   ; DialogFunc+452j
                           push    ds:hObject      ; hObject
                           call    CloseHandle
                           jmp     short loc_401706
           ; ---------------------------------------------------------------------------
                           push    ds:lpBaseAddress
                           call    UnmapViewOfFile
                           jmp     short loc_401713
           ; ---------------------------------------------------------------------------

           loc_40172D:                             ; CODE XREF: DialogFunc+25j
                           cmp     ds:dword_407EE8, 0
                           jz      loc_40134B
                           ;push    [ebp+hWnd]      ; hWnd
                           ;call    sub_402343
                           jmp     loc_40134B
           ; ---------------------------------------------------------------------------

           loc_401747:;WM_LBUTTONUP                             ; CODE XREF: DialogFunc+3Bj
                           and     ds:dword_407EE8, 0
                           call    ReleaseCapture
                           ;invoke SendMessage,[ebp+hWnd],WM_NCLBUTTONDOWN, HTCAPTION,0
                           
                           jmp     loc_40134B
           ; ---------------------------------------------------------------------------

           loc_401758:;WM_LBUTTONDOWN                             ; CODE XREF: DialogFunc+30j
                           
                           ;invoke SendMessage,[ebp+hWnd],WM_NCLBUTTONDOWN, HTCAPTION,0
                           mov     eax, [ebp+arg_C]
                           push    eax
                           call    sub_4012AB
                           jnz     loc_401354;exit
                           ;push    offset Point    ; lpPoint
                           ;call    GetCursorPos
                           ;push    [ebp+hWnd]      ; hWnd
                           ;call    SetCapture
                           ;or      ds:dword_407EE8, 1
                           
                           invoke SendMessage,[ebp+hWnd],WM_NCLBUTTONDOWN, HTCAPTION,0
                           jmp     loc_40134B
           ; ---------------------------------------------------------------------------

           loc_401785:                             ; CODE XREF: DialogFunc+46j
                                                   ; DialogFunc+51j
                           push    ds:dword_409FC0 ; int
                           push    0C0C0C0h        ; COLORREF
                           push    [ebp+arg_8]     ; HDC
                           call    sub_4023A6
                           jmp     loc_40134D
           DialogFunc      endp

