         loc_401000:                             ; DATA XREF: sub_401780+32Fo
                         mov     eax, dword_441668
                         push    ebx
                         mov     ebx, ds:BitBlt
                         push    esi
                         xor     esi, esi
                         push    edi
                         cmp     eax, esi
                         jnz     loc_4010D4
                         mov     eax, [esp+10h]
                         mov     dword_44164C, 1
                         push    eax
                         mov     dword_441648, esi
                         mov     dword ptr dbl_441638, esi
                         mov     dword ptr dbl_441638+4, esi
                         mov     dword ptr dbl_441640, esi
                         mov     dword ptr dbl_441640+4, esi
                         mov     dword_441668, 1
                         call    ds:GetDC
                         push    esi
                         mov     esi, ds:CreateCompatibleDC
                         mov     dword_441634, eax
                         call    esi ; CreateCompatibleDC
                         mov     ecx, dword_441654
                         mov     edi, ds:SelectObject
                         push    ecx
                         push    eax
                         mov     dword_441650, eax
                         call    edi ; SelectObject
                         push    0
                         call    esi ; CreateCompatibleDC
                         mov     edx, dword_44165C
                         mov     dword_441658, eax
                         push    edx
                         push    eax
                         call    edi ; SelectObject
                         push    0
                         call    esi ; CreateCompatibleDC
                         mov     ecx, dword_441664
                         mov     dword_441660, eax
                         push    ecx
                         push    eax
                         call    edi ; SelectObject
                         mov     edx, dword_441650
                         mov     eax, dword_441658
                         push    0CC0020h
                         push    0
                         push    0
                         push    edx
                         push    44h
                         push    158h
                         push    0
                         push    0
                         push    eax
                         call    ebx ; BitBlt
                         mov     ecx, 44h
                         mov     eax, 7Dh
                         mov     edi, offset dword_441520
                         xor     esi, esi
                         rep stosd
         
         loc_4010D4:                             ; CODE XREF: .text:00401012j
                         xor     eax, eax
                         mov     dword_441630, eax
         
         loc_4010DB:                             ; CODE XREF: .text:00401112j
                         mov     ecx, dword_441520[eax*4]
                         mov     edx, dword_441650
                         add     ecx, 3Ch
                         push    0CC0020h
                         push    eax
                         push    ecx
                         push    edx
                         push    1
                         push    94h
                         push    eax
                         mov     eax, dword_441658
                         push    ecx
                         push    eax
                         call    ebx ; BitBlt
                         mov     eax, dword_441630
                         inc     eax
                         cmp     eax, 44h
                         mov     dword_441630, eax
                         jl      short loc_4010DB
                         mov     eax, dword_44164C
                         cmp     eax, esi
                         jnz     short loc_401178
                         mov     eax, offset dword_441520
         
         loc_401122:                             ; CODE XREF: .text:0040112Fj
                         mov     ecx, [eax+4]
                         mov     [eax], ecx
                         add     eax, 4
                         cmp     eax, offset dword_44162C
                         jl      short loc_401122
                         mov     eax, dword_441648
                         mov     dword_44162C, 7Dh
                         inc     eax
                         cmp     eax, 64h
                         mov     dword_441648, eax
                         jle     loc_4015E3
                         mov     dword ptr dbl_441640, 0
                         mov     dword ptr dbl_441640+4, 0
                         mov     dword_441648, esi
                         mov     dword_44164C, 1
                         jmp     loc_4015E3
         ; ---------------------------------------------------------------------------
         
         loc_401178:                             ; CODE XREF: .text:0040111Bj
                         cmp     eax, 1
                         jnz     loc_40120D
                         mov     eax, offset dword_441520
         
         loc_401186:                             ; CODE XREF: .text:00401193j
                         mov     edx, [eax+4]
                         mov     [eax], edx
                         add     eax, 4
                         cmp     eax, offset dword_44162C
                         jl      short loc_401186
                         fld     dbl_441640
                         fsin
                         fmul    ds:dbl_42F4A0
                         fadd    ds:dbl_42F498
                         call    __ftol
                         fld     dbl_441640
                         fadd    ds:dbl_42F490
                         mov     dword_44162C, eax
                         fst     dbl_441640
                         fcomp   ds:dbl_42F488
                         fnstsw  ax
                         test    ah, 1
                         jnz     short loc_4011E4
                         fld     dbl_441640
                         fsub    ds:dbl_42F488
                         fstp    dbl_441640
         
         loc_4011E4:                             ; CODE XREF: .text:004011D0j
                         mov     eax, dword_441648
                         inc     eax
                         cmp     eax, 64h
                         mov     dword_441648, eax
                         jle     loc_4015E3
                         mov     dword_441648, esi
                         mov     dword_44164C, 2
                         jmp     loc_4015E3
         ; ---------------------------------------------------------------------------
         
         loc_40120D:                             ; CODE XREF: .text:0040117Bj
                         mov     edi, 2
                         cmp     eax, edi
                         jnz     loc_40129B
                         mov     eax, offset dword_441520
         
         loc_40121F:                             ; CODE XREF: .text:0040122Cj
                         mov     ecx, [eax+4]
                         mov     [eax], ecx
                         add     eax, 4
                         cmp     eax, offset dword_44162C
                         jl      short loc_40121F
                         fld     dbl_441640
                         fadd    ds:dbl_42F480
                         sub     dword_44162C, edi
                         fst     dbl_441640
                         fcomp   ds:dbl_42F488
                         fnstsw  ax
                         test    ah, 1
                         jnz     short loc_401265
                         fld     dbl_441640
                         fsub    ds:dbl_42F488
                         fstp    dbl_441640
         
         loc_401265:                             ; CODE XREF: .text:00401251j
                         cmp     dword_44162C, 6
                         jg      loc_4015E3
                         mov     dword ptr dbl_441640, 0
                         mov     dword ptr dbl_441640+4, 0
                         mov     dword_441648, esi
                         mov     dword_44164C, 3
                         jmp     loc_4015E3
         ; ---------------------------------------------------------------------------
         
         loc_40129B:                             ; CODE XREF: .text:00401214j
                         cmp     eax, 3
                         jnz     loc_401332
                         mov     eax, offset dword_441520
         
         loc_4012A9:                             ; CODE XREF: .text:004012B6j
                         mov     edx, [eax+4]
                         mov     [eax], edx
                         add     eax, 4
                         cmp     eax, offset dword_44162C
                         jl      short loc_4012A9
                         fld     dbl_441640
                         fsin
                         fmul    ds:dbl_42F4A0
                         fadd    ds:dbl_42F478
                         call    __ftol
                         fld     dbl_441640
                         fadd    ds:dbl_42F490
                         mov     dword_44162C, eax
                         fst     dbl_441640
                         fcomp   ds:dbl_42F488
                         fnstsw  ax
                         test    ah, 1
                         jnz     short loc_401307
                         fld     dbl_441640
                         fsub    ds:dbl_42F488
                         fstp    dbl_441640
         
         loc_401307:                             ; CODE XREF: .text:004012F3j
                         mov     eax, dword_441648
                         inc     eax
                         cmp     eax, 9Bh
                         mov     dword_441648, eax
                         jle     loc_4015E3
                         mov     dword_441648, esi
                         mov     dword_44164C, 4
                         jmp     loc_4015E3
         ; ---------------------------------------------------------------------------
         
         loc_401332:                             ; CODE XREF: .text:0040129Ej
                         cmp     eax, 4
                         jnz     short loc_4013A6
                         mov     eax, offset dword_441520
         
         loc_40133C:                             ; CODE XREF: .text:00401349j
                         mov     ecx, [eax+4]
                         mov     [eax], ecx
                         add     eax, 4
                         cmp     eax, offset dword_44162C
                         jl      short loc_40133C
                         mov     eax, dword_441648
                         mov     dword_44162C, 6
                         inc     eax
                         cmp     eax, 64h
                         mov     dword_441648, eax
                         jle     loc_4015E3
         
         __cfltcvt_init:
                         mov     dword ptr dbl_441640, 0
                         mov     dword ptr dbl_441640+4, 0
                         mov     dword ptr dbl_441638, 0
                         mov     dword ptr dbl_441638+4, 0
                         mov     dword_441648, esi
                         mov     dword_44164C, 5
                         jmp     loc_4015E3
         ; ---------------------------------------------------------------------------
         
         loc_4013A6:                             ; CODE XREF: .text:00401335j
                         cmp     eax, 5
                         jnz     loc_401454
                         mov     eax, offset dword_441520
         
         loc_4013B4:                             ; CODE XREF: .text:004013C1j
                         mov     edx, [eax+8]
                         mov     [eax], edx
                         add     eax, 8
                         cmp     eax, offset dword_441628
                         jl      short loc_4013B4
                         mov     eax, offset unk_441524
         
         loc_4013C8:                             ; CODE XREF: .text:004013D5j
                         mov     ecx, [eax+8]
                         mov     [eax], ecx
                         add     eax, 8
                         cmp     eax, offset dword_44162C
                         jl      short loc_4013C8
                         fld     dbl_441640
                         fsin
                         fmul    ds:dbl_42F4A0
                         fadd    ds:dbl_42F478
                         call    __ftol
                         fld     dbl_441640
                         fadd    ds:dbl_42F490
                         mov     dword_441628, eax
                         mov     eax, dword_44162C
                         add     eax, edi
                         mov     dword_44162C, eax
                         fst     dbl_441640
                         fcomp   ds:dbl_42F488
                         fnstsw  ax
                         test    ah, 1
                         jnz     short loc_401432
                         fld     dbl_441640
                         fsub    ds:dbl_42F488
                         fstp    dbl_441640
         
         loc_401432:                             ; CODE XREF: .text:0040141Ej
                         cmp     dword_44162C, 7Dh
                         jl      loc_4015E3
                         mov     dword_441648, esi
                         mov     dword_44164C, 6
                         jmp     loc_4015E3
         ; ---------------------------------------------------------------------------
         
         loc_401454:                             ; CODE XREF: .text:004013A9j
                         cmp     eax, 6
                         jnz     loc_40154E
                         mov     eax, offset dword_441520
         
         loc_401462:                             ; CODE XREF: .text:0040146Fj
                         mov     edx, [eax+8]
                         mov     [eax], edx
                         add     eax, 8
                         cmp     eax, offset dword_441628
                         jl      short loc_401462
                         mov     eax, offset unk_441524
         
         loc_401476:                             ; CODE XREF: .text:00401483j
                         mov     ecx, [eax+8]
                         mov     [eax], ecx
                         add     eax, 8
                         cmp     eax, offset dword_44162C
                         jl      short loc_401476
                         fld     dbl_441640
                         fsin
                         fmul    ds:dbl_42F4A0
                         fadd    ds:dbl_42F478
                         call    __ftol
                         fld     dbl_441638
                         fsin
                         mov     dword_441628, eax
                         fmul    ds:dbl_42F4A0
                         fadd    ds:dbl_42F498
                         call    __ftol
                         fld     dbl_441640
                         fadd    ds:dbl_42F480
                         mov     dword_44162C, eax
                         fst     dbl_441640
                         fcomp   ds:dbl_42F488
                         fnstsw  ax
                         test    ah, 1
                         jnz     short loc_4014F2
                         fld     dbl_441640
                         fsub    ds:dbl_42F488
                         fstp    dbl_441640
         
         loc_4014F2:                             ; CODE XREF: .text:004014DEj
                         fld     dbl_441638
                         fsub    ds:dbl_42F480
                         fst     dbl_441638
                         fcomp   ds:dbl_42F470
                         fnstsw  ax
                         test    ah, 41h
                         jz      short loc_401523
                         fld     dbl_441638
                         fadd    ds:dbl_42F488
                         fstp    dbl_441638
         
         loc_401523:                             ; CODE XREF: .text:0040150Fj
                         mov     eax, dword_441648
                         inc     eax
                         cmp     eax, 96h
                         mov     dword_441648, eax
                         jle     loc_4015E3
                         mov     dword_441648, esi
                         mov     dword_44164C, 7
                         jmp     loc_4015E3
         ; ---------------------------------------------------------------------------
         
         loc_40154E:                             ; CODE XREF: .text:00401457j
                         cmp     eax, 7
                         jnz     loc_4015E3
                         mov     eax, offset dword_441520
         
         loc_40155C:                             ; CODE XREF: .text:00401569j
                         mov     edx, [eax+8]
                         mov     [eax], edx
                         add     eax, 8
                         cmp     eax, offset dword_441628
                         jl      short loc_40155C
                         mov     eax, offset unk_441524
         
         loc_401570:                             ; CODE XREF: .text:0040157Dj
                         mov     ecx, [eax+8]
                         mov     [eax], ecx
                         add     eax, 8
                         cmp     eax, offset dword_44162C
                         jl      short loc_401570
                         fld     dbl_441638
                         fsin
                         add     dword_441628, edi
                         fmul    ds:dbl_42F4A0
                         fadd    ds:dbl_42F498
                         call    __ftol
                         fld     dbl_441638
                         fsub    ds:dbl_42F480
                         mov     dword_44162C, eax
                         fst     dbl_441638
                         fcomp   ds:dbl_42F470
                         fnstsw  ax
                         test    ah, 41h
                         jz      short loc_4015D4
                         fld     dbl_441638
                         fadd    ds:dbl_42F488
                         fstp    dbl_441638
         
         loc_4015D4:                             ; CODE XREF: .text:004015C0j
                         cmp     dword_441628, 7Dh
                         jl      short loc_4015E3
                         mov     dword_44164C, esi
         
         loc_4015E3:                             ; CODE XREF: .text:00401149j
                                                 ; .text:00401173j ...
                         xor     eax, eax
                         mov     dword_441630, eax
         
         loc_4015EA:                             ; CODE XREF: .text:00401622j
                         mov     edx, dword_441660
                         push    0CC0020h
                         push    eax
                         push    esi
                         mov     ecx, dword_441658
                         push    edx
                         push    1
                         push    94h
                         push    eax
                         mov     eax, dword_441520[eax*4]
                         add     eax, 3Ch
                         push    eax
                         push    ecx
                         call    ebx ; BitBlt
                         mov     eax, dword_441630
                         inc     eax
                         cmp     eax, 44h
                         mov     dword_441630, eax
                         jl      short loc_4015EA
                         mov     edx, dword_441658
                         mov     eax, dword_441634
                         push    0CC0020h
                         push    esi
                         push    esi
                         push    edx
                         push    44h
                         push    158h
                         push    5;106h
                         push    5;0Ah
                         push    eax
                         call    ebx ; BitBlt
                         pop     edi
                         pop     esi
                         pop     ebx
                         retn    10h
         ; ---------------------------------------------------------------------------
                         align 4
                         push    ebx
                         push    ebp
                         push    esi
                         push    edi
                         mov     edi, ecx
                         push    1
                         mov     eax, [edi+1Ch]
                         push    eax
                         call    ds:KillTimer
                         mov     ecx, dword_441650
                         mov     ebx, ds:ReleaseDC
                         xor     esi, esi
                         cmp     ecx, esi
                         jz      short loc_401689
                         cmp     edi, esi
                         jnz     short loc_40167C
                         xor     eax, eax
                         jmp     short loc_40167F
         ; ---------------------------------------------------------------------------
         
         loc_40167C:                             ; CODE XREF: .text:00401676j
                         mov     eax, [edi+1Ch]
         
         loc_40167F:                             ; CODE XREF: .text:0040167Aj
                         push    ecx
                         push    eax
                         call    ebx ; ReleaseDC
                         mov     dword_441650, esi
         
         loc_401689:                             ; CODE XREF: .text:00401672j
                         mov     eax, dword_441654
                         mov     ebp, ds:DeleteObject
                         cmp     eax, esi
                         jz      short loc_4016A1
                         push    eax
                         call    ebp ; DeleteObject
                         mov     dword_441654, esi
         
         loc_4016A1:                             ; CODE XREF: .text:00401696j
                         mov     ecx, dword_441658
                         cmp     ecx, esi
                         jz      short loc_4016C0
                         cmp     edi, esi
                         jnz     short loc_4016B3
                         xor     eax, eax
                         jmp     short loc_4016B6
         ; ---------------------------------------------------------------------------
         
         loc_4016B3:                             ; CODE XREF: .text:004016ADj
                         mov     eax, [edi+1Ch]
         
         loc_4016B6:                             ; CODE XREF: .text:004016B1j
                         push    ecx
                         push    eax
                         call    ebx ; ReleaseDC
                         mov     dword_441658, esi
         
         loc_4016C0:                             ; CODE XREF: .text:004016A9j
                         mov     eax, dword_44165C
                         cmp     eax, esi
                         jz      short loc_4016D2
                         push    eax
                         call    ebp ; DeleteObject
                         mov     dword_44165C, esi
         
         loc_4016D2:                             ; CODE XREF: .text:004016C7j
                         mov     ecx, dword_441660
                         cmp     ecx, esi
                         jz      short loc_4016F1
                         cmp     edi, esi
                         jnz     short loc_4016E4
                         xor     eax, eax
                         jmp     short loc_4016E7
         ; ---------------------------------------------------------------------------
         
         loc_4016E4:                             ; CODE XREF: .text:004016DEj
                         mov     eax, [edi+1Ch]
         
         loc_4016E7:                             ; CODE XREF: .text:004016E2j
                         push    ecx
                         push    eax
                         call    ebx ; ReleaseDC
                         mov     dword_441660, esi
         
         loc_4016F1:                             ; CODE XREF: .text:004016DAj
                         mov     eax, dword_441664
                         cmp     eax, esi
                         jz      short loc_401703
                         push    eax
                         call    ebp ; DeleteObject
                         mov     dword_441664, esi
         
         loc_401703:                             ; CODE XREF: .text:004016F8j
                         mov     ecx, edi
                         ;call    ?OnDestroy@CWnd@@IAEXXZ ; CWnd::OnDestroy(void)
                         pop     edi
                         pop     esi
                      pop     ebp
                         pop     ebx
                         retn

                         
                         
                         
                         
         ; Attributes: library function bp-based frame
         
         __ftol          proc near               ; CODE XREF: .text:004011A9p
                                                 ; .text:004012CCp ...
         
         var_C           = qword ptr -0Ch
         var_4           = word ptr -4
         var_2           = word ptr -2
         
                         push    ebp
                         mov     ebp, esp
                         add     esp, 0FFFFFFF4h
                         fstcw   [ebp+var_2]
                         wait
                         mov     ax, [ebp+var_2]
                         or      ah, 0Ch
                         mov     [ebp+var_4], ax
                         fldcw   [ebp+var_4]
                         fistp   [ebp+var_C]
                         fldcw   [ebp+var_2]
                         mov     eax, dword ptr [ebp+var_C]
                         mov     edx, dword ptr [ebp+var_C+4]
                         leave
                         retn
         __ftol          endp
         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         