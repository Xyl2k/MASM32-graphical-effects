                              
           ; BOOL __stdcall sub_4024C6(HWND,UINT,WPARAM,LPARAM)
              sub_4024C6:;      proc near               ; DATA XREF: DialogFunc+157o

              @hWnd            = dword ptr  8
              arg_4           = dword ptr  0Ch
              arg_8           = dword ptr  10h
              lParam          = dword ptr  14h

                              enter   3Ch, 0
                              mov     dword_406FD4, edi
                              mov     dword_406FD8, esi
                              mov     dword_406FDC, edx
                              mov     dword_406FE0, ecx
                              mov     dword_406FE4, ebx
                              cmp     [ebp+arg_4],WM_INITDIALOG
                              jz      loc_40269F
                              cmp     [ebp+arg_4],WM_CLOSE
                              jz      loc_4021A8
                              cmp     [ebp+arg_4],WM_CTLCOLORDLG
                              jz      colored
                              
                              
                              cmp     [ebp+arg_4],WM_LBUTTONDOWN
                              jz      move
                              
                              cmp     [ebp+arg_4],WM_COMMAND
                              jnz     @F
                              
                              mov eax,[ebp+10h]
                              cmp ax,11
                              jne @F
                              jmp      loc_4021A8
                              
                              
                            @@:  
                              mov     eax, 0
                              leave
                              retn    10h



      loc_40269F:

     ;wm_initdialog
                             push [ebp+@hWnd]
                             pop hDlg

                             cmp lpString ,0
                             jne @F
                             
                             
                             call Get_from_file
                             ;jmp _go
                          
                          @@:   
                             
                             
                             ;mov lpString,offset  D_BEGIN
                              
                             
                              _go:
                              invoke LoadBitmap,hInstance,1
                              
                              
                              invoke SendDlgItemMessage,hDlg,11,BM_SETIMAGE,IMAGE_BITMAP,eax
                              push    0               ; lpParam
                              push    hInstance       ; hInstance
                              push    0               ; hMenu
                              push    [ebp+@hWnd]      ; hWndParent
                              push    400;5Ah             ; nHeight
                              push    650;0B0h            ; nWidth
                              push    45;1Eh             ; Y
                              push    0;0Ah             ; X
                              push    50000004h       ; dwStyle
                              push    0               ; lpWindowName
                              push    offset ClassName ; "Static"
                              push    0               ; dwExStyle
                              call    CreateWindowExA
                              mov     hWnd, eax
                              call    sub_40159B
                              push    offset TimerFunc ; lpTimerFunc
                              push    100;32h             ; uElapse
                              push    2               ; nIDEvent
                              push    [ebp+@hWnd]      ; hWnd
                              call    SetTimer
                              
                              mov     byte_4100B0, 1
                              jmp     short loc_402865

              loc_402855:                             ; CODE XREF: sub_4024C6+FAj
                              shr     eax, 10h
                              cmp     ax, 0
                              jnz     short loc_402865
                              jmp     loc_4021A8
              ; ---------------------------------------------------------------------------
                              jmp     short $+2

              loc_402865:                             ; CODE XREF: sub_4024C6+119j
                                                      ; sub_4024C6+38Dj ...
                              mov     eax, 1
                              leave
                              retn    10h
              



              loc_4021A8:                             ; CODE XREF: sub_40208A+61j
              ;wm_close                                 ; sub_40208A+3D1j ...
                              
                              push    2               ; uIDEvent
                              push    hDlg;dword ptr [ebp+8] ; hWnd
                              call    KillTimer
                              
                              
                              
                              
                              mov     dword_40803F, 32h
                              mov     byte_40803A, 1
                              mov     dword_408032, 0
                              mov     byte_407FE9, 1
                              mov     dword_408036, 1
                              mov     dword_407FEA, 0
                              mov     byte ptr hWnd, 0
                              mov     dword_40800E, 0
                              mov     dword_408012, 0
                              mov     dword_408016, 0
                              mov     dword_40802A, 0
                              mov     dword_40802E, 0
                              mov     dword_407FE5, 0
                              mov     dword_408006, 0
                              mov     byte_410206, 0
                              mov     byte_4101A7, 0
                              mov     byte_4100B0, 0
                              
                              cmp byte_41022F ,1
                              je @F
                              invoke GlobalFree,lpString
                              
                             @@: 
                              push    0               ; nResult
                              push    hDlg;[ebp+hDlg]      ; hDlg
                              call    EndDialog
                              mov     edi, dword_406FD4
                              mov     esi, dword_406FD8
                              mov     edx, dword_406FDC
                              mov     ecx, dword_406FE0
                              mov     ebx, dword_406FE4
                              leave
                              retn    10h
              
              
              
              
  colored:
  invoke GetStockObject,BLACK_BRUSH
  leave
  ret            

