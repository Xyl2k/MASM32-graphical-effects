AboutProc	PROTO	:DWORD,:DWORD,:DWORD,:DWORD
DrawAbout 	PROTO	:DWORD
FadeInTxt   PROTO	:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
FadeSteps   PROTO	:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

.data
AboutFont	LOGFONT <16,0,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY, 0,"Courier New">     

AboutBoxText          db 0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah
				db "               tHE PERYFERiAH tEAM",0Dh,0Ah
				db "        PRESENTS U ANOTHER FiNE RELEASE :",0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah
				db "    Target     : ",0Dh,0Ah
				db "    GiliSoft Privacy Protector 11.0.0 ",0Dh,0Ah
				db "    keYgen by  : sabYn                    ",0Dh,0Ah
				db "    Date       : 08.08.2021               ",0Dh,0Ah
				db "    Protection : Custom                    ",0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah
				db "       10x 2 :   ",0Dh,0Ah,0Dh,0Ah
				db "       MagicH for the V2m lib ",0Dh,0Ah
				db "       Melwyn and Little Bitchard for the V2m",0Dh,0Ah
				db "       r0ger for the n0ice GFX",0Dh,0Ah
				db "       + for ripping this aboutbox effect",0Dh,0Ah
				db "         from UNDERPL :)",0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah
				db "       Gr33tZ 2  :   ",0Dh,0Ah,0Dh,0Ah
				db "       r0ger....[REVERSER/GFX-ER/ASM.CODER]",0Dh,0Ah
				db "       Al0hA.....................[REVERSER]",0Dh,0Ah
				db "       r0bica....................[REVERSER]",0Dh,0Ah
				db "       MaryNello.................[REVERSER]",0Dh,0Ah
				db "       GRUiA.....................[REVERSER]",0Dh,0Ah
				db "       yMRAN.....................[REVERSER]",0Dh,0Ah
				db "       s0r3l.....................[REVERSER]",0Dh,0Ah
				db "       iSkyle....................[C++CODER]",0Dh,0Ah
				db "       ShTEFY......................[HELPER]",0Dh,0Ah
				db "       NoNNy.....................[REVERSER]",0Dh,0Ah
				db "       zzLaTaNN..................[REVERSER]",0Dh,0Ah
				db "       B@TRyNU...................[REVERSER]",0Dh,0Ah
				db "       oViSpider.................[REVERSER]",0Dh,0Ah
				db "       bDM10.....................[REVERSER]",0Dh,0Ah
				db "       WeeGee....................[REVERSER]",0Dh,0Ah
				db "       st3fan(C)ADR!AN...........[REVERSER]",0Dh,0Ah
				db "       DAViiiiDDDDDDD..............[HELPER]",0Dh,0Ah
				db "       .............and other PRF memberz..",0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah
				db "       but also to :                            ",0Dh,0Ah,0Dh,0Ah
				db "       Cachito.......................[tSRh]",0Dh,0Ah
				db "       Roentgen......................[tSRh]",0Dh,0Ah
				db "       rooster1......................[tSRh]",0Dh,0Ah
				db "       kao.................................",0Dh,0Ah
				db "       Xylitol........................[RED]",0Dh,0Ah
				db "       Sangavi.......................[tSRh]",0Dh,0Ah
				db "       Vinnu.........................[tSRh]",0Dh,0Ah
				db "       FnZnL!................[decompile.us]",0Dh,0Ah
				db "       Razorblade1979................[URET]",0Dh,0Ah
				db "       GioTiN.........................[UST]",0Dh,0Ah
				db "       TeddyRogers....................[SnD]",0Dh,0Ah
				db "       GlacialMan....................[URET]",0Dh,0Ah
				db "       Tux528..............................",0Dh,0Ah
				db "       SKG-1010............................",0Dh,0Ah
				db "       vk1989..............................",0Dh,0Ah
				db "       Ayumi.........................[tSRh]",0Dh,0Ah
				db "       Bl4ckCyb3rEnigm4....................",0Dh,0Ah
				db "       Arttomov......................[URET]",0Dh,0Ah
				db "       Talers........................[tSRh]",0Dh,0Ah
				db "       LockerBoss....................[tSRh]",0Dh,0Ah
				db "       Jux64...............................",0Dh,0Ah
				db "       and otherz .........................",0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah
				db "    contact info :",0Dh,0Ah,0Dh,0Ah
				db "       mail    :   prfteam@hush.com",0Dh,0Ah
				db "       insta   :   @r0gerica // @sabiin.theo",0Dh,0Ah
				db "       discord :   r0gerica#2649",0Dh,0Ah
				db "       github  :   r0gerica",0Dh,0Ah
				db "       youtube :   MC Roger",0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah
				db "       fuckingz 2 all the lamerz and ripperz",0Dh,0Ah
				db "       who wanna make profit from these",0Dh,0Ah
				db "       releases, who supports p2p scene ,",0Dh,0Ah
				db "       who think PRF is a sockpuppet crackin`",0Dh,0Ah
				db "       team, who fucks a hardworking reverser,",0Dh,0Ah
				db "       or simply rip/steal other ppl's releases.",0Dh,0Ah,0 ; <-- end of scroller (i think you need to wait around 10-20 seconds to have the credits roll restart)
				

