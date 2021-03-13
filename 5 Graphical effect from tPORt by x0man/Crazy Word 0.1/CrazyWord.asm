AboutProc	PROTO :HWND,:UINT,:WPARAM,:LPARAM;sub_401A25 		PROTO :HWND,:UINT,:WPARAM,:LPARAM
sub_401775 		PROTO
sub_4017AD 		PROTO :DWORD
sub_4017CC 		PROTO :DWORD,:DWORD
sub_401802 		PROTO
sub_4017E2 		PROTO
StartAddress 	PROTO
sub_4019C7 		PROTO


.data

; HWND dword_40C004
dword_40C004    dd 0                    ; DATA XREF: sub_401292+49r

; HWND dword_40C008
dword_40C008    dd 0                    ; DATA XREF: sub_401292+64r

; LPARAM dword_40C010
dword_40C010    dd 0                    ; DATA XREF: sub_401292+43r

; HGDIOBJ dword_40C014
dword_40C014    dd 0                    ; DATA XREF: sub_401292+1F3r

; HGDIOBJ dword_40C018
dword_40C018    dd 0                    ; DATA XREF: sub_401292+255r

; HGDIOBJ dword_40C020
dword_40C020    dd 0                    ; DATA XREF: sub_401292+2Dr

; HGDIOBJ dword_40C024
dword_40C024    dd 0                    ; DATA XREF: sub_401292+8Fr

; HGDIOBJ dword_40C02C
dword_40C02C    dd 0                    ; DATA XREF: sub_401292+110r

; HGDIOBJ dword_40C030
dword_40C030    dd 0                    ; DATA XREF: sub_401292+172r


AboutText db	'      tHE PERYFERiAH tEAM  ',0Dh
			db	'            present:          ',0Dh,0Dh,0Dh
			db	'tARGEt    : Asoftis PC Cleaner 1.2',0Dh
			db	'CracKeR   : r0ger',0Dh
			db	'rls date  : 2.3.2o21',0Dh
			db	'pr0tecti0n: s/n',0Dh
			db	'v2m tune  : f0LL0w THE LiGHT',0Dh,0Dh,0Dh,0Dh
			db	' algo originally coded by TeRcO',0Dh
			db	' but then i`ve translated it',0Dh
			db	' from delphi to masm .',0Dh,0Dh,0Dh,0Dh
			db	'sh0ut 0ut 2:',0Dh,0Dh
			db	'  MagicH for the V2m lib',0Dh
			db	'  SofT MANiAC for the V2m',0Dh
			db	'  x0man for the about template',0Dh
			db	'  KesMezar for a lil bit of help',0Dh
			db	'     4 ripping this about temp',0Dh
			db	'  and kao for a lil bit of help',0Dh
			db	'     on translating the algo.',0Dh,0Dh,0Dh,0Dh
			db	'greetz fly 0ut 2:',0Dh,0Dh
			db	'  Al0hA',0Dh
			db	'  B@TRyNU',0Dh
			db	'  ShTEFY',0Dh
			db	'  DAViiiiDDDDDDD',0Dh
			db	'  GRUiA[neinfricatul]',0Dh
			db	'  MaryNello',0Dh
			db	'  yMRAN',0Dh
			db	'  sabYn',0Dh
			db	'  s0r3l',0Dh
			db	'  r1ckyTiTAN',0Dh
			db	'  WeeGee',0Dh
			db	'  st3fan(C)ADR!AN',0Dh
			db	'  aMaLiAVerSace',0Dh
			db	'  SiD',0Dh
			db	'  mYu',0Dh
			db	'  Gyahnni',0Dh
			db	'  bDM10',0Dh
			db	'  oViSpider',0Dh,0Dh
			db	'  + other PRF memberz around !',0Dh,0Dh,0Dh,0Dh
			db	'but also:',0Dh,0Dh
			db	'  GioTiN',0Dh
			db	'  [X-Ray]',0Dh
			db	'  Cachito',0Dh
			db	'  TeRcO',0Dh
			db	'  Xylitol',0Dh
			db	'  TeddyRogers',0Dh
			db	'  Tux528',0Dh
			db	'  SKG-1010',0Dh
			db	'  nuttertools',0Dh
			db	'  GlacialManDoUtDes',0Dh
			db	'  Bl4ckCyb3rEnigm4',0Dh
			db	'  kao',0Dh
			db	'  atom0s',0Dh
			db	'  TomaHawk',0Dh
			db	'  M!X0R',0Dh
			db	'  EarthMan123',0Dh
			db	'  dj-siba',0Dh
			db	'  Jowy (a.k.a H!X)',0Dh,0Dh,0Dh,0Dh,0Dh
			db	'         u can find us at',0Dh,0Dh
			db	'[ youtube : MC Roger............ ]',0Dh
			db	'[ facebook: Darius Dan.......... ]',0Dh
			db	'[ ig : @r0gerica................ ]',0Dh
			db	'[ .... @peryferiah.artpack...... ]',0Dh,0Dh
			db	'   or on discord + other sites',0Dh,0Dh
			db	'[ discord : r0gerica#2649....... ]',0Dh
			db	'[ dA : r0gerica................. ]',0Dh
			db	'[ furaff  : r0gerica............ ]',0Dh
			db	'[ github  : r0gerica............ ]',0Dh,0Dh,0Dh,0Dh
			db	'[        fuck da ripperz   :E    ]',0
				
				
