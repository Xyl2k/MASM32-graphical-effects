

_random		PROTO :DWORD
initstars	PROTO
MoveStars	PROTO :DWORD
ScanLines	PROTO :BYTE
BlitEffect	PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
BlitImg		PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
DrawStar	PROTO :DWORD, :DWORD

movmm	MACRO dest, src
	mov eax, src
	mov dest, eax
EndM

clreg	MACRO ; Clear ALL Registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
EndM


	STAR Struct
		color dd ?
		xpos  dd ?
		ypos  dd ?
		speed dd ?
	STAR ends
	
	RGBGrad STRUCT
		RFlag db ?
		GFlag db ?
		BFlag db ?
	RGBGrad EndS
	
.const
	ScreenWidth		equ 672	; screenwidth
	ScreenHeight	equ 480	; height
	DialogAlign		equ 600
	NUM_STARS 		equ 100
	starlen			equ 10
	PixelsN			equ ScreenWidth*ScreenHeight
	
.data?
	stardata	STAR NUM_STARS dup(<?>)

.data
	RandSeed		dd 0A2F59C2Eh
					dd 05B2A10E9h
	GradientColor	dd 00001Fe01h
	GradientSt		RGBGrad <0>

.code

ScanLines PROC SubVal:BYTE 	
	; adds scanlines by dimming every 2nd
	; row of pixels
	LOCAL pixels:DWORD		
	LOCAL total:DWORD
	LOCAL row  :DWORD
	LOCAL counter :DWORD
	
	mov total, PixelsN*4
	pushad
	mov esi, [cBuffer]
	mov row, 0
	mov counter, 0
	beginsub:
	mov ecx, counter
	mov al, byte ptr [esi+ecx]
	mov byte ptr [esi+ecx], al
	inc ecx
	mov al, byte ptr [esi+ecx]
	.if al > SubVal
		sub al, SubVal
	.elseif al < SubVal
		mov al, 22
	.endif
	mov byte ptr [esi+ecx], al
	inc ecx
	mov al, byte ptr [esi+ecx]
	.if al > SubVal
		sub al, SubVal
	.elseif al < SubVal
		mov al, 22
	.endif
	mov byte ptr [esi+ecx], al
	mov counter, ecx
	add row, 2
	cmp ecx, total
	ja endall
	je endall
	cmp row, ScreenWidth*4
	je skiprow
	jmp beginsub
	skiprow:
	mov row, 0
	add counter, ScreenWidth*4
	jmp beginsub
	endall:
	popad
	mov eax, 1
	Ret
ScanLines EndP

DecrunchFX PROC	
	; gives a decrunch thingy
	LOCAL color:DWORD
	LOCAL yPos :DWORD
	LOCAL count:DWORD
	mov count, 0
	invoke _random, 0FFFFFFh
	invoke BlitEffect, 0, 0, eax, ScreenWidth, ScreenHeight
	starts:
	invoke _random, 0FFFFFFh
	mov color, eax
	invoke _random,ScreenHeight-24
	mov yPos, eax
	invoke BlitEffect, 0, yPos, color, ScreenWidth-2, 24
	inc count
	cmp count, 100
	jnz starts
	Ret
DecrunchFX EndP

BlitImg proc xPos:DWORD, yPos:DWORD, hPal:DWORD, hImg:DWORD, wid:DWORD, len:DWORD, tColor:DWORD

LOCAL gfx_yindex       :DWORD                         
LOCAL sm_picturewidth  :DWORD                         
LOCAL sm_pictureleng   :DWORD                         
LOCAL x_position       :DWORD                         
LOCAL y_position       :DWORD                         
                    

                    pushad                            
                    mov eax, xPos
                    mov x_position,eax                
                    mov eax, yPos
                    mov y_position,eax                
                    
                    mov gfx_yindex,0                  
                                            
                    mov eax,y_position                
                    imul eax,sWidth*4           	  
                    add edi,eax                       

                    mov eax,x_position                
                    shl eax,2                         
                    add edi,eax                       
                    
                    mov eax, wid
                    mov sm_picturewidth,eax           
                    mov eax, len
                    mov sm_pictureleng,eax        	  

      
                    mov esi,hImg         			  
