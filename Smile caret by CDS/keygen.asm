
;                                                                           
;[= THE ===========================================================================]  
;[] _________ ____   ____ _______  _____  _____  _____                 ____  ____ []  
;[] \       / \   | |   / \      \ \    \ \    \ \    \     /\     /\  \   \/   / []  
;[] /   ___/   |  | |  |   |   > / /   > \ |  > \ |    \   /  \   /  \  |      |  []  
;[] \   \___   |  |_|  |   |   > \ \  ___/ | |  / |  >  \ / /\ \ / /\ \ | |\/| |  []  
;[]  \____  \   \_   _/    |___  /  \___ \ |_|\ \ |___  / \__  / \__  / |_|  | |  []  
;[]       \/      | |          \/       \/     \/     \/     \/     \/        \|  []  
;[=============== |/ =============================================== SYSTEMS ======]  
;                             Presents:                                               
;                            Smile Caret
;                           Author: CyberDoom

.486p
.model flat, stdcall
option casemap :none

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;                             IMPORTS, DEF
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

include		\masm32\include\windows.inc
include		\masm32\include\user32.inc
include		\masm32\include\gdi32.inc
include		\masm32\include\kernel32.inc

includelib	\masm32\lib\user32.lib
includelib	\masm32\lib\gdi32.lib
includelib	\masm32\lib\kernel32.lib


DlgKgProc	PROTO :DWORD,:DWORD,:DWORD,:DWORD
keygen		PROTO :DWORD


CarPos struct
 x dd ?
 y dd ?
CarPos ends

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;                              CONSTANTS
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.const 

IDD_DIALOGBOX1	equ	101
IDI_ICON		equ	103
IDC_INFO		equ	1002
IDC_EXIT		equ	1003
IDC_NAMEBOX		equ	1004
IDC_SERIALBOX	equ	1005

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;                                 DATA
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.data

ProgId		db "Keygen ",0

INIT_NAME	db "cds",0
invname		db "Please enter a longer name...",0

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;                                 DATA?
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.data?
hInstance	HINSTANCE ?
hcaret dd ?
lpfnEditAddr dd ?
hDC dd ?
CarDC dd ?
ps PAINTSTRUCT <>

cp CarPos <>
buffer_c db 250 dup(?)

X dd ?
red_flg db ?

EditHandle dd ?
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;                                 CODE
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.code 

start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	invoke	DialogBoxParam, hInstance, IDD_DIALOGBOX1, NULL, offset DlgKgProc, 0
	invoke	ExitProcess, NULL

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;                             MAIN DIALOG
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DlgKgProc	PROC	hWnd	:DWORD,
			uMsg	:DWORD,
			wParam	:DWORD,
			lParam	:DWORD

	mov	eax,uMsg    

	; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	.if eax == WM_CLOSE
		invoke	EndDialog, hWnd, NULL

	; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	.elseif eax == WM_LBUTTONDOWN
		mov	eax, lParam
		invoke	PostMessage, hWnd, WM_NCLBUTTONDOWN, HTCAPTION, eax

	; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	.elseif eax == WM_INITDIALOG
		xor	eax, eax
		
		invoke	LoadIcon,hInstance,IDI_ICON
		invoke	SendMessage,hWnd,WM_SETICON,ICON_SMALL, eax
		invoke  SetWindowText, hWnd, addr ProgId
		invoke	GetDlgItem, hWnd, IDC_NAMEBOX
		invoke	SendMessage, eax, EM_SETLIMITTEXT,50,0
		;invoke	SetDlgItemText, hWnd, IDC_NAMEBOX, offset INIT_NAME



invoke LoadBitmap,hInstance,104
mov hcaret,eax

invoke GetDlgItem,hWnd,1004
mov EditHandle,eax

push eax
call GetDC
mov hDC,eax
push eax
call CreateCompatibleDC
mov CarDC,eax
push hcaret
push eax
call SelectObject
push hcaret
call DeleteObject


push offset CarProc
push GWL_WNDPROC
push EditHandle
call SetWindowLong
mov lpfnEditAddr, eax

invoke SetTimer,hWnd,1,1,0	
		

	
		.elseif eax == WM_TIMER
		         
	
	        	invoke BitBlt,hDC,X,cp.y,50,50,CarDC,0,0,SRCCOPY
		        invoke HideCaret,EditHandle

	 .ELSEIF eax ==WM_CTLCOLOREDIT
     
     	invoke	SetTextColor, wParam,White 
	    invoke	SetBkColor,wParam,0
        invoke	GetStockObject,BLACK_BRUSH
	    ret
	
	
		.elseif eax == WM_COMMAND
		mov	eax,wParam
		mov	edx,wParam
		shr	edx,16
		.if ax == IDC_INFO
	
	
		
		; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		.elseif ax == IDC_NAMEBOX
			push	eax
			shr	eax, 16
			.if ax==EN_CHANGE
				;invoke	keygen,hWnd
			invoke GetDlgItemTextA, hWnd, IDC_NAMEBOX,offset buffer_c, 250
			
			invoke	SetDlgItemText, hWnd, IDC_SERIALBOX, offset buffer_c
			
			.endif
			pop	eax

		; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		.elseif ax == IDC_EXIT
			invoke	EndDialog, hWnd, eax
		.endif
	.else
		mov	eax, FALSE
		ret
	.endif

	mov	eax,TRUE
	ret

DlgKgProc	ENDP

CarProc proc hCtl: dword,
             uMsg   :DWORD,
             wParam :DWORD,
             lParam :DWORD
  
      LOCAL tl:DWORD
      LOCAL testBuffer[160]:BYTE
  
    ; -----------------------------
    ; Process control messages here
    ; -----------------------------
  
       cmp uMsg, WM_CHAR
       jne no_ch
  
       push offset cp
       call GetCaretPos
       
       cmp wParam,8; allow backspace
       jne @F
  
     
       cmp cp.x,0
       je show
       mov eax,cp.x
       sub eax,10
       mov X,eax
       jmp show
  @@:
 
       mov eax,cp.x
       add eax,10
       mov X,eax
       
 show: 
      
       
        push    1              ; bErase
        push    0               ; lpRect
        push    EditHandle; hWnd
        call    InvalidateRect
       
      
     
 no_ch:
      
  
      invoke CallWindowProc,lpfnEditAddr,hCtl,uMsg,wParam,lParam
  
      ret


CarProc endp


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
END	start
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~