; HWND dword_40C419
dword_40C419    dd 0                    ; DATA XREF: sub_401A25+21w

dword_40C41D	BOOL	FALSE										; this must be aGlobalStop , right?
										
dword_40C421    dd 0                    ; DATA XREF: sub_401775+31w

dword_40C425    dd 0                    ; DATA XREF: sub_4017E2+Aw

; HGLOBAL hMem
hMem            dd 0                    ; DATA XREF: sub_4017E2+1Aw

JumpHeight    	dd 1Eh                  ; DATA XREF: StartAddress+9Dr 
TextLeft    	dd 1Eh             ; DATA XREF: sub_401802+6r
                                    
StartPosition    dd 0D2h               ; DATA XREF: sub_401802+Fr 

dword_40C439    dd 0                    ; DATA XREF: StartAddress+74r
                                        
dword_40C43D    dd 0                    ; DATA XREF: StartAddress+8Cr
                           
; HDC hdc
hdc             dd 0                    ; DATA XREF: StartAddress+13Dr
                                     
; HDC hdcDest
hdcDest         dd 0                    ; DATA XREF: StartAddress+53r
                                      
; HGDIOBJ dword_40C449
dword_40C449    dd 0                    ; DATA XREF: sub_401A25+DCw
                                     
; HGDIOBJ h
;h               dd 0                    ; DATA XREF: sub_401A25+B0w
                                                                     
                                        
; DWORD ThreadId
ThreadId        dd 0                    ; DATA XREF: sub_401A25+157o
                               
; DWORD dword_40C455
dword_40C455    dd 0                    ; DATA XREF: sub_401A25+16Eo
                              
AboutBoxTitle          db "ab0utb0x",0          ; DATA XREF: sub_401A25+72o

AboutFont     db "Terminal",0      ; DATA XREF: sub_401A25+B5o

TextLength     db 62h                 ; DATA XREF: StartAddress+F3r; length of text
	

.code

sub_401775      proc ;near               ; CODE XREF: sub_401A25+27p
;SystemTime      = SYSTEMTIME ptr -10h
local SystemTime:SYSTEMTIME
                lea     eax, SystemTime
                push    eax            
                call    GetSystemTime
                movzx   eax, SystemTime.wHour
                imul    eax, 3Ch
                add     ax, SystemTime.wMinute
                imul    eax, 3Ch
                xor     edx, edx
                mov     dx, SystemTime.wSecond
                add     eax, edx
                imul    eax, 3E8h
                mov     dx, SystemTime.wMilliseconds
                add     eax, edx
                mov     dword_40C421, eax
				ret
sub_401775      endp


sub_4017AD      proc arg_0000:DWORD;near               ; CODE XREF: StartAddress+A3p
;arg_0000           = dword ptr  8
                mov     eax, arg_0000
                imul    edx, dword_40C421, 8088405h
                inc     edx
                mov     dword_40C421, edx
                mul     edx
                mov     eax, edx
				ret
sub_4017AD      endp


sub_4017CC      proc arg_000:DWORD,arg_444:DWORD
;arg_000           = dword ptr  8
;arg_444           = dword ptr  0Ch
                shr     [arg_444], 1
                shr     [arg_000], 1
                mov     eax, arg_000
                sub     arg_444, eax
                mov     eax,arg_444
				ret
sub_4017CC      endp


sub_4017E2      proc near 
                push    offset AboutText
                call    lstrlen
                mov     dword_40C425, eax
                imul    eax, 15h
                push    eax      
                push    40h  
                call    GlobalAlloc
                mov     hMem, eax
				ret
sub_4017E2      endp


sub_401802      proc
LOCAL var_88:DWORD
LOCAL var_44:DWORD
                push    TextLeft
                pop var_44
                push    StartPosition
                pop var_88
                mov     edx, hMem
                mov     ecx, offset AboutText
                xor     eax, eax
loc_401827: 
                push    eax
                mov     al, [ecx]
                mov     [edx], al
                push var_44
                pop     dword ptr [edx+1]
                push var_88
                pop     dword ptr [edx+5]
                push    dword ptr [edx+1]
                pop     dword ptr [edx+9]
                push    dword ptr [edx+5]
                pop     dword ptr [edx+0Dh]
                add var_44,8
                add     edx, 15h
                cmp     al, 0Dh
                jnz     short loc_40185C
                push    TextLeft
                pop var_44
                add var_88,0Fh