incY_line: 
                    xor ecx,ecx                       
incX_line:
                    movzx eax,byte ptr [esi+ecx]      

                    mov edx,hPal        			  
                    mov eax,[edx+eax*4]               
plot_to_screen:
					cmp eax, tColor
					je clip_pixel
                    mov [edi],eax                     
                    add edi,4                         

                    inc ecx                           
                    cmp ecx,sm_picturewidth           
                    jnz incX_line                     

                    mov eax,sm_picturewidth           
                    mov ecx,sWidth             		  
                    sub ecx,eax                       
                    shl ecx,2                         
                    add edi,ecx                       
                                                      
                                                      
                                                                                                          
                    add esi,sm_picturewidth           
                                                      
                    inc gfx_yindex                    
                    mov eax,sm_pictureleng            
                    cmp gfx_yindex,eax                
                    jnz incY_line                     
endit:
                    popad                             
                    ret                               
clip_pixel:
					add edi,4                         
                    jmp clip_pixel_return             
clip_pixel_return:
					inc ecx
					cmp ecx, sm_picturewidth
					jnz incX_line 
					
					mov eax, sm_picturewidth
					mov ecx,sWidth
					sub ecx, eax
					shl ecx,2
					add edi, ecx
					add esi, sm_picturewidth
					inc gfx_yindex
					mov eax, sm_pictureleng
					cmp gfx_yindex, eax
					jnz incY_line
					jmp endit

BlitImg endp


BlitEffect proc xpos:DWORD, ypos:DWORD, color:DWORD, w:DWORD, l:DWORD

; for this example, i'm just using a modified procedure
; from Sheep's DIB Tutorial 1 for simplicity,
; this should be pretty easy to understand if you've read
; Sheep's DibTut #1

LOCAL gfx_yindex       :DWORD                         
LOCAL sm_picturewidth  :DWORD                         
LOCAL sm_pictureleng   :DWORD                         
LOCAL x_position       :DWORD                         
LOCAL y_position       :DWORD                         
                    

                    pushad                            
                    mov eax, xpos
                    mov x_position,eax              
                    mov eax, ypos
                    mov y_position,eax                 
                    
                    mov gfx_yindex,0                  
                                            
                    mov eax,y_position                
                    imul eax,ScreenWidth*4            
                    add edi,eax                       

                    mov eax,x_position                
                    shl eax,2                         
                    add edi,eax                       
                    mov eax, w
                    mov sm_picturewidth,eax           
                    mov eax, l
                    mov sm_pictureleng,eax            

      
incY_line: 
                    xor ecx,ecx                       
incX_line:
                    mov eax,color               
plot_to_screen:
                    mov [edi],eax                     
                    add edi,4                         

                    inc ecx                           
                    cmp ecx,sm_picturewidth           
                    jnz incX_line                     

                    mov eax,sm_picturewidth           
                    mov ecx,ScreenWidth               
                    sub ecx,eax                       
                    shl ecx,2                         
                    add edi,ecx                       
                                                      
                                                      
                                                                                                          
                    add esi,sm_picturewidth           
                                                      
                    inc gfx_yindex                    
                    mov eax,sm_pictureleng            
                    cmp gfx_yindex,eax                
                    jnz incY_line                     

                    popad                             
                    ret                               

BlitEffect endp

_random         PROC USES EDI ESI EBX ECX Range:DWORD

