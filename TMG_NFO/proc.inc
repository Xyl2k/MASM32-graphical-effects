           sub_401D09      proc near               ; CODE XREF: start+19Ap
                                                   ; start+1A6p ...

           var_14          = dword ptr -14h
           var_10          = dword ptr -10h
           arg_0           = dword ptr  8
           arg_4           = dword ptr  0Ch

                           push    ebp
                           mov     ebp, esp
                           push    ebx
                           push    esi
                           push    edi
                           mov     esi, [ebp+arg_0]
                           mov     edi, esi
                           lodsd
                           stosd
                           mov     ecx, eax
                           finit
                           push    [ebp+arg_4]
                           fild    [esp+10h+var_10]
                           push    0Ah
                           fild    [esp+14h+var_14]
                           fdivp   st(1), st
                           add     esp, 8

           loc_401D2B:                             ; CODE XREF: sub_401D09+61j
                           xor     eax, eax
                           lodsw
                           movsx   eax, ax
                           push    eax
                           fild    [esp+10h+var_10]
                           fdiv    st, st(1)
                           frndint
                           fistp   [esp+10h+var_10]
                           pop     eax
                           stosw
                           xor     eax, eax
                           lodsw
                           movsx   eax, ax
                           push    eax
                           fild    [esp+10h+var_10]
                           fdiv    st, st(1)
                           frndint
                           fistp   [esp+10h+var_10]
                           pop     eax
                           stosw
                           xor     eax, eax
                           lodsw
                           movsx   eax, ax
                           push    eax
                           fild    [esp+10h+var_10]
                           fdiv    st, st(1)
                           frndint
                           fistp   [esp+10h+var_10]
                           pop     eax
                           stosw
                           loop    loc_401D2B
                           push    eax
                           fistp   [esp+10h+var_10]
                           pop     eax
                           pop     edi
                           pop     esi
                           pop     ebx
                           leave
                           retn    8
           sub_401D09      endp

