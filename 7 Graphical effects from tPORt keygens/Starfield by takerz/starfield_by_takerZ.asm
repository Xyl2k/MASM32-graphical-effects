OpenAbout		PROTO		:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
AboutProc		PROTO		:DWORD,:DWORD,:DWORD,:DWORD
AboutDraw		PROTO
FreeProc		PROTO		:DWORD
FadeText		PROTO		:DWORD,:DWORD
sub_4129CD      PROTO		
RandomStars		PROTO		:DWORD
sub_412A57		PROTO
DrawStars		PROTO

.data
AboutFont	LOGFONT <12,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY, 0,"Terminal">                                 
                                                                                                                          
AboutText          db 0Dh,0Dh,0Dh,0Dh,0Dh,0Dh
				db ' tHE PERYFERiAH tEAM ',0Dh
				db '   PRoUDLY PrEsEnT    ',0                   
				db 0Dh,0Dh,0Dh,0Dh
				db 'another aboutbox coded by takerZ !',0Dh,0Dh
				db 'Ripped by:  r0ger          ',0Dh
				db 'Date:       24.o7.2o21     ',0Dh
				db 'Tools:      IDA Pro+Winasm ',0  
				db 0Dh,0Dh                                                 
                db '   gr33tz fly out 2 :                  ',0Dh,0Dh
                db '               Al0hA                   ',0Dh
                db '               B@TRyNU                 ',0Dh
                db '               GRUiA                   ',0Dh
                db '               zzLaTaNN                ',0Dh
                db '               MaryNello               ',0Dh
                db '               WeeGee                  ',0Dh
                db '               ShTEFY                  ',0Dh
                db '               DAViD                   ',0Dh
                db '               yMRAN                   ',0       
                db 0Dh,0Dh,0Dh
                db '               sabYn                   ',0Dh
                db '               r0bica                  ',0Dh
                db '               NoNNy                   ',0Dh
                db '               bDM10                   ',0Dh
                db '               oViSpider               ',0Dh
                db '               mYu                     ',0Dh
                db '               st3fan(C)ADR!AN         ',0Dh
                db '               s0r3l                   ',0Dh
                db '               Gyahnni                 ',0Dh,0Dh
                db '         .. and other memberz .        ',0 
                db 0Dh,0Dh                       
                db '   but also :                         ',0Dh,0Dh
                db '               Cachito                ',0Dh
                db '               Roentgen               ',0Dh
                db '               kao                    ',0Dh 
                db '               s3rh47                 ',0Dh
                db '               tarequl                ',0Dh
                db '               KesMezar               ',0Dh
                db '               Xylitol                ',0Dh
                db '               Taitor                 ',0Dh
                db '               GioTiN                 ',0                 
                db 0Dh,0Dh,0Dh
                db '               rooster1               ',0Dh
                db '               Arttomov               ',0Dh
                db '               FnZnL!                 ',0Dh
                db '               Talers                 ',0Dh
                db '               SKG-1010               ',0Dh
                db '               Bl4ckCyb3rEnigm4       ',0Dh
                db '               Krinal                 ',0Dh
                db '               GlacialManDoUtDes      ',0Dh
                db '               Sangavi                ',0               
                db 0Dh,0Dh,0Dh,0Dh,0Dh,0Dh
                db '  and other positive ppl ^_^ ',0            
                db 0Dh,0Dh,0Dh,0Dh              
                db '   Sh0ut0utz 2 :                       ',0Dh,0Dh
                db '       kao for a lil suggestion          ',0Dh
                db '       takerZ for CooL about template    ',0Dh
                db '       heman for CooL Music              ',0Dh
                db '       Asterix and Quantum 4 uFMOD       ',0                                                    
                db 0Dh,0Dh,0Dh,0Dh,0Dh,0Dh
                db '  u can find us at ... ',0                
                db 0Dh,0Dh,0Dh,0Dh,0Dh  
                db '  ig      :  @r0gerica     ',0Dh
                db '  discord :  r0gerica#2649 ',0Dh
                db '  github  :  r0gerica      ',0Dh
                db '  dA      :  r0gerica      ',0                                                                                                             
                db 0Bh  ; <-- this constant is made to restart the aboutbox text , and you can comment this out if you don't want to make it restart (it will only go blank and shows only the stars)     

