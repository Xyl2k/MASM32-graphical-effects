.data

dword_401294    dd 14h

xImgPos		equ	0Eh
yImgPos		equ	14h

.data?
                  
                  dword_401E00    dd ?                    ; DATA XREF: sub_4018D3+2A5o
                                                          ; sub_4018D3+2E3w
                  dword_401E04    dd ?                    ; DATA XREF: sub_4018D3+2D7w
                  dword_401E08    dd ?                    ; DATA XREF: sub_4018D3+2ECw
                  word_401E0C     dw ?                    ; DATA XREF: sub_4018D3+2FFw
                  word_401E0E     dw ?                    ; DATA XREF: sub_4018D3+305w
                  dword_401E10    dd ?                    ; DATA XREF: sub_4018D3+30Ew
                                  dd 5 dup(?)
                  ; RECT stru_401E28
                  stru_401E28     RECT <?>     


                       


                  ; HDC dword_401E38
                  dword_401E38    dd ?                    ; DATA XREF: TimerFunc+3Dw
                                                          ; TimerFunc+14Er ...
                                  ;align 10h
                  ; BITMAPINFO stru_401E40
                  stru_401E40     BITMAPINFO <>          ; DATA XREF: TimerFunc+10Do
                                                  


                  dword_401DF8    dd ?                    



                  ; RECT stru_401E70
                  stru_401E70     RECT <?>                ; DATA XREF: DialogFunc+1C5w
                                                          ; DialogFunc+275o ...
                  ; int dword_401E80
                  LogoWidth	      dd ?                    ; DATA XREF: TimerFunc+15r
                                                          ; TimerFunc+C3r ...
                  ; UINT dword_401E84
                  LogoHeight      dd ?                    ; DATA XREF: TimerFunc+9r
                                                          ; TimerFunc+B8r ...
                  ; HDC dword_401E88
                  dword_401E88    dd ?                    ; DATA XREF: DialogFunc+52w
                                                          ; DialogFunc+AAr ...
                                  
                  ; RECT rc
                  rc              RECT <?>                ; DATA XREF: DialogFunc+63o
                                                          ; DialogFunc+204w ...
                  ; HINSTANCE hInstance
                ;  hInstance       dd ?                    ; DATA XREF: DialogFunc+230r
                                                          ; sub_4018D3+D0r ...
                                 
                  ; int dword_401EA8
                  dword_401EA8    dd ?                    ; DATA XREF: DialogFunc+91r
                                             



                  ; HGDIOBJ dword_401DB8
                  dword_401DB8    dd ?                    ; DATA XREF: DialogFunc+1ABr
                                                          ; DialogFunc+260r ...
                  byte_401DBC     db ?                    ; DATA XREF: TimerFuncr
                                                          ; TimerFunc+Ew
                                  
                  ; HBRUSH hbr
                  hbr             dd ?                    ; DATA XREF: DialogFunc+5Dr
                                                          ; DialogFunc+345r ...
                                  
                  ; RECT stru_401DC8
                  stru_401DC8     RECT <?>                ; DATA XREF: sub_4018D3+12Cw
                                                          ; sub_4018D3+3C5o ...
                  ; RECT stru_401DD8
                  stru_401DD8     RECT <?>                ; DATA XREF: DialogFunc+1E3w
                                                          ; DialogFunc+2FBo ...
                  dword_401DE8    dd ?                    ; DATA XREF: TimerFunc+42w
                                                          ; TimerFunc:loc_401498r ...
                  ; HBRUSH dword_401DEC
                  dword_401DEC    dd ?                    ; DATA XREF: DialogFunc+26Fr
                                                          ; sub_4018D3+1A4w ...
                  ; HGDIOBJ dword_401DF0
                  dword_401DF0    dd ?                    ; DATA XREF: DialogFunc:loc_401670r
                                                          ; DialogFunc+17Bw
                  ; HDC dword_401DF4
                  dword_401DF4    dd ?       




                  ; HGDIOBJ dword_401EB0
                  dword_401EB0    dd ?                    ; DATA XREF: TimerFunc+F5r
                                                          ; TimerFunc+11Fr ...
                  ; HDC hDC
                  hDC             dd ?                    ; DATA XREF: TimerFunc+101r
                                                          ; TimerFunc+125r ...
                  ; LPVOID lpAddress
                  lpAddress       dd ?                    ; DATA XREF: TimerFunc+5Er
                                                          ; TimerFunc+D4r ...
                  ; LPVOID dword_401EBC
                  dword_401EBC    dd ?                    ; DATA XREF: TimerFunc:loc_401463r
                                                          ; TimerFunc+EDr ...
                  dword_401EC0    dd ?                    ; DATA XREF: TimerFunc+99w
                                                          ; TimerFunc+A7r
                  inDC 			  dd ? 
                                  
