
AboutProc	PROTO :HWND,:UINT,:WPARAM,:LPARAM
Rndmproc proto	:DWORD
Randomize proto	:DWORD, :DWORD
Palettecolour proto	
LoadUp proto	:HWND
GlobalRemove proto	:HWND
SpotlightMovement proto
BasicWorks proto
PrintText proto
ScrollingCredits proto
MemoryReset proto	:DWORD, :DWORD	

.data
hModule         dd 0
dword_406164 dd 0;->
byte_4060D0 BYTE	0
byte_4060CF BYTE	0
AboutFont     LOGFONT <12,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY, 0,"Terminal">

TextLength		dd	offset	AboutBoxText
AboutBoxText      db	'PERYFERiAH tEAM pr0udly present :', 0
				db	'tARGEt   : Macrorit Disk',13
				db  '           Partition Expert 4.3.1',13
				db  'CracKeR  : r0ger',13
				db  'Date     : 2 5 . o 3 . 2 o 2 1',13
				db  'c0mpiler : delphi 2.0 - 7.0',13
				db  'tune     : mein planlos land',0
				db  'Gr33tz fly out to Al0hA,B@TRyNU,',13
				db  'ShTEFY,DAViiiiDDDDDDD,GRUiA,',13
				db  'MaryNello,NoNNy,r0bica,WeeGee,',13
				db  'yMRAN,r0cky,st3fan(C)ADR!AN,',13
				db  'sabYn and other prf memberz !',0
				db  'but also to GioTiN,KesMezar,',13
				db  'kao,SKG-1010,Roentgen,Cachito,',13
				db  'Xylitol,Teddy Rogers, and others',13
				db  'i`ve actually mentioned in the',13
				db  'text scroller .',0
				db  'sh0ut 0ut 2 :',13,13
				db  'eNeRGy/dAWN for the v2m lib',13
				db  'MAP for the CooL music',13
				db  'Rustem for coding the aboutbox effect',13
				db  'and KesMezar for helping me on rippin',13
				db  '   this cool aboutbox effect :)',0
				db  'u can find us at:',13,13
				db  'yt : MC Roger/KGMusicPack2o2o',13
				db  'ig : @r0gerica',13
				db  '     @peryferiah.artpack',0
				db  'or on discord + other sites:',13,13
				db  'discord : r0gerica#2649',13
				db  'dArt    : r0gerica',13
				db  'furaff  : r0gerica',13
				db  'github  : r0gerica',0
				db  ' fuck da ripperz . :E',0    
				

				
yAxisWidth equ 220				

.data?

dword_406170 dd ?;->
dword_40616C dd ?
dword_406174 dd ?
yAxis dd ?
dword_406168 dd ? ; <- figure..

hAboutfont 			HFONT		?
ppvBits 				PVOID		?
BitmapDC				HBITMAP		?
hdc						HDC			?
dword_40618C			HGDIOBJ		?
dword_406190			HGDIOBJ		?


dword_406194	DWORD ? 
dword_406198	DWORD ? 


.code

MemoryReset      proc uses edi arg_0, arg_4: DWORD 
                cld
                mov     edi,arg_0
                mov     ecx,arg_4
                shr     ecx, 2
                xor     eax, eax
                jecxz   short loc_4010DC
                rep stosd
loc_4010DC:                  
                mov     ecx,arg_4
                and     ecx, 3
                jecxz   short loc_4010E6
                rep stosb
loc_4010E6:                   
                pop     edi
				ret
MemoryReset      endp




TextColorz      proc near
                mov     al, byte_4060D0
                cmp     al, 0FFh
                jnz     short loc_4010FD
                mov     byte_4060CF, 0FFh
                jmp     short loc_401108
loc_4010FD:               
                or      al, al
                jnz     short loc_401108
                mov     byte_4060CF, 1
loc_401108:                         
                add     al, byte_4060CF
                mov     byte_4060D0, al
                ret
