AboutProc       PROTO 	:DWORD,:DWORD,:DWORD,:DWORD
Draw    		PROTO
DrawLine		PROTO	:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GraphShake		PROTO	:DWORD

.data
ScrollerText     db 'tHE PERYFERiAH tEAM PrEsEnT :                         KeyGen for XiLiSOFT YOUTUB'
                db 'E ViDEO CONVERTER 5.6.7 -- KgN`d bY GRUiA[PRF]                    '
                db '           PROTECTiON : MD5-HasH                                   '
                db '          V2m bY SofT MANiAC                                 ABOUT'
                db 'BOX eFFeCT bY rep0A[TLG] , and V2m LiB bY MagicH                        '     
                db 'Gr33tz fly out 2 Al0hA,r0bica,ShTEFY,B@TRyNU,DAViiiiDDDDD,r0ger,M'
                db 'aryNello,yMRAN,sabYn,WeeGee,NoNNy,QueenAntonia,bDM10,oViSpider an'
                db 'd other PRF memberz but also GioTiN,KesMezar,Xylitol,Teddy Rogers'
                db ',kao,atom0s,Sangavi,Cachito,tonyweb,de!,TeRcO,Roentgen,HcH,mrT4nt'
                db 'r4 and others that i`ve actually forgot to include them. Big THX '
                db 'to KesMezar for helpin` my br0 rippin this cool effect :)        '
                db 'contact info can be found in PRF.NFO, so fuck da ripperz. :E          ',0
                
FontName 		db "Terminal",0

.data?

hWndd 			dd ?
wParam2 		dd ?
nHeight    		dd ?
nWidth			dd ?
BmpDC    		dd ?
dword_404044    dd ?
BoxDC			dd ?
dword_404030    dd ?
dword_404034    dd ?
dword_404038    dd ?
ho				dd ?
rc 				RECT <?>
hDC 			dd ?
hThread			dd ?

.code

AboutProc proc hDlg:HWND,uMessg:UINT,wParams:WPARAM,lParam:LPARAM
LOCAL ThreadId:DWORD
LOCAL pv:byte
LOCAL X:DWORD
LOCAL Y:DWORD


                push    ebx
                push    esi
                push    edi
                cmp     [uMessg], 110h ; <-- WM_INITDIALOG
                jz      short loc_drawaboutbox
                cmp     [uMessg], 111h ; <-- WM_COMMAND
                jz      loc_402836
                cmp     [uMessg], 10h	 ; <-- WM_CLOSE
                jz      loc_402840
                cmp     [uMessg], 204h ; <-- WM_RBUTTONDOWN
                jz      loc_402840
                cmp     [uMessg], 201h ; <-- WM_LBUTTONDOWN
                jz		loc_movewindow
                xor     eax, eax
                jmp     loc_402868
loc_drawaboutbox:  
                mov     eax, 0FAh ; <-- form height
                mov     nHeight, eax
                mov     eax, 0FAh ; <-- form width
                mov     nWidth, eax                
                invoke GetSystemMetrics,0                
                sub     eax, nHeight
                shr     eax, 1
                mov     [X], eax
                invoke GetSystemMetrics,1               
                sub     eax, nWidth
                shr     eax, 1
                mov     [Y], eax
            	invoke SetWindowPos,hDlg,0,X,Y,nHeight,nWidth,40h

                mov     edx, nWidth
                add     edx, 0Ch
           	
				
                invoke CreateBitmap,nHeight,edx,1,20h,0
                mov     BmpDC, eax           
                invoke CreateCompatibleDC,0
                mov     BoxDC, eax
                invoke SelectObject,BoxDC,BmpDC
                invoke DeleteDC,dword_404034
                invoke CreatePatternBrush,dword_404030                
                mov     dword_404038, eax
                invoke CreateSolidBrush,00000000h; background color                               
                mov     ho, eax
                
				
                invoke CreateFont,12,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY, 0,offset FontName;12textH 
				mov     wParam2, eax              
				invoke SelectObject,BoxDC,wParam2
				invoke SetBkMode,BoxDC,TRANSPARENT                             
				invoke SetTextColor,BoxDC,00FFFFFFh ; text color
               
                
	
                call    Randomize     
                invoke GetDC,hDlg               
                mov     hDC, eax             
                mov     rc.left, 0
                mov     rc.top, 0
                mov     eax, nHeight
                mov     rc.right, eax
                mov     eax, nWidth
                mov     rc.bottom, eax                            
                lea     eax, [ThreadId]
                invoke CreateThread,0,0,offset Draw,0,0,eax               
                mov     hThread, eax
                xor     eax, eax
                jmp     short loc_402868   
                
