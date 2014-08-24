.data
hitem dd ?


.code
DlgProc PROC hWnd:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
     
                                add esp,-50h
     
     
     
     
                       .if uMsg==WM_INITDIALOG

                               mov     dword_4077A7, 7Ch
                               mov     dword_4077AF, 0
                               mov     dword_4077AB, 2
                               
                               
                               
                               push    [hWnd]      ; hWnd
                               call    GetWindowDC
                               
                               
                               
                               push    eax             ; HDC
                               call    sub_402039
                               push    0               ; lpTimerFunc
                               push    2Eh             ; uElapse
                               push    1               ; nIDEvent
                               push    [hWnd]      ; hWnd
                               call    SetTimer
                               
     
                         .elseif uMsg==WM_PAINT 
     
     
                               lea     eax, [ebp-50h]
                               push    eax             ; lpPaint
                               push    [hWnd]      ; hWnd
                               call    BeginPaint
                               push    eax
                               lea     eax, [ebp-10h]
                               push    eax             ; lpRect
                               push    [hWnd]      ; hWnd
                               call    GetClientRect
                               pop     eax
                               push    0CC0020h        ; DWORD
                               push    0               ; int
                               push    0               ; int
                               push    dword_4077A3    ; HDC
                               push    7Ch             ; int
                               push    158h            ; int
                               push    0               ; int
                               push    0               ; int
                               push    eax             ; HDC
                               call    BitBlt
                               lea     eax, [ebp-50h]
                               push    eax             ; lpPaint
                               push    [hWnd]      ; hWnd
                               call    EndPaint
                              
     
                      .elseif uMsg==WM_TIMER
   
                               cmp  dword ptr   [ebp+10h], 1
                               jnz     ret1
                               call    sub_40210C
                               mov     dword ptr  [ebp-10h], 0
                               mov      dword ptr [ebp-0ch], 0
                               mov     dword ptr  [ebp-8], 158h
                               mov     dword ptr  [ebp-4], 7Ch
                               push    0               ; bErase
                               lea     eax, [ebp-10h]
                               push    eax             ; lpRect
                               push    [hWnd]      ; hWnd
                               call    InvalidateRect
                              

                        .elseif uMsg==WM_CTLCOLORDLG ;||WM_CTLCOLORSTATIC       

                               push    0B48033h        ; COLORREF
                               push    [ebp+10h]     ; HDC
                               call    SetTextColor
                               push    0               ; COLORREF
                               push    [ebp+10h]     ; HDC
                               call    SetBkColor
                               push    2               ; int
                               push    [ebp+10h]     ; HDC
                               call    SetBkMode
                               push    0               ; COLORREF
                               call    CreateSolidBrush
                               ret
   
                       
                       
                       
                       .elseif uMsg==WM_LBUTTONDOWN
                                jmp @exit
     

     
                       .ELSEIF uMsg == WM_CLOSE
                         @exit:   invoke EndDialog,hWnd,0
     
     
     .ELSE
     xor eax,eax
     ret
     
     
     
     .ENDIF
ret1:
  xor eax,eax
     inc eax
     ret

DlgProc ENDP