TextColorz      endp



Lightcolors      proc arg_00:BYTE, arg_44:BYTE, arg_88:BYTE
                movzx   eax, arg_88
                shl     eax, 8
                mov     al, arg_44
                shl     eax, 8
                mov     al, arg_00
				ret
Lightcolors      endp



Rndmproc      proc arg_000: DWORD
                mov     eax, dword_406170
                imul    eax, 343FDh
                mov     dword_406170, eax
                mov     ecx, dword_406170
                add     ecx, 269EC3h
                mov     dword_406170, ecx
                mov     eax, dword_406170
                shr     eax, 10h
                and     eax, 7FFFh
                xor     edx, edx
                div     arg_000
                mov     eax, edx
				ret
Rndmproc      endp




Randomize      proc arg_0000: DWORD, arg_4444: DWORD
                mov     eax,arg_0000
                cmp     eax,arg_4444
                jnz     short loc_40117A
                mov     eax,arg_0000
				ret
loc_40117A:     
                mov     ecx,arg_4444
                sub     ecx,arg_0000
                push    ecx
                call    Rndmproc
                mov     edx,arg_0000
                add     eax, edx
				ret
Randomize      endp


Palettecolour      proc;PALET
LOCAL var_FF:BYTE
LOCAL var_EE:BYTE
LOCAL var_DD:BYTE
LOCAL var_CC:DWORD
LOCAL var_88888:DWORD;-> COUNTER
LOCAL var_44444:DWORD;->
                mov var_FF,0;-> RED
                mov var_EE,0;-> GREEN
                mov var_DD,0;-> BLUE
                mov var_CC,0
				
                push    4    
                push    3000h   
                push    400h  
                push    0     
                call    VirtualAlloc
				
                mov     dword_406164, eax;?
                mov     var_44444, 0
                jmp     short loc_4011FA
loc_4011C9:                    
                mov     ecx, var_44444
                mov     edx, dword_406164
                mov     byte ptr [edx+ecx*4], 0FCh
                mov     eax, var_44444
                mov     ecx, dword_406164
                mov     byte ptr [ecx+eax*4+1], 0FCh
                mov     edx, var_44444
                mov     eax, dword_406164
                mov     byte ptr [eax+edx*4+2], 0FCh
                mov     eax, var_44444
                add     eax, 1
                mov     var_44444, eax
loc_4011FA:                          
                cmp     var_44444, 100h
                jb      short loc_4011C9
                mov     var_44444, 0
                jmp     loc_40129F
loc_40120F:                          
                mov     var_88888, 4
                jmp     short loc_40128D
loc_401218:                          
                cmp     var_44444, 0
                jnz     short loc_401226
                mov     al, byte ptr [var_88888]
                mov     var_FF, al
                jmp     short loc_40124C
loc_401226:                      
                cmp     var_44444, 1
                jnz     short loc_401238
                mov     var_FF, 0FCh
                mov     cl, byte ptr [var_88888]
                mov     var_EE, cl
                jmp     short loc_40124C
loc_401238:                         
                cmp     var_44444, 2
                jnz     short loc_40124C
                mov     var_FF, 0FCh
                mov     var_EE, 0FCh
                mov     dl, byte ptr [var_88888]
                mov     var_DD, dl
loc_40124C:                         
                mov     eax, var_CC
                mov     ecx, dword_406164
                mov     dl, var_FF
                mov     [ecx+eax*4], dl
                mov     eax, var_CC
                mov     ecx, dword_406164
                mov     dl, var_EE
                mov     [ecx+eax*4+1], dl
                mov     eax, var_CC
                mov     ecx, dword_406164
                mov     dl, var_DD
                mov     [ecx+eax*4+2], dl
                mov     eax, var_CC
                add     eax, 1
                mov     var_CC, eax
                mov     edx, var_88888
                add     edx, 4
                mov     var_88888, edx
