
;######################################
; -=[ The Power Of Reversing Team ]=- #
;######################################
;# Text effect by x0man #
;########################

;######################################################
; Извините что комменты не сильно обильные...
; лень мне писать их...
; а если честно, хз как объяснить
; свои сумашедшие мысли... ыыы... =)))

;######################################################
; Чтобы изменить цвет букв, надо...
; Найти текст в коде
;-------------------------------------
;invoke SetTextColor, ahDC, 0FFFFFFh
;-------------------------------------
; И измените значение "0FFFFFFh" на свой цвет (по умолчанию он белый)
; Первые 'FF' указывают на оттенок СИНЕГО
; Вторые 'FF' указывают на оттенок ЗЕЛЕНГО
; Третие 'FF' указывают на оттенок КРАСНОГО
;-------------------------------------
; Если хотите использовать красный цвет для вывода текста,
; то измените значение "0FFFFFFh" на "00000FFh"
; если хотите зеленый цвет, то на "000FF00h" и т.д.
;-------------------------------------

_words_ struct			; структурка, для упрощения работы...
  char	CHAR	?		; чтобы не маяться с видом
  x		DWORD	?		; ........................
  y		DWORD	?		; mov byte ptr [edi], al
  ex		DWORD	?		; mov dword ptr [edi + 1], edx
  ey		DWORD	?		; ......... и т.д. .......
  pcount	BYTE	?
_words_ ends


IFDEF USE_JPG			; Если используем картинку...
	USE_IMAGE = 1		; то объявляем о том что мы её используем ))	
ELSEIFDEF USE_BMP			; -- только я чет не понял...
	USE_IMAGE = 1		; -- МАСМ юзать может вид на подобие
ENDIF					; -- ..................................
					; -- Если <определение> И <определение>
					; -- ..................................
					; -- ?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-?-
					; -- если да, скажите мне как это работает...
					; -- плиз... =)
					
; Переменные помеченные значком '*' являются базовыми
; т.е. которые можно изменять
; остальные лучше не трогать.. =)

.const
	aWidth			equ	400	; * Ширина окна - (Всётаки желательно, чтобы картинка имела такие размеры)
	aHeight			equ	200	; * Высота окна

	aStandartDelayTime	equ	2000	; * Стандартное время для задержки "блока текста" на экране

	aStartXPos			equ	30	; * Позиция по Х, откуда начинать выводить первый символ "блока строк"
	aStartYPos			equ	10	; * Позиция по Y, откуда начинать выводить первый символ "блока строк"

