.686
.model flat,stdcall
option casemap:none

PNGBTN	=	1

include keygen.inc
include DoKey.asm
include GFX\bmpbutn.asm

AboutProc	PROTO:DWORD,:DWORD,:DWORD,:DWORD
DrawItem    PROTO hWnd:HWND,lParam:LPARAM

 Draw_Scroller PROTO


tagRECT STRUCT
 left    	dd ?
 top     	dd ?
 right   	dd ?
 bottom  	dd ?
tagRECT ENDS    


GETV MACRO dVar
	mov eax,dVar
  EXITM <eax>
ENDM 

.code
start:



invoke GetModuleHandle,NULL
mov hInstance,eax

invoke LoadIcon,eax,200
mov hIcon,eax

AllowSingleInstance addr szCaption
mov hBgColor,FUNC(CreateSolidBrush,COLORDLG)  	
mov hpen,FUNC(CreatePen,PS_SOLID,0,COLORPEN)

mov hFontTitle,FUNC(CreateFont,13, 0, 0, 0, FW_MEDIUM, 0, 0, 0, 0, 0, 0, 0, 0, SADD(TITLEFONT))  
mov hFontBtn,FUNC(CreateFont,8, 0, 0, 0, FW_MEDIUM, 0, 0, 0, 0, 0, 0, 0, 0, SADD(BTNFONT))
mov hFontBtnBold,FUNC(CreateFont,8, 0, 0, 0, FW_BOLD, 0, 0, 0, 0, 0, 0, 0, 0, SADD(BTNFONT))
mov hFontAbout,FUNC(CreateFont,13, 0, 0, 0, FW_MEDIUM, 0, 0, 0, 0, 0, 0, 0, 0, SADD(ABOUTFONT))
invoke InitCommonControls
invoke DialogBoxParam,hInstance,MainDlg,0,addr MainProc,0
invoke ExitProcess,NULL
TranspWindow proc hWnd :DWORD, Tnsp:BYTE
		
.data
		Tfunc		db "SetLayeredWindowAttributes",0
		libname 	db "user32.dll",0
.code
		
		push	0FFFFFFECh
		push	hWnd
		call	GetWindowLong
		or	eax, 80000h
		push	eax
		push	0FFFFFFECh
		push	hWnd
		call	SetWindowLong
		test	eax, eax
		jnz	short Do_Tns
		ret
		
		
Do_Tns:
		invoke LoadLibrary,addr libname
		invoke GetProcAddress,eax,addr Tfunc
		.if eax == 0
			ret
		.endif
		mov edx,eax
		
		xor ebx,ebx
		mov bl,Tnsp
		
		push	2
		push	ebx
		push	0
		push	hWnd
		call	edx
		ret
		
TranspWindow endp
MainProc	proc	hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
local ThreadID:DWORD

push hWnd
pop hWND

	  
.if uMsg == WM_INITDIALOG

;invoke TranspWindow,hWnd,235
invoke SetWindowText,hWnd,addr szCaption
invoke SetWindowPos,hWnd,HWND_TOPMOST,0,0,0,0,SWP_NOMOVE or SWP_NOSIZE
invoke SetDlgItemText,hWnd,EditSerial,addr PressGen
invoke SendMessage,hWnd,WM_SETICON,1,hIcon
invoke LoadPng,500,addr sizeFrame
mov hIMG,eax
invoke CreatePatternBrush,hIMG
mov hBrush,eax
invoke ImageButton,hWnd,145,210,501,502,800,GenBtn
invoke ImageButton,hWnd,35,210,601,602,800,AboutBtn
invoke ImageButton,hWnd,255,210,701,702,800,ExitBtn

mov hGen,eax
invoke CreateFontIndirect,addr TxtFont

mov hFont,eax

invoke GetDlgItem,hWnd, EditName
invoke SendMessage,eax,WM_SETFONT,hFont,1

