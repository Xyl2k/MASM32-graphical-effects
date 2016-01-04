include		\masm32\include\windows.inc
include		\masm32\include\user32.inc
include		\masm32\include\kernel32.inc
include		\masm32\include\comctl32.inc	;windows common controls
include \masm32\include\gdi32.inc
includelib \masm32\lib\gdi32.lib
include \masm32\include\winmm.inc
includelib \masm32\lib\winmm.lib
include ufmod.inc
includelib ufmod.lib
includelib	\masm32\lib\user32.lib
includelib	\masm32\lib\kernel32.lib
includelib	\masm32\lib\comctl32.lib	;windows common controls

DlgProc		PROTO	:DWORD,:DWORD,:DWORD,:DWORD

.const
IDD_MAIN	equ	1000
IDB_EXIT	equ	1001

.data
String	db 'ORiON',0Ah
		db 'proudly presents',0Ah
		db 0Ah
		db 'Someapplication vx.xx',0Ah
		db 0Ah
		db 'Protection: Custom',0Ah
		db 0Ah
		db 'Group Greetings:',0Ah
		db 0Ah
		db 'AMN',0Ah
		db 'AMRC',0Ah
		db 'AOD',0Ah
		db 'CLASS',0Ah
		db 'DAMN',0Ah
		db 'DEViANCE',0Ah
		db 'DMG',0Ah
		db 'ECLiPSE',0Ah
		db 'FAiRLiGHT',0Ah
		db 'LND',0Ah
		db 'MYTH',0Ah
		db 'RAZOR1911',0Ah
		db 'ROR',0Ah
		db 's!p',0Ah
		db 'STARCUBE',0Ah
		db 'TMG',0Ah
		db 'TNO',0Ah
		db 'TSZ',0Ah
		db 'TV',0Ah
		db 'UCF',0Ah
		db 0Ah
		db 'Thanks goto Dualtrax [s!p] for the .xm!',0Ah
		db 'www.dualtrax.com',0Ah
		db 0Ah
		db 'Have a nice day :)',0Ah
		db 0Ah
		db 0Ah,0
aVerdana	db 'Verdana',0

hFont		dd 0
dword_40E510	dd 0
number	dd 0 
dword_40CCA0	dd 0
dword_40CCA4	dd 0
dword_40CCB8	dd 0
dword_40CD24	dd 0
				dd 1F2h	dup(0)
dword_40DCC4	dd 0
				dd 1F3h	dup(0)
dword_40D4F0	dd 0
dword_40D4F4	dd 0
				dd 1F3h	dup(0)

.data?
hInstance	dd	?
handle	dd	?
ScrollMainDC	HDC	?
ScrollBackDC	HDC	?
Tick	dd	?
ScrollBitmap	HBITMAP	?

dword_40CD18	dd	?
Rect		RECT	<>
Paint	PAINTSTRUCT	<>

dword_40E498	dd	?
TextLen	dd	?
dword_40E508	dd	?
dword_40E50C	dd	?
GoDown	db	?
dword_40E504	dd	?

