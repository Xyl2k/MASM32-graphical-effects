
                  ;in eax=hWnd
              sub_404E7C      proc near               ; CODE XREF: sub_404F70+3C4p

              var_48          = dword ptr -48h
              var_44          = dword ptr -44h
              Paint           = dword ptr -40h

                              push    ebx
                              push    esi
                              push    edi
                              push    ebp
                              add     esp, 0FFFFFFB8h
                              mov     ebp, eax
                              lea     eax, ds_Paint;[esp+48h+Paint]
                              push    eax             ; lpPaint
                              push    ebp             ; hWnd
                              call    BeginPaint
                              mov     esi, eax
                              push    esi             ; HDC
                              call    CreateCompatibleDC
                              mov     ebx, eax
                              mov     eax,ds_Paint.rcPaint.bottom ;[esp+1ch];[esp+48h+Paint.rcPaint.bottom]
                              push    eax             ; int
                              mov     eax,ds_Paint.rcPaint.right;[esp+1ch]; [esp+4Ch+Paint.rcPaint.right]
                              push    eax             ; int
                              push    esi             ; HDC
                              call    CreateCompatibleBitmap
                              mov     edi, eax
                              push    edi             ; HGDIOBJ
                              push    ebx             ; HDC
                              call    SelectObject
                              mov     [esp+48h+var_48], eax
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              mov     eax, dword_407BF8
                              push    eax             ; HDC
                              push    120h            ; int
                              push    16Eh            ; int
                              push    0               ; int
                              push    0               ; int
                              push    ebx             ; HDC
                              call    BitBlt
                              cmp     byte_4074DC, 0
                              jz      short loc_404F28
                              mov     edx, dword_407BEC
                              mov     eax, ebx
                              call    sub_404BA4
                              mov     eax, ebx
                              call    sub_404D7C
                              mov     eax, dword_407BF0
                              push    eax             ; HGDIOBJ
                              push    ebx             ; HDC
                              call    SelectObject
                              mov     [esp+48h+var_44], eax
                              push    1               ; int
                              push    ebx             ; HDC
                              call    SetBkMode
                              push    6               ; UINT
                              push    ebx             ; HDC
                              call    SetTextAlign
                              
                              pushad
                              mov     eax, ebx
                              call    sub_404A10
                              popad
                              
                              mov     eax, [esp+48h+var_44]
                              push    eax             ; HGDIOBJ
                              push    ebx             ; HDC
                              call    SelectObject

              loc_404F28:                             ; CODE XREF: sub_404E7C+64j
                              
                              
                              push    0EE0086h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    ds:logoDC       ; HDC
                              push    9Eh             ; int
                              push    11Ah            ; int
                              push    10               ; int
                              push    60               ; int
                              push    ebx             ; HDC
                              call    BitBlt
                              
                              
                              
                              push    0CC0020h        ; DWORD
                              push    0               ; int
                              push    0               ; int
                              push    ebx             ; HDC
                              push    120h            ; int
                              push    16Eh            ; int
                              push    0               ; int
                              push    0               ; int
                              push    esi             ; HDC
                              call    BitBlt
                              mov     eax, [esp+48h+var_48]
                              push    eax             ; HGDIOBJ
                              push    ebx             ; HDC
                              call    SelectObject
                              push    edi             ; HGDIOBJ
                              call    DeleteObject
                              push    ebx             ; HDC
                              call    DeleteDC
                              lea     eax, ds_Paint;[esp+48h+Paint]
                              push    eax             ; lpPaint
                              push    ebp             ; hWnd
                              call    EndPaint
                              add     esp, 48h
                              pop     ebp
                              pop     edi
                              pop     esi
                              pop     ebx
                              retn
              sub_404E7C      endp


              sub_404BA4      proc near               ; CODE XREF: sub_404E7C+6Ep

              var_1C          = dword ptr -1Ch
              var_18          = dword ptr -18h
              var_14          = dword ptr -14h
              var_10          = dword ptr -10h
              var_C           = dword ptr -0Ch
              var_8           = dword ptr -8
              var_4           = dword ptr -4

                              push    ebx
                              push    esi
                              push    edi
                              push    ebp
                              add     esp, 0FFFFFFE4h
                              mov     [esp+1Ch+var_18], edx
                              mov     [esp+1Ch+var_1C], eax
                              mov     eax, [esp+1Ch+var_18]
                              mov     ecx, 6
                              cdq
                              idiv    ecx
                              mov     esi, edx
                              add     esi, 0Fh
                              cmp     esi, 78h
                              jge     loc_404D3C

              loc_404BCC:                             ; CODE XREF: sub_404BA4+192j
                              add     esi, 6
                              mov     eax, [esp+1Ch+var_18]
                              add     eax, esi
                              mov     [esp+1Ch+var_8], eax
                              fild    [esp+1Ch+var_8]
                              fld     tbyte_404D4C
                              fmulp   st(1), st
                              call    sub_4025CC
                              mov     [esp+1Ch+var_4], esi
                              fild    [esp+1Ch+var_4]
                              fdiv    flt_404D58
                              fmul    flt_404D5C
                              fsubr   flt_404D60
                              fmulp   st(1), st
                              call    sub_4025DC
                              mov     [esp+1Ch+var_10], eax
                              mov     eax, [esp+1Ch+var_18]
                              add     eax, eax
                              add     eax, esi
                              mov     [esp+1Ch+var_8], eax
                              fild    [esp+1Ch+var_8]
                              fld     tbyte_404D4C
                              fmulp   st(1), st
                              call    sub_4025BC
                              mov     [esp+1Ch+var_4], esi
                              fild    [esp+1Ch+var_4]
                              fdiv    flt_404D58
                              fmul    flt_404D64
                              fsubr   flt_404D68
                              fmulp   st(1), st
                              call    sub_4025DC
                              mov     [esp+1Ch+var_C], eax
                              xor     ebp, ebp

              loc_404C53:                             ; CODE XREF: sub_404BA4+189j
                              mov     ebx, esi
                              add     ebx, ebx
                              mov     [esp+1Ch+var_8], ebp
                              fild    [esp+1Ch+var_8]
                              call    sub_4025BC
                              mov     [esp+1Ch+var_4], esi
                              fild    [esp+1Ch+var_4]
                              fmulp   st(1), st
                              call    sub_4025DC
                              add     eax, [esp+1Ch+var_10]
                              add     eax, 0B7h
                              mov     [esp+1Ch+var_14], eax
                              mov     [esp+1Ch+var_8], ebp
                              fild    [esp+1Ch+var_8]
                              call    sub_4025CC
                              mov     [esp+1Ch+var_4], esi
                              fild    [esp+1Ch+var_4]
                              fmulp   st(1), st
                              fld     tbyte_404D6C
                              fmulp   st(1), st
                              call    sub_4025DC
                              mov     edi, eax
                              add     edi, [esp+1Ch+var_C]
                              add     edi, 0C2h
                              cmp     edi, 7Fh
                              jl      short loc_404CBA
                              cmp     esi, 64h
                              jle     short loc_404CBC

              loc_404CBA:                             ; CODE XREF: sub_404BA4+10Fj
                              shr     ebx, 1

              loc_404CBC:                             ; CODE XREF: sub_404BA4+114j
                              cmp     esi, 6Eh
                              jle     short loc_404CC3
                              shr     ebx, 1

              loc_404CC3:                             ; CODE XREF: sub_404BA4+11Bj
                              cmp     [esp+1Ch+var_18], 258h
                              jge     short loc_404CED
                              mov     eax, [esp+1Ch+var_18]
                              add     eax, 12Ch
                              imul    ebx
                              mov     [esp+1Ch+var_8], eax
                              fild    [esp+1Ch+var_8]
                              fdiv    flt_404D78
                              call    sub_4025DC
                              mov     ebx, eax

              loc_404CED:                             ; CODE XREF: sub_404BA4+127j
                              mov     eax, ebx
                              mov     ecx, eax
                              push    eax
                              pop     edx
                              call    sub_403FE8
                              mov     ebx, eax
                              push    edi             ; int
                              mov     eax, [esp+20h+var_14]
                              push    eax             ; int
                              mov     eax, [esp+24h+var_1C]
                              push    eax             ; HDC
                              call    GetPixel
                              test    eax, eax
                              jz      short loc_404D16
                              cmp     edi, 97h
                              jge     short loc_404D29

              loc_404D16:                             ; CODE XREF: sub_404BA4+168j
                              or      ebx, eax
                              push    ebx             ; COLORREF
                              push    edi             ; int
                              mov     eax, [esp+24h+var_14]
                              push    eax             ; int
                              mov     eax, [esp+28h+var_1C]
                              push    eax             ; HDC
                              call    SetPixel

              loc_404D29:                             ; CODE XREF: sub_404BA4+170j
                              inc     ebp
                              cmp     ebp, 2Ch
                              jnz     loc_404C53
                              cmp     esi, 78h
                              jl      loc_404BCC

              loc_404D3C:                             ; CODE XREF: sub_404BA4+22j
                              add     dword_407BEC, 2
                              add     esp, 1Ch
                              pop     ebp
                              pop     edi
                              pop     esi
                              pop     ebx
                              retn
              sub_404BA4      endp


              sub_4025CC      proc near               ; CODE XREF: sub_404A10+5Cp
                                                      ; sub_404BA4+41p ...
                              fsin
                              fnstsw  ax
                              sahf
                              jp      short loc_4025D4
                              retn
              ; ---------------------------------------------------------------------------

              loc_4025D4:                             ; CODE XREF: sub_4025CC+5j
                              fstp    st
                              fldz
                              retn
              sub_4025CC      endp


              sub_4025DC      proc near               ; CODE XREF: sub_404A10+67p
                                                      ; sub_404BA4+62p ...

              var_8           = qword ptr -8

                              sub     esp, 8
                              fistp   [esp+8+var_8]
                              wait
                              pop     eax
                              pop     edx
                              retn
              sub_4025DC      endp


              sub_4025BC      proc near               ; CODE XREF: sub_404BA4+83p
                                                      ; sub_404BA4+BBp
                              fcos
                              fnstsw  ax
                              sahf
                              jp      short loc_4025C4
                              retn
              ; ---------------------------------------------------------------------------

              loc_4025C4:                             ; CODE XREF: sub_4025BC+5j
                              fstp    st
                              fldz
                              retn
              sub_4025BC      endp


              sub_403FE8      proc near               ; CODE XREF: sub_404A10+7Fp
                                                      ; sub_404A10+BBp ...
                              and     eax, 0FFh
                              and     edx, 0FFh
                              shl     edx, 8
                              or      eax, edx
                              xor     edx, edx
                              mov     dl, cl
                              shl     edx, 10h
                              or      eax, edx
                              retn
              sub_403FE8      endp


              sub_404D7C      proc near               ; CODE XREF: sub_404E7C+75p

              var_C           = dword ptr -0Ch
              var_8           = dword ptr -8
              var_4           = dword ptr -4

                              push    ebx
                              push    esi
                              push    edi
                              push    ebp
                              add     esp, 0FFFFFFF4h
                              mov     [esp+0Ch+var_C], eax
                              mov     [esp+0Ch+var_8], 96h
                              mov     ebx, offset dword_4074E8

              loc_404D93:                             ; CODE XREF: sub_404D7C+EFj
                              mov     ecx, [ebx]
                              mov     esi, ecx
                              cmp     esi, 3E8h
                              jle     short loc_404DA4
                              mov     esi, 3E8h

              loc_404DA4:                             ; CODE XREF: sub_404D7C+21j
                              mov     eax, 3E8h
                              sub     eax, esi
                              test    eax, eax
                              jns     short loc_404DB2
                              add     eax, 3

              loc_404DB2:                             ; CODE XREF: sub_404D7C+31j
                              sar     eax, 2
                              mov     esi, eax
                              cmp     esi, 0B4h
                              jle     short loc_404DD6
                              mov     eax, 0FFh
                              sub     eax, esi
                              mov     edx, 4Bh
                              sub     edx, eax
                              mov     eax, 0B4h
                              sub     eax, edx
                              mov     esi, eax

              loc_404DD6:                             ; CODE XREF: sub_404D7C+41j
                              imul    eax, [ebx-8], 12Ch
                              mov     edx, ecx
                              add     edx, 1C2h
                              mov     edi, edx
                              cdq
                              idiv    edi
                              mov     edi, eax
                              add     edi, 0B7h
                              imul    eax, [ebx-4], 12Ch
                              add     ecx, 258h
                              cdq
                              idiv    ecx
                              mov     ebp, eax
                              add     ebp, 0C2h
                              push    ebp             ; int
                              push    edi             ; int
                              mov     eax, [esp+14h+var_C]
                              push    eax             ; HDC
                              call    GetPixel
                              mov     [esp+0Ch+var_4], eax
                              cmp     [esp+0Ch+var_4], 0
                              jz      short loc_404E33
                              cmp     ebp, 27h
                              jge     short loc_404E56
                              cmp     edi, 3Ch
                              jle     short loc_404E56
                              cmp     edi, 150h
                              jge     short loc_404E56

              loc_404E33:                             ; CODE XREF: sub_404D7C+A3j
                              mov     ecx, esi
                              mov     edx, esi
                              sar     edx, 1
                              jns     short loc_404E3E
                              adc     edx, 0

              loc_404E3E:                             ; CODE XREF: sub_404D7C+BDj
                              mov     eax, esi
                              call    sub_403FE8
                              or      eax, [esp+0Ch+var_4]
                              push    eax             ; COLORREF
                              push    ebp             ; int
                              push    edi             ; int
                              mov     eax, [esp+18h+var_C]
                              push    eax             ; HDC
                              call    SetPixel

              loc_404E56:                             ; CODE XREF: sub_404D7C+A8j
                                                      ; sub_404D7C+ADj ...
                              sub     dword ptr [ebx], 1Eh
                              cmp     dword ptr [ebx], 0
                              jge     short loc_404E64
                              add     dword ptr [ebx], 1770h

              loc_404E64:                             ; CODE XREF: sub_404D7C+E0j
                              add     ebx, 0Ch
                              dec     [esp+0Ch+var_8]
                              jnz     loc_404D93
                              add     esp, 0Ch
                              pop     ebp
                              pop     edi
                              pop     esi
                              pop     ebx
                              retn
              sub_404D7C      endp

