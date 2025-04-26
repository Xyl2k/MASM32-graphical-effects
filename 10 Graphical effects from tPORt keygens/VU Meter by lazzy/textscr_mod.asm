SCROLLER_STRUCT struct
		scroll_hwnd		dd ?
		scroll_text		dd ? 
		scroll_x		dd ? 
		scroll_y		dd ? 
		scroll_width		dd ? 
		scroll_hFont		dd ? 
		scroll_textcolor	dd ? 
		scroll_alpha		db ? 
		scroll_wait		dd ? 
		scroll_pause		db ? 
		SCROLLER_STRUCT ends
	
		CreateScroller	PROTO :DWORD
		PauseScroller	PROTO :DWORD
		ScrollThread	PROTO :DWORD
		BlendBitmap		PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
		BlendPixel		PROTO :DWORD,:DWORD,:DWORD
		PercentValue	PROTO :DWORD,:DWORD
		PercentColor	PROTO :DWORD,:DWORD

ScrollerInit    PROTO	:DWORD
MakeDialogTransparentValue		PROTO	:DWORD,:DWORD

.data

ScrollFont		LOGFONT <14,0,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'Tahoma'>
ScrollText	    		db	"Some nice vu meter ripped from DreamCoder_for_MySQL_Enterprise_v4.4.Patch.LaZzy.tPORt , and many more of his patches,"
						db  " originally created by LaZzy^tPORt , ripped by ur bro r0ger^PRF using IDA Pro."
						db  " works perfectly with uFMOD (by using GetStats to sync within the XM music) , in the meantime i will "
						db  "see what other chiptune/module libs can sync with this vu meter.",0
			    
scr						SCROLLER_STRUCT <>
lf						LOGFONT<>

TRANSPARENT_VALUE	equ 254
TransColor			COLORREF	0FFFFFFFh

.data?
SkrThread	dd	?

.code

ScrollerInit proc aWnd:HWND
	
	;invoke MakeDialogTransparentValue,hWnd,TRANSPARENT_VALUE
	
	m2m scr.scroll_hwnd,aWnd
		
		mov scr.scroll_text,offset ScrollText
		
		mov scr.scroll_x,1
		mov scr.scroll_y,98
		
		mov scr.scroll_width,383
		
		invoke CreateFontIndirect,addr ScrollFont
		mov scr.scroll_hFont,eax
		
		;mov scr.scroll_alpha,TRANSPARENT_VALUE
		RGB  255, 255, 255
		mov scr.scroll_textcolor,eax
		
		invoke CreateScroller,addr scr
	Ret
ScrollerInit EndP

MakeDialogTransparentValue proc _dialoghandle:dword,_value:dword
	
	pushad
	
	invoke GetModuleHandle,chr$("user32.dll")
	invoke GetProcAddress,eax,chr$("SetLayeredWindowAttributes")
	.if eax!=0
		;---yes, its win2k/xp system---
		mov edi,eax
		invoke GetWindowLong,_dialoghandle,GWL_EXSTYLE	;get EXSTYLE
		
		.if _value==255
			xor eax,WS_EX_LAYERED	;remove WS_EX_LAYERED
		.else
			or eax,WS_EX_LAYERED	;eax = oldstlye + new style(WS_EX_LAYERED)
		.endif
		
		invoke SetWindowLong,_dialoghandle,GWL_EXSTYLE,eax
		
		.if _value<255
			push LWA_ALPHA
			push _value						;set level of transparency
			push 0							;transparent color
			push _dialoghandle				;window handle
			call edi
		.endif	
	.endif
	
	popad
	ret
MakeDialogTransparentValue endp

CreateScroller proc _scrollstruct:dword
	
	LOCAL ThreadID		:DWORD
	
	invoke CreateThread,0,0,addr ScrollThread,_scrollstruct,0,addr ThreadID
	mov SkrThread,eax
	invoke SetThreadPriority,SkrThread,THREAD_PRIORITY_ABOVE_NORMAL
	;'invoke CloseHandle,eax
	
	ret
CreateScroller endp


PauseScroller proc _scrollstruct:dword
	
	mov eax,_scrollstruct
	assume eax:ptr SCROLLER_STRUCT
	
	mov cl,[eax].scroll_pause
	
	.if cl==0
		inc cl
	.else
		dec cl
	.endif		
	
	mov [eax].scroll_pause,cl
		
	assume eax:nothing
	
	ret
PauseScroller endp


