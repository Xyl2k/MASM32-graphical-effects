
;##############################
;# This shit c0ded by x0man ;)#
;#    � tPORt 2007 =)         #
;##############################

;###############################################################################

_snow struct
	xPos		dd	?
	yPos		dd	?
	speed		dd	?
	lrspeed	dd	?
	xNewPos	dd	?
	side		BYTE	?
_snow ends
	
;###############################################################################

.const
	wwidth	equ 	400	; ������ ���� windows height
	wheight	equ	200	; ������ ���� windows width
	
.data
	hInstance	dd	HINSTANCE	; �� =) - abbreviation: dick (cock) know this, something like fuck
	wnd		dd	0		; ����� ���� windows handle
	
	stop		BOOL	FALSE		; ���������� ���� ��� �������... global stop (flag?) for threads
	
	RandSeed	dd	0		; ��� ��������� ����� for random numbers
	
	snowcount	dd	20		; ���������� ��������... amount of symbols
	snow		dd	0		; �������� � ������ �� ������ �������... a pointer to character (alphabet?) matrix
	
	dwTextColor	dd	000FFFFh	; ����... BGR BGR type
	xTextPos	dd	25		; ��������� X ������� ����� ������ x position of all text beginning
	
	dc		dd	0		; �������� ����... )) window context
	mdc		dd	0		; TEMP �������� TEMP context
	hFont		dd	0		; ����� font
	hBitmap	dd	0		; ������� ������ � "mdc"  this value used with "mdc"
	
	hSnowBmp	dd	0
	hMaskBmp	dd	0
	hSnowDc	dd	0
	
	; ������ ��� ��������...
	Main_Words_Thread		dd	0
	
	szTitle	db	"[tPORt]",0		; ��������� ���� window text
	szFontName	db	"Courier New", 0	; ��� ������ font name
		
	strLen	dd	0

	; ��� ����� =)
	LinesCount	dd	0
	szTxt		db	"[      The Power Of Reversing    ]", 13	
			db	"                Team", 13, 13

			db	"[ Prog. Name : Stuped snow effect]",13,13
			
			db	"[ Shit by    : x0man ;) ........ ]", 13,13

			db	"[-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-]", 13
			db	"[ Big ThanKz to :                ]", 13
			db	"[ GHOST[tPORt] for Snow Images ;)]", 13
			db	"[ bagie[tPORt] for help ;)))))   ]", 13
			db	"[-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-]", 13,13

			db	"[ mail: tport@list.ru........... ]", 13
			db	"[ web : http://tport.be......... ]", 13
			db	"[ ..... http://www.tport.com.ru. ]", 13
			db	"[ ..... http://www.tport.tk..... ]", 13
			db	"[ irc : #tport.................. ]", 13
			db	"[ (at street-creed.com:6667).... ]", 0
	
.code

;###################################################
; ������������� �������� ��������� ����� )) random numbers generation init
; ������� ������ ������� >> LaZzy [tPORt] << =) thank's for LaZzy
;###################################################
Randomize proc
local SystemTime:SYSTEMTIME
	invoke GetSystemTime, addr SystemTime
	movzx eax,[SystemTime.wHour]
	imul eax,60
	add ax,[SystemTime.wMinute]
	imul eax,60
	xor edx,edx
	mov dx,[SystemTime.wSecond]
	add eax,edx
	imul eax,1000
	mov dx,[SystemTime.wMilliseconds]
	add eax, edx
	mov [RandSeed],eax
ret
Randomize endp

;###################################################
; ����� ���������� ����� X, ��� �� ������ (0..X-1)  here we choose randos thread X
;###################################################
Random proc dwRange:DWORD ; -> EAX: random number
	mov eax, dwRange
	imul edx, RandSeed,08088405h
	inc edx
	mov RandSeed, edx
	mul edx
	mov eax,edx
ret
Random endp


;###################################################
; �� =) - abbreviation: dick (cock) know this, something like fuck. author mean that he don't know what is this
;###################################################
TopXY proc wDim:DWORD, sDim:DWORD

    shr sDim, 1      ; divide screen dimension by 2
    shr wDim, 1      ; divide window dimension by 2
    mov eax, wDim    ; copy window dimension into eax
    sub sDim, eax    ; sub half win dimension from half screen dimension

    mov eax, sDim
    ret

TopXY endp

DrawTxt proc yy : DWORD
local x:DWORD
local y:DWORD
	mov edi, offset szTxt
	
	push xTextPos
	pop x
	
	push yy
	pop y
	
	xor eax, eax
	.repeat
		.if byte ptr [edi + eax] == 13
			push xTextPos
			pop x

			add y, 15
		.else
			add x, 10
			
			push eax
			invoke TextOut, mdc, x, y, addr byte ptr [edi + eax], 1
			pop eax
		.endif
		inc eax
	.until eax >= strLen

	mov LinesCount, eax
	ret
DrawTxt endp

;###################################################
;########### �������������� ������... memory reservatiom
;###################################################
GetMemory proc
	; ������� ������� ������ ���������������... count how many memory reserve
	mov eax, snowcount
	imul eax, sizeof _snow
	add eax, sizeof _snow
	; ����� ������� ���� )))
	invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, eax
	mov snow, eax
	ret