StarColFast		equ	0FFFFFFh
StarColNorm		equ	0AAAAAAh
StarColSlow		equ	555555h

.data?
StarsDC   		dd ?                                             
hBgColor    	dd ?                                                                 
hStars    		dd ?                                                     
color           dd ?                                                                      
cchText         dd ?                           
hAboutbox    	dd ?                                             
Starcount    	dd ?                                              
dword_411BD7    dd ?                                                    
crKey           dd ?                                                                       
hFree    		dd ?                                                                      
dword_411BE3    dd ?                                                                       
WhiteFade    	dd ?                                  
dword_411BEB    dd ?                                                         
rc              RECT <>                                                                 
X               RECT <>                                                                 
hdcSrc          dd ?                                                                       
ppvBits         dd ?                                                                        
ho              dd ?                                                                       
pbmi            BITMAPINFO <>                             
word_411C47     dw 300 dup (?)
word_411E9F     dw 300 dup (?)
hThread			dd	?

.code

OpenAbout      proc hWndParent:DWORD,lpTemplateName:DWORD,arg_8:DWORD,arg_C:DWORD,arg_10:DWORD   ; had no choice but to add this shit to make the aboutbox work... :E                         
                                                                                            
                mov     eax, [arg_8]                       
                mov     color, eax                          
                mov     eax, [arg_C]                       
                mov     dword_411BD7, eax                   
                mov     eax, [arg_10]                      
                xor     edx, edx                               
                mov     ecx, 0Ah                               
                div     ecx                                    
                mov     hAboutbox, eax                                    
                 
                invoke  GetModuleHandle,0      
                invoke  DialogBoxParam,eax,IDD_ABOUTBOX,[hWndParent],offset AboutProc,0                                
                ret
                                                    
OpenAbout      endp   

AboutProc proc xWnd:HWND,uMsgz:UINT,wParamz:WPARAM,lParamz:LPARAM              ; DATA XREF: sub_4126EB+36^o
                                       
                push    edi                                                                                                                                                                                             
                mov     eax, [uMsgz]
                mov     edi, [xWnd]                                                                       
                cmp     eax, 10h                                                    
                jz      short loc_41274D                                            
                cmp     eax, 205h                                                   
                jnz     short loc_41277C                                            
                                                                                    
loc_41274D:                             ; CODE XREF: DialogFunc+D^j                 
                push    0FFFFFFECh      ; nIndex                                    
                push    edi             ; hWnd                                      
                call    GetWindowLongA                                           
                or      eax, 80000h                                                 
                push    eax             ; dwNewLong                                 
                push    0FFFFFFECh      ; nIndex                                    
                push    edi             ; hWnd                                      
                call    SetWindowLongA                                           

                xor     eax, eax                                                    
                invoke  CreateThread,eax,eax,offset FreeProc,edi,eax,eax                                     
                jmp     loc_41288E    
                                                                                    
loc_41277C:                             ; CODE XREF: DialogFunc+14^j                
                cmp     eax, 110h                                                   
                jnz     loc_movewnd                                       
                invoke  GetClientRect,[xWnd],offset rc                                       
                lea     ecx, X                                                          
                invoke  GetWindowRect,[xWnd],ecx                                        
                invoke  GetDC,edi                                                    
                mov     StarsDC, eax                                        
                invoke  CreateSolidBrush,color                                       
                mov     hBgColor, eax                                        
                xor     eax, eax                                                    
                invoke  CreateThread,eax,eax,offset AboutDraw,edi,eax,eax                                    
                mov     hStars, eax                     
                invoke  uFMOD_PlaySong, addr xm, xm_length, XM_MEMORY                     
                jmp     short loc_41288E                                            
; ---------------------------------------------------------------------------       
loc_movewnd:
                cmp     eax, 201h
                jnz     loc_41283C
                invoke  SendMessage,[xWnd],WM_NCLBUTTONDOWN,HTCAPTION,lParamz   
                jmp     short loc_41288E 
                                                                                                 
loc_41283C:                             ; CODE XREF: DialogFunc+4A^j                
                cmp     eax, 205h                                                   
                jnz     short loc_412852                                            
                xor     eax, eax                                                                                          
                invoke  PostMessage,edi,10h,eax,eax
                jmp     short loc_41288E                                            
