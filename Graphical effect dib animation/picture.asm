;*********************************************************************
;*                                                                   *
;*       Title: DibDemo Tutorial 1 - Picture Source.                 |
;*        Date: 23/01/05                                             |  
;* Description: This is the source code that accompanies             |
;*              The First tutorial.                                  |
;*      Author: Sheep                                                |
;*                                                                   *
;*********************************************************************
 
.486
.model flat, stdcall
option casemap:none
title Template
 ;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ;includes
 
      include \masm32\include\windows.inc
      include \masm32\include\kernel32.inc
      include \masm32\include\user32.inc
      include \masm32\include\gdi32.inc
      includelib \masm32\lib\kernel32.lib
      includelib \masm32\lib\user32.lib
      includelib \masm32\lib\gdi32.lib
      
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;constants

	ScreenWidth    equ 600;300
	ScreenHeight   equ 200
      DialogAlign    equ 600

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;function declaration

      DlgProc	  PROTO	:DWORD,:DWORD,:DWORD,:DWORD
      Draw_Picture  PROTO

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.data

	rcDraw		RECT	<0>

; |**** PICTURE DATA **************|

      include pic.asm;g_picture.asm
      
; |********************************|

loc_403048 dd 0
loc_40304c dd 0
x_pos dd 0
y_pos dd 0
local_flag db 0
loc_40303a db 0
loc_403043 db 0
loc_403044 dd 0
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.data?

	canvasDC	  dd	?
	canvasBmp	  dd	?
      hDC           dd  ?
	canvas_buffer dd	?
      clip1         dd  ?
      clip2         dd  ?
      
	ps		  PAINTSTRUCT	<>
	canvas	  BITMAPINFO	<>


;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


.code
start:	
      invoke	GetModuleHandle, eax
	invoke	DialogBoxParam, eax, 100, 0, ADDR DlgProc, eax
	invoke	ExitProcess, eax




DlgProc proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
	  
Wm_1:
           cmp [uMsg],WM_INITDIALOG
           jnz Wm_2
           push DialogAlign
             
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
           pop eax                                              ;|
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

		 invoke	SetTimer, [hWnd], 1, 0, 0                                                                      
mov loc_403048,0a0h
xor eax,eax
mov eax,DialogAlign;258
sub eax,loc_403048
sub eax,64h
mov loc_40304c,eax


Wm_2:
            cmp [uMsg],WM_TIMER
            jnz Wm_3
            cmp byte ptr local_flag,1
            je _01
            cmp dword ptr y_pos,5
            jle _02
            sub y_pos,2
            jmp _03
_01:        cmp y_pos,5fh
            jge _04
            add y_pos,2
            jmp _03
_02:        mov byte ptr local_flag,1
            jmp _03
_04:        mov byte ptr local_flag,0
_03:        cmp dword ptr x_pos,8
            jle _07
            sub x_pos,2
            jmp _09
 _07:       mov x_pos,24eh
            jmp _09
           
 _09:          
           
           
           
           
           
           ;All our drawing is done here. ***********************************=
                                                                            ;| This small peice of
             mov edi, [canvas_buffer]                                       ;| code wipes away the
             mov ecx,ScreenWidth * ScreenHeight                             ;| previous frame we 
             xor eax,eax                                                    ;| drew to the screen
             rep stosd                                                      ;| without it we get a mess.
                                                                            ;| 
             ;--- drawing functions...                                      ;|
                                                                            ;|
	       mov	edi, [canvas_buffer]                                        ;| IMPORTANT!
		 call	Draw_Picture                                                ;|
                                                                            ;|
             ;***************************************************************=


             ;*****************************************************************************=
                                                                                          ;|
             invoke	RedrawWindow, [hWnd], 0, 0, RDW_INVALIDATE                        ;| 
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
	
            xor	eax, eax
	      ret

DlgProc endp

;**************************************************************
;*
;* OUR FUNCTIONS ARE CODED HERE!!!!!!!!!!!!
;*
;**************************************************************

Draw_Picture proc