.data

	ahDC			dd	0	; Контекст для вывода всей графики на него(чтобы не мерцало)
	ahBmp			dd	0	; Юзается совместно с ahDC
	
	IFDEF USE_BRUSH			; Если используем "Кисть", то
		ahBrush	dd	0	; объявляем переменную ahBrush...
	ENDIF
	
	ahFont 		dd	0	; Хэндл для шрифта... =)
  
	aWnd			dd	0	; Хэндл для диалога
	aMainDC		dd	0	; Контекст основного окна(которое мы видим),
						; на него будет копироваться графика из ahDC

	IFDEF USE_IMAGE			; Если используется картинка для фона, то..
		ahBitmap	dd	0	; Задаем переменные...
		ahBitmapDC	dd	0
	ENDIF

	aThread		dd	0	; ID Потока... =)

	awords 		dd	0	; Указатель на массив букавок...

	aGlobalStop		BOOL	FALSE	; Глобальный стоп для эффекта (когда окно закрывается aGlobalStop == TRUE)

	aDelayTime		dd	0	; Сколько времени держать "блок строк" на экране...
	
	aRandSeed		dd	0	; Для Рандомайза надо =))
	
	aStartPos		dd	0	; Начальная позиция
	aEndPos		dd	0	; Конечная позиция
						; Смысл такой, что строка поделена на "блоки",
						; где изначально 
						; aStartPos = Первому символу в строке, а
						; aEndPos = Позиции символа #8 (окончания "блока строк")
						
						; потом идет проверка на то, что, все ли буквы из этого "блока"
						; стоят на своем месте (ex == x && ey == y), если ДА, то
						; aStartPos = aEndPos + 1
						; aEndPos = позиции следущего символа #8
						; вообщем переход на другой "блок строк"...
						
	astrLen		dd	0	; Длинна строки...


	szaFontName		db	"Courier New", 0			; * Имя шрифта, как вы уже поняли ;)
	szaTitle		db	"x0man's text effect", 0	; * ггг... ну не удержался =))
	
	; Каждый "блок строк" для вывода на экран, должен заканчиваться знаком #8
	; Знак #13 ставится в конце каждой строки
	; * Текст
	szaText	db	13,13,13,13						; <- Чередованием символов #13(опускаю строку вниз)
			db	"[     The Power Of Reversing     ]",13	
			db	"[               Team             ]",8	; '8' <- Показывает что первая строка закончилась
											; если будет много строк, то всегда в конце каждого
											; "блока" надо ставить знак '#8'

			db	13,13,13
			db	"[ mail: tport@list.ru........... ]",13
			db	"[ web : http://tport.be......... ]",13
			db	"[ ..... http://www.tport.com.ru. ]",13
			db	"[ ..... http://www.tport.tk..... ]",13
			db	"[ irc : #tport.................. ]",13
			db	"[ (at street-creed.com:6667).... ]",8,0	; <- Закончилась последний "блок строк".

.code

;########
; ХЗ =) #
;########
TopXY proc wDim:DWORD, sDim:DWORD

    shr sDim, 1      ; divide screen dimension by 2
    shr wDim, 1      ; divide window dimension by 2
    mov eax, sDim
    sub eax, wDim

    ret

TopXY endp

;#######################################
; Считаем количество "блоков" в строке #
;#######################################
GetLinesCount proc
	
	push ecx
	push edx
	
	xor eax, eax
	xor ecx, ecx
	mov edx, offset szaText

	.repeat
		
		.if (byte ptr [edx + ecx] == 8)
			inc eax
		.endif

		inc ecx
	.until ecx >= astrLen
	
	pop edx
	pop ecx

	ret
GetLinesCount endp

;---------------------------------------

;######################################
;Находим начальную и конечную позиции #
;######################################
SEPos proc

	push ecx
	push edx
	
	mov ecx, aStartPos
	mov edx, offset szaText
	
	.repeat
		
		.if (byte ptr [edx + ecx] == 8)
			mov aEndPos, ecx
			jmp @ex
		.endif

	inc ecx
	.until ecx > astrLen
	
	
@ex:	pop edx
	pop ecx
	
	ret
SEPos endp

;#######################################
; Здесь создается почти все... (вроде) #
;#######################################
Init_Proc proc

	mov aGlobalStop, FALSE
	
	push aStandartDelayTime
	pop aDelayTime

	invoke GetDC, aWnd
	mov aMainDC, eax
	
	invoke CreateCompatibleDC, 0
	mov ahDC, eax

	; Creating Bitmap... using with "ahDC"
	invoke CreateBitmap, aWidth, aHeight, 1, 32, NULL
	mov ahBmp, eax

	; Creating font
  	invoke CreateFont, 16, 0, 0, 0, 400, 0, 0, 0,
					DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
					DEFAULT_QUALITY, DEFAULT_PITCH, addr szaFontName
	mov ahFont, eax

	; assign "ahDC" with other variables
	invoke SelectObject, ahDC, ahBmp
	invoke SelectObject, ahDC, ahFont
	
	; Set Color of Text
	invoke SetTextColor, ahDC, 0FFFFFFh

	IFDEF USE_BRUSH
		invoke CreateSolidBrush, 094AA97h
		mov ahBrush, eax
		
		invoke SelectObject, ahDC, eax
	ENDIF
	
	IFDEF USE_IMAGE
	
		IFDEF USE_JPG
			invoke BitmapFromResource, 0, 550
		ELSEIFDEF USE_BMP
			invoke GetModuleHandle, 0
			invoke LoadBitmap, eax, 550
		ENDIF
	
	mov ahBitmap, eax
	
	invoke CreateCompatibleDC, NULL
	mov ahBitmapDC, eax
	
	invoke SelectObject, ahBitmapDC, ahBitmap
	
	ENDIF
	
	invoke SetBkMode, ahDC, TRANSPARENT

	; Узнаем длинну строки...
	invoke lstrlen, addr szaText
	mov astrLen, eax
	;------------------------
	
	; Возьмем на всякий случай на 1 букавку в памяти больше...
	inc eax
	
	; считаем сколько памяти зарезервировать...
	imul eax, sizeof _words_
	
	; Берем сколько надо )))
	invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, eax
	mov awords, eax

	ret
