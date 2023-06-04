include		/masm32/include/windows.inc 
include		/masm32/include/kernel32.inc 
include		/masm32/include/user32.inc 
include     /masm32/include/gdi32.inc  
include 	/masm32/include/shell32.inc
include		/masm32/include/winmm.inc
include		/masm32/include/masm32.inc
include		/masm32/include/msvcrt.inc
include		/masm32/include/comctl32.inc
include		/masm32/include/oleaut32.inc
include		/masm32/include/ole32.inc
include		/masm32/include/advapi32.inc
include		/masm32/include/comdlg32.inc
include     /masm32/macros/macros.asm

includelib	/masm32/lib/kernel32.lib
includelib	/masm32/lib/user32.lib 
includelib 	/masm32/lib/gdi32.lib
includelib 	/masm32/lib/shell32.lib
includelib	/masm32/lib/winmm.lib
includelib 	/masm32/lib/masm32.lib
includelib	/masm32/lib/msvcrt.lib
includelib	/masm32/lib/comctl32.lib
includelib  /masm32/lib/oleaut32.lib
includelib  /masm32/lib/ole32.lib
includelib	/masm32/lib/advapi32.lib
includelib	/masm32/lib/comdlg32.lib

DlgProc		PROTO	:DWORD,:DWORD,:DWORD,:DWORD

 
        
.const
IDD_MAIN	equ	1000

.data
WindowTitle		db	"Starfield effect coded by str^TeaM.iNFLUENCE",0
r3kt			RECT	<>
.data?
hInstance	dd ?
hIMG		dd ?
hFont		dd ?
hStatic		dd ?
hBrush		dd ?
nHeight    	dd ?
nWidth		dd ?
WndRect		RECT	<>
StaticRect	RECT	<>
xWnd        dd ?
StarfieldId dd ?