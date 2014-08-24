;                                                                           
;[= THE ===========================================================================]  
;[] _________ ____   ____ _______  _____  _____  _____                 ____  ____ []  
;[] \       / \   | |   / \      \ \    \ \    \ \    \     /\     /\  \   \/   / []  
;[] /   ___/   |  | |  |   |   > / /   > \ |  > \ |    \   /  \   /  \  |      |  []  
;[] \   \___   |  |_|  |   |   > \ \  ___/ | |  / |  >  \ / /\ \ / /\ \ | |\/| |  []  
;[]  \____  \   \_   _/    |___  /  \___ \ |_|\ \ |___  / \__  / \__  / |_|  | |  []  
;[]       \/      | |          \/       \/     \/     \/     \/     \/        \|  []  
;[=============== |/ =============================================== SYSTEMS ======]  
;                               Presents:
;                        NFO Viewer by tE! [TMG]
;                      Ripped/Modifed by CyberDoom
.686p
.mmx
.model flat,stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

INCLUDE    \masm32\INCLUDE\gdi32.inc
INCLUDELIB \masm32\LIB\gdi32.lib

RES_NFO=FALSE


scrl proto :dword



DlgProc   PROTO :DWORD,:DWORD,:DWORD,:DWORD
.data
include ida.asm
;include data3.inc
.data
nfo_rect     RECT <5, 0, 2f9h,139h>
lpszDiskFile db "CDS.NFO",0 
; char String[]
String		db 'NFO ViEWER',0          ; DATA XREF: DialogFunc+21Co

.DATA?


point_nfo dd ?

;hInstance dd ?
ps PAINTSTRUCT <?>

.CODE
include proc.inc
include proc2.inc
include proc4.inc
include dlg.inc
include proc3.inc
include proc5.inc

include scrl.inc
start:
    

                           push    0Ch
                           push    offset unk_4076C0
                           call    sub_401D09
                          
                           push    0Ch
                           push    offset unk_4077E4
                           call    sub_401D09
                           push    0Ch
                           push    offset unk_407908
                           call    sub_401D09
                           push    9
                           push    offset unk_407A2C
                           call    sub_401D09
                           push    0Eh
                           push    offset unk_407B50
                           call    sub_401D09
                           push    0Ch
                           push    offset unk_407C74
                           call    sub_401D09
                           push    0Ch
                           push    offset unk_407D98
                           call    sub_401D09

     
     
     invoke GetModuleHandle,0
     mov hInstance,eax
     
     IF RES_NFO
     call GetRes
     ELSE
     call Get_from_file
     ENDIF
     
     
     invoke DialogBoxParam,hInstance,101,0,OFFSET DialogFunc,0
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
mov point_nfo,eax

ret 
		
GetRes endp		
ELSE

Get_from_file proc
                             
 LOCAL hFile$ :DWORD                            
 LOCAL ln    :DWORD
 LOCAL br    :DWORD                           
                              
             invoke CreateFile,addr lpszDiskFile,GENERIC_READ,FILE_SHARE_READ,\
                       NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL
                       
                       or eax,eax
                       jnz @F
                       ret
                      
                      @@: 
                       mov hFile$, eax
                              
 invoke GetFileSize,hFile$,NULL
    mov ln, eax

    .if ln > 32767
      invoke CloseHandle,hFile$
    
      xor eax, eax
      ret
    .endif      
        
    invoke	GlobalAlloc, GMEM_FIXED OR GMEM_ZEROINIT,ln
    
    mov point_nfo, eax

    invoke ReadFile,hFile$,point_nfo,ln,ADDR br,NULL                      
     invoke CloseHandle,hFile$                         
     ret                         
                              
Get_from_file endp
ENDIF

END start