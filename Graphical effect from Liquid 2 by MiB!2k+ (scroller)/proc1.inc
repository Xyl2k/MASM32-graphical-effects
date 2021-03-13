              ; int __stdcall sub_4018DA(HWND hWnd)
               sub_4018DA      proc near               ; CODE XREF: DialogFunc+1E4p

               var_C           = dword ptr -0Ch
               var_8           = dword ptr -8
               var_4           = dword ptr -4
               _hWnd            = dword ptr  8

                               push    ebp
                               mov     ebp, esp
                               add     esp, 0FFFFFFF4h
                               
                  restart:             
                               
                               
                               sub     dword_40B90C, 2
                               sub     dword_40B918, 3
                               cmp     dword_40B920, 0
                               jnz     short loc_401913
                               add     byte_40B811, 2
                               cmp     byte_40B811, 0FAh
                               jbe     short loc_401936
                               mov     dword_40B920, 1
                               jmp     short loc_401936
               ; ---------------------------------------------------------------------------

               loc_401913:                             ; CODE XREF: sub_4018DA+1Bj
                               cmp     dword_40B920, 1
                               jnz     short loc_401936
                               sub     byte_40B811, 4
                               cmp     byte_40B811, 5
                               jnb     short loc_401936
                               mov     dword_40B920, 0

               loc_401936:                             ; CODE XREF: sub_4018DA+2Bj
                                                       ; sub_4018DA+37j ...
                               cmp     dword_40B914, 0
                               jnz     short loc_40195E
                               add     dword_40B910, 1
                               cmp     dword_40B910, 111h
                               jbe     short loc_401981
                               mov     dword_40B914, 1
                               jmp     short loc_401981
               ; ---------------------------------------------------------------------------

               loc_40195E:                             ; CODE XREF: sub_4018DA+63j
                               cmp     dword_40B914, 1
                               jnz     short loc_401981
                               sub     dword_40B910, 2
                               cmp     dword_40B910, 1
                               jnb     short loc_401981
                               mov     dword_40B914, 0

               loc_401981:                             ; CODE XREF: sub_4018DA+76j
                                                       ; sub_4018DA+82j ...
                               cmp     dword_40B91C, 0
                               jnz     short loc_4019A6
                               sub     dword_40B918, 2
                               cmp     dword_40B918, 0
                               jbe     short loc_4019C8
                               mov     dword_40B91C, 1
                               jmp     short loc_4019C8
               ; ---------------------------------------------------------------------------

               loc_4019A6:                             ; CODE XREF: sub_4018DA+AEj
                               cmp     dword_40B91C, 1
                               jnz     short loc_4019C8
                               inc     dword_40B918
                               cmp     dword_40B918, 0Ah
                               jnb     short loc_4019C8
                               mov     dword_40B91C, 0

               loc_4019C8:                             ; CODE XREF: sub_4018DA+BEj
                                                       ; sub_4018DA+CAj ...
                               push    0F00021h        ; DWORD
                               push    3Ch             ; int
                               push    111h            ; int
                               push    14h             ; int
                               push    0               ; int
                               push    dword_40B908    ; HDC
                               call    PatBlt
                               push    42h             ; DWORD
                               push    1Eh             ; int
                               push    0               ; int
                               push    dword_40B908    ; HDC
                               push    19h             ; int
                               push    118h            ; int
                               push    1Eh             ; int
                               push    0               ; int
                               push    dword_40B908    ; HDC
                               call    BitBlt
                               xor     eax, eax
                               mov     ah, 64h
                               shl     eax, 8
                               mov     ah, byte_40B811
                               mov     al, 0C8h
                               push    eax             ; COLORREF
                               push    dword_40B908    ; HDC
                               call    SetTextColor
                               push    offset String   ; "MiSSiNG iN ByTES present: Liquid 2 -- y"...
                               call    lstrlenA
                               push    eax             ; int
                               push    offset String   ; "MiSSiNG iN ByTES present: Liquid 2 -- y"...
                               push    22h             ; y int
                               
                               sal eax,3
                               add eax,12ah;<+start position
                               add eax,46h
                               
                               neg eax
                               cmp dword_40B90C,eax
                               jne @F
                              ; mov     dword_40B910, 22h
                              ; mov     dword_40B918, 111h
                              ; mov     dword_40B90C, 12Ch
                               
                               
                               mov rest_flag,1
                               ;jmp restart
                               
                               
                               
                               
                            @@:   
                               push    dword_40B90C    ; x int
                               push    dword_40B908    ; HDC
                               call    TextOutA
                               mov     [ebp+var_4], 1
                               mov     [ebp+var_8], 1

               loc_401A51:                             ; CODE XREF: sub_4018DA+8ECj
                               cmp     [ebp+var_4], 1
                               jnz     short loc_401A59
                               jmp     short loc_401A9F
               ; ---------------------------------------------------------------------------

               loc_401A59:                             ; CODE XREF: sub_4018DA+17Bj
                               cmp     [ebp+var_4], 2
                               jnz     short loc_401A6B
                               mov     dword_40B910, 0DFh
                               jmp     short loc_401A9F
               ; ---------------------------------------------------------------------------

               loc_401A6B:                             ; CODE XREF: sub_4018DA+183j
                               cmp     [ebp+var_4], 3
                               jnz     short loc_401A7D
                               mov     dword_40B910, 0B7h
                               jmp     short loc_401A9F
               ; ---------------------------------------------------------------------------

               loc_401A7D:                             ; CODE XREF: sub_4018DA+195j
                               cmp     [ebp+var_4], 4
                               jnz     short loc_401A8F
                               mov     dword_40B910, 8Fh
                               jmp     short loc_401A9F
               ; ---------------------------------------------------------------------------

               loc_401A8F:                             ; CODE XREF: sub_4018DA+1A7j
                               cmp     [ebp+var_4], 5
                               jnz     short loc_401A9F
                               mov     dword_40B910, 67h

               loc_401A9F:                             ; CODE XREF: sub_4018DA+17Dj
                                                       ; sub_4018DA+18Fj ...
                               mov     [ebp+var_C], 1Fh
                               push    0CC0020h        ; DWORD
                               push    1Fh             ; int
                               push    dword_40B910    ; int
                               push    dword_40B908    ; HDC
                               push    0Fh             ; int
                               push    1               ; int
                               push    1Eh             ; int
                               push    dword_40B910    ; int
                               push    dword_40B908    ; HDC
                               call    BitBlt
                               mov     eax, dword_40B910
                               sub     eax, 1
                               ;==========================================
                               push 1fh
                               call PaInT
                               
                               
                              
                               mov     eax, dword_40B910
                               sub     eax, 2
                               push 20h
                               call PaInT
                             
                               mov     eax, dword_40B910
                               sub     eax, 3
                               push 20h
                               call PaInT
                               
                               
                               mov     eax, dword_40B910
                               sub     eax, 4
                               push 21h
                               call PaInT
                               
                             
                               mov     eax, dword_40B910
                               sub     eax, 5
                               push 21h
                               call PaInT
                           
                               mov     eax, dword_40B910
                               sub     eax, 6
                               push 22h
                               call PaInT
                             
                               mov     eax, dword_40B910
                               sub     eax, 7
                               push 22h
                               call PaInT
                             
                               mov     eax, dword_40B910
                               sub     eax, 8
                               push 23h
                               call PaInT
                           
                               mov     eax, dword_40B910
                               sub     eax, 9
                               push 23h
                               call PaInT
                             
                               mov     eax, dword_40B910
                               sub     eax, 0Ah
                               push 24h
                               call PaInT
                             
                               mov     eax, dword_40B910
                               sub     eax, 0Bh
                               push 24h
                               call PaInT
                            
                               mov     eax, dword_40B910
                               sub     eax, 0Ch
                               push 24h
                               call PaInT
                          
                               mov     eax, dword_40B910
                               sub     eax, 0Dh
                               push 24h
                               call PaInT
                               
                             
                               mov     eax, dword_40B910
                               sub     eax, 0Eh
                               push 23h
                               call PaInT
                       
                               mov     eax, dword_40B910
                               sub     eax, 0Fh
                               push 23h
                               call PaInT
                       
                               mov     eax, dword_40B910
                               sub     eax, 10h
                               push 22h
                               call PaInT
                      
                               mov     eax, dword_40B910
                               sub     eax, 11h
                               push 22h
                               call PaInT
                      
                               mov     eax, dword_40B910
                               sub     eax, 12h
                               push 21h
                               call PaInT
                           
                               mov     eax, dword_40B910
                               sub     eax, 13h
                               push 21h
                               call PaInT
                               
                            
                               mov     eax, dword_40B910
                               sub     eax, 14h
                               push 20h
                               call PaInT
                         
                               mov     eax, dword_40B910
                               sub     eax, 15h
                               push 20h
                               call PaInT
                             
                               mov     eax, dword_40B910
                               sub     eax, 16h
                               push 1fh
                               call PaInT
                               
                        
                               mov     eax, dword_40B910
                               sub     eax, 17h
                               push 1fh
                               call PaInT
                          
                               mov     eax, dword_40B910
                               sub     eax, 18h
                               push 1eh
                               call PaInT
                            
                      
                               mov     eax, dword_40B910
                               sub     eax, 19h
                               push 1dh
                               call PaInT
                            
                             
                               mov     eax, dword_40B910
                               sub     eax, 1Ah
                               
                               push 1ch
                               call PaInT
                               
                          
                               mov     eax, dword_40B910
                               sub     eax, 1Bh
                               push 1bh
                               call PaInT
                               
                               
                       
                               mov     eax, dword_40B910
                               sub     eax, 1Ch
                               
                               push 1ch
                               call PaInT
                          
                               mov     eax, dword_40B910
                               sub     eax, 1Dh
                               push 19h
                               call PaInT
                               
                               
                          
                               mov     eax, dword_40B910
                               sub     eax, 1Eh
                               push 18h
                               call PaInT
                               
                               
                          
                               mov     eax, dword_40B910
                               sub     eax, 1Fh
                               push 17h
                               call PaInT
                               
                         
                               mov     eax, dword_40B910
                               sub     eax, 20h
                               push 17h
                               call PaInT
                               
                               
                               
                           
                               mov     eax, dword_40B910
                               sub     eax, 21h
                               push 17h
                               call PaInT
                               
                               
                               
                          
                               mov     eax, dword_40B910
                               sub     eax, 22h
                               push 17h
                               call PaInT
                               
                               
                       
                               mov     eax, dword_40B910
                               sub     eax, 23h
                               push 17h
                               call PaInT
                               
                               
                           
                               mov     eax, dword_40B910
                               sub     eax, 24h
                               push 18h
                               call PaInT
                               
                               
                               
                           
                               mov     eax, dword_40B910
                               sub     eax, 25h
                               push 19h
                               call PaInT
                               
                        
                               mov     eax, dword_40B910
                               sub     eax, 26h
                               push 1ah
                               call PaInT
                         
                         
                           
                               mov     eax, dword_40B910
                               sub     eax, 27h
                               push 1bh
                               call PaInT
                               
                               
                           
                               mov     eax, dword_40B910
                               sub     eax, 28h
                               push 1ch
                               call PaInT
                               
                              
                               mov     eax, dword_40B910
                               sub     eax, 29h
                               push 1dh
                               call PaInT
                               
                               
                            
                               mov     eax, dword_40B910
                               sub     eax, 2Ah
                               push 1dh
                               call PaInT
                               
                               
                               
                            
                               push    42h             ; DWORD
                               push    8               ; int
                               push    14h             ; int
                               push    1Eh             ; int
                               push    0B4h            ; int
                               push    dword_40B908    ; HDC
                               call    PatBlt
                               push    42h             ; DWORD
                               push    8               ; int
                               push    14h             ; int
                               push    1Eh             ; int
                               push    8Ch             ; int
                               push    dword_40B908    ; HDC
                               call    PatBlt
                               push    42h             ; DWORD
                               push    8               ; int
                               push    14h             ; int
                               push    1Eh             ; int
                               push    64h             ; int
                               push    dword_40B908    ; HDC
                               call    PatBlt
                               push    42h             ; DWORD
                               push    8               ; int
                               push    14h             ; int
                               push    1Eh             ; int
                               push    3Ch             ; int
                               push    dword_40B908    ; HDC
                               call    PatBlt
                               cmp     [ebp+var_8], 5
                               jnb     short loc_4021CB
                               inc     [ebp+var_8]
                               inc     [ebp+var_4]
                               jmp     loc_401A51
               ; ---------------------------------------------------------------------------

               loc_4021CB:                             ; CODE XREF: sub_4018DA+8E4j
                               xor     eax, eax
                               mov     ah, 64h
                               shl     eax, 8
                               mov     ah, byte_40B811
                               mov     al, 64h
                               push    eax             ; COLORREF
                               push    dword_40B908    ; HDC
                               call    SetTextColor
                               push    offset String   ; "MiSSiNG iN ByTES present: Liquid 2 -- y"...
                               call    lstrlenA
                               mov     ecx, dword_40B90C
                               push    eax             ; int
                               push    offset String   ; "MiSSiNG iN ByTES present: Liquid 2 -- y"...
                               push    23h             ; int
                               push    ecx             ; int
                               push    dword_40B908    ; HDC
                               call    TextOutA
                               push    0               ; bErase
                               push    offset Rect     ; lpRect
                               push    [ebp+_hWnd]      ; hWnd
                               call    InvalidateRect
                               
                               cmp rest_flag,1
                               jne @F
                               mov     dword_40B910, 22h
                               mov     dword_40B918, 111h
                               mov     dword_40B90C, 12Ch
                               mov     rest_flag,0
                               
                               
                               
                               
                             @@:  
                               leave
                               retn    4
               sub_4018DA      endp

                          PaInT proc _int:DWORD
                               push    0CC0020h        ; DWORD
                               push    _int;1Fh             ; int
                               push    eax             ; int
                               push    dword_40B908    ; HDC
                               push    0Fh             ; int
                               push    1               ; int
                               push    1Eh             ; int
                               push    eax             ; int
                               push    dword_40B908    ; HDC
                               call    BitBlt          
                               ret
           
                         PaInT endp   