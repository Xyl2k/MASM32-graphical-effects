.586p
.mmx			
.model flat, stdcall
option casemap :none

include			windows.inc	
include			user32.inc	
include			kernel32.inc
include			shell32.inc
include			advapi32.inc
include			gdi32.inc
include			comctl32.inc
include			comdlg32.inc
include			masm32.inc
include			c:\masm32\macros\macros.asm
include			cryptohash.inc
include			biglib.inc
include			ufmod.inc
includelib		kernel32.lib
includelib		user32.lib
includelib		shell32.lib
includelib		advapi32.lib
includelib		gdi32.lib
includelib		comctl32.lib
includelib		comdlg32.lib
includelib		masm32.lib
includelib		winmm.lib
includelib		cryptohash.lib
includelib		biglib.lib
includelib		ufmod.lib
include 		Aboutb0x.inc	;THIS IS THE NEW PLACE OF ABOUT IT'S BETTER ;)

DlgProc			proto		:DWORD,:DWORD,:DWORD,:DWORD 

.const
	IDD_CRACKME	    	equ		101
	ICON		    	equ		2000
	MAXSIZE				equ		512

.data     		
N db "CE53EF71DCC51B962FC9F71138D25D66A0814940001DDEB42F1987ACDD30CF11",0
E db "10001",0
;D db "7F7B930DCA37AB74DF702D8CE18BF112B4CB4ACB2FF064FECFD0B67F99B05BA5",0

bfBuffer1		db	MAXSIZE dup (0)
bfBuffer2		db	MAXSIZE dup (0)
bfBuffer3		db	MAXSIZE dup (0)
bfBuffer4		db	MAXSIZE dup (0)

.data? 
hInstance	HINSTANCE	? 

szInput 			db 		512 dup(?)
szSerialField 		db 		512 dup(?)
szReversed 			db 		512 dup(?)
lenDataToHash		dd 		?
szHexed 			db 		512 dup(?)
MD5Hash				db 		512 dup(?)

Serial 		dword ?
BigX 		dword ?
BigD 		dword ?
BigE 		dword ?
BigN 		dword ?

SerialBuffer		db 		512 dup(?)
szFinalSerial		db 		512 dup(?)

.code 
start: 
;================ AntiDebugs ================

;	MASM32 	antiPeID example 
;			coded by ap0x
;			Reversing Labs: http://ap0x.headcoders.net

;	PeID checks OEP for signatures. If the byte pattern at OEP matches some of
;	the signatures stored in PeID.exe or userdb.txt PeID will identify target as 
;	packer or protector assigned to that signature. So we can insert any number
;	of bytes at OEP and make PeID detect the wrong packer.