loc_movewindow:

                invoke SendMessage, hDlg, WM_NCLBUTTONDOWN, HTCAPTION, 0
                xor     eax, eax
                jmp     short loc_402868
                      
loc_402836:                         
                cmp     [wParam2], 2
                jz      short loc_402840
                xor     eax, eax
                jmp     short loc_402868
loc_402840:	                                     
                invoke TerminateThread,hThread,0
                invoke ReleaseDC,hDlg,hDC
                ; added the fade-out function below to make the aboutbox go *PooF!* when closing it =) [but this is optional tho]
                invoke AnimateWindow,hDlg,300,AW_BLEND+AW_HIDE 
                invoke EndDialog,hDlg,0              
loc_402868: 
                pop     edi
                pop     esi
                pop     ebx
                
                ret
AboutProc      endp

Draw    proc near 
LOCAL x:DWORD
LOCAL cc:DWORD
LOCAL var_4:DWORD
LOCAL rect:RECT
	
	
                push    ebx
                push    esi
                push    edi
                invoke lstrlen,offset ScrollerText ; <-- calculates the whole scroller text
                mov     [cc], eax
                xor     edx, edx
                mov     cx, 9 ; <-- scroller length (this will restart the scroller depending on the text length)
                mul     cx
                sub     eax, 64h
                mov     [var_4], eax
                mov     [x], 0E2h ; <-- scroller start position