invoke GetDlgItem,hWnd,EditSerial
invoke SendMessage,eax,WM_SETFONT,hFont,1

		push esi
		INVOKE FindResource, hInstance, 400, RT_RCDATA
		push eax
		INVOKE SizeofResource, hInstance, eax
		mov nMusicSize, eax
		pop eax
		INVOKE LoadResource, hInstance, eax
		INVOKE LockResource, eax
		mov esi, eax
		mov eax, nMusicSize
		add eax, SIZEOF nMusicSize
		INVOKE GlobalAlloc, GPTR, eax
		mov pMusic, eax
		mov ecx, nMusicSize
		mov dword ptr [eax], ecx
		add eax, SIZEOF nMusicSize
		mov edi, eax
		rep movsb
		pop esi
		invoke mfmPlay, pMusic ; (Play) Çal u len...

invoke AnimateWindow, hWnd, 1000, AW_ACTIVATE  or AW_CENTER 

invoke SetFocus,hGen

.elseif uMsg == WM_CTLCOLORDLG
return hBrush

.elseif uMsg == WM_CTLCOLOREDIT || uMsg == WM_CTLCOLORSTATIC
invoke GetDlgCtrlID,lParam
.if eax ==  EditName ; 
invoke SetBkMode,wParam,TRANSPARENT
invoke SetTextColor,wParam,00A00000h
invoke SetBkColor,wParam,0h
invoke SetBrushOrgEx,wParam,0,170,0
mov eax,hBrush
ret
.elseif uMsg == WM_CTLCOLORDLG
return hBrush

.elseif uMsg == WM_CTLCOLOREDIT || uMsg == WM_CTLCOLORSTATIC
invoke GetDlgCtrlID,lParam
.if eax ==  EditSerial 
invoke SetBkMode,wParam,TRANSPARENT
invoke SetTextColor,wParam,0800000h
invoke SetBkColor,wParam,0h
invoke SetBrushOrgEx,wParam,0,117,0
mov eax,hBrush
ret
.endif
.endif


.elseif uMsg == WM_COMMAND
mov eax,wParam

.if eax == GenBtn
invoke CreateThread,0,0,addr DoKey,hWnd,0,addr ThreadID
invoke Sleep,20

.elseif eax==ExitBtn
 invoke AnimateWindow, hWnd, 1000,   AW_HIDE     or AW_CENTER
 call ExitProcess


.elseif ax == AboutBtn

invoke lstrcpy,addr szAboutMsg,addr AboutTxt
invoke GetWindowRect,hWnd,addr PosRect
mov AboutFlag,1
invoke DialogBoxParam,hInstance,AboutDlg,hWnd,ADDR AboutProc,NULL
invoke RtlZeroMemory,addr szAboutMsg,sizeof szAboutMsg

.endif

.elseif uMsg==WM_LBUTTONDOWN
mov MoveDlg,TRUE
invoke SetCapture,hWnd
invoke GetCursorPos,addr OldPos
		
.elseif uMsg==WM_MOUSEMOVE		
		
.if MoveDlg==TRUE
invoke GetWindowRect,hWnd,addr Rect
invoke GetCursorPos,addr NewPos
mov eax,NewPos.x
mov ecx,eax
sub eax,OldPos.x
mov OldPos.x,ecx
add eax,Rect.left
mov ebx,NewPos.y
mov ecx,ebx
sub ebx,OldPos.y
mov OldPos.y,ecx
add ebx,Rect.top
mov ecx,Rect.right
sub ecx,Rect.left
mov edx,Rect.bottom
sub edx,Rect.top
invoke MoveWindow,hWnd,eax,ebx,ecx,edx,TRUE
.endif

.elseif uMsg==WM_LBUTTONUP
mov MoveDlg,FALSE
invoke ReleaseCapture