;---private---
ScrollThread proc _scrollstruct:dword
	
	LOCAL local_hdc_window		:DWORD
	LOCAL local_hdc_window_copy	:DWORD
	LOCAL local_hdc_text		:DWORD
	
	LOCAL local_window_copy_width	:DWORD
	LOCAL local_window_copy_height	:DWORD
	
	LOCAL local_scroll_height	:DWORD
	
	LOCAL local_text_len		:DWORD
	LOCAL local_text_width		:DWORD
	LOCAL local_text_endpos		:DWORD
	
	LOCAL local_sz 			:SIZEL
	
	
	;---scroller structure---
	mov esi,_scrollstruct
	assume esi:ptr SCROLLER_STRUCT
	
	
	;---wait before draw---
	mov eax,[esi].scroll_wait
	.if eax<500
		mov eax,500
	.endif	
	invoke Sleep,eax		;important!
	
	
	;---Textlen---
	invoke lstrlen,[esi].scroll_text
	mov local_text_len,eax
	
	
	
	;---get window dc---
	invoke GetDC,[esi].scroll_hwnd
	mov local_hdc_window,eax
	
	
	
	;---HDC for text---
	invoke GetDC,0
	invoke CreateCompatibleDC,eax
	mov local_hdc_text,eax
	
	;---use custom font---
	invoke SelectObject,eax,[esi].scroll_hFont
	
	;---get Textheight and width---
	invoke GetTextExtentPoint,local_hdc_text,[esi].scroll_text,local_text_len,addr local_sz
	
	m2m local_scroll_height,local_sz.y
	m2m local_text_width,local_sz.x
	
	;---..hdc for text---
	invoke CreateCompatibleBitmap,local_hdc_window,[esi].scroll_width,local_scroll_height
	invoke SelectObject,local_hdc_text,eax
	
	
	
	;---HDC for windowcopy---
	invoke GetDC,0
	invoke CreateCompatibleDC,eax
	mov local_hdc_window_copy,eax
	
	;---calc size for windowcopy---
	mov eax,[esi].scroll_x
	add eax,[esi].scroll_width
	mov local_window_copy_width,eax
	
	mov ecx,[esi].scroll_y
	add ecx,local_scroll_height
	mov local_window_copy_height,ecx
	
	;---...do window copy---
	invoke CreateCompatibleBitmap,local_hdc_window,eax,ecx
	invoke SelectObject,local_hdc_window_copy,eax
	
	invoke BitBlt,local_hdc_window_copy,0,0,local_window_copy_width,local_window_copy_height,local_hdc_window,0,0,SRCCOPY
	
	
	
	;---Set Text Color---
	invoke	SetBkMode,local_hdc_text,TRANSPARENT
	invoke	SetTextColor,local_hdc_text,[esi].scroll_textcolor
	
	
	;---for transparent windows---
	invoke GetModuleHandle,chr$("user32.dll")
	invoke GetProcAddress,eax,chr$("SetLayeredWindowAttributes")
	mov edi,eax
	
	;---calc endposition of text---
	xor eax,eax
	sub eax,local_text_width
	sub eax,8
	mov local_text_endpos,eax
	
	
	;---prepare loop---
	mov ebx,[esi].scroll_width	;ebx=text position
	add ebx,4
	

	@loop:
	
	.if [esi].scroll_pause==0
		
		;---draw background for scroll gfx---
		invoke BitBlt,local_hdc_text,0,0,[esi].scroll_width,local_scroll_height,local_hdc_window_copy,[esi].scroll_x,[esi].scroll_y,SRCCOPY
		
		;---draw scrolltext on background---
		invoke TextOut,local_hdc_text,ebx,0,[esi].scroll_text,local_text_len
		
		;---fade text in and out---
		invoke BlendBitmap,local_hdc_text,local_hdc_window_copy,local_scroll_height,[esi].scroll_width,[esi].scroll_x,[esi].scroll_y,[esi].scroll_textcolor
		
		;---draw scrolltext on window---
		invoke BitBlt,local_hdc_window,[esi].scroll_x,[esi].scroll_y,[esi].scroll_width,local_scroll_height,local_hdc_text,0,0,SRCCOPY			

		dec ebx
	
		.if ebx==local_text_endpos
			;---reset text position to begining---
			mov ebx,[esi].scroll_width
		.endif
		
		;---important for transparent window---
		.if edi!=0
			movzx eax,[esi].scroll_alpha
			.if al!=0 && al!=255
				Scall edi,[esi].scroll_hwnd,0,eax,LWA_ALPHA
			.endif
		.endif	
	.endif
	
	invoke Sleep,5
	
	jmp @loop
	
	assume esi:nothing
	
	ret