loc_40289C:    

                invoke FillRect,BoxDC,offset rc,ho
                invoke DrawLine,BoxDC,0,0,0F2h,0,8,0E2C5C5h,0,0 ; <-- top wall 
                ; Btw i've inserted this function into the prototype so u won't make huge blocks of lines to draw linez :P (see the top of the asm file)
                ; (won't work if inserted without prototype and insert "invoke" directly..)                
                invoke DrawLine,BoxDC,0F2h,0,0F2h,0F2h,8,0E2C5C5h,0,0 ; <-- right wall
                invoke DrawLine,BoxDC,0F2h,0F2h,0,0F2h,8,0E2C5C5h,0,0 ; <-- bottom wall
                invoke DrawLine,BoxDC,0,0F2h,0,0,8,0E2C5C5h,0,0 ; <-- left wall
                
  ; ------------------------------------------------------------------------------------------------------------------------------------------------------
  ; PRF acronym begin - may take a bunch of time to paint the letters and get `em right , so i just have to make `em all by myself, not like in msPaint :E              
  ; ------------------------------------------------------------------------------------------------------------------------------------------------------

               ; letter P
                invoke GraphShake,8
                invoke DrawLine,BoxDC,28h,4Bh,28h,6Eh,eax,0FFFFFFh,1Ah,0
                invoke GraphShake,8
                invoke DrawLine,BoxDC,28h,4Bh,3Ch,4Bh,eax,0FFFFFFh,1Ah,0
                invoke GraphShake,8
                invoke DrawLine,BoxDC,3Ch,4Bh,3Ch,5Ch,eax,0FFFFFFh,1Ah,0
                invoke GraphShake,8
                invoke DrawLine,BoxDC,28h,5Ch,3Ch,5Ch,eax,0FFFFFFh,1Ah,0
                
                
               ; letter R
                invoke GraphShake,8
                invoke DrawLine,BoxDC,28h,4Bh,28h,6Eh,eax,0FFFFFFh,4Ah,0
                invoke GraphShake,8
                invoke DrawLine,BoxDC,28h,4Bh,3Ch,4Bh,eax,0FFFFFFh,4Ah,0
                invoke GraphShake,8
                invoke DrawLine,BoxDC,3Ch,4Bh,3Ch,5Ch,eax,0FFFFFFh,4Ah,0
                invoke GraphShake,8
                invoke DrawLine,BoxDC,28h,5Ch,3Ch,5Ch,eax,0FFFFFFh,4Ah,0
                invoke GraphShake,8
                invoke DrawLine,BoxDC,5Ch,5Ch,6Eh,6Eh,eax,0FFFFFFh,1Ah,1
                
               ; letter F
                invoke GraphShake,8
                invoke DrawLine,BoxDC,28h,4Bh,28h,6Eh,eax,0FFFFFFh,7Bh,0
                invoke GraphShake,8
                invoke DrawLine,BoxDC,28h,4Bh,3Ch,4Bh,eax,0FFFFFFh,7Bh,0
                invoke GraphShake,8
                invoke DrawLine,BoxDC,28h,5Ch,3Ch,5Ch,eax,0FFFFFFh,7Bh,0
                
     ;-------------------------------------------------             
     ;         P A I N T I N G     E N D E D !                        
     ;-------------------------------------------------         
      
                push    8                  
                xor     eax, eax                
                invoke BitBlt,BoxDC,10h,nWidth,0D2h,0Ch,BoxDC,10h,0BAh,0CC0020h
                invoke GraphShake,2
                
                mov     edx,nWidth ; <-- text scroller position
                add     edx, eax
                
                invoke TextOut,BoxDC,[x],edx,offset ScrollerText,[cc]

                invoke BitBlt,BoxDC,10h,0BAh,0D2h,0Ch,BoxDC,10h,nWidth,0CC0020h
                mov     edi, 0BAh ; <-- scroller fade position (Y axis)
             
loc_402CCB:                       
                cmp     edi, 0C6h
                ja      loc_402D70
                mov     esi, 10h ; <-- left fade X axis value

loc_402CDC:                         
                cmp     esi, 2Eh
                ja      short loc_402D1E
                invoke GetPixel,BoxDC,esi,edi
                cmp     eax, 0FFFFFFh
                jnz     short loc_402D1B
                mov     eax, esi
                sub     eax, 10h
                push    1               ; int
                push    eax             ; nNumber
                push    1Eh             ; nDenominator
                push    0               ; int
                push    0FFFFFFh        ; int
                call    sub_402E31
                invoke SetPixel,BoxDC,esi,edi,eax
                
                
                
loc_402D1B:                      
                inc     esi
                jmp     short loc_402CDC
loc_402D1E:                         
                mov     esi, 0C4h ; <-- right fade X axis value
loc_402D23:                          
                cmp     esi, 0E2h
                ja      short loc_402D6A
                invoke GetPixel,BoxDC,esi,edi
                cmp     eax, 0FFFFFFh
                jnz     short loc_402D67
                mov     eax, esi
                sub     eax, 0C4h ;<-- right fade size
                push    0               ; int
                push    eax             ; nNumber
                push    1Eh             ; nDenominator
                push    0               ; int
                push    0FFFFFFh        ; int
                call    sub_402E31
                invoke SetPixel,BoxDC,esi,edi,eax
loc_402D67:       
                inc     esi
                jmp     short loc_402D23
loc_402D6A:              
                inc     edi
                jmp     loc_402CCB
                
loc_402D70:     
           
                mov     ecx, 28h ; <-- text line up width
                mov     esi, 79h ; <-- text line up X axis
                mov     edi, 0B8h ; <-- text line up Y axis
                
loc_402D7F:                     
                push    ecx
                invoke GraphShake,14h
                add     esi, eax
                invoke GraphShake,14h
                sub     esi, eax
                invoke SetPixel,BoxDC,esi,edi,0FFFFFFh ;0000FF00h  <-- text line up color 
                pop     ecx
                loop    loc_402D7F
                mov     ecx, 0Ah
                mov     esi, 79h
                mov     edi, 0C8h
                
loc_402DB7:           
                push    ecx
                invoke GraphShake,14h
                add     esi, eax
                invoke GraphShake,14h ;<-- text line down X axis
                sub     esi, eax
                invoke SetPixel,BoxDC,esi,edi,0FFFFFFh ; 0000FFFFh <-- text line down color
                pop     ecx
                loop    loc_402DB7
                invoke BitBlt,hDC,0,0,nHeight,nWidth,BoxDC,0,0,0CC0020h
                invoke Sleep,06h ; <-- scroller speed
                dec     [x]
                mov     eax, [x]
                neg     eax
                cmp     eax, [var_4]
                jle     loc_402E27
                mov     [x], 0E2h ; <-- scroller start position (when it ends)

loc_402E27:                       
                jmp     loc_40289C
                pop     edi
                pop     esi
                pop     ebx
                ret
Draw    endp

sub_402E31      proc arg_0:DWORD,arg_4:DWORD,nDenominator:DWORD,nNumber:DWORD,arg_10:DWORD 
LOCAL var_8:BYTE
LOCAL var_7:BYTE
LOCAL var_6:BYTE
LOCAL var_5:BYTE
LOCAL var_4:BYTE
LOCAL var_3:BYTE
                cmp     [arg_10], 0
                jz      short loc_402EA8
                mov     eax, [arg_4]
                mov     edx, [arg_0]
                mov     [var_8], al
                mov     [var_5], dl
                sub     [var_5], al
                shr     eax, 8
                shr     edx, 8
                mov     [var_7], al
                mov     [var_4], dl
                sub     [var_4], al
                shr     eax, 8
                shr     edx, 8
                mov     [var_6], al
                mov     [var_3], dl
                sub     [var_3], al
                movzx   eax, [var_5]
                push    [nDenominator] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumber]   ; nNumber
                call    MulDiv
                add     [var_8], al
                movzx   eax, [var_4]
                push    [nDenominator] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumber]   ; nNumber
                call    MulDiv
                add     [var_7], al
                movzx   eax, [var_3]
                push    [nDenominator] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumber]   ; nNumber
                call    MulDiv
                add     [var_6], al
                jmp     short loc_402F11