GetMemory endp

;################################################
;#### Round(sin(GetTickCount / lrsp) * emul) ####
;################################################
getX proc lrsp : DWORD, emul : DWORD
local tmp:DWORD
local t:DWORD
	call GetTickCount
	mov [esp], eax
	xor eax, eax

	mov [esp + 4], eax
	
	FILD qword ptr [esp]
	FILD dword ptr [lrsp]
	fdivp st(1), st(0)

      FSIN
      
      fmul dword ptr [emul]
      fstp tmp
      
      mov eax, tmp
      ret
getX endp

;###################################################
; ������� ���������� ����� � ������... count how many strings in text
;###################################################
GetLinesCount proc

	mov edi, offset szTxt
	xor eax, eax
	xor ecx, ecx
	
	.repeat
		.if byte ptr [edi + ecx] == 13
			inc eax
		.endif
		inc ecx
	.until ecx >= strLen
	
	mov LinesCount ,eax
	ret
GetLinesCount endp

;###################################################
;#### ���������� .. sorting
;###################################################
ResortSnow proc
	assume edi : ptr _snow
	mov edi, snow
	xor eax, eax
	.repeat
		inc eax
		push eax
				
		invoke Random, wwidth
		mov [edi].xPos, eax
		
		invoke Random, wheight
		imul eax, -1
		mov [edi].yPos, eax
		
		invoke Random, 3
		inc eax
		mov [edi].speed, eax
		
		;100 * Random( 3 ) + Random( 100 ) + 100;
		invoke Random, 2
		inc eax
		mov ecx, eax
		imul ecx, 100

		invoke Random, 100
		add eax, 100
		add eax, ecx
		mov [edi].lrspeed, eax
		
		invoke Random, 2
		mov [edi].side, al
		
		pop eax

		add edi, sizeof _snow
	.until eax >= snowcount

	ret
ResortSnow endp

; #################################
; �����, ������� ������� ������� =) thread which move signs
; #################################
MoveSnowThread proc
.repeat

	mov edi, snow
	xor eax, eax

	assume edi : ptr _snow
	.repeat
		push eax
		push edi
		
		mov eax, [edi].speed
		add [edi].yPos, eax
		
		.if [edi].yPos == wheight
			mov eax, 30
			imul eax, -1
			mov [edi].yPos, eax

			invoke Random, wwidth
			mov [edi].xPos, eax
		.endif

		invoke getX, [edi].lrspeed, 10
		movzx ecx, ax
		.if [edi].side == 1
			add ecx, [edi].xPos
		.else
			mov eax, [edi].xPos
			sub eax, ecx
			mov ecx, eax
		.endif

		mov [edi].xNewPos, ecx

		pop edi
		pop eax
		
		add edi, sizeof _snow
		inc eax		

	.until eax >= snowcount
	
	invoke Sleep, 50
	
.until stop == TRUE
	
MoveSnowThread endp


;###################################################
; ������� ����/���������... signs carry and draw
;###################################################

DrawSnow proc
local t:DWORD
	mov edi, snow
	xor eax, eax

	assume edi : ptr _snow
	.repeat
		push eax
		push edi

		invoke BitBlt, mdc, [edi].xNewPos, [edi].yPos, 20, 20, hSnowDc, 0, 0, SRCPAINT

		pop edi
		pop eax
		
		add edi, sizeof _snow
		inc eax		

	.until eax >= snowcount
	ret
DrawSnow endp

;###################################################
; ���������� ����, �������/�����... )) backgroung,signs/snow drawing
;###################################################
Paint proc
LOCAL pos:DWORD
LOCAL hBackground:DWORD
LOCAL hBackDc:HDC
local yPos : DWORD
local syPos: DWORD
	;-------------------------------
	invoke CreateCompatibleDC, NULL
	mov hBackDc, eax

	invoke GetModuleHandle, NULL
	push eax
	
	IFDEF USE_JPG
		; ������ JPEG �� �������� =) load JPEG from recources
		invoke BitmapFromResource, eax, 506
	ELSE
		invoke LoadBitmap, eax, 506
	ENDIF

	mov hBackground, eax
	
	invoke SelectObject, hBackDc, hBackground
	;--------------------------------
	
	pop eax
	invoke LoadBitmap, eax, 507
	mov hSnowBmp, eax
	
	invoke CreateCompatibleDC, NULL
	mov hSnowDc, eax
	
	invoke SelectObject, hSnowDc, hSnowBmp
	;--------------------------------
	
	push wheight
	pop yPos
	
	mov eax, LinesCount
	imul eax, 20
	imul eax, -1
	mov syPos, eax
	
.repeat
	
	invoke BitBlt, mdc, 0, 0, wwidth, wheight, hBackDc, 0, 0, SRCCOPY
	
	invoke DrawTxt, yPos
	
	call DrawSnow
	
	; ������ ��� ��� ���� �� ����... draw all this stuff
	invoke BitBlt, dc, 0, 0, wwidth, wheight, mdc, 0, 0, SRCCOPY	

	 dec yPos
	 mov eax, syPos
	.if eax == yPos
		push wheight
		pop yPos
	.endif

	; ������ ���� ))
	invoke Sleep, 20

