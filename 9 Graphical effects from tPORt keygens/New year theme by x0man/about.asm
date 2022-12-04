
;##############################
;# This shit c0ded by x0man ;)#
;#    © tPORt 2007 =)         #
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
	wwidth	equ 	400	; Ширина окна windows height
	wheight	equ	200	; Высота окна windows width
	
.data
	hInstance	dd	HINSTANCE	; ХЗ =) - abbreviation: dick (cock) know this, something like fuck
	wnd		dd	0		; Хэндл окна windows handle
	
	stop		BOOL	FALSE		; Глобальный стоп для потоков... global stop (flag?) for threads
	
	RandSeed	dd	0		; Для случайных чисел for random numbers
	
	snowcount	dd	20		; Количество символов... amount of symbols
	snow		dd	0		; Смещение в памяти на массив букавок... a pointer to character (alphabet?) matrix
	
	dwTextColor	dd	000FFFFh	; Вида... BGR BGR type
	xTextPos	dd	25		; Начальная X позиция всего текста x position of all text beginning
	
	dc		dd	0		; Контекст окна... )) window context
	mdc		dd	0		; TEMP Контекст TEMP context
	hFont		dd	0		; Шрифт font
	hBitmap	dd	0		; Юзается вместе с "mdc"  this value used with "mdc"
	
	hSnowBmp	dd	0
	hMaskBmp	dd	0
	hSnowDc	dd	0
	
	; Потоки для эффектов...
	Main_Words_Thread		dd	0
	
	szTitle	db	"[tPORt]",0		; Заголовок Окна window text
	szFontName	db	"Courier New", 0	; Имя шрифта font name
		
	strLen	dd	0

	; Сам текст =)
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
; Инициализация счетчика случайных чисел )) random numbers generation init
; Давайте скажем спасибо >> LaZzy [tPORt] << =) thank's for LaZzy
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
; Выбор Случайного числа X, где на выходе (0..X-1)  here we choose randos thread X
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
; ХЗ =) - abbreviation: dick (cock) know this, something like fuck. author mean that he don't know what is this
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
;########### Резервирование памяти... memory reservatiom
;###################################################
GetMemory proc
	; считаем сколько памяти зарезервировать... count how many memory reserve
	mov eax, snowcount
	imul eax, sizeof _snow
	add eax, sizeof _snow
	; Берем сколько надо )))
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
; Считает количество строк в тексте... count how many strings in text
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
;#### Сортировка .. sorting
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
; Поток, который двигает букавки =) thread which move signs
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
; Перенос букв/отрисовка... signs carry and draw
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
; Прорисовка фона, букавок/снега... )) backgroung,signs/snow drawing
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
		; Грузим JPEG из ресурсов =) load JPEG from recources
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
	
	; Рисуем все это дело на окне... draw all this stuff
	invoke BitBlt, dc, 0, 0, wwidth, wheight, mdc, 0, 0, SRCCOPY	

	 dec yPos
	 mov eax, syPos
	.if eax == yPos
		push wheight
		pop yPos
	.endif

	; просто ждем ))
	invoke Sleep, 20

.until stop == TRUE	; Повторять до тех пор, пока глобальных флаг STOP будет равен TRUE =) do until global stop flag equal TRUE
	
	invoke DeleteObject, hBackground
	invoke DeleteDC, hBackDc
	
	invoke DeleteObject, hSnowBmp
	invoke DeleteDC, hSnowDc
	
	mov stop, FALSE
	
	xor eax, eax	; КСОР ЕАХ =)
	ret
Paint endp