.code                                                                    
FadeBmp proc hWnd:DWORD;,uMsg:DWORD;,wParam:DWORD,lParam:DWORD                      
                                  
          hDlg            = dword ptr  8
          arg_4           = dword ptr  0Ch
          arg_8           = dword ptr  10h
          arg_C           = dword ptr  14h
                        
                                  
                                  xor     ebx,ebx
                                  invoke LoadBitmap,hInstance,201
                                  mov     dword_401EB0, eax
                                  mov     LogoHeight, 7Ah
                                  mov     LogoWidth, 148h
                                  jmp     short loc_401AFD

                  loc_401AFD:                             ; CODE XREF: sub_4018D3+20Fj
                                  push    [ebp+hDlg]      ; hWnd
                                  call    GetDC
                                  push    eax             ; HDC
                                  mov     [ebp+arg_8], eax
                                  call    CreateCompatibleDC
                                  push    dword_401EB0    ; HGDIOBJ
                                  mov     hDC, eax
                                  push    eax             ; HDC
                                  call    SelectObject
                                  mov     eax, LogoHeight
                                  imul    eax, LogoWidth
                                  lea     eax, [eax+eax*2]
                                  mov     edi, 1000h
                                  push    40h             ; flProtect
                                  push    edi             ; flAllocationType
                                  push    eax             ; dwSize
                                  push    ebx             ; lpAddress    
                                  call    VirtualAlloc
                                  mov     lpAddress, eax
                                  mov     eax, LogoWidth
                                  imul    eax, LogoHeight
                                  push    40h             ; flProtect
                                  push    edi             ; flAllocationType
                                  lea     eax, [eax+eax*2]
                                  push    eax             ; dwSize
                                  push    ebx             ; lpAddress
                                  call    VirtualAlloc
                                  push    2Ch
                                  push    ebx
                                  push    offset stru_401E40
                                  mov     dword_401EBC, eax
                                  call    sub_401D60
                                  push    28h
                                  mov     esi, offset dword_401E00
                                  pop     edi
                                  push    edi
                                  push    ebx
                                  push    esi
                                  call    sub_401D60
                                  mov     eax, LogoWidth
                                  imul    eax, LogoHeight
                                  lea     eax, [eax+eax*2]
                                  push    eax
                                  push    ebx
                                  push    lpAddress
                                  call    sub_401D60
                                  mov     eax, LogoWidth
                                  add     esp, 24h
                                  mov     dword_401E04, eax
                                  mov     eax, LogoHeight
                                  push    0Eh             ; int
                                  mov     dword_401E00, edi
                                  push    [ebp+arg_8]     ; HDC
                                  mov     dword_401E08, eax
                                  call    GetDeviceCaps
                                  push    0Ah
                                  mov     edi, offset stru_401E40
                                  pop     ecx
                                  mov     word_401E0C, ax
                                  mov     word_401E0E, 18h
                                  mov     dword_401E10, ebx
                                  rep movsd
                                  mov     esi, offset stru_401E40
                                  push    ebx             ; UINT
                                  push    esi             ; LPBITMAPINFO
                                  push    dword_401EBC    ; LPVOID
                                  push    LogoHeight    ; UINT
                                  push    ebx             ; UINT
                                  push    dword_401EB0    ; HBITMAP
                                  push    hDC             ; HDC
                                  call    GetDIBits
                                  mov     ecx, LogoHeight
                                  cmp     eax, ecx
                                  jnz     loc_40190B
                                  push    ebx             ; UINT
                                  push    esi             ; BITMAPINFO *
                                  push    lpAddress       ; void *
                                  push    ecx             ; UINT
                                  push    ebx             ; UINT
                                  push    dword_401EB0    ; HBITMAP
                                  push    hDC             ; HDC
                                  call    SetDIBits
                                  push    0CC0020h        ; DWORD
                                  push    ebx             ; int
                                  push    ebx             ; int
                                  push    hDC             ; HDC
                                  push    LogoHeight    ; int
                                  push    LogoWidth    ; int
                                  push    1Eh             ; int
                                  push    1Eh             ; int
                                  push    [ebp+arg_8]     ; HDC
                                  call    BitBlt
                                  push    offset TimerFunc ; lpTimerFunc
                                  push    28h             ; uElapse
                                  push    1               ; nIDEvent
                                  push    [ebp+hDlg]      ; hWnd
                                  call    SetTimer
                                  
                  loc_40190B:    
                                  
                                  ret