TextLength EQU $-AboutBoxText

nWidth	equ	400
nHeight	equ	200

.data?
pbmi            BITMAPINFO <>
rc              RECT <>
dword_402C93    dd ?
AboutThread     dd ?
hAboutFont      dd ?
dword_402CAB    dd ?
hdc             dd ?
dword_402CBB    dd ?
dword_402CC3    dd ?
dword_402CCB    dd ?
hLength   		dd ?
ho              dd ?
hdcSrc          dd ?
ppvBits         dd ?

.code
TopXY proc wDim:DWORD, sDim:DWORD

    shr sDim, 2      ; divide screen dimension by 2
    shr wDim, 4      ; divide window dimension by 2
    mov eax, sDim
    sub eax, wDim

    ret
TopXY	endp

AboutProc       proc near uses ebx esi edi xWnd:DWORD, uMsgz:DWORD, wParamz:DWORD, LParamz:DWORD
LOCAL dwNewLong:DWORD
LOCAL xPos
LOCAL yPos
                cmp     [uMsgz], WM_INITDIALOG
                jnz     loc_408FBC

loc_initdialog:                       
                invoke  GetWindowLong,[xWnd],GWL_EXSTYLE
                mov     [dwNewLong], eax

                or      [dwNewLong], 80h
                and     [dwNewLong], 0FFFBFFFFh
                invoke  SetWindowLong,[xWnd],GWL_EXSTYLE,[dwNewLong]
                mov     dword_402C93, 0
                
                invoke  GetSystemMetrics,SM_CXSCREEN
               	invoke  TopXY,nWidth,eax
                mov     xPos,eax
         
                invoke  GetSystemMetrics, SM_CYSCREEN
                invoke  TopXY,nHeight,eax
                mov     yPos,eax

                invoke  SetWindowPos,[xWnd],0,xPos,yPos,nWidth,nHeight,SWP_SHOWWINDOW

               	invoke  CreateThread,0,0,offset DrawAbout,[xWnd],0,AboutThread
               	invoke  CloseHandle,eax
                jmp     short loc_408FE2

loc_408FBC:                             
                cmp     [uMsgz], WM_LBUTTONDOWN
                jz      short loc_movewnd
                cmp     [uMsgz], WM_RBUTTONUP
                jz      short loc_enddialog
                jmp     short loc_408FE2

loc_movewnd:
                invoke  SendMessage,[xWnd],WM_NCLBUTTONDOWN,HTCAPTION,LParamz
                jmp     short loc_408FE2
                
loc_enddialog:           
                mov     dword_402C93, 1
                invoke  EndDialog,[xWnd],0

loc_408FE2:                             
                                        
                xor     eax, eax
                ret
AboutProc       endp


DrawAbout      proc near  xWnd : DWORD

                invoke  CreateFontIndirect,addr AboutFont
                mov     hAboutFont, eax

                invoke  GetDC,[xWnd]
                mov     dword_402CAB, eax

                xor     esi, esi
                dec     esi
                mov     edi, offset AboutBoxText
                mov     ecx, TextLength
                mov     al, 0Dh

