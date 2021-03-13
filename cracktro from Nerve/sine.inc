; sine stuff

DYCPSineText PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
DXYCPSineScroll PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
BlitChar	PROTO :DWORD, :DWORD, :BYTE, :DWORD, :DWORD,:DWORD,:DWORD,:DWORD
GetSineValue PROTO :DWORD

.data
sinpos	dd 0
sinelen	dd 512
sineorg	dd 0
sineorg2 dd 0
include	sinedata.inc
.code

DYCPSineText PROC xPos:DWORD, yPos:DWORD, mArray:DWORD, hPal:DWORD, hImg:DWORD , cBuffer:DWORD, font_allwid:DWORD, charWid:DWORD, charLen:DWORD
	LOCAL sineadd:DWORD
	LOCAL xposb	 :DWORD
	LOCAL yposb	 :DWORD
	LOCAL char	 :BYTE
	LOCAL arrayad:DWORD
	LOCAL count	 :DWORD
	LOCAL sinpos2 :DWORD
	pushad
	mov eax, sinpos
	mov sinpos2, eax
	mov eax, yPos
	mov yposb, eax
	mov eax, xPos
	mov xposb, eax
	mov count, 0
	mov arrayad, 0
	nextchar:
	mov edi, mArray							; offset of ascii
	mov ecx, arrayad
	mov al, byte ptr [edi+ecx]
	cmp al, 0
	je enddraw
	cmp al, 0aah							; 0aah == lf
	je newline								; newline
	mov char, al
	invoke GetSineValue	, offset SinTabDiv4	; get sine value
	mov sineadd, eax
	add eax, 20
	add eax, yposb
	mov edx, eax
	mov edi, cBuffer
	invoke BlitChar,edx , xposb, char, hPal, hImg, font_allwid, charWid, charLen	; write char
	call ResetPos
	mov eax, charWid
	add xposb, eax
	inc count
	inc arrayad
	jmp nextchar
	newline:
	mov eax, sinpos2
	mov sinpos, eax
	mov sineorg, eax
	mov sineorg2, eax
	mov eax, count
	mov count,0
	imul eax, charWid
	sub xposb, eax
	mov eax, charLen
	add yposb, eax
	inc arrayad
	jmp nextchar
	enddraw:
	call ReallyResetPos				;reset sinepos
	popad
	mov eax, 1
	Ret
DYCPSineText EndP
.data
	msgcharpos		dd 0
	lettercharpos	dd 8
.code
DXYCPSineScroll PROC yPos:DWORD, mArray:DWORD, hPal:DWORD, hImg:DWORD,allwid:DWORD,wid:DWORD,len:DWORD, cBuffer:DWORD
	LOCAL xPb:DWORD
	LOCAL yPb:DWORD
	LOCAL sineadd:DWORD
	LOCAL char:BYTE
	LOCAL count:DWORD
	LOCAL cc:DWORD
	LOCAL sinepos1:DWORD
	pushad
	mov cc,0
	mov eax, sinpos
	mov sinepos1,eax
	mov count, 0
	mov xPb, 0
	mov esi, mArray
	add esi, msgcharpos
	mov eax, lettercharpos
	add eax, xPb
	mov xPb, eax
	startscroll:
	mov al, byte ptr [esi]
	cmp al, 0
	je RESET
	; otherwise
	inc cc
	cmp cc, 690/16
	ja EndScroll
	mov char, al
	invoke GetSineValue, offset SinTabDiv4	; fetch sine
	mov sineadd, eax
	add eax, 20
	add eax, yPos
	mov edx, eax
	invoke BlitChar, edx, xPb, char, hPal, hImg, allwid, wid, len	 ; blit character
	call ResetPos
	inc esi	; next char
	mov eax, wid
	add xPb, eax
	jmp startscroll
	DoneOne:
	inc msgcharpos	;we completed scrolling 1 char
	mov eax, wid
	mov lettercharpos, eax
	inc esi
	inc count
;	call ResetPos
	mov eax, wid
	add xPb, eax
	jmp startscroll
	EndScroll:
	call ReallyResetPos
	mov eax, sinepos1
	mov sinpos, eax
	.if lettercharpos == 0
		mov eax, wid
		mov lettercharpos, eax
		inc msgcharpos
		mov eax, count
		add msgcharpos, eax
	.else
		sub lettercharpos, 2
	.endif
	popad
	Ret
	RESET:
	mov msgcharpos, 0
	mov count, 0
	mov eax, wid
	mov lettercharpos, eax
	jmp EndScroll
DXYCPSineScroll EndP

