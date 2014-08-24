

     
.code
init proc

push hInstance
pop hModule



                              push    4               ; int
                              call    GetStockObject
                              mov     ds:hbr, eax
                              push    0CECECEh        ; COLORREF
                              call    CreateSolidBrush
                              mov     ds:dword_40EED8, eax
                              push    505050h         ; COLORREF
                              call    CreateSolidBrush
                              mov     ds:dword_40EED0, eax
                              push    0A0A0A0h        ; COLORREF
                              call    CreateSolidBrush
                              mov     ds:dword_40EED4, eax
                              
                              push    83h             ; lpBitmapName
                              push    ds:hModule      ; hInstance
                              call    LoadBitmapA
                              mov     ds:dword_40EE9C, eax
                             
                             ifdef LUNA
                             
                             push 1
                             push    ds:hModule      ; hInstance
                             call    LoadBitmapA
                             mov hLuna,eax
                             
                            endif
                            
                              push    88h             ; lpBitmapName
                              push    ds:hModule      ; hInstance
                              call    LoadBitmapA
                              mov     ds:dword_40EEC4, eax
                              push    89h             ; lpBitmapName
                              push    ds:hModule      ; hInstance
                              call    LoadBitmapA
                              mov     ds:dword_40EEC8, eax
                              
                              push    offset stru_40AB04 ; LOGFONTA *
                              call    CreateFontIndirectA
                              mov     ds:dword_40EE64, eax
                             

                              ret
init endp