loc_408C28:                             ; CODE XREF: ThreadProc+51?j
                inc     esi
                repne scasb
                jz      short loc_408C28

                lea     esi, ds:TextLength
                mov     hLength, esi

                invoke  CreateCompatibleDC,0
                mov     hdc, eax
                invoke  SelectObject,hdc,hAboutFont
                xor     edx, edx
                lea     edi, pbmi
                mov     dword ptr [edi], 28h ; '('
                mov     dword ptr [edi+4], 280h
                mov     eax, hLength
                not     eax
                mov     [edi+8], eax
                mov     word ptr [edi+0Ch], 1
                mov     word ptr [edi+0Eh], 20h ; ' '
                invoke  CreateDIBSection,hdc,edi,edx,offset ppvBits,edx,edx
                mov     ho, eax
                invoke  SelectObject,hdc,eax
                mov     eax, ppvBits
                mov     ecx, 280h
                imul    ecx, hLength

loc_408CB8:                             ; CODE XREF: ThreadProc+E7?j
                mov     dword ptr [eax], 0
                add     eax, 4
                loop    loc_408CB8
                invoke  CreateCompatibleDC,0
                mov     hdcSrc, eax
                invoke  CreateDIBSection,hdcSrc,edi,0,offset dword_402CC3,0,0
                mov     dword_402CCB, eax
                invoke  SelectObject,hdcSrc,eax
                invoke  SetTextColor,hdc,0FFFFFFh
                invoke  SetBkMode,hdc,TRANSPARENT
                mov     rc.top, 2
                mov     rc.left, 3
                push    hLength
                pop     rc.bottom
                mov     rc.right, 280h
                invoke  DrawText,hdc,offset AboutBoxText,TextLength,offset rc,0
                invoke  SetTextColor,hdc,0FFFFFFh
                mov     rc.top, 0
                mov     rc.left, 0

loc_408D7E:                             ; CODE XREF: ThreadProc+317?j
                mov     eax, dword_402CC3
                mov     ecx, 280h
                imul    ecx, hLength

loc_408D8F:                             ; CODE XREF: ThreadProc+1BE?j
                mov     dword ptr [eax], 0
                add     eax, 4
                loop    loc_408D8F
                mov     esi, 0

loc_408D9F:                             ; CODE XREF: ThreadProc+239?j
                call    GetTickCount
                push    eax
                invoke  FadeInTxt,dword_402CC3,nWidth,0,0,ppvBits,nWidth,hLength,esi
                invoke  BitBlt,dword_402CAB,0,0,nWidth,nHeight,hdcSrc,0,0,0CC0020h
                cmp     dword_402C93, 1
                jz      loc_408EF6

loc_408E00:                             ; CODE XREF: ThreadProc+232?j
                call    GetTickCount
                pop     ebx
                push    ebx
                sub     eax, ebx
                cmp     eax, 19h
                jb      short loc_408E00
                pop     ebx
                inc     esi
                cmp     esi, 46h ; 'F'
                jnz     short loc_408D9F

                invoke  Sleep,10
                mov     eax, dword_402CC3
                mov     ecx, 280h
                imul    ecx, hLength

loc_408E30:                             ; CODE XREF: ThreadProc+25F?j
                mov     dword ptr [eax], 0
                add     eax, 4
                loop    loc_408E30
                mov     dword_402CBB, 0
                invoke  FadeSteps,ppvBits,dword_402CBB,dword_402CC3,nWidth,nHeight,0,28h

loc_408E6A:                             ; CODE XREF: ThreadProc+311?j
                call    GetTickCount
                push    eax
                invoke  BitBlt,dword_402CAB,0,0,nWidth,nHeight,hdcSrc,0,0,0CC0020h
                push    2Ah ; '*'
                push    0
                push    nHeight ; 'Ü'
                push    280h ; <-- this is where the glitch happens bcs when i put the about dialogbox width setted up in .data section,
                		     ; after the first page fades in , the credits roll will start rolling from right to left while the credits scroll up - so be cautious with it.
                		     ; the more you increase this value , the more credits roll starts rolling horizontally and increasing the speed.
                push    dword_402CC3
                push    dword_402CBB
                push    ppvBits
                call    FadeSteps