ScrollThread endp


;---Blend Routine---
;align 16
BlendBitmap proc uses esi edi ebx _text_hdc:dword,_window_hdc:dword,_height:dword,_width:dword,_x:dword,_y:dword,_textcolor:dword
	
	LOCAL local_blendvalue	:DWORD
	LOCAL local_fadeout_pos	:DWORD
	
	.const
	FADE_WIDTH	equ 25
	FADE_STEP	equ 4
	
	.code
	mov eax,_width
	
	.if eax>=2*FADE_WIDTH	;only works with minimum width
		
		
		;---calc x-coordinate where to start fade out---
		sub eax,FADE_WIDTH
		mov local_fadeout_pos,eax
		
		
		;---prepare loop--
		xor esi,esi		;x=width
		mov local_blendvalue,0
	
		
		.while esi!=_width
			
			xor edi,edi	;y=height
			
			.while edi!=_height
				
				;---get pixel of scrolltext hdc---
				invoke GetPixel,_text_hdc,esi,edi
				.if eax==_textcolor
					mov ebx,eax
					
					;---get correct pixel of source window---
					mov ecx,esi
					add ecx,_x
					
					mov edx,edi
					add edx,_y
					invoke GetPixel,_window_hdc,ecx,edx
					
					
					invoke BlendPixel,eax,ebx,local_blendvalue
					invoke SetPixel,_text_hdc,esi,edi,eax
					
				.else
					mov eax,ebx	
				.endif
				
				inc edi
			.endw
			
			
			;---for fading---
			.if 	esi<FADE_WIDTH
				add local_blendvalue,FADE_STEP	;4 * 25pixel = 100 %
				
			.elseif esi==FADE_WIDTH
				mov esi,local_fadeout_pos
					
			.elseif esi>local_fadeout_pos
				sub local_blendvalue,FADE_STEP	;4 * 25pixel = 100 %
				
			.endif	
	
			inc esi	
		.endw
	.endif	
	
	ret
BlendBitmap endp


;align 16
BlendPixel proc uses esi edi ebx _sourcepixel:dword,_overpixel:dword,_transparency:dword
	
	;---parameters---
	;_sourcepixel  : Pixel of Backgroundimage
	;_overpixel    : Pixel which overlaps the sourcepixel
	;_transparency : 5 - 90 %  (using 100 % is stupid)
	
	;---Color Format---
	; 00 00 00 00
	; xx BB GG RR
	
	.if _transparency<100
		
		mov eax,_overpixel
		.if eax!=_sourcepixel
			
			;---calc new colors of _sourcepixel---
			mov eax,100
			sub eax,_transparency
			
			invoke PercentColor,_sourcepixel,eax
			mov ebx,eax
			
			
			;---calc new colors of _overpixel---	
			invoke PercentColor,_overpixel,_transparency
			
			
			;---add each color---
			xor esi,esi
			
			.while esi!=3
				
				movzx edx,al
				movzx ecx,bl
				
				add edx,ecx
				.if edx>255
					mov dl,255
				.endif
				
				mov al,dl
					
				ror eax,8
				ror ebx,8
				
				inc esi
			.endw
			
			rol eax,3*8
		.else	
			mov eax,_overpixel
		.endif	
	.else	
		mov eax,_overpixel
	
	.endif
	
	ret
BlendPixel endp


;align 16
PercentValue proc _value:dword,_percent:dword

	mov eax,_value
	
	mul _percent
	
	mov ecx,100
	
	xor edx,edx
	div ecx
	
	ret
PercentValue endp


;align 16
PercentColor proc uses esi edi ebx _color:dword,_percent:dword
	
	;---reduce color by certain percent---
	
	mov ebx,_color
	
	;---Red--
	movzx eax,bl
	
	invoke PercentValue,eax,_percent
	mov edi,eax
	
	
	;---Green---
	ror ebx,8
	movzx eax,bl
	invoke PercentValue,eax,_percent
	
	ror edi,8 
	mov edx,edi
	mov dl,al
	mov edi,edx
	
	
	;---Blue---
	ror ebx,8
	movzx eax,bl
	invoke PercentValue,eax,_percent
	
	ror edi,8 
	mov edx,edi
	mov dl,al
	mov edi,edx
	
	
	;---return new color value---
	rol edi,16
	mov eax,edi
	
	ret
PercentColor endp