Init_Proc endp

;###############################
;Удаляем все нафиг из памяти...#
;###############################
;Может что то пропустил...хз
Free_Proc proc

	IFDEF USE_IMAGE
		invoke DeleteObject, ahBitmap
		invoke DeleteDC, ahBitmapDC
	ELSEIFDEF USE_BRUSH
		invoke DeleteObject, ahBrush
	ENDIF

	invoke DeleteObject, ahBmp
	invoke DeleteObject, ahFont
		
	invoke DeleteDC, ahDC
	invoke DeleteDC, aMainDC
	
	invoke GlobalFree, awords

	ret
Free_Proc endp

;###############################################
; Процедура сортировки букавок по своим местам #
;###############################################
Resort_Words proc
LOCAL xPos:DWORD, yPos:DWORD
	
	push aStartXPos
	pop xPos
	
	push aStartYPos
	pop yPos
	
	xor ecx, ecx
	mov ebx, offset szaText
	mov edi, awords
	
	assume edi : ptr _words_

	.repeat
		mov al, byte ptr [ebx + ecx]
		mov byte ptr [edi].char, al

		push xPos
		pop [edi].ex
		
		push yPos
		pop [edi].ey

		push aHeight
		pop [edi].x

		push yPos
		pop [edi].y

		mov [edi].pcount, 0
		
		add xPos, 10
		
		.if al == 13	; Если символ равен #13, тогда увеличиваем "Y", а к X приравниваем начальное значение
					; получается типа переноса строки =)
			push aStartXPos
			pop xPos
			
			add yPos, 14	

		.elseif al == 8	; Если символ равен #8 тогда переводим значение "X" и "Y" в начальные значения =)
					; т.е. символ 8, говорит о том, что блок,
					; который надо вывести на экран закончился.
			push aStartXPos
			pop xPos
			
			push aStartYPos
			pop yPos

		.endif
		
		; Переносим указатель на след. букву.
		add edi, sizeof _words_
		inc ecx
		
	; делаем до тех пор, пока не закончатся буковки ))
	.until ecx >= astrLen
	
	assume edi : ptr nothing
	
	ret
Resort_Words endp

;---------------------------------------