loc_40128D:                            
                cmp     var_88888, 0FCh
                jbe     short loc_401218
                mov     ecx, var_44444
                add     ecx, 1
                mov     var_44444, ecx
loc_40129F:                           
                cmp     var_44444, 3
                jb      loc_40120F
                mov     eax, dword_406164
				ret
Palettecolour      endp



LoadUp      proc hWnd: HWND 
LOCAL var_7CC: DWORD
LOCAL rcttag: RECT;=tagRECT
LOCAL bminfo: BITMAPINFO;=BITMAPINFO
LOCAL lfo: LOGFONT;=LOGFONTA				
                push    2Ch
                lea     eax, bminfo
                push    eax
                call    MemoryReset				
                push    3Ch
                lea     eax, lfo
                push    eax
                call    MemoryReset			
                mov     lfo.lfHeight, 10h ; letter height
                push    offset AboutFont ; font name , as usual ...
                lea     eax, lfo.lfFaceName
                push    eax     
                call    lstrcpy
                lea     eax, lfo
                push    eax       
                invoke    CreateFontIndirect,addr AboutFont
                mov     hAboutfont, eax
                lea     eax, rcttag
                push    eax   
                push    hWnd  
                call    GetWindowRect
                mov     edx, rcttag.right
                sub     edx, rcttag.left
                mov     dword_406174, edx;X
                mov     eax, rcttag.bottom
                sub     eax, rcttag.top
                mov     yAxis, eax;Y
                xor     eax, eax
                rdtsc				
                mov     dword_406170, eax;
                call    Palettecolour
                mov     dword_406164, eax				
                push    6 ; maximum figure
                push    3 ; minimum figure
                call    Randomize				
                mov     dword_40616C, eax;				
                imul    eax, 18h				
                push    4       
                push    3000h   
                push    eax 
                push    0             
                call    VirtualAlloc				
                mov     dword_406168, eax;				
                mov     var_7CC, 0
                mov     eax, var_7CC
                jmp     loc_401458
loc_401359:                         
                mov     var_7CC, eax
                push    dword_406174
                push    0
                call    Randomize
                mov     edx, var_7CC
                imul    edx, 18h
                mov     ecx, dword_406168
                mov     [edx+ecx], eax
                push    yAxis
                push    0
                call    Randomize
                mov     ecx, var_7CC
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+4], eax
                push    64h
                push    14h
                call    Randomize
                imul    eax, 2710h
                mov     ecx, var_7CC
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+10h], eax
                push    2
                call    Rndmproc
                or      eax, eax
                jnz     short loc_4013DA
                push    0Ah
                push    2
                call    Randomize
                mov     ecx, var_7CC
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+8], eax
                jmp     short loc_4013F5
loc_4013DA:                   
                push    0Ah
                push    2
                call    Randomize
                neg     eax
                mov     ecx, var_7CC
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+8], eax
loc_4013F5:                     
                push    2
                call    Rndmproc
                or      eax, eax
                jnz     short loc_40141B
                push    0Ah
                push    2
                call    Randomize
                mov     ecx, var_7CC
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+0Ch], eax
                jmp     short loc_401436
loc_40141B:                         
                push    0Ah
                push    2
                call    Randomize
                neg     eax
                mov     ecx, var_7CC
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+0Ch], eax
loc_401436:                        
                push    46h
                push    14h
                call    Randomize
                mov     ecx, var_7CC
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+14h], eax
                mov     eax, var_7CC
                add     eax, 1
                mov     var_7CC, eax
