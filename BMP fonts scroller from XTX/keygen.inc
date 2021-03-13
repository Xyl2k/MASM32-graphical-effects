include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc
;include macros.inc
include \masm32\include\masm32.inc
include MyMacros.asm
include \masm32\include\comctl32.inc
include \masm32\include\advapi32.inc
include \masm32\include\comdlg32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\ole32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\comctl32.lib
includelib \masm32\lib\oleaut32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\winmm.lib
includelib \masm32\lib\advapi32.lib
includelib \masm32\lib\comdlg32.lib




include SFX\ufmod.inc
includelib SFX\ufmod.lib
include	GFX\pnglib.inc
includelib	GFX\pnglib.lib
include	Lib\mfmplayer\mfmplayer.inc
includelib Lib\mfmplayer\mfmplayer.lib

MainProc		   proto:DWORD,:DWORD,:DWORD,:DWORD
LoadPng			   proto:DWORD,:DWORD
SetClipboard	   proto:DWORD
FadeIn			   proto
FadeOut			   proto
PlayMidiFile	PROTO:DWORD,:DWORD
.const
MainDlg	=	100
EditSerial	=	101
EditName	=	1002
GenBtn		=	102
AboutBtn           =        103
ExitBtn                =        104

AboutDlg	=	700
IDC_TIMER	=	10
SIZEOFTITLEBAR	EQU 20
HEIGHTSYSBUTTON	EQU 14
WIDTHSYSBUTTON	EQU 14
TITLEFONT		EQU "Lucida Console"
BTNFONT			EQU "MS Sans Serif"
ABOUTFONT		EQU "Tahoma"
COLORDLG		EQU 00FA5B2Eh
COLORPEN		EQU 009D2604h
COLORTEXT	    EQU 00FFFF00h
VITESSEDEFIL	EQU 35
;================================ scroll  horizontal==========================
ScreenWidth    equ 347
	ScreenHeight   equ 20
;================================ scroll  horizontal==========================
.data

	rcDraw		RECT	<0>
;
;; |**** SCROLLER DATA **************|
;
      text_message    db "                                      "
				db "# # # # # #  KEYGEN BRUTEFORCE "
				db "BUGFIXED "
				db "CODED BY SP0KE "
				db "IN ASM MASM "
				db "XTX TEAM 2009 "
				db "GREETZ "
				db " TO FARGOTH POUR FOR THIS KEYGENME"
				db" VERY COOL MAN"
				db" GREETZ TO COOLMEN,Z!PPER,KIRJO,MARS,TYTAN,TALOCHE,BURNER"
				db" @++"
				db" SP0KE."
				db "# # # # # #                         ",0
      message_index   dd 0
      posindex        dd 0
      
     
      

      include g_goldyfont.inc
; |*********************************|


;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++





Transparency		dd 0
TransColor			COLORREF	0FFFFFFFh
sizeFrame			dd	?,?
MoveDlg				BOOL		?
OldPos				POINT		<>
NewPos				POINT		<>
Rect				RECT		<>
handle				dd				?
ofn OPENFILENAME <>
szCaption			db	"Keygen/BruteForce",0
PressGen			db	"pressez le bouton  !",0
Buffer          db  256 dup(?)
szMIDISeqr  	db "Sequencer",0
TxtFont		LOGFONT <-14,0,0,0,FW_NORMAL,TRUE,FALSE,FALSE,0,3,2,1,20,"Arial Black">
;========================== scroller ===================================================
 AppHWnd         dd 0
 phkResult       dd 0
 lpdwDisposition dd 0
AboutTitle              db "A propos de KeygenMe#2 de Fargoth",0
ResultTitle             db "Mettez une Majuscule S.V.P. Merci",0
AboutFlag               dd  ?


szbtnClassName			db "button"     
szNULL					db 0

hCurrentCtl				HWND  NULL
ScrollOffset			DWORD	1
;Transparency		    dd 0
;TransColor			    COLORREF	00000FFh
AboutTxt                    db "Keygen BruteForce bugfixed:",10,13,10,13
				db "Codé par sp0ke ",10,13,10,13
				db "en ASM syntaxe MASM. ",10,13,10,13
				db "xtx TeaM 2009 ",10,13,10,13
				db "~~[Remerciements]~~",10,13,10,13
				db " à Fargoth pour ce KeygenMe,", 10, 13,10,13
				db " et de m'avoir aidé à corriger  le bug du xor,", 10, 13,10,13
				db"C'est Très sympa Merci !",10,13,10,13
				db " Ce défi m'a donné du fil à retordre lol, ",10,13
				db"je dois avouer, j'ai mis le temps ! ",10,13,10,13
				db" Comme quoi la patience paye.",10,13,10,13
				db" Merci à Coolmen,Z!PPer,Kirjo,.",10,13,10,13
				db" mars,Tytan, taloche, Burner, .",10,13,10,13
				db" @++",10,13,10,13
				db" sp0ke.",10,13,10,13,0
				
				

			
.data?

;============================================ scrolling horizontal===========================
canvasDC	  dd	?
canvasBmp	  dd	?
hDC           dd  ?
canvas_buffer dd	?
clip1         dd  ?
clip2         dd  ?

ps		  PAINTSTRUCT	<>
canvas	  BITMAPINFO	<>

;========================================================================================
nMusicSize DWORD	?
pMusic     LPVOID	?


;hInstance	dd	?
hIcon		dd	?
hGen		dd	?
hWND		dd	?
hIMG		dd	?
hBrush		dd	?
hFont		dd	?

;============================================ scrolling ===========================

hBgColor     	HBRUSH				?
;handle          HWND                ?
hpen         	HPEN				?
hFontTitle   	HFONT				?
hFontBtn     	HFONT				?
hFontBtnBold	HFONT				?
dlgRect      	RECT				<?>
txtBoxRect   	RECT				<?>
hInstance    	HINSTANCE			?
hBtnExit       	HWND				?
hBtnMin      	HWND				?
hBtnAbout    	HWND				?
hBtnPatch		HWND				?
hBtnUnPatch		HWND				?
hFontAbout		HFONT				?
AboutRect    	RECT				<?>
rScroll			RECT				<?>
rClientAbout	RECT				<?>
PosRect         RECT                <?>
hbmp			HANDLE				?
chdc			HDC					?

TimerID			DWORD				?
hFile			dd					?
hFileSize		dd					?
hMapFile		dd					?
hViewFile		dd					?
szAboutMsg      db                  300 dup(?)
WinBuff			db					200 dup(?)
ResDat			dd					?
ResInf			dd					?
ResSize			dd					?
MidDeviceID 	dd					?











