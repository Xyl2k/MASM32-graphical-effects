
.686
.model flat,stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

INCLUDE    \masm32\INCLUDE\comctl32.inc
INCLUDELIB \masm32\LIB\comctl32.lib


INCLUDE    \masm32\INCLUDE\gdi32.inc
INCLUDELIB \masm32\LIB\gdi32.lib

INCLUDE    \masm32\INCLUDE\oleaut32.inc
INCLUDELIB \masm32\LIB\oleaut32.lib

;############################################################
RES_NFO =1

;############################################################
;NFO colors: 

NFO_GREEN =0CA68h
NFO_RED =00FF0000h
NFO_BLUE =000FFh


NFO_COLOR=NFO_RED



;#############################################################


.data
include data.inc



.DATA?


hInstance dd ?


.CODE

include dlg.inc
include proc.inc

start:
     invoke GetModuleHandle,0
     mov hInstance,eax
     
     
     invoke InitCommonControls
     
     IF RES_NFO
     call GetRes
     ENDIF
     
     invoke DialogBoxParam,hInstance,100,0,OFFSET DialogFunc ,0
     invoke ExitProcess,0

IF RES_NFO
GetRes proc 
	LOCAL hResource		:DWORD
	LOCAL ResSize		:DWORD
	LOCAL lpResBuffer	:DWORD

	invoke FindResource,hInstance,1,RT_RCDATA ;get handle of resource
		mov hResource,eax				;preserve handle
		invoke SizeofResource,hInstance,hResource	;get size of resource
		mov ResSize,eax
		invoke LoadResource,hInstance,hResource
mov word_4066EE,eax

ret 
		
GetRes endp		
ENDIF


END start