move:
invoke SendMessage,hDlg,WM_NCLBUTTONDOWN,HTCAPTION,lParam
leave
ret



              sub_40159B      proc near               ; CODE XREF: sub_40208A+387p
                                                      ; sub_4024C6+368p
                              pusha
                              push    offset stru_407C77 ; LOGFONTA *
                              call    CreateFontIndirectA
                              mov     dword_407FE5, eax
                              push    offset Rect     ; lpRect
                              push    hWnd            ; hWnd
                              call    GetClientRect
                              call    sub_40161E
                              mov     byte_407FE9, 1
                             
                              popa
                              retn
              sub_40159B      endp

                     
                     
                     
                     
                     
                     
              sub_40161E      proc near               ; CODE XREF: sub_40159B+20p
                                                      ; TimerFunc:loc_401610p
                              push    eax
                              push    ebx
                              push    ecx
                              push    edx
                              push    esi
                              push    edi
                              push    ebp
                              push    hWnd            ; hWnd
                              call    GetDC
                              mov     dword_407FEA, eax
                              push    dword_407FEA    ; HDC
                              call    CreateCompatibleDC
                              mov     dword_408006, eax
                              mov     eax, Rect.right
                              mov     rc.right, eax
                              push    rc.bottom       ; int
                              push    rc.right        ; int
                              push    dword_407FEA    ; HDC
                              call    CreateCompatibleBitmap
                              mov     dword_40FFA4, eax
                              push    dword_40FFA4    ; HGDIOBJ
                              push    dword_408006    ; HDC
                              call    SelectObject
                              mov     dword_40800E, eax
                              push    100000h         ; COLORREF
                              call    CreateSolidBrush
                              mov     dword_408016, eax
                              push    eax             ; hbr
                              push    offset rc       ; lprc
                              push    dword_408006    ; hDC
                              call    FillRect
                              push    1               ; int
                              push    dword_408006    ; HDC
                              call    SetBkMode
                              cmp     byte_408043, 1
                              jz      short loc_4016D0
                              inc     dword_40803B
                              cmp     dword_40803B, 6F6FFFh
                              jnz     short loc_4016E9
                              mov     byte_408043, 1

              loc_4016D0:                             ; CODE XREF: sub_40161E+97j
                              dec     dword_40803B
                              cmp     dword_40803B, 6F6F00h
                              jnz     short loc_4016E9
                              mov     byte_408043, 0

              loc_4016E9:                             ; CODE XREF: sub_40161E+A9j
                                                      ; sub_40161E+C2j
                              push    dword_40803B    ; COLORREF
                              push    dword_408006    ; HDC
                              call    SetTextColor
                              push    4               ; int
                              call    GetStockObject
                              push    dword_407FE5    ; HGDIOBJ
                              push    dword_408006    ; HDC
                              call    SelectObject
                             
              ; ---------------------------------------------------------------------------

              loc_401722:                             ; CODE XREF: sub_40161E+FBj
                              mov     eax, lpString

              loc_401727:                             ; CODE XREF: sub_40161E+102j
                              push    0E11h;DT_CENTER or DT_TOP or DT_WORDBREAK or DT_EXTERNALLEADING or DT_NOPREFIX;0E11h           ; uFormat
                              push    offset rc       ; lpRect
                              push    0FFFFFFFFh      ; nCount
                              push    eax             ; lpString
                              push    dword_408006    ; hDC
                              call    DrawTextA
                              cmp     eax, Rect.bottom
                              ja      short loc_40174C
                              mov     eax, Rect.bottom

              loc_40174C:                             ; CODE XREF: sub_40161E+127j
                              sub     eax, Rect.bottom
                              mov     dword_408036, eax
                              mov     eax, Rect.right
                              mov     rc.right, eax
                              
              ; ---------------------------------------------------------------------------

              loc_401771:                             ; CODE XREF: sub_40161E+14Aj
                              mov     eax, lpString

              loc_401776:                             ; CODE XREF: sub_40161E+151j
                              push    0A11h;DT_CENTER or DT_TOP or DT_WORDBREAK or DT_EXTERNALLEADING or DT_NOPREFIX ;0A11h           ; uFormat
                              push    offset rc       ; lpRect
                              push    0FFFFFFFFh      ; nCount
                              push    eax             ; lpString
                              push    dword_408006    ; hDC
                              call    DrawTextA
                              push    0CC0020h        ; DWORD
                              push    dword_408032    ; int
                              push    0               ; int
                              push    dword_408006    ; HDC
                              push    Rect.bottom     ; int
                              push    Rect.right      ; int
                              push    0               ; int
                              push    0               ; int
                              push    dword_407FEA    ; HDC
                              call    BitBlt
                              
                              mov     eax, dword_408032
                              cmp     byte_407FE9, 0
                              jnz     short loc_40182F
                              test    eax, eax
                              jnz     short $+2
                              push    eax
                              mov     al, byte_40803A
                              test    al, al
                              pop     eax
                              jz      short loc_40181B
                              inc     eax
                              mov     ebx, dword_408036
                              sub     ebx, 8
                              cmp     eax, ebx
                              jle     short loc_40182F
                              mov     byte_40803A, 0
                              mov     byte_407FE9, 1
                              jmp     short loc_40182F
              ; ---------------------------------------------------------------------------

              loc_40181B:                             ; CODE XREF: sub_40161E+1DDj
                              dec     eax
                              cmp     eax, 0
                              jnz     short loc_40182F
                              mov     byte_40803A, 1
                              mov     byte_407FE9, 1

              loc_40182F:                             ; CODE XREF: sub_40161E+1C0j
                                                      ; sub_40161E+1CEj ...
                              mov     dword_408032, eax
                              push    dword_40800E    ; HGDIOBJ
                              push    dword_408006    ; HDC
                              call    SelectObject
                              push    dword_40FFA4    ; HGDIOBJ
                              call    DeleteObject
                              push    dword_408016    ; HGDIOBJ
                              call    DeleteObject
                              push    dword_40800E    ; HGDIOBJ
                              call    DeleteObject
                              push    dword_408006    ; HDC
                              call    DeleteDC
                              push    dword_407FEA    ; hDC
                              push    hWnd            ; hWnd
                              call    ReleaseDC
                              pop     ebp
                              pop     edi
                              pop     esi
                              pop     edx
                              pop     ecx
                              pop     ebx
                              pop     eax
                              retn
              sub_40161E      endp


           
          



              ; --------------- S U B R O U T I N E ---------------------------------------


              ; void __stdcall TimerFunc(HWND,UINT,UINT,DWORD)
              TimerFunc       proc near               ; DATA XREF: sub_40208A+38Co
                                                      ; sub_4024C6+36Do
                              push    eax
                              push    ebx
                              push    ecx
                              push    edx
                              push    esi
                              push    edi
                              push    ebp
                              pusha
                              cmp     byte_407FE9, 1
                              jb      short loc_401606
                              inc     byte_407FE9
                              mov     eax, dword_40803F
                              cmp     byte_407FE9, al
                              jb      short loc_401610
                              mov     byte_407FE9, 0

              loc_401606:                             ; CODE XREF: TimerFunc+Fj
                              mov     eax, 190h
                              mov     dword_40803F, eax

              loc_401610:                             ; CODE XREF: TimerFunc+22j
                              call    sub_40161E
                              popa
                              pop     ebp
                              pop     edi
                              pop     esi
                              pop     edx
                              pop     ecx
                              pop     ebx
                              pop     eax
                              retn
              TimerFunc       endp

             
                              

               


                              
                              
                              
Get_from_file proc
                             
 LOCAL hFile :DWORD                            
 LOCAL ln    :DWORD
 LOCAL br    :DWORD                           
                              
             invoke CreateFile,addr lpszDiskFile,GENERIC_READ,FILE_SHARE_READ,\
                       NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL
                       mov hFile, eax
                              
 invoke GetFileSize,hFile,NULL
    mov ln, eax

    .if ln > 32767
      invoke CloseHandle,hFile
     ; szText tooBig,"Sorry, file is too large for QIKPAD"
     ; invoke MessageBox,hWnd,ADDR tooBig,ADDR szDisplayName,MB_OK
      xor eax, eax
      ret
    .endif      
        
    invoke	GlobalAlloc, GMEM_FIXED OR GMEM_ZEROINIT,ln
    
    mov lpString, eax

    invoke ReadFile,hFile,lpString,ln,ADDR br,NULL                      
     invoke CloseHandle,hFile                         
     ret                         
                              
Get_from_file endp