loc_40185C: 
                pop     eax
                inc     eax
                inc     ecx
                cmp     dword_40C425, eax
                ja      short loc_401827
				ret
sub_401802      endp

StartAddress    proc
LOCAL hdcSrc:HDC 
LOCAL hBackground:DWORD
LOCAL var_4:DWORD
                push    0 
                call    CreateCompatibleDC
                mov hdcSrc,eax 
                invoke FindResource,hInstance,p00p,eax                 
			
;IFDEF USE_JPG
	invoke BitmapFromResource, eax, p00p
;ELSE
;	invoke LoadBitmap, eax, p00p		(NOTE: p00p is actually a resource for the aboutbox background.)
;ENDIF				
                mov hBackground,eax
                push hBackground
                push hdcSrc
                call    SelectObject

	; to get all the gradient colors of the selected background , you must enter 0Ah on loc_401897 section.
	
loc_401897:    
                mov var_4,0
                push    0CC0020h; color for solid background i think ..
                push    0Ah ;0C8h picture height (200)
                push    0Ah ;190h picture width (400) 
                push    0     
                push    0          
                push    hdcSrc
                push    0C8h ; height 
                push    140h ; width
                push    0 
                push    0   
                push    hdcDest       
                call    StretchBlt
                mov     edx, hMem

loc_4018CD:  
                mov     eax, [edx+5]
                cmp     [edx+0Dh], eax
                jnz     short loc_401939
                mov     eax, [edx+1]
                mov     ecx, eax
                add     ecx, 7
                cmp     dword_40C439, eax
                jb      short loc_40193F
                cmp     dword_40C439, ecx
                ja      short loc_40193F
                mov     eax, [edx+5]
                mov     ecx, eax
                add     ecx, 0Fh
                cmp     dword_40C43D, eax
                jb      short loc_401937
                cmp     dword_40C43D, ecx
                ja      short loc_401937
                push    edx
                push    JumpHeight
                call    sub_4017AD
                pop     edx
                mov     ecx, eax
                push    edx
                push    2
                call    sub_4017AD
                pop     edx
                cmp     al, 1
                jnz     short loc_40192D
                mov     dword ptr [edx+11h], 1
                imul    ecx, -1
                jmp     short loc_401934
; ---------------------------------------------------------------------------
loc_40192D:                   
                mov     dword ptr [edx+11h], 0FFFFFFFFh
loc_401934:           
                add     [edx+5], ecx
loc_401937:  
                jmp     short loc_40193F
; ---------------------------------------------------------------------------
loc_401939: 
                mov     eax, [edx+11h]
                add     [edx+5], eax
loc_40193F:    
                push    edx
                cmp     byte ptr [edx], 0Dh
                jz      short loc_40195B
                push    1    
                lea     eax, [edx]
                push    eax  
                push    dword ptr [edx+5]
                push    dword ptr [edx+1] 
                push    hdcDest        
                call    TextOut

loc_40195B:  
                pop     edx
                movzx   ecx, TextLength
                imul    ecx, 0Fh
                imul    ecx, -1
                cmp     ecx, [edx+5]
                jnz     short loc_401975
                pusha
                call    sub_401802
                popa

loc_401975:   
                add     edx, 15h
                mov     eax, dword_40C425
                inc var_4
                cmp var_4,eax
                jb      loc_4018CD
                push    0CC0020h; bg color  
                push    0             
                push    0             
                push    hdcDest  
                push    0C8h ; height
                push    140h ; width  
                push    0          
                push    0           
                push    hdc         
                call    BitBlt
                push    14h ; jumping revert time
                call    Sleep
                cmp     dword_40C41D, 1
                jnz     loc_401897
				ret
StartAddress    endp


sub_4019C7      proc 
                mov     ecx, dword_40C425
                mov     edx, hMem
loc_4019D3: 
                mov     eax, [edx+5]
                cmp     [edx+0Dh], eax
                jnz     short loc_401A09
                push    ecx
                push    edx
                push    3
                call    sub_4017AD
                mov     ecx, eax
                push    2
                call    sub_4017AD
                pop     edx
                cmp     al, 1
                jnz     short loc_4019FE
                mov     dword ptr [edx+11h], 1
                imul    ecx, -1
                jmp     short loc_401A05
; ---------------------------------------------------------------------------
loc_4019FE: 
                mov     dword ptr [edx+11h], 0FFFFFFFFh
loc_401A05: 
                add     [edx+5], ecx
                pop     ecx