;================== text
              sub_404A10      proc near               ; CODE XREF: sub_404E7C+9Cp

              var_14          = dword ptr -14h
              var_10          = dword ptr -10h
              var_C           = dword ptr -0Ch
              var_8           = dword ptr -8
              var_4           = dword ptr -4

                              push    ebp
                              mov     ebp, esp
                              add     esp, 0FFFFFFECh
                              push    ebx
                              push    esi
                              push    edi
                              xor     edx, edx
                              mov     [ebp+var_14], edx
                              mov     [ebp+var_4], eax
                              xor     eax, eax
                              push    ebp
                           
                              mov     edi, 1
                              mov     esi, offset off_4064B0

              loc_404A39:                             ; CODE XREF: sub_404A10+146j
                              mov     eax, [esi]
                              mov     [ebp+var_C], eax
                              mov     ebx, dword_407BE8
                              add     ebx, 8Bh
                              imul    eax, edi, 0Dh
                              add     ebx, eax
                              mov     eax, [ebp+var_C]
                              cmp     byte ptr [eax], 7Ah
                              jnz     short loc_404A84
                              imul    eax, edi, 0Dh
                              add     eax, dword_407BE8
                              mov     [ebp+var_10], eax
                              fild    [ebp+var_10]
                              fdiv    flt_404B9C
                              call    sub_4025CC
                              fmul    flt_404BA0
                              call    sub_4025DC
                              mov     [ebp+var_8], eax
                              inc     [ebp+var_C]
                              jmp     short loc_404A89
              ; ---------------------------------------------------------------------------

              loc_404A84:                             ; CODE XREF: sub_404A10+45j
                              xor     eax, eax
                              mov     [ebp+var_8], eax

              loc_404A89:                             ; CODE XREF: sub_404A10+72j
                              mov     cl, 0BEh
                              mov     dl, 0E6h
                              mov     al, 0E6h
                              call    sub_403FE8
                              push    eax             ; COLORREF
                              mov     eax, [ebp+var_4]
                              push    eax             ; HDC
                              call    SetTextColor
                              cmp     ebx, 8Bh
                              jle     short loc_404ADA
                              cmp     ebx, 0AAh
                              jge     short loc_404ADA
                              mov     eax, ebx
                              sub     al, 8Bh
                              mov     ecx, eax
                              shl     ecx, 3
                              sub     ecx, eax
                              mov     eax, ebx
                              sub     al, 8Bh
                              mov     edx, eax
                              shl     edx, 3
                              sub     edx, eax
                              mov     eax, ebx
                              sub     al, 8Bh
                              imul    eax, 7
                              call    sub_403FE8
                              push    eax             ; COLORREF
                              mov     eax, [ebp+var_4]
                              push    eax             ; HDC
                              call    SetTextColor

              loc_404ADA:                             ; CODE XREF: sub_404A10+94j
                                                      ; sub_404A10+9Cj
                              cmp     ebx, 0D9h
                              jle     short loc_404B14
                              mov     al, 0F8h
                              sub     al, bl
                              mov     ecx, eax
                              shl     ecx, 3
                              sub     ecx, eax
                              mov     al, 0F8h
                              sub     al, bl
                              mov     edx, eax
                              shl     eax, 3
                              sub     eax, edx
                              push    eax
                              mov     al, 0F8h
                              sub     al, bl
                              mov     edx, eax
                              shl     eax, 3
                              sub     eax, edx
                              pop     edx
                              call    sub_403FE8
                              push    eax             ; COLORREF
                              mov     eax, [ebp+var_4]
                              push    eax             ; HDC
                              call    SetTextColor

              loc_404B14:                             ; CODE XREF: sub_404A10+D0j
                              cmp     ebx, 8Bh
                              jle     short loc_404B4F
                              cmp     ebx, 0F8h
                              jge     short loc_404B4F
                              ;lea     eax, [ebp+var_14]
                              mov     edx, [ebp+var_C]
                             
                              
                              push edx
                              call lstrlen
                             
                              
                              
                              push    eax             ; int
                              mov     eax, [ebp+var_C]
                              push    eax             ; LPCSTR
                              push    ebx             ; int
                              mov     eax, [ebp+var_8]
                              add     eax, 0B7h
                              push    eax             ; int
                              mov     eax, [ebp+var_4]
                              push    eax             ; HDC
                              call    TextOutA

              loc_404B4F:                             ; CODE XREF: sub_404A10+10Aj
                                                      ; sub_404A10+112j
                              inc     edi
                              add     esi, 4
                              cmp     edi, 34h
                              jnz     loc_404A39
                              dec     dword_407BE8
                              cmp     dword_407BE8, 0FFFFFD69h
                              jge     short loc_404B78
                              mov     dword_407BE8, 0F8h

              loc_404B78:                             ; CODE XREF: sub_404A10+15Cj
                              xor     eax, eax
                              pop     edx
                              pop     ecx
                              pop     ecx
                            

              loc_404B85:                             ; CODE XREF: UPX0:00404B93j
                            
                              add esp,4*7
                              
                              retn
              sub_404A10      endp ; sp = -28h

