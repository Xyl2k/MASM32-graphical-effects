AboutProc      PROTO :DWORD,:DWORD,:DWORD,:DWORD

.data

hThread			dd 0
hWks    dd 0
hdckm    dd 0
hdcksm    dd 0
ho              dd 0

AboutFont	LOGFONT <12,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY, 0,"Terminal">

AboutBoxText 	db '     P E R Y F E R i A H   t E A M ',0Ch,0Ah
                db '   RELEASED FOR UR FUCKiN` PLEASURE :',0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah
				db 'tARGEt APP :',0Ch,0Ah
				db '   eTeSoft Video Converter 2.32.912.2',0Ch,0Ah,0Ch,0Ah
				db 'WeB PaGe :',0Ch,0Ah
				db '   www.audio-video-converter.com',0Ch,0Ah,0Ch,0Ah
				db 'pr0tecti0n :',0Ch,0Ah
				db '   S / N',0Ch,0Ah,0Ch,0Ah
				db 'keYgenned by :',0Ch,0Ah
				db '   WeeGee ^ PRF',0Ch,0Ah,0Ch,0Ah
				db 'release date :',0Ch,0Ah
				db '   o 6 . o 4 . 2 o 2 1',0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah
				db 'sh0ut 0ut 2 :',0Ch,0Ah,0Ch,0Ah
				db '  r0ger for this n0ice GFX',0Ch,0Ah
				db '  KesMezar for helping r0ger rippin`',0Ch,0Ah
				db '   this n0ice aboutbox from tPORt',0Ch,0Ah
				db '  ev1l^4 for coding this about temp',0Ch,0Ah
				db '   (initially,i think)',0Ch,0Ah
				db '  MagicH for his V2m library',0Ch,0Ah
				db '  and Melwyn for this CooL V2m !',0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah
				db 'Gr33tz fly out 2 :',0Ch,0Ah,0Ch,0Ah
				db 'Al0hA',0Ch,0Ah
				db 'B@TRyNU',0Ch,0Ah
				db 'ShTEFY',0Ch,0Ah
				db 'r0ger',0Ch,0Ah
				db 'r0bica',0Ch,0Ah
				db 'DAViiiiDDDDDDD',0Ch,0Ah
				db 'pHane',0Ch,0Ah
				db 'PuMMy',0Ch,0Ah
				db 'ShoGunu`',0Ch,0Ah
				db 'zzLaTaNN',0Ch,0Ah
				db 'GRUiA[neinfricatul]',0Ch,0Ah
				db 'MaryNello',0Ch,0Ah
				db 'yMRAN',0Ch,0Ah
				db 'NoNNy',0Ch,0Ah
				db 'QueenAntonia',0Ch,0Ah
				db 'sabYn',0Ch,0Ah
				db 's0r3l',0Ch,0Ah
				db 'r1ckyTiTAN',0Ch,0Ah
				db 'st3fan(C)ADR!AN',0Ch,0Ah
				db 'SiD',0Ch,0Ah
				db 'mYu',0Ch,0Ah
				db 'aMaLiAVerSace',0Ch,0Ah
				db 'Gyahnni',0Ch,0Ah
				db 'bDM10',0Ch,0Ah
				db 'oViSpider',0Ch,0Ah
				db '7epTaru`',0Ch,0Ah
				db 'm3mu',0Ch,0Ah
				db ' + other PRF memberz around !',0Ch,0Ah,0Ch,0Ah
				db 'but also:',0Ch,0Ah,0Ch,0Ah
				db 'GioTiN',0Ch,0Ah
				db 'Roentgen',0Ch,0Ah
				db 'Cachito',0Ch,0Ah
				db 'TeRc0',0Ch,0Ah
				db 'Xylitol',0Ch,0Ah
				db 'Teddy Rogers',0Ch,0Ah
				db 'SKG-1010',0Ch,0Ah
				db 'nuttertools',0Ch,0Ah
				db 'GlacialManDoUtDes',0Ch,0Ah
				db 'Bl4ckCyb3rEnigm4',0Ch,0Ah
				db 'kao',0Ch,0Ah
				db 'atom0s',0Ch,0Ah
				db 'TomaHawk',0Ch,0Ah
				db 'M!X0R',0Ch,0Ah
				db 'EarthMan123',0Ch,0Ah
				db 'dj-siba',0Ch,0Ah
				db 'mrT4ntr4',0Ch,0Ah
				db 'HcH',0Ch,0Ah
				db 'Jowy (a.k.a H!X)',0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah
				db 'u can find us at :',0Ch,0Ah,0Ch,0Ah
				db 'yt : MC Roger',0Ch,0Ah
				db 'ig : @r0gerica',0Ch,0Ah
				db '     @peryferiah.artpack',0Ch,0Ah
				db '     @___.luigi___',0Ch,0Ah
				db 'discord : r0gerica#2649',0Ch,0Ah
				db 'devArt  : r0gerica',0Ch,0Ah
				db 'furaff  : r0gerica',0Ch,0Ah
				db 'github  : r0gerica',0Ch,0Ah,0Ch,0Ah,0Ch,0Ah,0Ch,0Ah
				db '          fuck da ripperz . :E',0
				
				
