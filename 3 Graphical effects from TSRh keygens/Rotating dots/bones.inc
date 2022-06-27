include		/masm32/include/windows.inc 
include		/masm32/include/kernel32.inc 
include		/masm32/include/user32.inc 
include     /masm32/include/gdi32.inc  
include		/masm32/include/comctl32.inc

include     /masm32/macros/macros.asm

includelib	/masm32/lib/kernel32.lib
includelib	/masm32/lib/user32.lib 
includelib 	/masm32/lib/gdi32.lib

includelib	/masm32/lib/comctl32.lib

DlgProc		PROTO	:DWORD,:DWORD,:DWORD,:DWORD

.const
IDD_MAIN	equ	1000
.data

WindowTitle	db	"Graphical effect from TSRh keygen by Funbit (Rotating dots)",0
LogFont	LOGFONT <8,6,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY, 0,"Terminal">
rkkt	RECT	<>

.data?
hInstance	dd	?
ThreadId	dd	?
DottedShapezId	dd  ?
hFont		dd	?
hInfo		dd	?