loc_401A09:    
                dec     dword ptr [edx+0Dh]
                dec     dword ptr [edx+5]
                add     edx, 15h
                loop    loc_4019D3
                push    1Eh ; scroll speed
                call    Sleep
                cmp     dword_40C41D, 1
                jnz     short sub_4019C7
				ret
sub_4019C7      endp


AboutProc proc hWnd:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
LOCAL Y:DWORD;Y               = dword ptr -8
LOCAL X:DWORD;X               = dword ptr -4
;hWnd_            = dword ptr  8
;LOCAL arg_4000:DWORD;arg_4           = dword ptr  0Ch
;LOCAL arg_C:DWORD;arg_C           = dword ptr  14h

                mov eax,uMsg;arg_4000
                cmp     eax, 110h
                jnz     loc_401BAF
                mov     dword_40C41D, 0
                push hWnd
                pop     dword_40C419
                call    sub_401775
                push    0  
                call    GetSystemMetrics
                push    eax
                push    140h ; width
                call    sub_4017CC
                mov X,eax;
                push    1     
                call    GetSystemMetrics
                push    eax
                push    0C8h ; height
                call    sub_4017CC
                mov Y,eax;
                push    40h   
                push    0C8h ; height
                push    140h ; width   
                push Y
                push X
                push    0 
                push hWnd
                call    SetWindowPos
                push    offset AboutBoxTitle
                push hWnd
                call    SetWindowText
                push    dword_40C419 ;wnd
                call    GetDC
                mov     hdc, eax
                push    0  
                call    CreateCompatibleDC
                mov     hdcDest, eax
                push    0  
                push    20h
                push    1    
                push    0C8h ; height 
                push    140h ; width
                call    CreateBitmap
                mov     hBitmap, eax
                push    offset AboutFont
                push    0    
                push    0   
                push    0  
                push    0  
                push    1
                push    0  
                push    0 
                push    0  
                push    140h ; width
                push    0  
                push    0  
                push    0   
                push    08h; text size
                invoke CreateFont, 12, 8, 0, 0, 400, 0, 0, 0,
				DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
				DEFAULT_QUALITY, DEFAULT_PITCH, addr AboutFont
                mov     dword_40C449, eax ;mov ahFont,eax
                push    hBitmap
                push    hdcDest        
                call    SelectObject
                push    dword_40C449    
                push    hdcDest        
                call    SelectObject
                push    1              
                push    hdcDest         
                call    SetBkMode
                xor     eax, eax
                mov     ah, 0
                mov     al, 0
                rol     eax, 8
                mov     al, 0
                push    0FFFEFDh ; color of text
                push    hdcDest        
                call    SetTextColor
                push    28h ; oval size           
                push    28h ; oval size         
                push    0C8h ; height   
                push    140h ; width
                push    0           
                push    0          
                call    CreateRoundRectRgn
                push    1            
                push    eax          
                push hWnd
                call    SetWindowRgn
                call    sub_4017E2
                call    sub_401802
                push    offset ThreadId 
                push    0            
                push    0               
                push    offset StartAddress 
                push    0             
                push    0              
                call    CreateThread
                push    offset dword_40C455 
                push    0               
                push    0               
                push    offset sub_4019C7
                push    0               
                push    0             
                call    CreateThread
                jmp     loc_401C83
; ---------------------------------------------------------------------------
loc_401BAF:                  
                cmp uMsg,200h
                jnz     short loc_401BD5
                mov eax,lParam;arg_C
                and     eax, 0FFFFh
                mov     dword_40C439, eax
                mov eax,lParam;arg_C
                shr     eax, 10h
                mov     dword_40C43D, eax
                jmp     loc_401C83
; ---------------------------------------------------------------------------
loc_401BD5:                            
                cmp     eax, 201h
                jnz     short loc_401BF2
                push    0               
                push    2              
                push    0A1h          
                push hWnd
                call    SendMessage
                jmp     loc_401C83
; ---------------------------------------------------------------------------
loc_401BF2:                            
                cmp     eax, 205h
                jnz     short loc_401C09
                push    0             
                push    0               
                push    10h           
                push hWnd
                call    SendMessage
                jmp     short loc_401C83
; ---------------------------------------------------------------------------
loc_401C09:                           
                cmp     eax, 10h
                jnz     short loc_401C83
                mov     dword_40C41D, 1
                push    64h            
                call    Sleep
                push    hdc             
                push    dword_40C419   
                call    ReleaseDC
                push    hdcDest         
                call    DeleteObject
                push    dword_40C449    
                call    DeleteObject
                push    hBitmap
                call    DeleteObject
                push    0              
                push    ThreadId       
                call    TerminateThread
                push    0              
                push    dword_40C455   
                call    TerminateThread
                push    hMem          
                call    GlobalFree
                push    0              
                push    dword_40C419 
                call    EndDialog
loc_401C83:                                                             
                xor     eax, eax
				ret
AboutProc      endp