; this function not by me....
; I found this online. If anyone
; recognizes this as their own, feel
; free to contact me, and i'll credit
; you for this.

        mov     ecx,Range      
        mov     eax,dWord ptr [RandSeed+4]
        mov     ebx,dWord ptr [RandSeed]
        mov     esi,eax
        mov     edi,ebx        
        mov     dl,ah
        mov     ah,al
        mov     al,bh
        mov     bh,bl
        xor     bl,bl
        rcr     dl,1        
        rcr     eax,1
        rcr     ebx,1
        add     ebx,edi
        adc     eax,esi
        add     ebx,03b1c62e9h
        adc     eax,04d8f3619h
        mov     dword ptr [RandSeed],ebx
        mov     dword ptr [RandSeed+4],eax
        xor     edx,edx
        div     ecx
        mov     eax,edx           
        jnz     _quit
        inc     eax
_quit:        
        ret
_random         EndP

initstars PROC			; this fills the stardata array
	LOCAL color:DWORD	; with initialization random variables (x, y, color)
	local xpos:DWORD	; xposition
	local ypos:DWORD	; yposition
	local speed:DWORD	; speed
	local counter:DWORD	; counter
	local dwords:DWORD	; number_of_dwords done
	
	mov counter, 0
	mov dwords, 0
	
	startinit:
;	invoke _random, 0FFFFFFh			; disabled
;	mov eax, 099999999h					; this is totally useless, ignore this 
;	mov color, eax						; same
	invoke _random, ScreenWidth-30			; generate random x plane position
	mov xpos, eax						; save value
	invoke _random, ScreenHeight-1			; generate randome y plane position
	mov ypos, eax						; save value
	invoke _random, 8					; generate random speed
	add eax, 2							; add 2 in order to make sure
	mov speed, eax						; no stars have speed of 0, 
										; which would mean they won't move
	mov edx, dwords						; edx == offset from base of star data
;	mov eax, color
	mov dword ptr [offset stardata+edx], eax	; save color (disabled)
	add edx, 4									; next
	mov eax, xpos								; eax == x pos
	mov dword ptr [offset stardata+edx], eax	; save into array
	add edx, 4									; next
	mov eax, ypos								; eax == y pos
	mov dword ptr [offset stardata+edx], eax	; save into array
	add edx, 4									; etc....
	mov eax, speed
	mov dword ptr [offset stardata+edx], eax
	add edx, 4
	mov dwords, edx								; save offset
	inc counter									; increment counter (stars done)
	cmp counter, NUM_STARS						; done yet?
	je AllDone									; if we are, exit
	jmp startinit								; else, start again
	AllDone:									; done!
	mov eax, 1									; return 1
	Ret
initstars EndP

