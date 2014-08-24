;initdialog

           ; int __stdcall sub_401A71(HWND hWnd)
           sub_401A71      proc near               ; CODE XREF: DialogFunc+3DDp

           rc              = dword ptr -10h
           hWnd            = dword ptr  8

                           push    ebp
                           mov     ebp, esp
                           add     esp, 0FFFFFFF0h
                           and     ds:dword_407EC0, 0
                           and     ds:dword_407EBC, 0
                           mov     ds:byte_407EC6, 1
                           mov     esi, ds:hMem
               
                           
                           push    [ebp+hWnd]      ; hWnd
                           call    GetDC
                           mov     ebx, eax
                           push    ebx             ; HDC
                           call    CreateCompatibleDC
                           mov     ds:dword_409F90, eax
                           push    ds:dword_409F8C ; HGDIOBJ
                           push    eax             ; HDC
                           call    SelectObject
                           push    ebx             ; HDC
                           call    CreateCompatibleDC
                           mov     ds:dword_40703A, eax
                           push    ds:dword_407032 ; HGDIOBJ
                           push    eax             ; HDC
                           call    SelectObject
                           push    ebx             ; HDC
                           call    CreateCompatibleDC
                           mov     ds:dword_407036, eax
                           push    ds:dword_40702E ; HGDIOBJ
                           push    eax             ; HDC
                           call    SelectObject
                           push    ebx             ; HDC
                           call    CreateCompatibleDC
                           mov     ds:dword_409FA4, eax
                           push    172h            ; int
                           push    28Dh            ; int
                           push    ebx             ; HDC
                           call    CreateCompatibleBitmap
                           mov     ds:dword_409F84, eax
                           push    eax             ; HGDIOBJ
                           push    ds:dword_409FA4 ; HDC
                           call    SelectObject
                           push    ebx             ; HDC
                           call    CreateCompatibleDC
                           mov     ds:dword_409FA8, eax
                           push    14Ah            ; int
                           push    28Dh            ; int
                           push    ebx             ; HDC
                           call    CreateCompatibleBitmap
                           mov     ds:dword_409F88, eax
                           push    eax             ; HGDIOBJ
                           push    ds:dword_409FA8 ; HDC
                           call    SelectObject
                           push    ds:dword_409FD0 ; HGDIOBJ
                           push    ds:dword_409FA4 ; HDC
                           call    SelectObject
                           push    0               ; UINT
                           push    ds:dword_409FA4 ; HDC
                           call    SetTextAlign
                           lea     edx, [ebp+rc]
                           mov     dword ptr [edx], 0
                           mov     dword ptr [edx+4], 0
                           mov     dword ptr [edx+8], 28Dh
                           mov     dword ptr [edx+0Ch], 172h
                           push    ds_hbr          ; hbr
                           push    edx             ; lprc
                           push    ds:dword_409FA4 ; hDC
                           call    FillRect
                           lea     edx, [ebp+rc]
                           mov     dword ptr [edx], 0
                           mov     dword ptr [edx+4], 0
                           mov     dword ptr [edx+8], 28Dh
                           mov     dword ptr [edx+0Ch], 14Ah
                           push    ds_hbr          ; hbr
                           push    edx             ; lprc
                           push    ds:dword_409FA8 ; hDC
                           call    FillRect
                           push    0FFFFFFh        ; COLORREF
                           push    ds:dword_409FA4 ; HDC
                           call    SetTextColor
                           push    0               ; COLORREF
                           push    ds:dword_409FA4 ; HDC
                           call    SetBkColor
                           push    ebx             ; hDC
                           push    [ebp+hWnd]      ; hWnd
                           call    ReleaseDC
                           and     ds:uIDEvent, 0
                           push    0               ; lpTimerFunc
                           push    1Eh             ; uElapse
                           push    3               ; nIDEvent
                           push    [ebp+hWnd]      ; hWnd
                           call    SetTimer
                           mov     ds:uIDEvent, eax
                           leave
                           retn    4
           sub_401A71      endp

           sub_4019B6      proc near               ; CODE XREF: DialogFunc+3E2p

           var_4           = dword ptr -4

                           push    ebp
                           mov     ebp, esp
                           add     esp, 0FFFFFFFCh
                           push    ebx
                           push    esi
                           push    edi
                           mov     [ebp+var_4], 0F0h
                           lea     edi, unk_4099D8
                           call    GetTickCount
                           lea     esi, ds:15F8E773h[eax*4]
                           rol     esi, 3

           loc_4019DB:                             ; CODE XREF: sub_4019B6+B0j
                           mov     eax, esi
                           imul    eax, 13A71h
                           xor     eax, 78983458h
                           rol     eax, 5
                           imul    eax, 83F3A0h
                           lea     esi, ds:123AA678h[eax*4]
                           xor     ds:dword_409F78, esi
                           xor     edx, edx
                           mov     ebx, 1F9Fh
                           div     ebx
                           mov     eax, edx
                           test    eax, 1
                           jnz     short loc_401A17
                           neg     ax
                           jnz     short loc_401A17
                           dec     ax

           loc_401A17:                             ; CODE XREF: sub_4019B6+58j
                                                   ; sub_4019B6+5Dj
                           stosw
                           mov     eax, esi
                           imul    eax, 13333h
                           xor     eax, 11884422h
                           rol     eax, 5
                           imul    eax, 72231h
                           lea     esi, ds:42345678h[eax*4]
                           xor     ds:dword_409F78, esi
                           xor     edx, edx
                           mov     ebx, 1BB7h
                           div     ebx
                           mov     eax, edx
                           test    eax, 1
                           jnz     short loc_401A55
                           neg     ax
                           jnz     short loc_401A55
                           dec     ax

           loc_401A55:                             ; CODE XREF: sub_4019B6+96j
                                                   ; sub_4019B6+9Bj
                           stosw
                           mov     ax, si
                           rol     ax, 5
                           and     eax, 7Fh
                           stosw
                           dec     [ebp+var_4]
                           jg      loc_4019DB
                           pop     edi
                           pop     esi
                           pop     ebx
                           leave
                           retn
           sub_4019B6      endp

           sub_401884      proc near               ; CODE XREF: DialogFunc+3E7p

           var_10          = dword ptr -10h
           var_C           = dword ptr -0Ch
           var_8           = dword ptr -8
           var_4           = dword ptr -4

                           push    ebx
                           push    esi
                           push    edi
                           mov     ds:dword_407006, 0
                           mov     eax, ds:dword_407006
                           lea     esi, off_40704A
                           mov     esi, [esi+eax*4]
                           lea     edi, unk_409524
                           lodsd
                           mov     ecx, eax
                           stosd

           loc_4018A9:                             ; CODE XREF: sub_401884+31j
                           lodsw
                           stosw
                           lodsw
                           stosw
                           lodsw
                           stosw
                           loop    loc_4018A9
                           mov     ds:dword_40700A, 0
                           mov     ds:dword_40700E, 0
                           mov     ds:dword_407012, 0
                           mov     ds:dword_40703E, 190h
                           mov     ds:dword_407042, 0
                           mov     ds:dword_407046, 0
                           mov     ds:dword_407016, 2
                           mov     ds:dword_40701A, 4
                           mov     ds:dword_40701E, 6
                           lea     edi, dword_408070
                           lea     esi, dword_408870
                           xor     ecx, ecx
                           push    0B4h
                           finit
                           fldpi
                           fild    [esp+4+var_4]
                           fdivp   st(1), st
                           push    200h
                           push    168h
                           fild    [esp+0Ch+var_C]
                           fild    [esp+0Ch+var_8]
                           push    100h
                           fdivp   st(1), st
                           fild    [esp+10h+var_10]
                           push    0
                           push    0
                           fldz
                           fstp    qword ptr [esp+4]

           loc_401953:                             ; CODE XREF: sub_401884+F2j
                           fld     qword ptr [esp+4]
                           fmul    st, st(3)
                           fsincos
                           fmul    st, st(2)
                           fistp   dword ptr [esi+ecx*4]
                           fmul    st, st(1)
                           fistp   dword ptr [edi+ecx*4]
                           fld     qword ptr [esp+4]
                           fadd    st, st(2)
                           fstp    qword ptr [esp+4]
                           inc     ecx
                           cmp     ecx, 200h
                           jl      short loc_401953
                           ffree   st(2)
                           ffree   st(1)
                           ffree   st
                           add     esp, 18h
                           pop     edi
                           pop     esi
                           pop     ebx
                           retn
           sub_401884      endp