FadeBmp endp


;#########################################################################################

                  sub_401D60      proc near               ; CODE XREF: sub_4018D3+29Ep
                                                          ; sub_4018D3+2AEp ...

                  arg_0           = dword ptr  4
                  arg_4           = byte ptr  8
                  arg_8           = dword ptr  0Ch

                                  mov     edx, [esp+arg_8]
                                  mov     ecx, [esp+arg_0]
                                  test    edx, edx
                                  jz      short loc_401DB3
                                  xor     eax, eax
                                  mov     al, [esp+arg_4]
                                  push    edi
                                  mov     edi, ecx
                                  cmp     edx, 4
                                  jb      short loc_401DA7
                                  neg     ecx
                                  and     ecx, 3
                                  jz      short loc_401D89
                                  sub     edx, ecx

                  loc_401D83:                             ; CODE XREF: sub_401D60+27j
                                  mov     [edi], al
                                  inc     edi
                                  dec     ecx
                                  jnz     short loc_401D83

                  loc_401D89:                             ; CODE XREF: sub_401D60+1Fj
                                  mov     ecx, eax
                                  shl     eax, 8
                                  add     eax, ecx
                                  mov     ecx, eax
                                  shl     eax, 10h
                                  add     eax, ecx
                                  mov     ecx, edx
                                  and     edx, 3
                                  shr     ecx, 2
                                  jz      short loc_401DA7
                                  rep stosd
                                  test    edx, edx
                                  jz      short loc_401DAD

                  loc_401DA7:                             ; CODE XREF: sub_401D60+18j
                                                          ; sub_401D60+3Fj ...
                                  mov     [edi], al
                                  inc     edi
                                  dec     edx
                                  jnz     short loc_401DA7

                  loc_401DAD:                             ; CODE XREF: sub_401D60+45j
                                  mov     eax, [esp+4+arg_0]
                                  pop     edi
                                  retn
                  ; ---------------------------------------------------------------------------

                  loc_401DB3:                             ; CODE XREF: sub_401D60+Aj
                                  mov     eax, [esp+arg_0]
                                  retn
                  sub_401D60      endp