;###################################################
;           Обработка событий окна ))    windows events procedure           
;###################################################
DlgProc_About proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
LOCAL x,y:DWORD	; Нужно для позиции окна... this value for window position

	mov eax, uMsg
	.if eax == WM_INITDIALOG
	
		push hWnd
		pop wnd
		
		; Инициализация генератора псевдослучайных чисел! init random numbers generations
		; :-D хз как сказать прально ))) 
		call Randomize
		
		; Получим координату по X get X position (coordinate)
		invoke GetSystemMetrics, SM_CXSCREEN
		invoke TopXY, wwidth, eax
		mov x, eax
		
		; Получим координату по Y get Y position (coordinate)
		invoke GetSystemMetrics, SM_CYSCREEN
		invoke TopXY, wheight, eax
		mov y, eax
		
		; Установим позицию окна по центру
		invoke SetWindowPos, hWnd, 0, x, y, wwidth, wheight, SWP_SHOWWINDOW
		
		; Установка Заголовка окна set window title
		invoke SetWindowText, hWnd, addr szTitle

		; Получим контекст окна для вывода графики
		invoke GetDC, wnd
		mov dc, eax
	
		;--------------
		invoke CreateCompatibleDC, NULL
		mov mdc, eax
	
		; Создадим картинку create picture
		invoke CreateBitmap, wwidth, wheight, 1, 32, NULL
		mov hBitmap, eax
		;--------------
			
		; Создаем Шрифт )) create font
		invoke CreateFont,	16, 0, 0, 0, 600, 0, 0, 0,
	                        	DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
	                        	DEFAULT_QUALITY, DEFAULT_PITCH, addr szFontName
 		mov hFont, eax

		invoke SelectObject, mdc, hBitmap	; Создадим картинку с канвасом... create picture ...???...
		invoke SelectObject, mdc, hFont	; Установим шрифт set font
		invoke SetBkMode, mdc, TRANSPARENT	; Прозрачный текст text transparency
					
		invoke SetTextColor, mdc, dwTextColor	; Ставим цвет текста ser texxt color
		
		; Создание закругленных краёв у окна making ...???....
		invoke CreateRoundRectRgn, 1, 0, wwidth + 1, wheight, 100, 100
		invoke SetWindowRgn, hWnd, eax, TRUE

		; Узнаем длинну строки... get string lenth
		invoke lstrlen, addr szTxt
		mov strLen, eax
		;------------------------

		;-- Создание букавок ---
		call GetMemory		; Резервируем память... reserve memory
		call ResortSnow		; Сортруем )) sorting
		;-----------------------
		
		call GetLinesCount
		
		; Поток для эффекта, когда мышь над буквой... thread for video effect when mouse under sign
		invoke CreateThread, NULL, 0, addr Paint, 0, 0, addr Main_Words_Thread
		invoke CreateThread, NULL, 0, addr MoveSnowThread, 0, 0, addr Main_Words_Thread
		
	.elseif eax == WM_LBUTTONDOWN
		; если нажата левая кнопка мыши... if left mouse button down
		; то отправляем мессадж, что типа мышь сидит на капшине =) send message that mouse ...???...
		invoke SendMessage, hWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0
		
	.elseif eax == WM_RBUTTONUP		
		; Если нажата правая кнопка мыши то if right mouse button down
		; отправляем мессадж окну на выход... send exit message to window
		invoke SendMessage, hWnd, WM_CLOSE, 0, 0
		
	.elseif eax == WM_CLOSE	
		; Если выход то ставим флаг остановки Потока в TRUE if go out change thread stop flag
		mov stop, TRUE
		
		.repeat
		 invoke Sleep, 1		; Ждем пока остановятся все потоки.... wait all threads stop
		.until stop == FALSE
		
		; Удаляем все дела... (вроде ничего не забыл... хз...) delete all. may be I forgot something?
		invoke ReleaseDC, wnd, dc

		invoke DeleteDC, mdc
		invoke DeleteObject, hFont
		invoke DeleteObject, hBitmap
		invoke TerminateThread, Main_Words_Thread, 0
		invoke GlobalFree, snow
	
		invoke EndDialog, wnd, 0
		
		; bla bla bla - DEMO MAFAKA =))))
	.endif
	
	; КСОР ЕАХ =)
	xor eax, eax
	ret
DlgProc_About endp

; #########################################################################