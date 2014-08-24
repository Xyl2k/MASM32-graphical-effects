               ; int __stdcall sub_402039(HDC)
               sub_402039      proc near               ; CODE XREF: DialogFunc+36p

               ;var_2C          = BITMAPINFO ptr -2Ch
               ;arg_0           = dword ptr  8

              ; LOCAL arg_0 :DWORD
               ;LOCAL var_2C :BITMAPINFO                
                               
                               
                               
                               push    ebp
                               mov     ebp, esp
                               add     esp, 0FFFFFFD4h
                               push    2Ch
                               lea     eax, [ebp-2ch]
                               push    eax
                               call    RtlZeroMemory
                               mov     dword ptr [ebp-2ch],28h;[var_2C.bmiHeader.biSize], 28h
                               push    20h
                               call    sub_4021D1
                               mov    dword ptr  [ebp-18h],eax;[var_2C.bmiHeader.biSizeImage], eax
                               mov    dword ptr  [ebp-20h],1;[var_2C.bmiHeader.biPlanes], 1
                               mov    dword ptr  [ebp-1eh],20h;[var_2C.bmiHeader.biBitCount], 20h
                               mov    dword ptr  [ebp-28h],158h;[var_2C.bmiHeader.biWidth], 158h
                               mov    dword ptr  [ebp-24h],7ch;[var_2C.bmiHeader.biHeight], 7Ch
                               mov     dword_40779F, 0
                               push    0               ; DWORD
                               push    0               ; HANDLE
                               push    offset dword_40779F ; void **
                               push    0               ; UINT
                               lea     eax, [ebp-2ch];[var_2C]
                               push    eax             ; BITMAPINFO *
                               push    0               ; HDC
                               call    CreateDIBSection
                               push    eax
                               push    [ebp+8];[arg_0]     ; HDC
                               call    CreateCompatibleDC
                               mov     dword_4077A3, eax
                               pop     edx
                               push    edx             ; HGDIOBJ
                               push    eax             ; HDC
                               call    SelectObject
                               push    offset aCourierNew ; "courier new"
                               push    0               ; DWORD
                               push    2               ; DWORD
                               push    0               ; DWORD
                               push    2               ; DWORD
                               push    0               ; DWORD
                               push    0               ; DWORD
                               push    0               ; DWORD
                               push    0               ; DWORD
                               push    2BCh            ; int
                               push    0               ; int
                               push    0               ; int
                               push    7               ; int
                               push    0Eh             ; int
                               call    CreateFontA
                               push    eax             ; HGDIOBJ
                               push    dword_4077A3    ; HDC
                               call    SelectObject
                               push    1               ; int
                               push    dword_4077A3    ; HDC
                               call    SetBkMode
                               push    0FEFEFEh        ; COLORREF
                               push    dword_4077A3    ; HDC
                               call    SetTextColor
                               push    0               ; UINT
                               push    dword_4077A3    ; HDC
                               call    SetTextAlign
                               leave
                               retn    4
               sub_402039      endp


               ; --------------- S U B R O U T I N E ---------------------------------------

               ; Attributes: bp-based frame

               sub_4021D1      proc near               ; CODE XREF: sub_402039+1Ap

               arg_0           = dword ptr  8

                               push    ebp
                               mov     ebp, esp
                               mov     eax, 158h
                               cdq
                               mul     [ebp+arg_0]
                               add     eax, 1Fh
                               and     eax, 0FFFFFFE0h
                               shr     eax, 3
                               cdq
                               mov     ecx, 7Ch
                               mul     ecx
                               leave
                               retn    4
               sub_4021D1      endp