; ---------------------------------------------------------------------------       
                                                                                    
loc_412852:                             ; CODE XREF: DialogFunc+10A^j               
                cmp     eax, 136h                                                   
                jnz     short loc_41288E                                            
                push    40h ; '@'       ; uFlags                                    
                push    rc.bottom    ; cy                                        
                push    rc.right     ; cx                                        
                push    X.top        ; Y                                         
                push    X.left       ; X                                         
                push    0               ; hWndInsertAfter                           
                push    edi         ; hWnd                                      
                call    SetWindowPos                                             
                push    0               ; color                                     
                push    [wParamz]    ; hdc                                       
                call    SetBkColor                                               
                mov     eax, hBgColor    
                jmp     short loc_412890                                                                              
; ---------------------------------------------------------------------------       
                                                                                    
loc_41288E:                             ; CODE XREF: DialogFunc+40^j                
                                        ; DialogFunc+103^j ...                      
                xor     eax, eax 
loc_412890:                             ; CODE XREF: DialogFunc+155^j
                 pop     edi
                 ret                                                     
AboutProc endp

AboutDraw      proc near          
                                                                                                                                                           
                invoke  CreateCompatibleDC,0                                               
                mov     hdcSrc, eax                                                        
                mov     edi, eax                                                              
                mov     pbmi.bmiHeader.biSize, 28h ; '('                                   
                mov     eax, rc.right                                                      
                mov     pbmi.bmiHeader.biWidth, eax                                        
                mov     eax, rc.bottom                                                     
                not     eax                                                                   
                mov     pbmi.bmiHeader.biHeight, eax                                       
                mov     pbmi.bmiHeader.biPlanes, 1                                         
                mov     pbmi.bmiHeader.biBitCount, 20h ; ' '                               
                mov     pbmi.bmiHeader.biCompression, 0                                    
                xor     eax, eax                                                                 
                invoke  CreateDIBSection,edi,offset pbmi,eax,offset ppvBits,eax,eax                                              
                mov     ho, eax                                                                                                     
                invoke  SelectObject,edi,eax
                call    sub_412A57                                                            
                mov     ebx, 12Bh ; <-- number of stars (?)                                                            
                                                                                              
loc_412ADF:                                                    
                push    rc.right                                                           
                call    RandomStars                                                            
                mov     word ptr[ebx+ebx+word_411C47], ax                                           
                push    rc.bottom                                                          
                call    RandomStars                                                            
                mov     word ptr[ebx+ebx+word_411E9F], ax                                           
                dec     ebx                                                                   
                jnz     short loc_412ADF                                                       
           		invoke  SetBkMode,edi,1                                                    
                xor     eax, eax                                                              
                mov     Starcount, eax                                                        
                invoke  CreateFontIndirect,addr AboutFont                             
                invoke  SelectObject,edi,eax                                                  
                mov     eax, color                                                         
                mov     WhiteFade, eax                                                  
                                                                                              
loc_412B48:                             ; CODE XREF: sub_412A64+166?j                         
                mov     esi, offset AboutText   
                                                                                              
loc_412B4D:                             ; CODE XREF: sub_412A64+164?j                                                   
                invoke  lstrlen,esi                                
                mov     cchText, eax                                                       
                                                                                              
loc_412B59:                             ; CODE XREF: sub_412A64+116?j                         
                call    DrawStars                                                            
                push    WhiteFade                                                       
                push    dword_411BD7                                                       
                call    FadeText                                                            
                mov     WhiteFade, eax                                                  
                cmp     eax, dword_411BD7                                                  
                jnz     short loc_412B59                                                      
                                                                                              
loc_412B7C:                             ; CODE XREF: sub_412A64+12E?j                         
                call    DrawStars                                                            
                inc     Starcount                                                       
                mov     eax, Starcount                                                  
                cmp     hAboutbox, eax                                                  
                jnz     short loc_412B7C                                                      
                xor     eax, eax                                                              
                mov     Starcount, eax                                                  
                                                                                              