loc_401458:                           
                cmp     eax, dword_40616C
                jb      loc_401359				
                push    0            
                push    19h            
                push    1             
                push    hWnd     
                call    SetTimer				
                push    0            
                push    1            
                push    2           
                push    hWnd    
                call    SetTimer
                mov     bminfo.bmiHeader.biSize, 28h		
                mov     ecx, dword_406174;X
                mov     bminfo.bmiHeader.biWidth, ecx
                mov     edx, yAxis;Y
                mov     bminfo.bmiHeader.biHeight, edx
                mov     bminfo.bmiHeader.biPlanes, 1
                mov     bminfo.bmiHeader.biBitCount,20h
                mov     bminfo.bmiHeader.biCompression, 0
                push    0  
                call    CreateCompatibleDC				
                mov     hdc, eax;
                push    0    
                push    0   
                push    offset ppvBits
                push    0   
                lea     eax, bminfo
                push    eax          
                push    hdc   
                call    CreateDIBSection				
                mov     BitmapDC, eax;
                push    BitmapDC  
                push    hdc  
                call    SelectObject				
                mov     dword_40618C, eax				
                push    hAboutfont   
                push    hdc  
                call    SelectObject				
                mov     dword_406190, eax			
                push    1       
                push    hdc  
                call    SetBkMode
				ret
LoadUp      endp



GlobalRemove      proc hWnd: HWND; global remove (?)
                push    8000h         
                push    0         
                push    offset dword_406164
                call    VirtualFree				
                push    8000h         
                push    0             
                push    offset dword_406168 ;SEKIL
                call    VirtualFree			
                push    1          
                push    hWnd    
                call    KillTimer			
                push    dword_406190;->
                push    hdc
                call    SelectObject
                push    hAboutfont;hFont
                call    DeleteObject				
                push    dword_40618C;->
                push    hdc       
                call    SelectObject				
                push    BitmapDC;->
                call    DeleteObject
                push    hdc 
                call    DeleteDC				
				ret
GlobalRemove      endp


SpotlightMovement      proc;SEKIL HAREKET
LOCAL var_444444:DWORD
                mov     var_444444, 0
                mov     ecx, var_444444
                jmp     loc_4017E6
loc_40159F:                     
                mov     edx, var_444444
                imul    edx, 18h
                mov     eax, var_444444
                imul    eax, 18h
                mov     ecx, dword_406168;->SEKIL
                mov     edx, [edx+ecx]
                mov     ecx, dword_406168
                add     edx, [eax+ecx+8]
                mov     eax, var_444444
                imul    eax, 18h
                mov     ecx, dword_406168
                mov     [eax+ecx], edx
                mov     edx, var_444444
                imul    edx, 18h
                mov     eax, var_444444
                imul    eax, 18h
                mov     ecx, dword_406168
                mov     edx, [edx+ecx+4]
                mov     ecx, dword_406168
                add     edx, [eax+ecx+0Ch]
                mov     eax, var_444444
                imul    eax, 18h
                mov     ecx, dword_406168
                mov     [eax+ecx+4], edx
                mov     edx, var_444444
                imul    edx, 18h
                mov     eax, dword_406168
                cmp     dword ptr [edx+eax], 0
                jge     short loc_40163A
                mov     ecx, var_444444
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     dword ptr [ecx+edx], 0
                push    0Ah
                push    2
                call    Randomize
                mov     ecx, var_444444
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+8], eax
loc_40163A:                          
                mov     eax, var_444444
                imul    eax, 18h
                mov     ecx, dword_406168
                mov     edx, [eax+ecx]
                cmp     edx, dword_406174
                jbe     short loc_401681
                mov     eax, var_444444
                imul    eax, 18h
                mov     ecx, dword_406168
                mov     edx, dword_406174
                mov     [eax+ecx], edx
                push    0Ah
                push    2
                call    Randomize
                neg     eax
                mov     ecx, var_444444
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+8], eax
loc_401681:                          
                mov     eax, var_444444
                imul    eax, 18h
                mov     ecx, dword_406168
                cmp     dword ptr [eax+ecx+4], 0
                jge     short loc_4016C0
                mov     edx, var_444444
                imul    edx, 18h
                mov     eax, dword_406168
                mov     dword ptr [edx+eax+4], 0
                push    0Ah
                push    2
                call    Randomize
                mov     ecx, var_444444
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+0Ch], eax
loc_4016C0:                          
                mov     eax, var_444444
                imul    eax, 18h
                mov     ecx, dword_406168
                mov     edx, [eax+ecx+4]
                cmp     edx, yAxis
                jbe     short loc_401709
                mov     eax, var_444444
                imul    eax, 18h
                mov     ecx, dword_406168
                mov     edx, yAxis
                mov     [eax+ecx+4], edx
                push    0Ah
                push    2
                call    Randomize
                neg     eax
                mov     ecx, var_444444
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+0Ch], eax
loc_401709:                        
                mov     eax, var_444444
                imul    eax, 18h
                mov     ecx, dword_406168
                cmp     dword ptr [eax+ecx+14h], 0
                jz      short loc_401742
                mov     edx, var_444444
                imul    edx, 18h
                mov     eax, dword_406168
                mov     ecx, [edx+eax+14h]
                sub     ecx, 1
                mov     edx, var_444444
                imul    edx, 18h
                mov     eax, dword_406168
                mov     [edx+eax+14h], ecx
                jmp     loc_4017DD
