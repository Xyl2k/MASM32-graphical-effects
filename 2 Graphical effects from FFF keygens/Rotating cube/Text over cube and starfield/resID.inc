include        \masm32\include\windows.inc
include        \masm32\include\user32.inc
include        \masm32\include\kernel32.inc
include        \masm32\include\masm32.inc
include        \masm32\include\gdi32.inc  
include        \masm32\include\comctl32.inc
include        \masm32\macros\macros.asm

includelib     \masm32\lib\user32.lib
includelib     \masm32\lib\kernel32.lib
includelib     \masm32\lib\masm32.lib
includelib     \masm32\lib\gdi32.lib
includelib     \masm32\lib\comctl32.lib

DlgProc                	PROTO :DWORD,:DWORD,:DWORD,:DWORD
Draw					 PROTO :DWORD
CreateTVBox 			proto :dword

.const
IDD_KEYGEN             equ 2000
IDB_QUIT                 equ 2002
IDB_ABOUT				 equ 2010


.data
AboutFont		LOGFONT	<0FFFFFFF6h,0,0,0,320h,0,0,0,0,0,0,0,0,'Verdana'>

AboutText	db 13,13,"Panorado 3.3.1.167 (c) Simple Software",13
			db ":: kEyGeN made by GRUiA ::",13,13
			db "Protection : Serial , Date : o7.nov.2o22",13
			db "Music by Jeroen Tel, Template by r0ger",13
			db "TitchySID lib by StatMat , cube by RocketSpawn^FFF",13,13
			db "Gr33tingz to all my PRF thugz and",13
			db "other friendz from my hood from bUCHAREST,",13
			db "and of course to Cachito,Xylitol,Roentgen,",13
			db "Talers,Intel Core 2 Extreme,de!,Vad1m,kEy-tONe,",13
			db "Dilik,Log0,SKG-1010,Bang1338 and othrz . :)",13,13
			db "web : [[Hyperlink Blocked]]",13
			db "telegram : t.me/r0ger888",13
			db "ig : @r0ger888 / @bobo.crt",13
			db "github : r0ger888",13
			db "discord : r0ger#2649",13,13

szTitle                  db "fork by PRF",0

;these should match dialog size in pixels

xStarzPos                equ 7
yStarzPos                equ 31
nWidth                   equ 342
nHeight                  equ 201


nStarzSlow               equ 50
nStarzNorm               equ 50
nStarzFast               equ 50
StarColSlow              equ 777777h
StarColNorm              equ 0AAAAAAh
StarColFast              equ 0FFFFFFh

ScrollerSpeed            equ 1
nStarCount               equ nStarzSlow + nStarzNorm + nStarzFast

PausedOrRunning	dd	0
AboutActive	BOOL		FALSE
Continue	BOOL		FALSE
nFont                dd     1


.data?
NameLen                  dd         ?
hInstance                dd         ?
hBlackBrush              HBRUSH     ?
hExit                    BOOL       ?
hMatrix                  DWORD      ?
hDC                      HANDLE     ?
hFont					 dd			?
hMail					 dd			?
hSerial					 dd			?
hREGBOX					 dd			?
hDate					 dd			?
hQuit					 dd 		?
hAbout					 dd			?
pbmi                     BITMAPINFO <>
ppvBits                  dd         ?
randomSeed               dw         ?
randomMaxVal             dw         ?
starArrayX               dw nStarCount dup(?)
starArrayY               dw nStarCount dup(?)
scrollerCurrentY         dd         ?
freezeCounter            dd         ?
ThreadID                 dd         ?
hDlgWnd                  dd         ?
hStarsDC                 dd         ?
hLogoDC                  dd         ?
hThread                  dd         ?
BitmapDC				 dd         ?
xHeight    				 dd 		?
xWidth					 dd 		?
xPos					 dd			?
yPos					 dd			?