loc_412B9B:                             ; CODE XREF: sub_412A64+158?j                         
                call    DrawStars                                                            
                push    WhiteFade                                                       
                push    color                                                              
                call    FadeText                                                            
                mov     WhiteFade, eax                                                  
                cmp     eax, color                                                         
                jnz     short loc_412B9B                                                      
                add     esi, cchText                                                       
                inc     esi                                                                   
                cmp     byte ptr [esi], 0Bh                                                   
                jnz     short loc_412B4D                                                      
                jmp     loc_412B48   
                ret                                                      
AboutDraw      endp           

sub_412A57      proc near               ; CODE XREF: sub_412A64+71¡p
                 rdtsc
                 shr     eax, 2
                 inc     eax
                 xchg    eax, dword_411BEB
                 ret
sub_412A57      endp                                           

RandomStars      proc near arg_000:DWORD                                                                                               
                push    ecx                               
                push    edx                               
                mov     eax, dword_411BEB              
                xor     edx, edx                          
                mov     ecx, 1F31Dh                       
                div     ecx                               
                xchg    eax, edx                          
                imul    eax, 41A7h                        
                xchg    eax, edx                          
                imul    eax, 0B14h                        
                sub     edx, eax                          
                xchg    eax, edx                          
                mov     dword_411BEB, eax              
                xor     edx, edx                          
                mov     ecx, [arg_000]                
                div     ecx                               
                xchg    eax, edx                          
                pop     edx                               
                pop     ecx                               
                ret                             
RandomStars      endp       

DrawStars      proc near               
 
                mov     eax, rc.right                                            
                mov     ecx, rc.bottom                                           
                imul    ecx, eax                                                    
                mov     edi, ppvBits                                             
                xor     eax, eax                                                    
                rep stosd                                                           
                mov     edi, ppvBits                                             
                mov     ebx, 12Bh                                                   
           		invoke  SetTextColor,hdcSrc,WhiteFade                                        
                ;invoke  SetTextColor,hdcSrc,White ; <-- if you don't want fades between the pages of text , you can choose this one tho (or any text color u want)
                invoke  DrawText,hdcSrc,esi,cchText,offset rc,101h                                       
                                                                                    
loc_412C25:                             ; CODE XREF: sub_412BD3+D4?j                
                xor     eax, eax                                                    
                mov     ax, word_411E9F[ebx+ebx]                                 
                mov     ecx, rc.right                                            
                mul     ecx                                                         
                add     ax, word_411C47[ebx+ebx]                                 
                cmp     ebx, 64h ; 'd'                                              
                jnb     short loc_412C56                                            
                mov     dword ptr [edi+eax*4], StarColFast                            
                add     word ptr [word_411C47+ebx+ebx], 3                                  
                jmp     short loc_412C7F                                            
; ---------------------------------------------------------------------------       
                                                                                    
loc_412C56:                             ; CODE XREF: sub_412BD3+6F^j                
                cmp     ebx, 0C8h ; 'C'                                             
                jnb     short loc_412C70                                            
                mov     dword ptr [edi+eax*4], StarColNorm                           
                add     word ptr [word_411C47+ebx+ebx], 2                                  
                jmp     short loc_412C7F                                            
; ---------------------------------------------------------------------------       
                                                                                    
loc_412C70:                             ; CODE XREF: sub_412BD3+89^j                
                mov     dword ptr [edi+eax*4], StarColSlow                     
                inc     word ptr [word_411C47+ebx+ebx]                                   
                                                                                    
loc_412C7F:                             ; CODE XREF: sub_412BD3+81^j                
                                        ; sub_412BD3+9B^j                           
                mov     eax, rc.right                                            
                cmp     word_411C47[ebx+ebx], ax                                 
                jbe     short loc_412CA6                                            
                mov     word ptr [word_411C47+ebx+ebx], 0                                  
                push    eax                                                         
                call    RandomStars                                                  
                mov     word ptr [word_411C47+ebx+ebx], ax                                 
                                                                                    
loc_412CA6:                             ; CODE XREF: sub_412BD3+B9^j                
                dec     ebx                                                         
                jns     loc_412C25                                                  

                xor     eax, eax                                                    
                invoke  BitBlt,StarsDC,eax,eax,rc.right,rc.bottom,hdcSrc,eax,eax,0CC0020h
                invoke  Sleep,10                                                  
                ret
                                                                               
DrawStars      endp                                                