loc_401742:                   
                push    46h
                push    14h
                call    Randomize
                mov     ecx, var_444444
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+14h], eax
                push    2
                call    Rndmproc
                or      eax, eax
                jnz     short loc_401781
                push    0Ah
                push    2
                call    Randomize
                mov     ecx, var_444444
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+8], eax
                jmp     short loc_40179C
loc_401781:                      
                push    0Ah
                push    2
                call    Randomize
                neg     eax
                mov     ecx, var_444444
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+8], eax
loc_40179C:                        
                push    2
                call    Rndmproc
                or      eax, eax
                jnz     short loc_4017C2
                push    0Ah
                push    2
                call    Randomize
                mov     ecx, var_444444
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+0Ch], eax
                jmp     short loc_4017DD
loc_4017C2:                    
                push    0Ah
                push    2
                call    Randomize
                neg     eax
                mov     ecx, var_444444
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     [ecx+edx+0Ch], eax
loc_4017DD:                        
                mov     ecx, var_444444
                add     ecx, 1
                mov     var_444444, ecx
loc_4017E6:                     
                cmp     ecx, dword_40616C
                jb      loc_40159F
				ret
SpotlightMovement      endp




BasicWorks      proc
LOCAL var_1C1C1C: DWORD
LOCAL var_181818: DWORD
LOCAL var_1453: DWORD
LOCAL var_1071: DWORD
LOCAL var_CCC_CCC: DWORD
LOCAL var_888888888: DWORD
LOCAL var_444444444444:DWORD
                mov     eax, ppvBits
                mov     var_444444444444, eax
                mov     var_181818, 0
                mov     edx, var_181818
                jmp     loc_40198E
loc_401811:                        
                mov     var_181818, edx
                mov     var_1C1C1C, 0
                mov     ecx, var_1C1C1C
                jmp     loc_401979
loc_401823:                         
                mov     var_1C1C1C, ecx
                mov     var_888888888, 0
                mov     var_1453, 0
                mov     eax, var_1453
                jmp     loc_4018DC
loc_40183C:                      
                mov     var_1453, eax
                mov     ecx, var_1453
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     eax, [ecx+edx]
                sub     eax, var_1C1C1C
                mov     ecx, var_1453
                imul    ecx, 18h
                mov     edx, dword_406168
                mov     ecx, [ecx+edx]
                sub     ecx, var_1C1C1C
                imul    eax, ecx
                mov     edx, var_1453
                imul    edx, 18h
                mov     ecx, dword_406168
                mov     edx, [edx+ecx+4]
                sub     edx, var_181818
                mov     ecx, var_1453
                imul    ecx, 18h
                mov     esi, dword_406168
                mov     ecx, [ecx+esi+4]
                sub     ecx, var_181818
                imul    edx, ecx
                add     eax, edx
                mov     var_1071, eax
                cmp     var_1071, 0
                jnz     short loc_4018A3
                mov     var_CCC_CCC, 0FFh
                jmp     short loc_4018CA