MoveStars PROC STwidth:DWORD
	LOCAL color:DWORD
	LOCAL xpos :DWORD
	LOCAL ypos :DWORD
	LOCAL speed:DWORD
	LOCAL dwords :DWORD
	LOCAL counter:DWORD
	
	; this procedure will MOVE stars
	
	mov counter, 0
	mov dwords, 0
	mov color, 0
	mov xpos, 0
	mov ypos, 0
	startmove:
	mov edx, dwords		; load offset 
	mov eax, dword ptr [offset stardata+edx]	; load color (unused)
	mov color, eax								; save
	add edx, 4									; next
	mov eax,dword ptr [offset stardata+edx]		; load x position from array
	mov xpos ,eax								; save
	add edx, 4									; next
	mov eax,dword ptr [offset stardata+edx]		; load y position from array
	mov ypos, eax								; save
	add edx, 4									; next
	mov eax, dword ptr [offset stardata+edx]	; load speed from array
	mov speed, eax								; save
	add edx, 4									; next
	mov eax, speed								; load speed
	add xpos, eax								; add speed to x-position (moves star)
	mov ecx, ScreenWidth								; ecx == width_screen
	sub ecx, STwidth							; subtract star width
	cmp xpos, ecx								; has the star scrolled across screen?
	mov dwords, edx								; save edx
	je reseed									; if we have, reseed
	ja reseed									; same as above
	mov edx, dwords								; load into edx, dwords (offset)
	sub edx, 16									; sub edx, 16 (back one)
	mov eax, color								; eax = color (unused)
	mov dword ptr [offset stardata+edx], eax	; saving into array
	add edx, 4									; next
	mov eax, xpos								; xpos
	mov dword ptr [offset stardata+edx], eax	; etc, etc....
	add edx ,4
	mov eax, ypos
	mov dword ptr [offset stardata+edx], eax
	add edx, 4
	mov eax, speed
	mov dword ptr [offset stardata+edx], eax
	add edx, 4
	mov dwords, edx
	inc counter									; one more star done
	cmp counter, NUM_STARS						; done yet?
	je alldone									; done?
	jmp startmove								; nope.
	alldone:
	mov dwords, 0
	mov counter, 0
	StartBlt:
	mov edx, dwords								; load edx
	mov eax, dword ptr [offset stardata+edx]	; get color
	mov color, eax								; save
	add edx, 4									; next
	mov eax, dword ptr [offset stardata+edx]	; xpos
	mov xpos, eax
	add edx, 4
	mov eax, dword ptr [offset stardata+edx]	; ypos
	mov ypos, eax
	add edx, 4
	mov eax, dword ptr [offset stardata+edx]	; speed
	mov speed, eax
	add edx, 4
	mov dwords, edx
	invoke DrawStar, xpos, ypos					; call drawstar to draw a star at this position
	inc counter
	cmp counter, NUM_STARS
	je EndAlls
	jmp StartBlt
	EndAlls:
	mov eax, 1
	Ret
	reseed:
	mov eax, 099999999h
	mov color, eax
	invoke _random, ScreenHeight-1				; random y-pos
	mov ypos, eax
	invoke _random, 8							; random speed
	add eax, 2
	mov speed, eax
	mov xpos, 0
	sub dwords, 16
	mov edx, dwords
	mov eax, color
	mov dword ptr [offset stardata+edx], eax	; saving values
	add edx, 4
	mov eax, xpos
	mov dword ptr [offset stardata+edx], eax
	add edx ,4
	mov eax, ypos
	mov dword ptr [offset stardata+edx], eax
	add edx, 4
	mov eax, speed
	mov dword ptr [offset stardata+edx], eax
	add edx, 4
	sub edx, 16
	mov dwords, edx
	jmp startmove
MoveStars endp

DrawStar PROC xP:DWORD, yP:DWORD
	pushad
	xor edx, edx
	mov ecx, 0888888h
	startdraw:
	invoke BlitEffect, xP, yP, ecx, 2, 2
	inc xP
	inc edx
	cmp edx, 02
	ja enddraw
	add ecx, 05050505h
	jmp startdraw
	enddraw:
	popad
	Ret
DrawStar EndP

Noise PROC xP:DWORD, yP:DWORD, rx:DWORD, ry:DWORD, pix2steal:DWORD
	LOCAL hRegion:DWORD
	LOCAL count:DWORD
	mov count, 0
	pushad
	mov edi, [cBuffer]
	mov eax, yP
	imul eax, ScreenWidth*4
	add edi, eax
	mov eax, xP
	shl eax, 2
	add edi, eax
	mov hRegion, edi
	; now we're here
	starts:
	invoke _random, 112
	mov edx, eax
	invoke _random, 112
	mov ecx, eax
	imul ecx, ScreenWidth*4
	shl edx, 2
	add edx, ecx
	add edi, edx
	; stealing pixels
	mov eax, dword ptr [edi]
	mov edi, hRegion
	push eax
	invoke _random, rx
	mov ecx, eax
	invoke _random, ry
	mov edx, eax
	imul edx, ScreenWidth*4
	shl ecx, 2
	add edx, ecx
	add edi, edx
	pop eax
	mov dword ptr [edi], eax
	inc count
	mov ecx, count
	cmp ecx, pix2steal
	ja done
	mov edi, hRegion
	jmp starts
	done:
	popad
	Ret
Noise EndP