FadeText      proc arg_111:DWORD,arg_222:DWORD
                                                              
                push    ebx                     
                xchg    esi, [arg_111]     
                xchg    edi, [arg_222]     
                mov     eax, esi                
                shr     eax, 10h                
                mov     bl, al                  
                mov     eax, edi                
                shr     eax, 10h                
                call    sub_4129CD              
                shl     ebx, 8                  
                mov     eax, esi                
                shr     eax, 8                  
                mov     bl, al                  
                mov     eax, edi                
                shr     eax, 8                  
                call    sub_4129CD              
                shl     ebx, 8                  
                mov     eax, esi                
                mov     bl, al                  
                mov     eax, edi                
                call    sub_4129CD              
                shr     ebx, 8                  
                xchg    eax, ebx                
                xchg    edi, [arg_222]     
                xchg    esi, [arg_111]     
                pop     ebx                     
                ret
                                  
FadeText      endp                    

sub_4129CD      proc near               ; CODE XREF: sub_412981+16^p
                                                       ; sub_412981+2A^p ...
                cmp     al, bl                                                         
                jz      short loc_412A1C                                               
                mov     cl, al                                                         
                mov     dl, bl                                                         
                cmp     al, bl                                                         
                jbe     short loc_4129FB                                               
                mov     ah, al                                                         
                sub     ah, bl                                                         
                cmp     ah, 80h ; '€'                                                  
                jb      short loc_4129E5                                               
                sub     cl, 0Ah                                                        
                                                                                       
loc_4129E5:                             ; CODE XREF: sub_4129CD+13^j                   
                sub     cl, 5                                                          
                add     dl, 0Fh                                                        
                cmp     al, dl                                                         
                jbe     short loc_4129F7                                               
                cmp     cl, dl                                                         
                jbe     short loc_4129F7                                               
                mov     bh, cl                                                         
                jmp     short locret_412A1B                                            
; ---------------------------------------------------------------------------          
                                                                                       
loc_4129F7:                             ; CODE XREF: sub_4129CD+20^j                   
                                        ; sub_4129CD+24^j                              
                mov     bh, bl                                                         
                jmp     short locret_412A1B                                            
; ---------------------------------------------------------------------------          
                                                                                       
loc_4129FB:                             ; CODE XREF: sub_4129CD+A^j                    
                mov     ah, bl                                                         
                sub     ah, al                                                         
                cmp     ah, 80h ; '€'                                                  
                jb      short loc_412A07                                               
                add     cl, 0Ah                                                        
                                                                                       
loc_412A07:                             ; CODE XREF: sub_4129CD+35^j                   
                add     cl, 5                                                          
                sub     dl, 0Fh                                                        
                cmp     al, dl                                                         
                ja      short loc_412A19                                               
                cmp     cl, dl                                                         
                ja      short loc_412A19                                               
                mov     bh, cl                                                         
                jmp     short locret_412A1B                                            
; ---------------------------------------------------------------------------          
                                                                                       
loc_412A19:                             ; CODE XREF: sub_4129CD+42^j                   
                                        ; sub_4129CD+46^j                              
                mov     bh, bl                                                         
                                                                                       
locret_412A1B:                          ; CODE XREF: sub_4129CD+28^j                   
                                        ; sub_4129CD+2C^j ...                          
                retn                                                                   
; ---------------------------------------------------------------------------          
                                                                                       
loc_412A1C:                             ; CODE XREF: sub_4129CD+2^j                    
                mov     bh, al                                                         
                jmp     short locret_412A1B                                            
sub_4129CD      endp                    


FreeProc      proc lpThreadParameter:DWORD                 
                                                                                                              
               mov     ebx, [lpThreadParameter]                                            
               invoke  ResumeThread,hThread                               
               invoke  TerminateThread,hFree,0                           
               mov     edi, crKey                                   
                                                                        
loc_412927:                             ; CODE XREF: sub_4128F5+4A?j                                
               invoke  TerminateThread,hStars,0
               invoke  ReleaseDC,ebx,StarsDC
               invoke  DeleteDC,hdcSrc
               invoke  DeleteObject,ho
               invoke  uFMOD_PlaySong,0,0,0   
               invoke  EndDialog,ebx,0                                    
               ret
                                                           
FreeProc      endp        
                                                                                                                                                                                              