loc_4018A3:                     
                mov     edx, var_1453
                imul    edx, 18h
                mov     eax, dword_406168
                mov     eax, [edx+eax+10h]
                xor     edx, edx
                div     var_1071
                mov     var_CCC_CCC, eax
                cmp     var_CCC_CCC, 100h
                jb      short loc_4018CA
                mov     var_CCC_CCC, 0FFh
loc_4018CA:                        
                mov     ecx, var_888888888
                add     ecx, var_CCC_CCC
                mov     var_888888888, ecx
                mov     eax, var_1453
                add     eax, 1
                mov     var_1453, eax
loc_4018DC:                 
                cmp     eax, dword_40616C
                jb      loc_40183C
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				;BLUE
                mov     eax, var_888888888
                xor     edx, edx
                div     dword_40616C;-> form
                and     eax, 0FFh;-> color
                mov     edx, var_181818
                imul    edx, dword_406174
                add     edx, var_1C1C1C
                mov     ecx, var_444444444444
                mov     esi, dword_406164
                mov     al, [esi+eax*4]
                mov     [ecx+edx*4], al
				;GREEN
                mov     eax, var_888888888
                xor     edx, edx
                div     dword_40616C;-> form
                and     eax, 0FFh;->color
                mov     ecx, var_181818
                imul    ecx, dword_406174
                add     ecx, var_1C1C1C
                mov     edx, var_444444444444
                mov     esi, dword_406164
                mov     al, [esi+eax*4+1]
                mov     [edx+ecx*4+1], al
				; RED
                mov     eax, var_888888888
                xor     edx, edx
                div     dword_40616C;->form
                and     eax, 0FFh;->color
                mov     ecx, var_181818
                imul    ecx, dword_406174 ; x axis
                add     ecx, var_1C1C1C
                mov     edx, var_444444444444;->?
                mov     esi, dword_406164;->
                mov     al, [esi+eax*4+2]
                mov     [edx+ecx*4+2], al
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                mov     ecx, var_1C1C1C
                add     ecx, 1
                mov     var_1C1C1C, ecx
loc_401979:                       
                cmp     ecx, dword_406174
                jb      loc_401823
                mov     edx, var_181818
                add     edx, 1
                mov     var_181818, edx				
loc_40198E:                      
                cmp     edx, yAxis
                jb      loc_401811
                call    SpotlightMovement
                call    ScrollingCredits
				ret
BasicWorks      endp



PrintText      proc 
LOCAL YYYYY:DWORD
                mov     esi, TextLength
                push    esi 
                call    lstrlen
                mov     ebx, eax
                inc     ebx				
                push    dword_406198;->
                pop     YYYYY;->				
                mov     edi, esi
loc_4019C6:                        
                cmp     byte ptr [esi], 0Dh
                jz      short loc_4019D0
                cmp     byte ptr [esi], 0
                jnz     short loc_4019F8
loc_4019D0:                          
                mov     cl, [esi]
                push    ecx
                mov     byte ptr [esi], 0
                push    edi        
                call    lstrlen
                push    eax   
                push    edi   
                push    YYYYY     
                push    46h;-> X axis text align   
                push    hdc     
                call    TextOut
                add     YYYYY, 0Fh;-> Y axis text align
                pop     ecx
                mov     edi, esi
                inc     edi
                mov     [esi], cl
loc_4019F8:                         
                lodsb
                dec     ebx
                jnz     short loc_4019C6
                mov     eax, YYYYY
                sub     eax, dword_406198
                shr     eax, 1
				ret
