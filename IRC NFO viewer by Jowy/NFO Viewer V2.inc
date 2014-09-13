USESCROLLER	=	1

include windows.inc
include kernel32.inc
include user32.inc
include gdi32.inc
include masm32.inc
include comctl32.inc
include ole32.inc
include oleaut32.inc
include winmm.inc

includelib kernel32.lib
includelib user32.lib
includelib gdi32.lib
includelib masm32.lib
includelib comctl32.lib
includelib ole32.lib
includelib oleaut32.lib
includelib winmm.lib

include \masm32\macros\macros.asm

NFOProc		proto	:DWORD,:DWORD,:DWORD,:DWORD
TopXY		proto	:DWORD,:DWORD

.const
NFODLG	=	100

SIZEOFTITLEBAR	= 20
IDC_TIMER		= 10
TITLEFONT		equ "Verdana"
ABOUTFONT		equ "Verdana"
COLORDLG		equ White
COLORPEN		equ Black
COLORCAPTION	equ Black
COLORTEXT		equ Red
COLORTEXT2		equ Blue
SCROLLSPEED		equ 20
tagRECT STRUCT
 left    	dd ?
 top     	dd ?
 right   	dd ?
 bottom  	dd ?
tagRECT ENDS    


GETV MACRO dVar
	mov eax,dVar
  EXITM <eax>
ENDM 

.data
Transparency		dd 0
TransColor			COLORREF	0FFFFFFFh
MoveDlg				BOOL		?
OldPos				POINT		<>
NewPos				POINT		<>
Rect				RECT		<>
hCurrentCtl			HWND  NULL
ScrollOffset		DWORD	1
szNULL				db 	0
NFOFont		LOGFONT	<13,7,NULL,NULL,0,FALSE,FALSE,FALSE,OEM_CHARSET,OUT_DEFAULT_PRECIS,\
			CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,DEFAULT_PITCH,"Terminal">
			
szHeader				db	"iRC nFo Viewer V2b   |   + for faster   |   - for slower   |   P for pause   |   X for exit",0
szFooter				db	" Coded by Jowy [IRC]                                                    http://www.sembako.ngirit.org/",0
szNFOName				db	"IRC.nfo",0
Speed					dd		25
ID						dd		?
SpeedCp					dd		?

.data?
hInstance	dd	?
hWND		dd	?
hNFOFont		HFONT		?
hBgColor     	HBRUSH		?
hpen         	HPEN		?
hFontTitle   	HFONT		?
hFontAbout		HFONT		?
AboutRect    	RECT		<?>
rScroll			RECT		<?>
rClientAbout	RECT		<?>
hbmp			HANDLE		?
chdc			HDC			?
TimerID			DWORD		?
PosRct			RECT		<?>
hIcon			HICON		?
hCursor			HCURSOR		?

hResInfo	dd	?
hResSize	dd	?
hResData	dd	?
hRgnData	dd	?

hFile		dd	?
hFileMap	dd	?
hViewMap	dd	?
hFileSize	dd	?