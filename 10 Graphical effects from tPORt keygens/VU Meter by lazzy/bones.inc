tagOFNA         struct
lStructSize     dd ?
hwndOwner       dd ?                    ; offset
hInstance       dd ?                    ; offset
lpstrFilter     dd ?                    ; offset
lpstrCustomFilter dd ?                  ; offset
nMaxCustFilter  dd ?
nFilterIndex    dd ?
lpstrFile       dd ?                    ; offset
nMaxFile        dd ?
lpstrFileTitle  dd ?                    ; offset
nMaxFileTitle   dd ?
lpstrInitialDir dd ?                    ; offset
lpstrTitle      dd ?                    ; offset
Flags           dd ?
nFileOffset     dw ?
nFileExtension  dw ?
lpstrDefExt     dd ?                    ; offset
lCustData       dd ?
lpfnHook        dd ?                    ; offset
lpTemplateName  dd ?                    ; offset
pvReserved      dd ?                    ; offset
dwReserved      dd ?                    ; XREF: DialogFunc+1B8/r
FlagsEx         dd ?
tagOFNA         ends


include	/masm32/include/windows.inc 
include	/masm32/include/kernel32.inc 
include	/masm32/include/user32.inc 
include /masm32/include/gdi32.inc  
include /masm32/include/shell32.inc
include	/masm32/include/winmm.inc
include	/masm32/include/msvcrt.inc
include	/masm32/include/comctl32.inc
include	/masm32/include/oleaut32.inc
include	/masm32/include/ole32.inc
include	/masm32/include/advapi32.inc
include	/masm32/include/comdlg32.inc
include /masm32/macros/macros.asm

includelib	/masm32/lib/kernel32.lib
includelib	/masm32/lib/user32.lib 
includelib 	/masm32/lib/gdi32.lib
includelib 	/masm32/lib/shell32.lib
includelib	/masm32/lib/winmm.lib
includelib	/masm32/lib/msvcrt.lib
includelib	/masm32/lib/comctl32.lib
includelib  /masm32/lib/oleaut32.lib
includelib  /masm32/lib/ole32.lib
includelib	/masm32/lib/advapi32.lib
includelib	/masm32/lib/comdlg32.lib

include ufmod.inc
includelib ufmod.lib

DlgProc		PROTO	:DWORD,:DWORD,:DWORD,:DWORD

.const
IDD_MAIN	equ	1000

.data
include chip.inc
WindowTitle	db	"LaZzy's VU meter",0
;Newfont LOGFONT <12,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'terminal'>
r3kt		RECT	<>

.data?
hInstance	dd	?
hIMG 		dd	?
hBrush		dd  ?
hFont		dd	?
hStatic	dd	?
WndRect	RECT	<>
StaticRect	RECT	<>