.data?
unk_420454      db	44Dh	dup(?) ; <-- depending on the text length,ya need to increase these up
unk_420854      db	44Dh	dup(?) ;     so it can loop correctly without crashing (otherwise it will crash) (idfk if it's that so ...
								   ;     it worked even if i inserted two more lines like now . :m)

.code
AboutProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
mov eax,uMsg
.if eax==WM_INITDIALOG
                push    [hWin]
                pop     hWks
                push    0        
                push    0      
                push    0        
                push    offset Draw
                push    0        
                push    0      
                call    CreateThread
                mov     hThread, eax
                xor eax,eax
                ret
.elseif eax==WM_LBUTTONDOWN               
				invoke SendMessage,hWin,112h,0F012h,0
				xor eax,eax
				ret
.elseif eax==WM_RBUTTONDOWN
				invoke TerminateThread,hThread,0
                invoke ReleaseDC,hWin,hdckm
                invoke DeleteDC,hdcksm
                invoke DeleteObject,ho
                invoke EndDialog,hWin,0
                xor eax,eax
                ret		
.elseif eax==WM_CLOSE
				invoke EndDialog,hWin,0
.else
				mov		eax,FALSE
				ret
.endif
				mov		eax,TRUE
				ret
AboutProc endp

Draw    proc near
LOCAL var_4B:DWORD
LOCAL var_41:DWORD
LOCAL var_44:DWORD
LOCAL var_49:DWORD
LOCAL var_52:DWORD
LOCAL psizl:_SIZE
LOCAL hbr:DWORD
LOCAL Rect:RECT
LOCAL h:DWORD
LOCAL hdcSrc:DWORD
LOCAL hdc:DWORD
LOCAL hAboutFont:DWORD
                invoke CreateFontIndirect,addr AboutFont
                mov hAboutFont, eax
                invoke GetDC,hWks
                mov     [hdc], eax
                mov     hdckm, eax
                invoke CreateCompatibleDC,hdc
                mov     [hdcSrc], eax
                mov     hdcksm, eax
                lea     eax, [Rect]   
                invoke GetClientRect,hWks,eax  
                invoke CreateCompatibleBitmap,hdc,Rect.right,Rect.bottom
                mov     [h], eax
                mov     ho, eax  
                invoke SelectObject,hdcSrc,h  
                invoke SetBkMode,hdcSrc,1            
                invoke GetStockObject,4
                mov     [hbr], eax
                lea     eax, [psizl]
                push    eax         
                push    2Bh        
                push    offset AboutBoxText
                push    [hdcSrc] 
                call    GetTextExtentPoint32
                push    [Rect.bottom]
                pop     [psizl.x]
                lea     eax, [psizl]
                push    eax
                push    offset AboutBoxText
                call    DrawEf
                mov     [var_52], eax
                mov     eax, [var_52]
                mov     eax, [eax]
                lea     eax, ds:4[eax*8]
                mov     [var_49], eax
                mov     eax, offset unk_420454
                mov     [var_44], eax
                mov     ecx, [var_49]
                shr     ecx, 2
                mov     esi, [var_52]
                mov     edi, [var_44]
                rep movsd
                mov     eax, [psizl.y]
                neg     eax
                mov     [psizl.y], eax
                mov     eax, [var_44]
                mov     ecx, [eax]
                lea     eax, [eax+ecx*8-4]
                mov     [var_41], eax
loc_41B706:                      
                lea     eax, [Rect]
                invoke  FillRect,hdcSrc,eax,hbr
                push    [var_44]
                call    rectloop
                mov     edi, [var_44]
                mov     ecx, [edi]
                lea     edi, [edi+4]
                mov     [var_4B], 0
loc_41B72C:   
                push    ecx
                mov     esi, [Rect.bottom]
                mov     ebx, [psizl.y]
                cmp     [edi], ebx
                jnb     short loc_41B73B
                cmp     [edi], esi
                jnb     short loc_41B76A
loc_41B73B:                         
                invoke SelectObject,hdcSrc,hAboutFont
                push    dword ptr [edi]
                push    [psizl.y]
                lea     eax, [Rect]
                push    eax
                call    colortx 
                invoke SetTextColor,hdcSrc,eax
                mov     eax, offset AboutBoxText
                add     eax, [var_4B]
                push    dword ptr [edi+4]
                push    eax          
                push    dword ptr [edi] 
                push    14h        ; <-- abouttext X axis value
                push    [hdcSrc]
                call    TextOut
loc_41B76A:  
                mov     eax, [edi+4]
                inc     eax
                inc     eax
                add     [var_4B], eax
                lea     edi, [edi+8]
                pop     ecx
                loop    loc_41B72C
                mov     eax, [var_41]
                mov     eax, [eax]
                cmp     eax, [psizl.y]
                jnz     short loc_41B790
                mov     ecx, [var_49]
                shr     ecx, 2
                mov     esi, [var_52]
                mov     edi, [var_44]
                rep movsd