PrintText      endp


ScrollingCredits      proc ; text scrolling
                push    0FFh;RANDOM COLOUR
                push    0FFh;RANDOM COLOUR
                mov     al, byte_4060D0
                push    eax
                call    Lightcolors
				
                push    eax  
                push    hdc  
                call    SetTextColor
                call    PrintText
                mov     ecx, yAxisWidth/2;->yAxisWidth ( Y = Constant 220 )
                sub     ecx, eax
                cmp     dword_406198, ecx
                jnz     short loc_401A66
                mov     ecx, eax
                shl     ecx, 2
                add     ecx, 5
                cmp     dword_406194, ecx;-> 
                jnb     short loc_401A5C
                inc     dword_406194;->
                inc     dword_406198;->
                jmp     short loc_401A66
loc_401A5C:                       
                mov     dword_406194, 0

loc_401A66:      
                cld
                dec     dword_406198
                add     eax, eax
                not     eax
                cmp     dword_406198, eax
                jnz     short locret_401AA8
                mov     edi, TextLength
                xor     eax, eax
                or      ecx, 0FFFFFFFFh
                repne scasb
                cmp     byte ptr [edi], 0
                jz      short loc_401A93
                mov     TextLength, edi
                jmp     short loc_401A9E
loc_401A93:                         
                push offset AboutBoxText
                pop  TextLength
loc_401A9E:                    
                mov    dword_406198, yAxisWidth;->
locret_401AA8:         
                ret
ScrollingCredits      endp


AboutProc PROC hWnd :HWND, uMsg :UINT, wParam :WPARAM, lParam :LPARAM
LOCAL Drawspotlight: PAINTSTRUCT;=tagPAINTSTRUCT
                cmp     [uMsg], 110h
                jnz     short loc_401AFA
                push    hWnd    
                call    LoadUp
                push    1   
                push    hWnd   
                call    GetDlgItem
                push    eax      
                call    SetFocus
                mov     dword_406198, yAxisWidth
                mov     dword_406194, 0
                jmp     loc_401BD0
loc_401AFA:                          
                cmp     uMsg, 0Fh
                jnz     short loc_401B42
                lea     eax, [Drawspotlight]
                push    eax     
                push    hWnd   
                call    BeginPaint
                push    0CC0020h      
                push    0          
                push    0             
                push    hdc           
                push    yAxis
                push    dword_406174
                push    0             
                push    0             
                push    eax           
                call    BitBlt
                lea     eax, [Drawspotlight]
                push    eax            
                push    hWnd     
                call    EndPaint
                jmp     loc_401BD0
loc_401B42:                           
                cmp     uMsg, 113h
                jnz     short loc_401B71
                cmp     wParam, 1
                jnz     short loc_401B58
                call    BasicWorks
                jmp     short loc_401B63
loc_401B58:                            
                cmp     wParam, 2
                jnz     short loc_401B63
                call    TextColorz
loc_401B63:                            
                push    0            
                push    0           
                push    hWnd    
                call    InvalidateRect
                jmp     short loc_401BD0
loc_401B71:                            
                cmp     uMsg, 205h
                jnz     short loc_401B8F
                push    hWnd     
                call    GlobalRemove
                push    wParam 
                push    hWnd   
                call    EndDialog
                jmp     short loc_401BD0
loc_401B8F:                            
                cmp     uMsg, 201h
                jnz     short loc_401BAC
                push    lParam  
                push    2          
                push    0A1h       
                push    hWnd   
                call    SendMessage
                jmp     short loc_401BD0
loc_401BAC:                           
                cmp     uMsg, 203h
                jnz     short loc_401BBC
                jmp     short loc_401BD0
loc_401BBC:                             
                cmp     uMsg, 10h
                jnz     short loc_401BD0
                push    0         
                call    PostQuitMessage
loc_401BD0:                          
                xor     eax, eax
				ret
AboutProc endp