loc_402EA8:                            
                mov     eax, [arg_0]
                mov     edx, [arg_4]
                mov     [var_8], al
                mov     [var_5], al
                sub     [var_5], dl
                shr     eax, 8
                shr     edx, 8
                mov     [var_7], al
                mov     [var_4], al
                sub     [var_4], dl
                shr     eax, 8
                shr     edx, 8
                mov     [var_6], al
                mov     [var_3], al
                sub     [var_3], dl
                movzx   eax, [var_5]
                push    [nDenominator] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumber]   ; nNumber
                call    MulDiv
                sub     [var_8], al
                movzx   eax, [var_4]
                push    [nDenominator] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumber]   ; nNumber
                call    MulDiv
                sub     [var_7], al
                movzx   eax, [var_3]
                push    [nDenominator] ; nDenominator
                push    eax             ; nNumerator
                push    [nNumber]   ; nNumber
                call    MulDiv
                sub     [var_6], al

loc_402F11:                           
                mov     al, [var_6]
                shl     eax, 8 ; <-- right fade color 
                mov     al, [var_7]
                shl     eax, 8
                mov     al, [var_8]
                ret
sub_402E31      endp


DrawLine      proc hdca:DWORD,arg_4:DWORD,arg_8:DWORD,arg_C:DWORD,arg_10:DWORD,arg_14:DWORD,color:DWORD,arg_1C:DWORD,arg_20:DWORD
LOCAL var_2:BYTE
LOCAL var_1:BYTE
                push    ecx
                push    ebx
                push    esi
                push    edi
                mov     edi, [arg_14]
                mov     esi, [arg_8]
                mov     ebx, [arg_4]
                mov     [var_1], 0
                mov     [var_2], 0
                cmp     ebx, [arg_C]
                jge     short loc_402F45
                mov     [var_1], 1
loc_402F45:                         
                cmp     esi, [arg_10]
                jge     short loc_402F4E
                mov     [var_2], 1
loc_402F4E:                            
                cmp     ebx, [arg_C]
                jle     short loc_402F57
                mov     [var_1], 0FFh
loc_402F57:                           
                cmp     esi, [arg_10]
                jle     short loc_402F94
                mov     [var_2], 0FFh
                jmp     short loc_402F94
loc_402F62:                                                          
                mov     eax, [color]
                push    eax          
                push    edi
                call    GraphShake
                add     eax, esi
                add     eax, [arg_20]
                push    eax             
                push    edi
                call    GraphShake
                add     eax, ebx
                add     eax, [arg_1C]
                push    eax       
                mov     eax, [hdca]
                push    eax            
                call    SetPixel
                movsx   eax, [var_2]
                add     esi, eax
                movsx   eax, [var_1]
                add     ebx, eax
loc_402F94: 
                cmp     ebx, [arg_C]
                jnz     short loc_402F62
                cmp     esi, [arg_10]
                jnz     short loc_402F62
                pop     edi
                pop     esi
                pop     ebx
                pop     ecx
                ret
DrawLine      endp

Randomize      proc near
LOCAL SystemTime:SYSTEMTIME
                lea     edx, [SystemTime]
                push    edx          
                call    GetSystemTime
                movzx   eax, [SystemTime.wHour]
                imul    eax, 3Ch
                add     ax, [SystemTime.wMinute]
                imul    eax, 3Ch
                xor     edx, edx
                mov     dx, [SystemTime.wSecond]
                add     eax, edx
                imul    eax, 3E8h
                mov     dx, [SystemTime.wMilliseconds]
                add     eax, edx
                mov     dword_404044, eax
                ret
Randomize      endp

GraphShake      proc arg_w:DWORD
                mov     eax, [arg_w]
                imul    edx, dword_404044, 8088405h
                inc     edx
                mov     dword_404044, edx
                mul     edx
                mov     eax, edx
                ret
GraphShake      endp