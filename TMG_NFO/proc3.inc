;paint

           ; int __stdcall sub_4023CF(HWND hWnd,HDC hDC)
           sub_4023CF      proc near               ; CODE XREF: DialogFunc+15Dp

           lRect            = dword ptr -10h
           hWnd            = dword ptr  8
           hDC             = dword ptr  0Ch

                           push    ebp
                           mov     ebp, esp
                           add     esp, 0FFFFFFF0h
                           push    ebx
                           push    esi
                           push    edi
                           lea     edi, [ebp+lRect]
                           push    edi             ; lpRect
                           push    [ebp+hWnd]      ; hWnd
                           call    GetClientRect
                           push    ds:dword_409FCC ; hbr
                           push    edi             ; lprc
                           push    [ebp+hDC]       ; hDC
                           call    FrameRect
                           pop     edi
                           pop     esi
                           pop     ebx
                           leave
                           retn    8
           sub_4023CF      endp

           ; int __stdcall sub_4023FA(HWND hWnd,int nIDDlgItem,HDC hDC,HBRUSH hbr,int,int dy,int,int,int,int)
           sub_4023FA      proc near               ; CODE XREF: DialogFunc+17Fp

           var_18          = dword ptr -18h
           var_10          = dword ptr -10h
           hWnd            = dword ptr  8
           nIDDlgItem      = dword ptr  0Ch
           hDC             = dword ptr  10h
           hbr             = dword ptr  14h
           arg_10          = dword ptr  18h
           dy              = dword ptr  1Ch
           arg_18          = dword ptr  20h
           arg_1C          = dword ptr  24h
           arg_20          = dword ptr  28h
           arg_24          = dword ptr  2Ch

                           push    ebp
                           mov     ebp, esp
                           add     esp, 0FFFFFFE8h
                           push    ebx
                           push    esi
                           push    edi
                           lea     edi, [ebp+var_10]
                           cmp     [ebp+nIDDlgItem], 0FFFFFFFFh
                           jnz     short loc_402425
                           mov     eax, [ebp+arg_18]
                           mov     ebx, [ebp+arg_1C]
                           mov     ecx, [ebp+arg_20]
                           mov     edx, [ebp+arg_24]
                           mov     [edi+4], eax
                           mov     [edi], ebx
                           mov     [edi+8], ecx
                           mov     [edi+0Ch], edx
                           jmp     short loc_402472
           ; ---------------------------------------------------------------------------

           loc_402425:                             ; CODE XREF: sub_4023FA+10j
                           lea     esi, [ebp+var_18]
                           push    [ebp+nIDDlgItem] ; nIDDlgItem
                           push    [ebp+hWnd]      ; hDlg
                           call    GetDlgItem
                           push    eax
                           push    edi             ; lpRect
                           push    eax             ; hWnd
                           call    GetWindowRect
                           mov     eax, [edi]
                           mov     ebx, [edi+4]
                           mov     [esi], eax
                           mov     [esi+4], ebx
                           push    esi             ; lpPoint
                           push    [ebp+hWnd]      ; hWnd
                           call    ScreenToClient
                           pop     eax
                           push    edi             ; lpRect
                           push    eax             ; hWnd
                           call    GetClientRect
                           mov     eax, [esi]
                           mov     ebx, [esi+4]
                           add     [edi], eax
                           add     [edi+8], eax
                           add     [edi+4], ebx
                           add     [edi+0Ch], ebx
                           push    [ebp+dy]        ; dy
                           push    [ebp+arg_10]    ; dx
                           push    edi             ; lprc
                           call    InflateRect

           loc_402472:                             ; CODE XREF: sub_4023FA+29j
                           push    [ebp+hbr]       ; hbr
                           push    edi             ; lprc
                           push    [ebp+hDC]       ; hDC
                           call    FrameRect
                           pop     edi
                           pop     esi
                           pop     ebx
                           leave
                           retn    28h
           sub_4023FA      endp
