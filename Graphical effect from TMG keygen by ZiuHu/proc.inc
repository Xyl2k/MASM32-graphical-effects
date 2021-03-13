   tagSIZE STRUCT
        _cx   dd ?
        cy    dd ?
        tagSIZE ENDS                  
                  
                  
                  
                  
paint_it proc hWnd:dword



                  
var_6C          = dword ptr -6Ch
 var_68          = dword ptr -68h
 var_64          = dword ptr -64h
 var_5C          = dword ptr -5Ch
 var_58          =dword ptr -58h;= tagSIZE ptr -58h
 Paint          =dword ptr -40h ;= PAINTSTRUCT ptr -40h
                 
                  
                  
                  
                  
                  
                  

                                 sub     esp, 68h
                                 mov     ecx, ds:hWndParent
                                 lea     eax, [esp+68h+Paint]
                                 push    ebx
                                 push    esi
                                 push    edi
                                 push    ebp
                                 push    eax             ; lpPaint
                                 push    ecx             ; hWnd
                                 call    BeginPaint
                                 push    eax             ; HDC
                                 mov     esi, eax
                                 mov     ebx,CreateCompatibleDC
                                 call    ebx ; CreateCompatibleDC
                                 push    68h             ; lpBitmapName
                                 mov     ebp,LoadBitmapA
                                 mov     [esp+7Ch+var_68], eax
                                 mov     eax, ds:hInstance
                                 push    eax             ; hInstance
                                 call    ebp ; LoadBitmapA
                                 mov     ecx, [esp+78h+var_68]
                                 push    eax             ; HGDIOBJ
                                 push    ecx             ; HDC
                                 mov     edi,SelectObject
                                 call    edi ; SelectObject
                                 cmp     ds:dword_408040, 2
                                 mov     [esp+78h+var_5C], eax
                                 jnz     loc_401D3E
                                 mov     eax, ds:dword_408044
                                 cmp     eax, 14h
                                 jge     loc_401BBD;<-------------------------
                                 test    eax, eax
                                 jnz     loc_401E4B
                                 fld     ds:dbl_408048
                                 fsub    ds:dbl_407000
                                 lea     eax, [esp+28h]
                                 push    eax             ; lpRect
                                 mov     ecx, ds:hWndParent
                                 fmul    ds:dbl_407008
                                 push    ecx             ; hWnd
                                 fstp    ds:dbl_409400
                                 fld     ds:dbl_408050
                                 fsub    ds:dbl_407010
                                 fmul    ds:dbl_407008
                                 fstp    ds:dbl_4093F8
                                 call    GetClientRect ; Get the coordinates of a window's client area
                                 push    0               ; COLORREF
                                 mov     ebp, CreateSolidBrush
                                 call    ebp ; CreateSolidBrush
                                 push    eax             ; hbr
                                 mov     ebx, eax
                                 lea     eax, [esp+2Ch]
                                 mov     ebp, FillRect
                                 push    eax             ; lprc
                                 push    esi             ; hDC
                                 call    ebp ; FillRect
                                 push    ebx             ; HGDIOBJ
                                 call    DeleteObject
                                 mov     ecx, [esp+78h+var_68]
                                 push    0CC0020h        ; DWORD
                                 fld     ds:dbl_408050
                                 push    0               ; int
                                 push    0               ; int
                                 push    ecx             ; HDC
                                 push    93h             ; int
                                 push    1D6h            ; int
                                 call    __ftol
                                 fld     ds:dbl_408048
                                 push    eax             ; int
                                 call    __ftol
                                 push    eax             ; int
                                 push    esi             ; HDC
                                 call    BitBlt
                                 jmp     loc_401E4B
                 ; ---------------------------------------------------------------------------

                 loc_401BBD:                             ; CODE XREF: sub_401AB0+5Fj
                                 cmp     eax, 26h
                                 jg      loc_401CD5
                                 push    esi
                                 call    ebx
                                 mov     ebx, eax
                                 push    0C8h            ; int
                                 push    25Bh            ; int
                                 push    esi             ; HDC
                                 call    CreateCompatibleBitmap
                                 push    eax             ; HGDIOBJ
                                 push    ebx             ; HDC
                                 call    SelectObject
                                 mov     ecx, ds:hWndParent
                                 mov     ebp,GetClientRect ; Get the coordinates of a window's client area
                                 mov     [esp+7Ch+var_64], eax
                                 lea     eax, [esp+7Ch+var_58-4];.cy]
                                 push    eax             ; lpRect
                                 push    ecx             ; hWnd
                                 call    ebp ; __imp_GetClientRect ; Get the coordinates of a window's client area
                                 push    0               ; COLORREF
                                 call    CreateSolidBrush
                                 push    eax             ; hbr
                                 mov     ebp, eax
                                 lea     eax, [esp+80h+var_58-4];.cy]
                                 push    eax             ; lprc
                                 push    ebx             ; hDC
                                 call    FillRect
                                 push    ebp             ; HGDIOBJ
                                 call    DeleteObject
                                 mov     ecx, 43h
                                 push    0CC0020h        ; DWORD
                                 sub     ecx, ds:dword_408044
                                 push    93h             ; int
                                 push    1D6h            ; int
                                 push    0               ; int
                                 lea     eax, [ecx+ecx*4]
                                 push    0               ; int
                                 mov     ecx, [esp+90h+var_6C]
                                 lea     ebp, ds:0[eax*2]
                                 mov     [esp+90h+var_68], ebp
                                 push    ecx             ; HDC
                                 fild    [esp+94h+var_68]
                                 fmul    ds:dbl_407018
                                 call    __ftol
                                 fld     ds:dbl_408050
                                 push    eax             ; int
                                 push    ebp             ; int
                                 call    __ftol
                                 fld     ds:dbl_408048
                                 push    eax             ; int
                                 call    __ftol
                                 push    eax             ; int
                                 push    ebx             ; HDC
                                 call    StretchBlt
                                 push    0CC0020h        ; DWORD
                                 push    0               ; int
                                 push    0               ; int
                                 push    ebx             ; HDC
                                 push    0C8h            ; int
                                 push    25Bh            ; int
                                 push    0               ; int
                                 push    0               ; int
                                 push    esi             ; HDC
                                 call    BitBlt
                                 mov     eax, [esp+7Ch+var_64]
                                 push    eax             ; HGDIOBJ
                                 push    ebx             ; HDC
                                 call    edi ; __imp_SelectObject
                                 push    eax             ; HGDIOBJ
                                 call    DeleteObject
                                 push    ebx             ; HDC
                                 call    DeleteDC
                                 fld     ds:dbl_408048
                                 fsub    ds:dbl_409400
                                 fstp    ds:dbl_408048
                                 fld     ds:dbl_408050
                                 fsub    ds:dbl_4093F8
                                 fstp    ds:dbl_408050
                                 jmp     loc_401E4B
                 ; ---------------------------------------------------------------------------

                 loc_401CD5:                             ; CODE XREF: sub_401AB0+110j
                                
                                 push    64h             ; uIDEvent
                                 mov     eax, ds:hWndParent
                                 push    eax             ; hWnd
                                 mov     ebp, KillTimer
                                 call    ebp ; __imp_KillTimer
                                 push    1               ; bErase
                                 mov     ecx, hWndParent
                                 mov     ds:dword_408040, 1
                                 push    0               ; lpRect
                                 push    ecx             ; hWnd
                                 call    InvalidateRect
                                 jmp     loc_401E4B
                 ; ---------------------------------------------------------------------------

                 loc_401D3E:                             ; CODE XREF: sub_401AB0+51j
                                 mov     eax, [esp+78h+var_68]
                                 push    0CC0020h        ; DWORD
                                 push    93h             ; int
                                 push    1D6h            ; int
                                 push    0               ; int
                                 push    0               ; int
                                 push    eax             ; HDC
                                 push    5Ah             ; int
                                 push    122h            ; int
                                 push    0Ah             ; int
                                 push    5               ; int
                                 push    esi             ; HDC
                                 call    StretchBlt
                                 push    1               ; int
                                 mov     ebp,SetBkMode
                                 push    esi             ; HDC
                                 call    ebp ;SetBkMode
                                 push    0B0A170h        ; COLORREF
                                 push    esi             ; HDC
                                 call    SetTextColor



                          loc_401E4B:
                                 lea     eax, [esp+78h+Paint]
                                 mov     ecx, ds:hWndParent
                                 push    eax             ; lpPaint
                                 push    ecx             ; hWnd
                                 call    EndPaint
                                 mov     ecx, [esp+78h+var_5C]
                                 mov     eax, [esp+78h+var_68]
                                 push    ecx             ; HGDIOBJ
                                 push    eax             ; HDC
                                 call    SelectObject
                                 push    eax             ; HGDIOBJ
                                 call    DeleteObject
                                 mov     ecx, [esp+78h+var_68]
                                 push    ecx             ; HDC
                                 call    DeleteDC
                                 push    esi             ; HDC
                                 call    DeleteDC
                                 pop     ebp
                                 pop     edi
                                 pop     esi
                                 pop     ebx
                                 add     esp, 68h
                                 add esp,4
                                 
                                 retn
                 paint_it      endp



                 __ftol          proc near               ; CODE XREF: sub_401AB0+EFp
                                                         ; sub_401AB0+FBp ...

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