GetSineValue PROC sintab:DWORD
	LOCAL sinv:DWORD
	pushad
	mov esi, sintab
	startsine:
	mov edx, sinpos
	cmp edx, sinelen
	je resetp
	ja resetp
	; else
	imul edx, 4	; dword!
	mov eax, dword ptr [esi+edx]
	mov sinv, eax
	add sinpos,2
	popad
	mov eax, sinv
	add eax, 1
	Ret
	resetp:
	xor edx, edx
	mov sinpos, 0
	jmp startsine
GetSineValue EndP

ResetPos PROC
	pushad
	mov sinpos, 0
	add sineorg, 2
	mov eax, sinelen
	cmp sineorg, eax
	je reset
	ja reset
	startr:
	mov eax, sineorg
	mov sinpos,eax
	popad
	ret
	reset:
	mov sineorg, 0
	jmp startr
ResetPos EndP

ReallyResetPos PROC
	pushad
	mov sinpos, 0
	mov sineorg, 0
	add sineorg2, 2
	mov eax, sineorg2
	mov sineorg, eax
	mov eax, sinelen
	cmp sineorg2, eax
	je reset
	ja reset
	startr:
	mov eax, sineorg2
	mov sinpos, eax
	popad
	ret
	reset:
	mov sineorg2,0
	jmp startr
ReallyResetPos EndP

BlitChar proc yp:DWORD, xp:DWORD, char:BYTE, fontpal:DWORD, fontimg:DWORD, allwidth:DWORD, charwidth:DWORD, charleng:DWORD


    

LOCAL gfx_yindex       :DWORD                         
LOCAL sm_allcharswidth :DWORD                         
LOCAL sm_onecharwidth  :DWORD                         
LOCAL sm_onecharleng   :DWORD                         
LOCAL letter_index     :DWORD                         
LOCAL x_position       :DWORD                         
LOCAL y_position       :DWORD                         
LOCAL msg_index        :DWORD                         
LOCAL sin_status       :DWORD                    
LOCAL sin_addition     :DWORD    
LOCAL letterx_pos      :DWORD           
LOCAL lettery_pos      :DWORD          
LOCAL invert_me        :DWORD  
LOCAL invert_counter   :DWORD
LOCAL draw_buffer      :DWORD




                    pushad                            
                    mov eax,yp
                    mov y_position,eax
                    mov draw_buffer,edi
                    mov invert_counter,0
                    mov msg_index,0                   
                    mov eax, xp
                    mov x_position,eax                
                    mov eax,yp
                    mov y_position,eax                
                    mov eax, allwidth
                    mov sm_allcharswidth,eax         
                    mov eax, charwidth
                    mov sm_onecharwidth,eax	
                    mov eax, charleng
                    mov sm_onecharleng,eax	
                    mov letterx_pos,0                 
                    mov lettery_pos,0                 

           

next_char:
                  




                    mov gfx_yindex,0                  
					movzx edi, char
                    cmp edi,0                         
                    jz  end_func                      
no_newline:
                  
                    sub edi,20h                       
                                                      
                                                      
                    mov eax, edi
                    mov char,al             		  
                    
                    mov edi,draw_buffer               
                    
                    mov eax,letterx_pos               
                    imul eax,sm_onecharwidth          
                    shl eax,2                         
                    add edi,eax                       

                    mov eax,lettery_pos               
                    imul eax,sWidth*4                 
                    add edi,eax                       




      
                    mov esi,fontimg           
                    movzx eax,char              
                    imul eax,sm_onecharwidth          
                                                      
                                                                                                          
                    add esi,eax                       
                                 

                    mov eax,x_position                
                    shl eax,2                         
                    add edi,eax                       

                    mov edx,y_position                
                    imul edx,sWidth*4                 
                    add edi,edx                       
incY_line: 
                                        
                    xor ecx,ecx                       
incX_line:

                    movzx eax,byte ptr [esi+ecx]      
                    mov edx,fontpal
                    mov eax,[edx+eax*4]
                                       
                    cmp eax,0
                    jz clip_pixel
        
plot_to_screen:
                    stosd                             
clip_pixel_return:
                    inc ecx                           
                    cmp ecx,sm_onecharwidth           
                    jnz incX_line                     

                    mov eax,sm_onecharwidth           
                    mov ecx,sWidth               
                    sub ecx,eax                       
                                                      
                    shl ecx,2                         
                    
                    add edi,ecx                       
                                                      
                    add esi,sm_allcharswidth          
                                                      
                    inc gfx_yindex                    
                    mov eax,sm_onecharleng            
                    cmp gfx_yindex,eax                
                    jnz incY_line                     






end_func:                                    

                    popad                             
                    ret                               

clip_pixel:
                    add edi,4                         
                    jmp clip_pixel_return             
       


BlitChar endp