.elseif uMsg == WM_CLOSE
invoke uFMOD_PlaySong,0,0,0
invoke DeleteObject,hIMG
invoke DeleteObject,hBrush
invoke EndDialog,hWnd,0
.endif
Wm_1:
           cmp [uMsg],WM_INITDIALOG

           jnz Wm_2

             
             ; Fill in important Bitmap elements. ***************=
             ;                                                  ;|
             ; Nothing complex here.. Just filling in a BITMAP  ;|
             ; structure to specify our format to the DIB call. ;| 
                                                                ;| 
           mov canvas.bmiHeader.biSize,sizeof canvas.bmiHeader  ;|
           mov canvas.bmiHeader.biWidth,ScreenWidth             ;|
           mov canvas.bmiHeader.biHeight,-ScreenHeight          ;|
           mov canvas.bmiHeader.biPlanes,1                      ;|
           mov canvas.bmiHeader.biBitCount,32                   ;|
                                                                ;|
             ;***************************************************=


             ; Setup DibSection. *********************************************************************=
             ;                                                                                       ;| 
             ; This basically Sets up our buffer to write to.                                        ;|
             ; Creates a DC and passes it to the DIBSection call so that it can give us back an      ;|
             ; address to our buffer.                                                                ;|
             ;                                                                                       ;|
                                                                                                     ;|
		 invoke	GetDC, [hWnd]                                                                ;|    
		 mov        hDC,eax 	                                                                 ;| IMPORTANT!
		 invoke	CreateCompatibleDC, eax                                                      ;|
		 mov	      [canvasDC], eax                                                              ;|
		 invoke	CreateDIBSection,hDC,ADDR canvas,DIB_RGB_COLORS, ADDR canvas_buffer, 0, 0    ;|
		 mov	      [canvasBmp], eax                                                             ;|
		 invoke	SelectObject, [canvasDC], eax                                                ;|                                                                       ;|
		 invoke     ReleaseDC,hDC,0                                                              ;|
                                                                                                     ;|
             ;****************************************************************************************=

		 invoke	SetTimer, [hWnd], 12, 0, 0                                                                      

Wm_2:
            cmp [uMsg],WM_TIMER
            jnz Wm_3
          
           ;All our drawing is done here. ***********************************=
                                                                            ;| This small peice of
             mov edi, [canvas_buffer]                                       ;| code wipes away the
             mov ecx,ScreenWidth * ScreenHeight                             ;| previous frame we 
             xor eax,eax                                                    ;| drew to the screen
             rep stosd                                                      ;| without it we get a mess.
                                                                            ;| 
             ;--- drawing functions...                                      ;|
                                                                            ;|
	       mov	edi, [canvas_buffer]                                      ;| IMPORTANT!
	       
		 call	Draw_Scroller                                             ;|
                                                                            ;|
             ;***************************************************************=


             ;*****************************************************************************=
 ;================================================================================================================================            
;================================================================================================================================
 invoke	RedrawWindow, [hWnd], 0, 0,   RDW_INVALIDATE OR RDW_UPDATENOW OR  RDW_NOCHILDREN ;==> evite les clignotement des boutons<========
;================================================================================================================================
;================================================================================================================================
                                                                                          ;|
Wm_3:                                                                                     ;|
	       cmp [uMsg],WM_PAINT                                                          ;|
             jnz Wm_4                                                                     ;|
                                                                                          ;| 
		 mov	eax, [hWnd]                                                             ;| If you dont know what
		 mov	ecx, OFFSET ps                                                          ;| this stuff does then   
		 push	ecx	                                                                  ;| I suggest you start
		 push	eax                                                                     ;| with something a little
		 invoke BeginPaint, eax, ecx                                                  ;| simpler.. 
		 invoke BitBlt, eax, 0, 0, ScreenWidth, ScreenHeight, [canvasDC],0, 0, SRCCOPY;| goto win32asm.cjb.net
		 call EndPaint                                                                ;|