;##########################################################################################
                  ; void __stdcall TimerFunc(HWND,UINT,UINT,DWORD)
                  TimerFunc       proc near               ; DATA XREF: sub_4018D3+38Co

                  @hWnd            = dword ptr  4

                                  test    byte_401DBC, 1
                                  jnz     short loc_40143D
                                  mov     eax, LogoHeight
                                  or      byte_401DBC, 1
                                  imul    eax, LogoWidth
                                  lea     eax, [eax+eax*2]
                                  mov     dword_401DF8, eax

                  loc_40143D:                             ; CODE XREF: TimerFunc+7j
                                  push    ebx
                                  push    ebp
                                  mov     ebp, [esp+8+@hWnd]
                                  push    esi
                                  push    edi
                                  push    ebp             ; hWnd
                                  call    GetDC
                                  xor     edi, edi
                                  xor     esi, esi
                                  cmp     dword_401DF8, edi
                                  mov     dword_401E38, eax
                                  mov     dword_401DE8, esi
                                  jle     short loc_4014AD

                  loc_401463:                             ; CODE XREF: TimerFunc+92j
                                  mov     eax, dword_401EBC
                                  mov     bl, [eax+esi]
                                  movzx   ecx, bl
                                  mov     eax, ecx
                                  cdq
                                  idiv    dword_401294
                                  mov     edx, lpAddress
                                  add     esi, edx
                                  mov     dl, [esi]
                                  mov     [esp+10h+@hWnd], eax
                                  sub     ecx, eax
                                  movzx   eax, dl
                                  cmp     eax, ecx
                                  jge     short loc_401496
                                  add     dl, byte ptr [esp+10h+@hWnd]
                                  mov     [esi], dl
                                  jmp     short loc_401498
                  ; ---------------------------------------------------------------------------

                  loc_401496:                             ; CODE XREF: TimerFunc+73j
                                  mov     [esi], bl

                  loc_401498:                             ; CODE XREF: TimerFunc+7Bj
                                  mov     esi, dword_401DE8
                                  inc     esi
                                  cmp     esi, dword_401DF8
                                  mov     dword_401DE8, esi
                                  jl      short loc_401463

                  loc_4014AD:                             ; CODE XREF: TimerFunc+48j
                                  mov     eax, dword_401294
                                  inc     dword_401EC0
                                  mov     ebx, ReleaseDC
                                  add     eax, eax
                                  cmp     dword_401EC0, eax
                                  jle     short loc_401525
                                  push    1               ; uIDEvent
                                  push    ebp             ; hWnd
                                  call    KillTimer
                                  
                                  mov     eax, LogoHeight
                                  mov     esi, VirtualFree
                                  imul    eax, LogoWidth
                                  mov     edi, 4000h
                                  lea     eax, [eax+eax*2]
                                  push    edi             ; dwFreeType
                                  push    eax             ; dwSize
                                  push    lpAddress       ; lpAddress
                                  call    esi ; VirtualFree
                                  mov     eax, LogoHeight
                                  push    edi             ; dwFreeType
                                  imul    eax, LogoWidth
                                  lea     eax, [eax+eax*2]
                                  push    eax             ; dwSize
                                  push    dword_401EBC    ; lpAddress
                                  call    esi ; VirtualFree
                                  push    dword_401EB0    ; HGDIOBJ
                                  call    DeleteObject
                                  push    hDC             ; hDC
                                  push    ebp             ; hWnd
                                  call    ebx ; ReleaseDC
                                  xor     edi, edi

                  loc_401525:                             ; CODE XREF: TimerFunc+ADj
                                  push    edi             ; UINT
                                  push    offset stru_401E40 ; BITMAPINFO *
                                  push    lpAddress       ; void *
                                  push    LogoHeight    ; UINT
                                  push    edi             ; UINT
                                  push    dword_401EB0    ; HBITMAP
                                  push    hDC             ; HDC
                                  call    SetDIBits
                                  push    0CC0020h        ; DWORD
                                  push    edi             ; int
                                  push    edi             ; int
                                  push    hDC             ; HDC
                                  push    LogoHeight    ; int
                                  push    LogoWidth    ; int
                                  push    yImgPos             ; int
                                  push    xImgPos            ; int
                                  push    dword_401E38    ; HDC
                                  call    BitBlt
                                  push    dword_401E38    ; hDC
                                  push    ebp             ; hWnd
                                  call    ebx ; ReleaseDC
                                  pop     edi
                                  pop     esi
                                  pop     ebp
                                  pop     ebx
                                  retn    10h
                  TimerFunc       endp


                  ; --------------- S U B R O U T I N E ---------------------------------------