Draw proc
LOCAL aLinesCount	: DWORD	; Количество "блоков" в строке
LOCAL aLineNumber	: DWORD	; Текущий номер "блока"
LOCAL await:BOOL			; флаг указывающий на то, что все буквы из "блока" находятся на своих местах
LOCAL aNextLine:BOOL		; Флаг указывающий на то, что нужно перенести указатель на след. блок
LOCAL aChangeDelayTime:BOOL	; эээ.... долго объяснять :(


	; Считаем сколько нужно строк для вывода...
	call GetLinesCount
	mov aLinesCount, eax

	mov aLineNumber, 1
	mov aStartPos, 0
	call SEPos
	
	push aStandartDelayTime
	pop aDelayTime

	; в EDI указатель на наши супер буковки )))
	assume edi : ptr _words_	
	mov edi, awords
	
	.repeat
	
		IFDEF USE_IMAGE
			; Если используем картинку, то рисуем её на фоне
			invoke BitBlt, ahDC, 0, 0, aWidth, aHeight, ahBitmapDC, 0, 0, SRCCOPY
		ELSE
			; Если же используем Кисть, то рисуем кистью...
			invoke Rectangle, ahDC, 0, 0, aWidth, aHeight
		ENDIF
		
		mov await, TRUE
		
		mov edi, awords
		mov ecx, aStartPos

		;-------------------------------
		; Переход на нужную нам букву...
		mov eax, ecx
		imul eax, sizeof _words_
		add edi, eax
		;-------------------------------

		.repeat
		
		; Если окно закрывается, то выходим
		.if aGlobalStop == TRUE
			jmp @@ex
		.endif

		
		; Если символ текущей буковки не равен символу "переноса" строки или
		; символу, который говорит, что "блок строк" закончился, то
		; Выводим эту букву на экран... т.е. рисуем =)
		.if [edi].char != 13 && [edi].char != 8
			
				push ecx	; Сохраним регистры...
				push edi

				invoke TextOut, ahDC, [edi].x, [edi].y, addr [edi].char, 1
				
				pop edi	; И восстановим их %)
				pop ecx
		.endif
					
			;--------
				
			; Если букавка не стоит на своей позиции по X координате, то
			mov eax, [edi].x
			.if eax != [edi].ex
				
				; Будем двигать её в зависимости где она находится
				; т.е. ВПРАВО или ВЛЕВО
				mov eax, [edi].x
				.if eax < [edi].ex
					inc [edi].x
				.else
					dec [edi].x
				.endif
				
			.endif
			
			;--------
			
			; Если букавка не стоит на своей позиции по Y координате, то
			mov eax, [edi].y
			.if eax != [edi].ey
			
				; Будем двигать её в зависимости где она находится
				; т.е. ВНИЗ или ВВЕРХ 
				mov eax, [edi].y
				.if eax < [edi].ey
					inc [edi].y
				.else
					dec [edi].y
				.endif
				
			.endif
			
			;--------
			
			; Если же буква не стоит на месте, то
			; то установим флаг "ожидания" в FALSE
			mov eax, [edi].x
			mov edx, [edi].y				
			.if (eax != [edi].ex) || ( edx != [edi].ey)
				mov await, FALSE	; Флаг указывает на то, что "блок строк" НЕ стоит на месте...
			.endif
				
			;--------
			
			inc ecx
			add edi, sizeof _words_
			
		.until (ecx >= aEndPos) || (ecx >= astrLen)
		
		; Рисуем на окне... )
		invoke BitBlt, aMainDC, 0, 0, aWidth, aHeight, ahDC, 0, 0, SRCCOPY
				

			; если "блок букв" стоит на своем месте и НЕ двигается...то...
			.if await == TRUE
			
				mov aNextLine, TRUE
				mov aChangeDelayTime, TRUE

				push edi
				push ecx
				
				invoke GetTickCount
				mov ecx, eax
				
				; ##############################
				; ждем пока "прочитают" текст =)
				.repeat
				; Если окно закрывают, то выходим
				.if aGlobalStop
					jmp @@ex
				.endif
					
					push ecx
					invoke BitBlt, aMainDC, 0, 0, aWidth, aHeight, ahDC, 0, 0, SRCCOPY
					invoke GetTickCount
					pop ecx
					
					sub eax, ecx
					
				.until eax >= aDelayTime
				; ##############################
				
				mov edi, awords
				mov ecx, aStartPos
				
				mov eax, ecx
				imul eax, sizeof _words_
				add edi, eax

				inc [edi].pcount

				.if ( [edi].pcount != 2)
					mov aNextLine, FALSE
				.endif

				.if ([edi].pcount != 1)
					mov aChangeDelayTime, FALSE
				.endif
			
				; т.к. буквы уже на своих позициях,
				; нам надо указать им новые координаты
				; чтобы они начали двигаться...
				; что мы и делаем...
				.repeat
					; Если окно закрывается, то выходим
					.if aGlobalStop == TRUE
						jmp @@ex
					.endif
					
					push aHeight
					pop [edi].ey	; Указываем каждой букве, новую координату по Y
								; Получается, что буква теперь пойдет вниз...
					
					add edi, sizeof _words_					
					inc ecx
				.until (ecx >= aEndPos) || (ecx >=astrLen)

				pop ecx
				pop edi
								
				.if aNextLine == TRUE					
					inc aLineNumber
					
					push aStandartDelayTime
					pop aDelayTime
					
					push aEndPos
					pop aStartPos
					
					inc aStartPos
					
					call SEPos
				.endif
				
				.if aChangeDelayTime
					xor eax, eax
					mov aDelayTime, eax
				.endif
						
				; Если текущий номер "блока" больше чем всего "блоков", то
				; сортируем буквы и обнуляем все переменные...
				; вообщем начинаем все заново...
				mov eax, aLinesCount
				.if aLineNumber > eax

					mov aLineNumber, 1	; LineNumber := 0;
					mov aStartPos, 0		; StartPos := 0;

					push aStandartDelayTime
					pop aDelayTime
					
					call Resort_Words
					call SEPos
				.endif

			.endif
	
	.until aGlobalStop == TRUE
	
	@@ex:
	
	; Укажем что поток закончил работу...
	mov aGlobalStop, FALSE

	xor eax, eax
	ret