Wm_4:                                                                                     ;| 
	      cmp [uMsg],WM_CLOSE                                                           ;|
		jnz Wm_5                                                                      ;| 
                                                                                          ;|
             invoke EndDialog, [hWnd], 0                                                  ;|
Wm_5:                                                                                     ;|
            ;******************************************************************************=

            ;*****************************************************************************;=
                                                                                          ;| Enables you to click on
            cmp [uMsg],WM_LBUTTONDOWN                                                     ;| the window and move it 
            jnz Wm_6                                                                      ;| around.
                                                                                          ;|
             invoke SendMessage, hWnd, WM_NCLBUTTONDOWN, HTCAPTION, NULL                  ;|  
                                                                                          ;|
            ;******************************************************************************=
Wm_6:
	
  @@quit:	xor	eax, eax
;xor eax,eax
ret

	;Ret
MainProc EndP

LoadPng proc ID:DWORD,pSize:DWORD
local pngInfo:PNGINFO

invoke PNG_Init, addr pngInfo
invoke PNG_LoadResource, addr pngInfo, hInstance, ID
.if !eax
xor eax, eax
jmp @cleanup
.endif
invoke PNG_Decode, addr pngInfo
.if !eax
xor eax, eax
jmp @cleanup
.endif
invoke PNG_CreateBitmap, addr pngInfo, hWND, PNG_OUTF_AUTO, FALSE
.if		!eax
xor eax, eax
jmp @cleanup
.endif
mov edi,pSize
.if edi!=0
lea esi,pngInfo
movsd
movsd
.endif
	
@cleanup:
push eax	
invoke PNG_Cleanup, addr pngInfo	
pop eax
ret
LoadPng endp

SetClipboard	proc	txtSerial:DWORD
local	sLen:DWORD
local	hMem:DWORD
local	pMem:DWORD
	
invoke lstrlen, txtSerial
inc eax
mov sLen, eax
invoke OpenClipboard, 0
invoke GlobalAlloc, GHND, sLen
mov hMem, eax
invoke GlobalLock, eax
mov pMem, eax
mov esi, txtSerial
mov edi, eax
mov ecx, sLen
rep movsb
invoke EmptyClipboard
invoke GlobalUnlock, hMem
invoke SetClipboardData, CF_TEXT, hMem
invoke CloseClipboard	
ret

SetClipboard endp

FadeOut proc

sub Transparency,10
invoke SetLayeredWindowAttributes,hWND,TransColor,Transparency,2
mov eax, Transparency
shr eax,3
add eax,10
invoke uFMOD_SetVolume,eax
cmp Transparency,0
jne @f
invoke SendMessage,hWND,WM_CLOSE,0,0
@@:
	Ret
FadeOut EndP

FadeIn proc

add Transparency,10
invoke SetLayeredWindowAttributes,hWND,TransColor,Transparency,2
mov eax, Transparency
shr eax,3
add eax,10
invoke uFMOD_SetVolume,eax
cmp Transparency,230
jne @f
invoke KillTimer,hWND,222
@@:
	Ret
FadeIn EndP


DrawItem PROC uses esi hWnd:HWND,lParam:LPARAM
mov esi, lParam
assume esi:PTR DRAWITEMSTRUCT

invoke SelectObject,[esi].hdc, hpen
invoke SelectObject,[esi].hdc, hBgColor
invoke Rectangle, [esi].hdc, [esi].rcItem.left, [esi].rcItem.top, [esi].rcItem.right, [esi].rcItem.bottom

.if [esi].itemState & ODS_SELECTED
inc [esi].rcItem.left
inc [esi].rcItem.top
inc [esi].rcItem.bottom
inc [esi].rcItem.right
.endif

invoke SetBkMode,[esi].hdc, TRANSPARENT
invoke SetTextColor,[esi].hdc,COLORTEXT

.if [esi].itemState & ODS_HOTLIGHT
invoke SelectObject,[esi].hdc,hFontBtnBold
.else
invoke SelectObject,[esi].hdc,hFontBtn
.endif