.until stop == TRUE	; ��������� �� ��� ���, ���� ���������� ���� STOP ����� ����� TRUE =) do until global stop flag equal TRUE
	
	invoke DeleteObject, hBackground
	invoke DeleteDC, hBackDc
	
	invoke DeleteObject, hSnowBmp
	invoke DeleteDC, hSnowDc
	
	mov stop, FALSE
	
	xor eax, eax	; ���� ��� =)
	ret
Paint endp

;###################################################
;           ��������� ������� ���� ))    windows events procedure           
;###################################################
DlgProc_About proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
LOCAL x,y:DWORD	; ����� ��� ������� ����... this value for window position

	mov eax, uMsg
	.if eax == WM_INITDIALOG
	
		push hWnd
		pop wnd
		
		; ������������� ���������� ��������������� �����! init random numbers generations
		; :-D �� ��� ������� ������� ))) 
		call Randomize
		
		; ������� ���������� �� X get X position (coordinate)
		invoke GetSystemMetrics, SM_CXSCREEN
		invoke TopXY, wwidth, eax
		mov x, eax
		
		; ������� ���������� �� Y get Y position (coordinate)
		invoke GetSystemMetrics, SM_CYSCREEN
		invoke TopXY, wheight, eax
		mov y, eax
		
		; ��������� ������� ���� �� ������
		invoke SetWindowPos, hWnd, 0, x, y, wwidth, wheight, SWP_SHOWWINDOW
		
		; ��������� ��������� ���� set window title
		invoke SetWindowText, hWnd, addr szTitle

		; ������� �������� ���� ��� ������ �������
		invoke GetDC, wnd
		mov dc, eax
	
		;--------------
		invoke CreateCompatibleDC, NULL
		mov mdc, eax
	
		; �������� �������� create picture
		invoke CreateBitmap, wwidth, wheight, 1, 32, NULL
		mov hBitmap, eax
		;--------------
			
		; ������� ����� )) create font
		invoke CreateFont,	16, 0, 0, 0, 600, 0, 0, 0,
	                        	DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
	                        	DEFAULT_QUALITY, DEFAULT_PITCH, addr szFontName
 		mov hFont, eax

		invoke SelectObject, mdc, hBitmap	; �������� �������� � ��������... create picture ...???...
		invoke SelectObject, mdc, hFont	; ��������� ����� set font
		invoke SetBkMode, mdc, TRANSPARENT	; ���������� ����� text transparency
					
		invoke SetTextColor, mdc, dwTextColor	; ������ ���� ������ ser texxt color
		
		; �������� ������������ ���� � ���� making ...???....
		invoke CreateRoundRectRgn, 1, 0, wwidth + 1, wheight, 100, 100
		invoke SetWindowRgn, hWnd, eax, TRUE

		; ������ ������ ������... get string lenth
		invoke lstrlen, addr szTxt
		mov strLen, eax
		;------------------------

		;-- �������� ������� ---
		call GetMemory		; ����������� ������... reserve memory
		call ResortSnow		; �������� )) sorting
		;-----------------------
		
		call GetLinesCount
		
		; ����� ��� �������, ����� ���� ��� ������... thread for video effect when mouse under sign
		invoke CreateThread, NULL, 0, addr Paint, 0, 0, addr Main_Words_Thread
		invoke CreateThread, NULL, 0, addr MoveSnowThread, 0, 0, addr Main_Words_Thread
		
	.elseif eax == WM_LBUTTONDOWN
		; ���� ������ ����� ������ ����... if left mouse button down
		; �� ���������� �������, ��� ���� ���� ����� �� ������� =) send message that mouse ...???...
		invoke SendMessage, hWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0
		
	.elseif eax == WM_RBUTTONUP		
		; ���� ������ ������ ������ ���� �� if right mouse button down
		; ���������� ������� ���� �� �����... send exit message to window
		invoke SendMessage, hWnd, WM_CLOSE, 0, 0
		
	.elseif eax == WM_CLOSE	
		; ���� ����� �� ������ ���� ��������� ������ � TRUE if go out change thread stop flag
		mov stop, TRUE
		
		.repeat
		 invoke Sleep, 1		; ���� ���� ����������� ��� ������.... wait all threads stop
		.until stop == FALSE
		
		; ������� ��� ����... (����� ������ �� �����... ��...) delete all. may be I forgot something?
		invoke ReleaseDC, wnd, dc

		invoke DeleteDC, mdc
		invoke DeleteObject, hFont
		invoke DeleteObject, hBitmap
		invoke TerminateThread, Main_Words_Thread, 0
		invoke GlobalFree, snow
	
		invoke EndDialog, wnd, 0
		
		; bla bla bla - DEMO MAFAKA =))))
	.endif
	
	; ���� ��� =)
	xor eax, eax
	ret
DlgProc_About endp

; #########################################################################