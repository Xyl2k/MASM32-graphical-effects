           sub_4012AB      proc near               ; CODE XREF: DialogFunc+483p

           arg_0           = dword ptr  8

                           push    ebp
                           mov     ebp, esp
                           mov     eax, [ebp+arg_0]
                           cmp     ax, 280h
                           jl      short loc_4012D3
                           cmp     ax, 292h
                           ja      short loc_4012D3
                           shr     eax, 10h
                           cmp     ax, 3
                           jl      short loc_4012D3
                           cmp     ax, 12h
                           ja      short loc_4012D3
                           or      eax, 0FFFFFFFFh
                           leave
                           retn    4
           ; ---------------------------------------------------------------------------

           loc_4012D3:                             ; CODE XREF: sub_4012AB+Aj
                                                   ; sub_4012AB+10j ...
                           xor     eax, eax
                           leave
                           retn    4
           sub_4012AB      endp


           ; int __stdcall sub_4023A6(HDC,COLORREF,int)
           sub_4023A6      proc near               ; CODE XREF: DialogFunc+4BAp

           arg_0           = dword ptr  8
           arg_4           = dword ptr  0Ch
           arg_8           = dword ptr  10h

                           push    ebp
                           mov     ebp, esp
                           push    2               ; int
                           push    [ebp+arg_0]     ; HDC
                           call    SetBkMode
                           push    0               ; COLORREF
                           push    [ebp+arg_0]     ; HDC
                           call    SetBkColor
                           push    [ebp+arg_4]     ; COLORREF
                           push    [ebp+arg_0]     ; HDC
                           call    SetTextColor
                           mov     eax, [ebp+arg_8]
                           leave
                           retn    0Ch
           sub_4023A6      endp