push DT_CENTER or DT_VCENTER or DT_NOCLIP or DT_SINGLELINE

add esi,1Ch
push esi
sub esi,1Ch
push -1
push eax
push [esi].hdc
call DrawText

assume esi:nothing
	Ret
DrawItem EndP

AboutProc	proc	hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
;LOCAL	ps:PAINTSTRUCT
LOCAL	hdc:HDC

.if uMsg == WM_INITDIALOG
invoke TranspWindow,hWnd,212

mov eax,PosRect.left
add eax, 0
mov ebx,PosRect.top
add ebx, 20

invoke MoveWindow,hWnd,eax,ebx,347,230,TRUE
invoke GetParent,hWnd
 invoke AnimateWindow, hWnd, 1000, AW_ACTIVATE or AW_CENTER 
invoke GetClientRect,hWnd,ADDR AboutRect
mov hdc,FUNC(GetDC,hWnd)
mov chdc,FUNC(CreateCompatibleDC,hdc)
mov hbmp,FUNC(CreateCompatibleBitmap,hdc,AboutRect.right,AboutRect.bottom)
invoke SelectObject,chdc,hbmp
mov rClientAbout.top,1
mov rClientAbout.left,1
m2m rClientAbout.right,AboutRect.right
m2m rClientAbout.bottom,AboutRect.bottom    
dec rClientAbout.bottom
dec rClientAbout.right
invoke FillRect,chdc,ADDR AboutRect,hBgColor
invoke FrameRect,chdc,ADDR rClientAbout,hpen
invoke SelectObject,chdc,hpen
invoke MoveToEx,chdc,rClientAbout.left,SIZEOFTITLEBAR,NULL
invoke LineTo,chdc,rClientAbout.right,SIZEOFTITLEBAR
invoke SetTextColor,chdc,COLORTEXT
invoke SetBkColor,chdc,00FA5B2Eh
invoke SelectObject,chdc,hFontTitle
mov rClientAbout.bottom,SIZEOFTITLEBAR

.if AboutFlag == 1
invoke DrawText,chdc,addr AboutTitle,-1,ADDR rClientAbout,DT_CENTER or DT_SINGLELINE or DT_VCENTER or DT_NOCLIP
.elseif
invoke DrawText,chdc,addr ResultTitle,-1,ADDR rClientAbout,DT_CENTER or DT_SINGLELINE or DT_VCENTER or DT_NOCLIP
.endif

inc rClientAbout.left
dec rClientAbout.right
m2m rClientAbout.bottom,AboutRect.bottom
sub rClientAbout.bottom,2
add rClientAbout.top,SIZEOFTITLEBAR

invoke IntersectClipRect,chdc,rClientAbout.left,rClientAbout.top,rClientAbout.right,rClientAbout.bottom

invoke SelectObject,hdc,hFontAbout	  		
invoke DrawText,hdc,ADDR szAboutMsg,-1,ADDR rScroll,DT_CALCRECT + DT_NOPREFIX + DT_CENTER + DT_TOP + DT_NOCLIP

m2m rScroll.right,rClientAbout.right
sub rScroll.right,5
add rScroll.top,GETV(rClientAbout.bottom)
add rScroll.bottom,eax	
		
INVOKE ReleaseDC,hWnd,hdc	
		
mov TimerID,FUNC(SetTimer,hWnd,IDC_TIMER,VITESSEDEFIL,NULL)

.elseif uMsg == WM_PAINT
invoke BeginPaint,hWnd,addr ps
mov hdc,eax
invoke FillRect,chdc,ADDR rScroll,hBgColor
invoke SelectObject,chdc,hFontAbout	
invoke DrawText,chdc,ADDR szAboutMsg,-1,ADDR rScroll,DT_CENTER + DT_TOP + DT_NOPREFIX + DT_NOCLIP
invoke BitBlt,hdc,0,0,AboutRect.right,AboutRect.bottom,chdc,0,0,SRCCOPY
invoke EndPaint,hWnd,addr ps