;	For example this is ExeCryptor`s OEP

	db 0E8h,024h,000h,000h,000h,08Bh,04Ch,024h,00Ch,0C7h,001h,017h,000h,001h,000h,0C7h
	db 081h,0B8h,000h,000h,000h,000h,000h,000h,000h,031h,0C0h,089h,041h,014h,089h,041h
	db 018h,080h,0A1h,0C1h,000h,000h,000h,0FEh,0C3h,031h,0C0h,064h,0FFh,030h,064h,089h
	db 020h

	ASSUME FS:NOTHING
	POP FS:[0]
	ADD ESP,4

		invoke 	GetModuleHandle, NULL 
		MOV    	hInstance,eax 
		invoke 	InitCommonControls
		invoke 	DialogBoxParam, hInstance,IDD_CRACKME, NULL, addr DlgProc, NULL 
		invoke	ExitProcess,0

DlgProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM 
mov eax,uMsg
	.if eax == WM_INITDIALOG
		invoke LoadIcon,hInstance,ICON
		invoke SendMessage,hWnd,WM_SETICON,ICON_SMALL, eax
		invoke SendMessage,eax, EM_SETLIMITTEXT,50,0
		invoke SendMessage,hWnd,WM_SETICON,1,eax
		invoke SetWindowText, hWnd, CTXT("rEvErs0rEd KeygenMe - by Xylitol")
		invoke SetFocus,eax 
	.elseif eax == WM_COMMAND
		mov eax,wParam
			.if eax==2080
	;	GET NAME		
				invoke GetDlgItemText,hWnd,2015,addr szInput,sizeof szInput
				mov lenDataToHash,eax												 
				TEST EAX,EAX
				je noname
	;	REVERSE NAME
				LEA ESI, szInput
				call lstrRev
	;	ENCODE NAME TO HEX		
				invoke HexEncode,offset szReversed,lenDataToHash,addr szHexed
	;	FREE THE BUFFERS	szReversed & lenDataToHash
				invoke RtlZeroMemory,addr szReversed,sizeof szReversed				
				invoke RtlZeroMemory,addr lenDataToHash,sizeof lenDataToHash
	;	GET SIZEOF ENCODED HEX & PUT IT IN lenDataToHash
				invoke lstrlen,addr szHexed
				mov lenDataToHash,eax
	;	REVERSE ENCODED HEX			
				lea esi,szHexed
				call lstrRev
	;	GET THE ENTERED SERiAL			
				invoke GetDlgItemText,hWnd,2023,addr szSerialField,sizeof szSerialField
				mov lenDataToHash,eax
				test eax,eax
				je noserial
	;	CREATES A BIGNUM AND INITIALIZES IT WITH THE VALUE INITVALUE
				invoke _BigCreate,0
				mov BigX,eax
				invoke _BigCreate,0
				mov BigE,eax
				invoke _BigCreate,0
				mov BigN,eax
				invoke _BigCreate,0
				mov Serial,eax
	;	FILLS BIG WITH THE NULL-TERMINATED STRING
				invoke _BigIn,addr szSerialField,16, BigX
				invoke _BigIn,addr E,16,BigE
				invoke _BigIn,addr N,16,BigN
	;	SERiAL = ENTERED SERiAL ^ E mod N
				invoke _BigPowMod,BigX,BigE,BigN,Serial
	;	FILLS BUFFER WITH THE VALUE OF BIG IN BASE 16 AS A NULL-TERMINATED STRING
				invoke _BigOutB16,Serial,addr SerialBuffer
	;	DESTROYS THE BIGNUM BIG
				invoke _BigDestroy,BigX
				invoke _BigDestroy,BigE
				invoke _BigDestroy,BigN
				invoke _BigDestroy,Serial
	;	COMPARE THE ENCODED HEX 'szReversed' & ENTERED SERiAL 'SerialBuffer'
				invoke lstrcmp,addr szReversed,addr SerialBuffer
				TEST EAX,EAX
				jnz @badserial
				
				invoke MessageBox,hWnd,CTXT("Now that's the correct one"),CTXT("Yeah baby"),MB_ICONINFORMATION
				ret
				@badserial:
				invoke MessageBox,hWnd,CTXT("nah not a correct one"),CTXT("Whaaaa333t"),MB_ICONEXCLAMATION
				ret
				noname:
				invoke MessageBox,hWnd,CTXT("Name field is empty"),CTXT("z0rO"),MB_ICONEXCLAMATION
				ret
				noserial:
				invoke MessageBox,hWnd,CTXT("Serial field is empty"),CTXT("z0rO"),MB_ICONEXCLAMATION
				ret
			.elseif eax==2010
				invoke SendMessage, hWnd, WM_CLOSE, 0, 0
			.elseif eax==2046
				invoke DialogBoxParam, hInstance, 102, hWnd, offset Aboutproc, 0
			.endif
		
	.elseif eax==WM_MOUSEMOVE
		mov eax,wParam
			.if eax==1
				invoke SendMessage,hWnd,WM_SYSCOMMAND,0F012h,0
			.endif
	.elseif eax==WM_RBUTTONDOWN
		invoke ShowWindow,hWnd,SW_MINIMIZE
			
	.elseif eax==WM_CLOSE
		invoke	EndDialog, hWnd,0
	.Endif        
		xor	eax,eax
		ret 
DlgProc endp

lstrRev proc
		lea edi, szReversed
		mov ecx, lenDataToHash
		xor ebx, ebx
			Reversor:
				mov al, byte ptr[esi+ecx-1]
				mov byte ptr[edi+ebx], al
				inc ebx
				dec ecx
			jnz Reversor
				mov byte ptr[edi+ebx], 0
		Ret
lstrRev endp

  @exit:
	PUSH 0
	CALL ExitProcess
	
end start