LOCAL gfx_yindex       :DWORD                         ; Y position of raw data index
LOCAL sm_picturewidth  :DWORD                         ; Width of picture (100) 
LOCAL sm_pictureleng   :DWORD                         ; Length of picture (100)
LOCAL x_position       :DWORD                         ; Onscreen X position of picture
LOCAL y_position       :DWORD                         ; Onscreen Y position of picture
                    

                    pushad                            ; Save all registers.
                  
                    ;mov x_position,0                  ; Set the X position on screen.
                    ;mov y_position,0                  ; Set the Y position on screen.
                    mov eax,x_pos
                    mov x_position,eax
                    mov eax,y_pos
                    mov y_position,eax
                    
                    
                    mov gfx_yindex,0                  ; Reset Y raw data index.
                                            
                    mov eax,y_position                ; Add Y offset to screen.  
                    imul eax,ScreenWidth*4            ; ScreenWidth*4 = 1 line down.
                    add edi,eax                       ;

                    mov eax,x_position                ; Add X offset to screen.
                    shl eax,2                         ; 
                    add edi,eax                       ; 
                    
                    mov sm_picturewidth,100           ; Set width of picture.
                    mov sm_pictureleng,100            ; Set length of picture.

      
                    mov esi,offset picture_g          ; esi = pointer to start of raw picture data.
incY_line: 
                    xor ecx,ecx                       ; Reset X raw picture data position.                     
incX_line:
                    movzx eax,byte ptr [esi+ecx]      ; Move raw picture data byte into eax.

                    mov edx,offset picture_p          ; edx = pointer to raw pallete data.
                    mov eax,[edx+eax*4]               ; Move the indexed palette color into eax.
plot_to_screen:
 ;-----------new------                   
          mov loc_403044,eax
          mov eax,x_pos                  
          cmp eax,loc_403048
          ja _x1
          jmp _x2
_x1:      cmp eax,loc_40304c
          jl _x3
          jmp _x4
_x3:      mov eax,loc_403044
          jmp _x5
_x2:      mov eax,loc_403048
          sub eax,x_pos
          mov byte ptr loc_40303a,al
          mov eax,loc_403044
          jmp _x7
_x4:      mov eax,x_pos
          sub eax,loc_40304c
          mov byte ptr loc_40303a,al
          mov eax,loc_403044
_x7:      mov byte ptr loc_403043,0
_x9:      cmp al,loc_40303a
          jnb _x8
          mov al,loc_40303a
_x8:      sub al,loc_40303a
          ror eax,8
          inc byte ptr loc_403043
          cmp byte ptr loc_403043,8;4 fix bug!
          jnz _x9
          jmp _x10
_x5:      mov byte ptr loc_40303a,0
                
_x10:                   
  
  ;---------end-------------------                  
                    mov [edi],eax                     ; Draws pixel stored in EAX to our screen buffer.
                    add edi,4                         ; Increase buffer so its pointing to next pixel.

                    inc ecx                           ; Increase X position of raw picture data.
                    cmp ecx,sm_picturewidth           ; have we completed 1 whole line of X pixels?
                    jnz incX_line                     ; If no then we draw the next pixel.

                    mov eax,sm_picturewidth           ; Move picture width into eax.
                    mov ecx,ScreenWidth               ; Move screen width into ecx
                    sub ecx,eax                       ; Subtract position of pixels we just drew.
                    shl ecx,2                         ; (convert to 32 bit)
                    add edi,ecx                       ; This drops the Screen position down 1 whole line.
                                                      ; (so now we are at the start of line 2 on the screen
                                                      ; ready to start drawing the next line of our picture). 
                                                                                                          
                    add esi,sm_picturewidth           ; This drops the raw picture data down 1 whole line.
                                                      ; (so now we are at line 2 of the picture (raw data). 
                    inc gfx_yindex                    ; Increase overall Y index. (amount of lines we have written)
                    mov eax,sm_pictureleng            ; Move picture length into eax.
                    cmp gfx_yindex,eax                ; Have we finished all lines?
                    jnz incY_line                     ; If no then we keep drawing the next line.

                    popad                             ; Restore all registers.
                    ret                               ; Exit the function.

Draw_Picture endp

end start