.elseif uMsg == WM_CTLCOLORDLG
return hBgColor

.elseif uMsg == WM_TIMER
add rScroll.top,GETV(ScrollOffset)
add rScroll.bottom,eax			
.if SDWORD PTR rScroll.top >= GETV(rClientAbout.bottom)
mov ScrollOffset,-1			
.ELSE
.if SDWORD PTR rScroll.bottom <= GETV(rClientAbout.top)
mov ScrollOffset,1
.endif
.endif		
invoke InvalidateRect,hWnd,NULL,FALSE

.ELSEIF uMsg == WM_CLOSE || uMsg == WM_LBUTTONDOWN
mov rScroll.top,0
mov rScroll.bottom,0
mov rScroll.left,0
mov rScroll.right,0
invoke DeleteDC,chdc 
invoke DeleteObject,hbmp
invoke KillTimer,hWnd,TimerID

 invoke AnimateWindow, hWnd, 1000,   AW_HIDE     or AW_CENTER	
invoke EndDialog,hWnd,NULL

.else
    return FALSE    
.endif
  return TRUE
  xor eax,eax 
	Ret
AboutProc EndP
Draw_Scroller proc


     
LOCAL gfx_yindex       :DWORD                         ; Y index of draw position
LOCAL sm_allcharswidth :DWORD                         ; Width of entire character set
LOCAL sm_onecharwidth  :DWORD                         ; Width of 1 character 
LOCAL sm_onecharleng   :DWORD                         ; Length of 1 char  (if ur character set is 8x8 then both are 8)
LOCAL letter_index     :DWORD                         ; Current character to print to screen
LOCAL x_position       :DWORD                         ; Onscreen X position of scroller
LOCAL y_position       :DWORD                         ; Onscreen Y position of scroller
LOCAL scroll_spacer    :DWORD                         ; Smount of space between letters
LOCAL msg_index        :DWORD                         ; Index for text message.
LOCAL draw_buffer      :DWORD
                    
     
;----
; Scroller Function Setup.
;---------------------------------------------------------------------------------------

                    pushad                            ; Save all registers.

                    mov draw_buffer,edi

                    mov msg_index,-0                  ; Start at char 0 in the message.
                    mov x_position,10                 ; Set the X position on screen.
                    mov y_position,4               ; Set the Y position on screen.
                    mov sm_allcharswidth,512          ; Set length of entire font data.
                    mov sm_onecharwidth,8             ; Set character width.   
                    mov sm_onecharleng,14             ; Set character length
                    mov scroll_spacer,0               ; Reset Scroll Spacer.
next_char:

;----
; Scroller Function Main.
;---------------------------------------------------------------------------------------

                                
                    mov gfx_yindex,0                  ; Reset Y plotting variable.
                    mov edi,msg_index                 ; Work out what letter we 
                    mov eax,offset text_message       ; are currently 
                    add eax,message_index             ; starting from.

                    movzx edi,byte ptr [eax+edi]      ; Move current letter into edi
                    cmp edi,0                         ; Check if we have reached end 
                    jnz no_message_reset              ; of message.
                    mov message_index,0               ; If yes then we reset the message.
no_message_reset:
                    sub edi,20h                       ; Subtract 20h from edi to work 
                                                      ; out a reference for our gfx 
                                                      ; data.
                                                       
                    mov letter_index,edi              ; Save resulting offset into variable.
                    
                    mov edi,draw_buffer               ; Setup our Screen buffer to write gfx to.
                    
                    mov eax,posindex                  ; Add our scrolled amount to edi. 
                    shl eax,2                         ; (convert to 32bit).
                    sub edi,eax                       ; 
                    
                    mov eax,y_position                ; Add Y offset to screen.  
                    imul eax,ScreenWidth*4            ; 600*4 = 1 line down.
                    add edi,eax                       ;

                    mov eax,x_position                ; Add X offset to screen.
                    shl eax,2                         ; 
                    add edi,eax                       ; 
              
                    mov eax,scroll_spacer             ; Add scroller text space position.
                    imul eax,sm_onecharwidth          ; (multiply width of space by 1 char)
                    shl eax,2                         ; (convert to 32bit)
                    add edi,eax                       ;