Draw endp

;---------------------------------------

DlgProc_About proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
LOCAL x
LOCAL y

	mov eax, uMsg
	.if eax == WM_INITDIALOG
			
		push hWnd
		pop aWnd
		
		;------------------
		; Получим координату по X
		invoke GetSystemMetrics, SM_CXSCREEN
		invoke TopXY, aWidth, eax
		mov x, eax
		
		; Получим координату по Y
		invoke GetSystemMetrics, SM_CYSCREEN
		invoke TopXY, aHeight, eax
		mov y, eax
		
		; Установим позицию окна по центру
		invoke SetWindowPos, hWnd, 0, x, y, aWidth, aHeight, SWP_SHOWWINDOW
		
		; Установка Заголовка окна
		invoke SetWindowText, hWnd, addr szaTitle
		;------------------
		
		; Создаем все что надо...
		call Init_Proc
		
		; Сортируем буковки по своим местам...
		call Resort_Words

		; Создаем поток для прорисовки/перемещения текста
		invoke CreateThread, NULL, 0, addr Draw, 0, 0, addr aThread

	.elseif eax == WM_LBUTTONDOWN
		; если нажата левая кнопка мыши...
		; то отправляем мессадж, что типа мышь сидит на капшине =)
		invoke SendMessage, hWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0
				
	.elseif eax == WM_RBUTTONUP		
		; Если нажата правая кнопка мыши то
		; отправляем мессадж окну на выход...
		invoke SendMessage, hWnd, WM_CLOSE, 0, 0

	.elseif eax == WM_CLOSE
	
		; Останавливаем поток
		mov aGlobalStop, TRUE
		
		; Ждем когда Поток закончит свою работу...
		.repeat
			invoke Sleep, 1
		.until aGlobalStop == FALSE
		
		; Освобождаем память...
		call Free_Proc

		; Выходим...
		invoke EndDialog, hWnd, 0
		
	.endif
	
	xor eax, eax
	ret
DlgProc_About endp

;---------------------------------------
; ########################################################################
; © x0man / [tPORt] 2006 ;)
; -------------------------
; http://www.tport.be      
; -------------------------