loc_408EBD:                             ; CODE XREF: ThreadProc+2EF?j
                call    GetTickCount
                pop     ebx
                push    ebx
                sub     eax, ebx
                cmp     eax, 19h
                jb      short loc_408EBD
                pop     ebx
                cmp     dword_402C93, 1
                jz      short loc_408EF6
                inc     dword_402CBB
                mov     eax, hLength
                sub     eax, 0C8h ; '?'
                cmp     dword_402CBB, eax
                jnz     loc_408E6A
                jmp     loc_408D7E
; ---------------------------------------------------------------------------

loc_408EF6:                             ; CODE XREF: ThreadProc+220?j
                                        ; ThreadProc+2F9?j
                invoke DeleteDC,hdc
                invoke DeleteDC,hdcSrc
                invoke DeleteObject,ho
                invoke DeleteObject,dword_402CCB
                invoke DeleteObject,hAboutFont
                mov     dword_402C93, 0
                ret
DrawAbout      endp


FadeInTxt      proc near arg_0:DWORD,arg_4:DWORD,arg_8:DWORD,arg_C:DWORD,arg_10:DWORD,arg_14:DWORD,arg_18:DWORD,arg_1C:DWORD

                pusha
                mov     ecx, [arg_18]
                mov     esi, [arg_10]
                mov     edi, [arg_C]
                imul    edi, [arg_4]
                add     edi, [arg_8]
                shl     edi, 2
                add     edi, [arg_0]
                mov     edx, [arg_4]
                sub     edx, [arg_14]
                shl     edx, 2

loc_408BB5:                             ; CODE XREF: sub_408B92+41?j
                push    ecx
                mov     ecx, [arg_14]
                shl     ecx, 2

loc_408BBC:                             ; CODE XREF: sub_408B92+3C?j
                xor     eax, eax   ; if you replace this eax with esi , you will experience an amiga scanline intro lookalike :D        the glitch seemed pretty interesting for me :))
                lodsb
                movzx   ebx, byte ptr [edi]
                sub     eax, ebx
                imul    eax, [arg_1C]
                shr     eax, 8 ; <-- fade speed(?)
                add     eax, ebx
                stosb
                loop    loc_408BBC
                pop     ecx
                add     edi, edx
                loop    loc_408BB5
                popa
                ret
FadeInTxt      endp

FadeSteps      proc near arg_0:DWORD,arg_4:DWORD,arg_8:DWORD,arg_C:DWORD,arg_10:DWORD,arg_14:DWORD,arg_18:DWORD
LOCAL var_8:DWORD
LOCAL var_4:DWORD

                pusha
                mov     esi, [arg_4]
                imul    esi, [arg_C]
                shl     esi, 2
                add     esi, [arg_0]
                mov     edi, [arg_8]
                xor     edx, edx
                mov     eax, 0FFh
                idiv    [arg_18]
                mov     [var_4], eax
                mov     edx, [arg_14]
                mov     ecx, [arg_10]

loc_408B3F:                             ; CODE XREF: sub_408B15+76?j
                push    ecx
                mov     eax, [arg_10]
                sub     eax, ecx
                cmp     eax, [arg_18]
                ja      short loc_408B53
                imul    eax, [var_4]
                mov     [var_8], eax
                jmp     short loc_408B6D
; ---------------------------------------------------------------------------

loc_408B53:                             ; CODE XREF: sub_408B15+33?j
                sub     eax, [arg_10]
                not     eax
                cmp     eax, [arg_18]
                ja      short loc_408B66
                imul    eax, [var_4]
                mov     [var_8], eax
                jmp     short loc_408B6D
; ---------------------------------------------------------------------------

loc_408B66:                             ; CODE XREF: sub_408B15+46?j
                mov     [var_8], 0FFh

loc_408B6D:                             ; CODE XREF: sub_408B15+3C?j
                                        ; sub_408B15+4F?j
                mov     ecx, [arg_C]
                shl     ecx, 2 ; <-- fade step size

loc_408B73:                             ; CODE XREF: sub_408B15+73?j
                xor     eax, eax
                lodsb
                movzx   ebx, dl
                sub     eax, ebx
                imul    eax, [var_8]
                shr     eax, 8
                add     eax, ebx
                stosb
                ror     edx, 8
                loop    loc_408B73
                pop     ecx
                loop    loc_408B3F
                popa
                ret
FadeSteps      endp