;----
; Scroller Function Gfx Drawing Start.
;---------------------------------------------------------------------------------------

      
                    mov esi,offset goldyfont_g        ; Set font raw data into esi.
                    mov eax,letter_index              ; Move letter being drawn into eax.
                    imul eax,sm_onecharwidth          ; Multiply the current letter by the char 
                                                      ; width to obtain the exact place to read from.
                                                      
                    add esi,eax                       ; Esi now = the correct place to start drawing.
                    
incY_line: 
                    xor ecx,ecx                       ; Reset X plotting position.                     
incX_line:
                    movzx eax,byte ptr [esi+ecx]      ; Move GFX data byte into eax.
                    cmp eax,0                         ; Is it a black color byte?
                    jnz pixel_not_black               ; jmp if byte is not black
                    
                    jmp clip_pixel                    ; Dont Draw if color is black. 
pixel_not_black:
                    mov edx,offset goldyfont_p
                    mov eax,[edx+eax*4]
            

plot_to_screen:
                    stosd                             ; Draws pixel to our screen buffer
clip_pixel_return:
                    inc ecx                           ; Increase X position of current letter gfx.
                    cmp ecx,sm_onecharwidth           ; have we completed 1 whole line of X pixels?
                    jnz incX_line                     ; If no then we draw the next pixel.

                    mov eax,sm_onecharwidth           ; Move character width mutiplier into eax.
                    mov ecx,ScreenWidth                       ; Move screen width into ecx
                    sub ecx,eax                       ; Subtract position of pixels we just drew.
                                                      ; (this places us back at the start of the letter) 
                    shl ecx,2                         ; (convert to 32 bit)
                    
                    add edi,ecx                       ; This drops the Screen position down 1 whole line.
                                                      ; (so now we are at line 2 of the letter (on screen). 
                    add esi,sm_allcharswidth          ; This drops the GFX data down 1 whole line.
                                                      ; (so now we are at line 2 of the letter (gfx data). 
                    inc gfx_yindex                    ; Increase overall Y index.
                    mov eax,sm_onecharleng            ; Move character length into eax.
                    cmp gfx_yindex,eax                ; Have we finished all lines?
                    jnz incY_line                     ; If no then we keep drawing the next line.


;----
; Scroller Function Gfx Drawing End.
;---------------------------------------------------------------------------------------


                    inc msg_index                     ; Move onto next letter in the text message. 
                    inc scroll_spacer                 ; Update scroll offset. 
                                                      ; (so we dont draw the next letter on top of the last one.
   
                    cmp msg_index,37                  ; Have we drawn all 40 characters onscreen?
                    jnz next_char                     ; If no, we keep drawing from the text message.


                    add posindex,1                   ; Move our scroll position along 1 pixel.
                    cmp posindex,8                    ; have we scrolled (character width) pixels across the screen?
                    jnz keep_scrolling                ; If no then we keep scrolling.
                                               
                    mov posindex,0                    ; If yes then we reset the scrolling position back to 0. 
                    add message_index,1               ; Add 1 to the overall message index.
                                                      ; (IMPORTANT - the above 2 instructions create the illusion
                                                      ; that the letter has actually scrolled across the screen) 
keep_scrolling:                                       ;

                    popad                             ; Restore all registers.
                    ret                               ; Exit the function.

clip_pixel:
                    add edi,4                         ; This moves the screen position on by 1 pixel.
                    jmp clip_pixel_return             ; Jump back to drawing loop.




      popad
	ret
Draw_Scroller endp



end start