loc_41B790:                    
                invoke BitBlt,hdc,0,0,Rect.right,Rect.bottom,hdcSrc,0,0,0CC0020h
                invoke Sleep,1Eh ; <-- scroller speed 
                jmp     loc_41B706
Draw    endp


DrawEf      proc offsetx:DWORD,sizetx:DWORD
LOCAL var_C:DWORD
LOCAL var_8:DWORD
LOCAL var_4:DWORD
                push    edi
                push    esi
                xor     eax, eax
                xor     ecx, ecx
                dec     ecx
                mov     edi, [offsetx]
                repne scasb
                not     ecx
                dec     ecx
                mov     [var_4], ecx
                xor     eax, eax
                mov     ah, 0Ah
                mov     al, 0Ch
                mov     ecx, [var_4]
                mov     edi, [offsetx]
                xor     ebx, ebx
loc_41B85E:                       
                cmp     [edi], ax
                jnz     short loc_41B864
                inc     ebx
loc_41B864:                           
                inc     edi
                loop    loc_41B85E
                add     ebx, 3
                shl     ebx, 2
                mov     eax, offset unk_420854
                mov     dword ptr [eax], 0
                mov     [var_8], eax
                mov     [var_C], 0
                xor     eax, eax
                mov     ah, 0Ah
                mov     al, 0Ch
                mov     ecx, [var_4]
                mov     edi, [offsetx]
loc_41B88E:                         
                cmp     [edi], ax
                jnz     short loc_41B8CB
                push    ecx
                push    eax
                push    edi
                mov     edx, [var_8]
                mov     ecx, [edx]
                inc     dword ptr [edx]
                lea     edx, [edx+ecx*8+4]
                mov     eax, [sizetx]
                imul    ecx, [eax+4]
                add     ecx, [eax]
                mov     [edx], ecx
                lea     edx, [edx+4]
                cmp     [var_C], 0
                jnz     short loc_41B8B8
                sub     edi, [offsetx]
loc_41B8B8:                      
                cmp     [var_C], 0
                jz      short loc_41B8C0
                dec     edi
                dec     edi
loc_41B8C0:                        
                sub     edi, [var_C]
                mov     [edx], edi
                pop     edi
                pop     eax
                pop     ecx
                mov     [var_C], edi
loc_41B8CB:                            
                inc     edi
                dec     [var_4]
                jnz     short loc_41B88E
                dec     edi
                dec     edi
                sub     edi, [var_C]
                cmp     [var_C], 0
                jnz     short loc_41B8E1
                inc     edi
                inc     edi
                sub     edi, [offsetx]
loc_41B8E1:                      
                mov     edx, [var_8]
                mov     ecx, [edx]
                inc     dword ptr [edx]
                lea     edx, [edx+ecx*8+4]
                mov     eax, [sizetx]
                imul    ecx, [eax+4]
                add     ecx, [eax]
                mov     [edx], ecx
                lea     edx, [edx+4]
                mov     [edx], edi
                mov     eax, [var_8]
                pop     esi
                pop     edi
                ret
DrawEf      endp

rectloop      proc arg_K:DWORD
                mov     eax, [arg_K]
                mov     ecx, [eax]
                sub     eax, 4
loc_41B82D:              
                lea     eax, [eax+8]
                dec     dword ptr [eax]
                loop    loc_41B82D
                ret
rectloop      endp

colortx      proc valrect:DWORD,ysizx:DWORD,redi:DWORD
                push    ecx
                push    edx
                push    ebx
                mov     eax, [redi]
                mov     ecx, [valrect]
                mov     ecx, [ecx+0Ch]
                sub     ecx, 33h
                mov     edx, [ysizx]
                neg     edx
                sub     edx, 33h
                neg     edx
                cmp     eax, [ysizx]
                ja      short loc_41B7DF
                cmp     eax, edx
                jnb     short loc_41B7F2
loc_41B7DF:                       
                mov     ecx, [ysizx]
                neg     ecx
                add     eax, ecx
                imul    eax, 5
                mov     ah, al
                rol     eax, 8
                mov     al, ah
                jmp     short loc_41B7F7
loc_41B7F2:                        
                mov     eax, 0FFFFFFh
loc_41B7F7:  
                mov     ecx, [valrect]
                mov     ecx, [ecx+0Ch]
                mov     ebx, ecx
                sub     ebx, 33h
                cmp     ebx, [redi]
                jnb     short loc_41B81B
                cmp     [redi], ecx
                jnb     short loc_41B81B
                sub     ecx, [redi]
                mov     eax, ecx
                imul    eax, 5
                mov     ah, al
                rol     eax, 8
                mov     al, ah
loc_41B81B:  
                pop     ebx
                pop     edx
                pop     ecx
				ret
colortx      endp