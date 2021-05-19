.386
.model flat,stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\gdi32.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\gdi32.lib

DlgProc proto   :DWORD,:DWORD,:DWORD,:DWORD
Text	proto
Pause   proto

.data
Text1		db "..:: KAT/HTBTeam ::..",0
Text2		db "Presents...",0
Text3		db "Fucking Fade Text Effect v2.0",0
Text4		db "Coded on 01.I.2005 at 13:34",0
Text5		db "Thx: FiNS, Reywen, Ved and others...",0
Text6           db "Hmmmmmmmm... I don`t know...",0
Text7		db "Ok, that`s all...",0
Text8		db "PRESS RIGHT MOUSE BUTTON TO EXIT",0

.data?
ThreadID	dd ?
Handler		dd ?
hsb             dd ?

.code
start:

   invoke  GetModuleHandle,0
   invoke  DialogBoxParam,eax,101,0,addr DlgProc,0 
   invoke  ExitProcess,eax

DlgProc proc uses esi edi ebp ebx, hwnd:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

 mov eax,uMsg
 mov edi,hwnd
 mov Handler,edi

 .IF (eax==WM_CLOSE) || (eax==WM_RBUTTONUP)
   @Exit:
	invoke  EndDialog,edi,0

   .ELSEIF eax==WM_INITDIALOG
             invoke  CreateSolidBrush,0Fh
             mov     hsb,eax	
	     invoke  CreateThread,0,0,addr Text,edi,0,addr ThreadID

   .ELSEIF eax==WM_CTLCOLORDLG
             invoke  SetBkColor,wParam,0h
             mov     eax,hsb
	     ret
 .ENDIF

 xor	eax,eax
 ret

DlgProc endp

Text proc uses edi ebx
 LOCAL  Txt     :DWORD

	@@:
	invoke  GetDC,Handler
	cmp     eax,0
	je      @B
        mov     edi,eax

 	invoke  SetBkMode,edi,TRANSPARENT
	invoke  CreateFont,13,0,0,0,700,0,0,0,OEM_CHARSET,0,0,0,0,0
 	invoke  SelectObject,edi,eax

        mov     ebx,00101010h
        mov     Txt,1

	@SetColor:
	invoke  SetTextColor,edi,ebx

        .IF     Txt==1
 		invoke  TextOut,edi,87,25,addr Text1,sizeof Text1-1
        .ELSEIF Txt==2
 		invoke  TextOut,edi,109,35,addr Text2,sizeof Text2-1
        .ELSEIF Txt==3
 		invoke  TextOut,edi,62,45,addr Text3,sizeof Text3-1
        .ELSEIF Txt==4
 		invoke  TextOut,edi,67,55,addr Text4,sizeof Text4-1
        .ELSEIF Txt==5
 		invoke  TextOut,edi,45,65,addr Text5,sizeof Text5-1
	.ELSEIF Txt==6
 		invoke  TextOut,edi,54,75,addr Text6,sizeof Text6-1
	.ELSEIF Txt==7
 		invoke  TextOut,edi,100,85,addr Text7,sizeof Text7-1
	.ELSEIF Txt==8
 		invoke  TextOut,edi,38,95,addr Text8,sizeof Text8-1
	.ENDIF

	invoke  Sleep,10

	add	ebx,00010101h
	cmp	ebx,00FFFFFFh
        jne     @SetColor
  
        mov     ebx,00101010h
        inc     Txt
        cmp     Txt,9
        je      @F
	jmp     @SetColor
	@@:
	ret
Text endp

end start