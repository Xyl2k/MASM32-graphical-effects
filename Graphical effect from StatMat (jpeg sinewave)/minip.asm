;**************************************************
; StatMat's Mini-Patch v1.2
; Change, alter, and distrubute as you see fit. ;)
;**************************************************

.386
.model flat, stdcall
option casemap :none   ; case sensitive

include \masm32\include\windows.inc 
include \masm32\include\masm32.inc
include \masm32\macros\macros.asm
include \masm32\include\user32.inc 
include \masm32\include\kernel32.inc
include \masm32\include\comctl32.inc 
include \masm32\include\comdlg32.inc
include \masm32\include\gdi32.inc
include \masm32\include\shell32.inc
include \masm32\include\oleaut32.inc
include \masm32\include\ole32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\user32.lib 
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\comctl32.lib 
includelib \masm32\lib\comdlg32.lib 
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\shell32.lib
includelib \masm32\lib\oleaut32.lib
includelib \masm32\lib\ole32.lib

include crc32.inc
include mfmplayer.inc
include patch.inc
include BmpFrom.inc

includelib mfmplayer.lib

    WndProc          PROTO :DWORD,:DWORD,:DWORD,:DWORD
    HyperLinkWndProc PROTO :DWORD,:DWORD,:DWORD,:DWORD
    DrawItem         PROTO :HWND,:LPARAM

.const
    MAXSIZE             equ 261
    MUTEX_ALL_ACCESS    equ STANDARD_RIGHTS_REQUIRED+SYNCHRONIZE+MUTANT_QUERY_STATE
 
    GfxCharWidth        equ 16
    NumStars            equ 140

.data
    szTitle      db " [ Team MatStat ]",0
    szPName      db "[ App Name ]",0
    szTgtFile    db "[ Target File ]",0
    szFileSize   db "[ File Size && CRC32 ]",0
    szStatus     db "[ Status ]",0
    szCrack      db "&Crack",0
    szRstore     db "&Restore",0
    szExit       db "&Exit",0
    szSizeCRC    db "%d bytes  -  0x%08X",0
    szTheFile    db "The file %s",0
    szWrongSize  db "size is incorrect!",0
    szCracked    db "is already cracked!",0
    szUncracked  db "is already uncracked!",0
    szReadOnly   db "is read-only!",0
    szWrongCRC   db "CRC32 is incorrect!",0
    szCannotOpen db "cannot be opened to patch!",13,"File already open!",0
    szPatchedOK  db "was successfully patched!",0
    szFileOnCD   db "is on CDROM!",0
    szOpen       db "open",0
    dlgname      db "M",0

    ; Open file dialog stuff
    szOpenTitle  db "Choose target file",0
    FiltFormat   db "%s%c%s%c%c",0
    FiltString   db MAXSIZE dup(0)
    FileName     db MAXSIZE dup(0)
    ofn          OPENFILENAME <>

    ; Colour settings in the form BBGGRR
    ; Group box colour settings
    GBTextCol    dd 000000FFh
    GBBackCol    dd 00C5C5C5h

    ; Static text/Edit box colours
    STEBTextCol  dd 00FF0000h
    STEBBackCol  dd 00FFAA89h

    ; Dialog background colour
    DlgBGCol     dd 008FBCB9h

    ; Scroller stuff
    ScrollYPos   dd 298         ; Scroller's Y position on the dialog
    ScrollSpeed  dd 10         ; Timeout (in milliseconds) for scroller update
	  frequency	   real4 25.0
	  amplitude	   real4 10.0
    rectScroll   RECT <-(GfxCharWidth + 1),0,270,52>
	  ScrollLenPixels dd 0
	  chrmap       db "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789""'(),.;:+-!?*",0
    StarList     dd 0
    MoveStarsNow dd 0

    ; Logo stuff
    LogoWidth    dd 260
    LogoHeight   dd 70
    dwX          dd 0
    dwY          dd 0
	  logofrequency	   real4 15.0
	  logoamplitude	   real4 3.0
    rectLogo     RECT <0,0,270,78>

    LogBrush     LOGBRUSH <>
    LFont        LOGFONT <>
    rect         RECT <>

    Hyperlink db 0

.data?
    hInstance    dd ?
    hFinger      dd ?
    hDlgBGBrush  dd ?
    hParentWnd   dd ?
    hWndHL       dd ?
    hSTEBBGCol   dd ?
    hHyperlinkBGCol dd ?

    ; Logo stuff
    hLogoBmp     dd ?
    hDCLogo      dd ?
    hOldLogo     dd ?  
    hBuf         dd ?
    hDCBuf       dd ?
    hOldBuf      dd ?
    hBuf2        dd ?
    hDCBuf2      dd ?
    hOldBuf2     dd ?

    ; Scroller stuff
    hDC          dd ?
    hDCScroll    dd ?
    hBmp         dd ?
    hOld         dd ?
    hOldGfxBmp   dd ?
    dwScrollX    dd ?
    hDCGfxScroll dd ?
    hGfxScrollBmp dd ?

    ; XM Music stuff
    pMusic       LPVOID    ?
    nMusicSize   DWORD     ?

    ; Owner drawn buttons stuff
    szBtnText    TCHAR     16 dup(?)
    hButBmp      dd ?
    hButBrush    dd ?
    hButPressBmp dd ?
    hButPressBrush dd ?   

Star STRUCT
  x SDWORD ?
  y SDWORD ?
  speed SDWORD ?
  colour SDWORD ?
Star ends

.code

start:

    invoke GetModuleHandle,NULL
    mov hInstance,eax
    invoke InitCommonControls
    invoke CoInitialize,NULL

    ; Load the XM music
    push esi
    invoke FindResource,hInstance,70,RT_RCDATA
    push eax
    invoke SizeofResource,hInstance,eax
    mov nMusicSize,eax
    pop eax
    invoke LoadResource,hInstance,eax   
    invoke LockResource,eax
    mov esi,eax
    mov eax,nMusicSize
    add eax,SIZEOF nMusicSize
    invoke GlobalAlloc,GPTR,eax
    mov pMusic,eax
    mov ecx,nMusicSize
    mov dword ptr [eax],ecx
    add eax,SIZEOF nMusicSize
    mov edi,eax
    rep movsb
    pop esi

    invoke DialogBoxParam,hInstance,ADDR dlgname,0,ADDR WndProc,0  ; load the main window

    invoke CoUninitialize           ; all done with COM

    ; ret won't do here, as we need to make sure the threads
    ; created for the browse for file dialog get killed
    invoke ExitProcess,eax

WndProc proc hWnd:HWND,uMsg:DWORD,wParam:DWORD,lParam:DWORD
    LOCAL hFile:HFILE
    LOCAL BytesWritten:DWORD
    LOCAL hFind:HANDLE
    LOCAL ff32:WIN32_FIND_DATA
    LOCAL buffer[512]:byte
    LOCAL off_set:DWORD
    LOCAL pFileMem:DWORD

    .if uMsg == WM_INITDIALOG
        invoke OpenMutex,MUTEX_ALL_ACCESS,FALSE,ADDR szProgName

        ; This is the only instance of the app
        .if eax == 0
	          invoke CreateMutex,0,FALSE,ADDR szProgName

            mov eax,hWnd
            mov hParentWnd,eax                              ; Store the main window handle for global use

            invoke BmpFromResource,hInstance,50             ; Load logo bitmap into memory
            mov hLogoBmp,eax                                ; Save it's handle
        
            invoke BmpFromResource,hInstance,90             ; Load button bitmap into memory
            mov hButBmp,eax                                 ; Save it's handle
        
            invoke BmpFromResource,hInstance,91             ; Load button pressed bitmap into memory
            mov hButPressBmp,eax                            ; Save it's handle
        
            invoke BmpFromResource,hInstance,100            ; Load scroll text bitmap into memory
            mov hGfxScrollBmp,eax                           ; Save it's handle

            ; Set the groupbox and pushbutton texts. Done here in the code instead of resource
            ; file to reduce the required bytes (strings in the rc file are UNICODE not ANSI)
            invoke SetDlgItemText,hWnd,10,ADDR szPName
            invoke SetDlgItemText,hWnd,11,ADDR szTgtFile
            invoke SetDlgItemText,hWnd,12,ADDR szFileSize
            invoke SetDlgItemText,hWnd,14,ADDR szStatus
            invoke SetDlgItemText,hWnd,41,ADDR szCrack
            invoke SetDlgItemText,hWnd,42,ADDR szRstore
            invoke SetDlgItemText,hWnd,43,ADDR szExit

            invoke wsprintf,ADDR buffer,ADDR szSizeCRC,TargetSize,BeforeCRC32

            ; Update the static texts
            invoke SetDlgItemText,hWnd,20,ADDR szProgName
            invoke SetDlgItemText,hWnd,21,ADDR szFileName
            invoke SetDlgItemText,hWnd,22,ADDR buffer
            invoke CreateSolidBrush,STEBBackCol
            mov hSTEBBGCol,eax
            invoke CreateSolidBrush,STEBTextCol
            mov hHyperlinkBGCol,eax
    
            invoke LoadIcon,hInstance,60                    ; Load icon from the resources
            invoke SendMessage,hWnd,WM_SETICON,0,eax        ; Set it on the title bar
    
            ; Won't work under 95, but who cares right?
            invoke LoadCursor,NULL,IDC_HAND                 ; Load finger cursor into memory
            mov hFinger,eax                                 ; Save it's handle
    
            invoke SetWindowText,hWnd,ADDR szTitle          ; Set the window title text
    
            invoke GetDlgItem,hWnd,20                                     ; Get the handle of our item
            mov hWndHL,eax                                                ; Save it
            invoke SetWindowLong,hWndHL,GWL_WNDPROC,ADDR HyperLinkWndProc ; subclass our static window
            invoke SetWindowLong,hWndHL,GWL_USERDATA,eax                  ; Set new value
    
            ; Setup the filter string for the open file dialog
    		    invoke wsprintf,ADDR FiltString,ADDR FiltFormat,ADDR szFileName,0,ADDR szFileName,0,0
    
            ; Setup up our brush for the dialog background colour
            mov eax,DlgBGCol
            mov LogBrush.lbColor,eax
            invoke CreateBrushIndirect,ADDR LogBrush
            mov hDlgBGBrush,eax
    
            ; Setup up our text scroller
            invoke SetTimer,hWnd,1,ScrollSpeed,0
        		invoke GetDC,hWnd
        		mov	hDC,eax
        		invoke CreateCompatibleDC,eax
        		mov	hDCScroll,eax
            invoke lstrlen,ADDR szScrollText
            imul eax,GfxCharWidth
            mov ScrollLenPixels,eax
            mov eax,rectScroll.right
            mov dwScrollX,eax
        		invoke CreateCompatibleBitmap,hDC,rectScroll.right,rectScroll.bottom
        		mov	hBmp,eax
        		invoke SelectObject,hDCScroll,eax
        		mov hOld,eax
        		invoke CreateCompatibleDC,hDC
        		mov	hDCGfxScroll,eax
        		invoke SelectObject,hDCGfxScroll,hGfxScrollBmp
        		mov hOldGfxBmp,eax

            ; Generate our stars
            invoke GlobalAlloc,GPTR,NumStars*SIZEOF Star
            mov StarList,eax
            push esi
            mov esi,eax
            assume esi: PTR Star
            invoke GetTickCount
            invoke nseed,eax
            mov off_set,0
            xor ecx,ecx
            .while ecx < NumStars
              invoke nrandom,rectScroll.right
              mov [esi].x,eax
              invoke nrandom,rectScroll.bottom          
              mov [esi].y,eax
              invoke nrandom,200
              xor edx,edx
              sub dl,al
              mov al,dl
              shl edx,8
              mov dl,al
              shl edx,8
              mov dl,al
              mov [esi].colour,edx
              and eax,3
              inc eax
              mov [esi].speed,eax
              inc off_set
              mov ecx,off_set
              add esi,SIZEOF Star
            .endw
            assume esi: NOTHING
            pop esi

            ; Setup the logo stuff
        		invoke CreateCompatibleDC,hDC
        		mov	hDCBuf,eax
        		invoke CreateCompatibleBitmap,hDC,280,90
        		mov	hBuf,eax
        		invoke SelectObject,hDCBuf,eax
        		mov hOldBuf,eax
        		invoke CreateCompatibleDC,hDC
        		mov	hDCBuf2,eax
        		invoke CreateCompatibleBitmap,hDC,280,90
        		mov	hBuf2,eax
        		invoke SelectObject,hDCBuf2,eax
        		mov hOldBuf2,eax
        		invoke CreateCompatibleDC,hDC
        		mov	hDCLogo,eax
        		invoke SelectObject,hDCLogo,hLogoBmp
        		mov hOldLogo,eax

            ; Create brushes for the ownerdraw buttons
	          invoke CreatePatternBrush,hButBmp
	          mov hButBrush,eax
	          invoke CreatePatternBrush,hButPressBmp
	          mov hButPressBrush,eax

            ; Init CRC32 table
   					call InitCRC32Table

            ; Start the music playing
            invoke mfmPlay,pMusic

        ; Another instance of the app is already running, so exit
        .else           
            invoke SendMessage,hWnd,WM_CLOSE,NULL,NULL
        .endif
              
    .elseif uMsg == WM_CTLCOLORSTATIC
        invoke GetWindowLong,lParam,GWL_ID

        ; Group boxes
        .if eax < 15
            invoke SetTextColor,wParam,GBTextCol
            invoke SetBkColor,wParam,GBBackCol
            invoke GetStockObject,HOLLOW_BRUSH

        ; Edit and static boxes
        .else
            .if eax == 20 && Hyperlink == 1
                invoke SetBkColor,wParam,STEBTextCol
                invoke SetTextColor,wParam,STEBBackCol
                mov eax,hHyperlinkBGCol
            .else 
                invoke SetBkColor,wParam,STEBBackCol
                invoke SetTextColor,wParam,STEBTextCol
                mov eax,hSTEBBGCol
            .endif
        .endif
        ret
         
    .elseif uMsg == WM_COMMAND

        ; Crack/Restore buttons
        .if wParam == 41 || wParam == 42

            ; File has not yet been selected
            .if dword ptr [FileName] == 0
		            mov ofn.lStructSize,SIZEOF ofn 
		            mov eax,hWnd 
		            mov ofn.hwndOwner,eax
		            mov ofn.lpstrFilter, OFFSET FiltString
		            mov ofn.lpstrFile, OFFSET FileName
		            mov ofn.nMaxFile,MAXSIZE-1
		            mov ofn.Flags, OFN_FILEMUSTEXIST or OFN_NONETWORKBUTTON or \ 
		                OFN_PATHMUSTEXIST or OFN_LONGNAMES or \ 
		                OFN_EXPLORER or OFN_HIDEREADONLY
		            mov ofn.lpstrTitle, OFFSET szOpenTitle
		            invoke GetOpenFileName, ADDR ofn
		            .if eax
		                invoke GetPathOnly,ADDR FileName,ADDR buffer
		                invoke GetDriveType,ADDR buffer
		                
		                ; The selected file is on CD-ROM!
		                .if eax == DRIVE_CDROM
		                    invoke wsprintf,ADDR buffer,ADDR szTheFile,ADDR szFileOnCD
		                 		invoke SetDlgItemText,hWnd,23,ADDR buffer
		                    mov dword ptr [FileName],0
		                .endif
		            .endif           		
            .endif

            invoke FindFirstFile,ADDR FileName,ADDR ff32

            .if eax != INVALID_HANDLE_VALUE
                mov eax,TargetSize

                ; File size is incorrect
                .if ff32.nFileSizeLow != eax
                    invoke wsprintf,ADDR buffer,ADDR szTheFile,ADDR szWrongSize

                ; Filesize is correct
                .else
                    mov pFileMem,InputFile(ADDR FileName) ; load the file into memory
                    invoke CRC32,pFileMem,ff32.nFileSizeLow
                    
                    ; Crack button
                    .if wParam == 41
                        mov edx,BeforeCRC32
                    ; Restore button
                    .else
                        mov edx,AfterCRC32
                    .endif

                    ; Calculated CRC32 does not match
                    .if eax != edx
                        ; File is already cracked
                        .if wParam == 41 && eax == AfterCRC32
                            mov ecx,OFFSET szCracked

                        ; File is already uncracked
                        .elseif eax == BeforeCRC32
                            mov ecx,OFFSET szUncracked

                        ; File is corrupted/wrong in some way
                        .else
                            mov ecx,OFFSET szWrongCRC
                        .endif

                        invoke wsprintf,ADDR buffer,ADDR szTheFile,ecx
                    .else
                        ;mov eax,1

                        ; The file is read-only, so let's try to set it to read/write
                        ;.if ff32.dwFileAttributes & FILE_ATTRIBUTE_READONLY
                            invoke SetFileAttributes,ADDR FileName,FILE_ATTRIBUTE_NORMAL
                        ;.endif
        
                        ; File is read-only, and we could not remove the attribute
                        .if !eax
                            invoke wsprintf,ADDR buffer,ADDR szTheFile,ADDR szReadOnly

                        ; Everything's okay, so let's patch the file
                        .else
                            invoke CreateFile,ADDR FileName,GENERIC_WRITE,FILE_SHARE_WRITE,\
                                              NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL
                            mov hFile,eax
                        
                            .if hFile != INVALID_HANDLE_VALUE
                                ; Start patches to the file
                                mov off_set,0
                                xor ebx,ebx ; Used to step through patch len array
        
                                .while PRPos[ebx] != -1
                                    invoke SetFilePointer,hFile,PRPos[ebx],NULL,FILE_BEGIN
        
                                    .if wParam == 41
                                        mov ecx,OFFSET szPatch
                                    .else
                                        mov ecx,OFFSET szRestore                                
                                    .endif
        
                                    add ecx,off_set
                                    invoke WriteFile,hFile,ecx,PRLen[ebx],ADDR BytesWritten,NULL
        
                                    mov eax,PRLen[ebx]
                                    add off_set,eax
                                    add ebx,sizeof DWORD
                                .endw
                                ; End patches to the file
        
                                invoke SetFileTime,hFile,ADDR (ff32.ftLastWriteTime),\
                                                   ADDR (ff32.ftLastWriteTime),\
                                                   ADDR (ff32.ftLastWriteTime)
    
                                invoke CloseHandle,hFile
    
                                invoke wsprintf,ADDR buffer,ADDR szTheFile,ADDR szPatchedOK
    
                            ; File is already open
                            .else
                                invoke wsprintf,ADDR buffer,ADDR szTheFile,ADDR szCannotOpen
                            .endif

                            ; Make sure the original file attributes are restored
                            invoke SetFileAttributes,ADDR FileName,ff32.dwFileAttributes
                        .endif
                    .endif
                    
                    ; Free up the in-memory file used for CRC32 calc
                    free pFileMem
                .endif

            		invoke SetDlgItemText,hWnd,23,ADDR buffer
            .endif

        ; Exit button, so send a close message
        .elseif wParam == 43
            invoke SendMessage,hWnd,WM_CLOSE,NULL,NULL
        .endif

    .elseif uMsg == WM_ERASEBKGND
        invoke GetClientRect,hWnd,ADDR rect
        invoke FillRect,wParam,ADDR rect,hDlgBGBrush
        ret

    ; Use the HTCAPTION trick to allow dragging of the window
    .elseif uMsg == WM_LBUTTONDOWN
        invoke SendMessage,hWnd,WM_NCLBUTTONDOWN,HTCAPTION,lParam
    
    ; To paint our ownerdraw buttons
    .elseif uMsg == WM_DRAWITEM
        invoke DrawItem,hWnd,lParam

    ; Update our text scroller and logo
    .elseif uMsg == WM_TIMER
    	  mov	eax,dwScrollX

    	  add eax,ScrollLenPixels
        dec dwScrollX
    	  cmp	eax,0
    	  jge	@@skip
        mov eax,rectScroll.right

    		mov	dwScrollX,eax
    	@@skip:
        invoke GetStockObject,BLACK_BRUSH
		    invoke FillRect,hDCScroll,ADDR rectScroll,eax

        ; Draw stars
        push esi
        mov esi,StarList
        assume esi: PTR Star
        xor ebx,ebx
        .while ebx < NumStars
          .if MoveStarsNow == 1
            mov eax,[esi].speed
            add [esi].x,eax
          .endif
          mov eax,rectScroll.right
          .if [esi].x > eax
            mov [esi].x,0
          .endif
          invoke SetPixel,hDCScroll,[esi].x,[esi].y,[esi].colour
          inc ebx
          add esi,SIZEOF Star
        .endw
        assume esi: NOTHING
        .if MoveStarsNow == 1
          mov MoveStarsNow,0
        .else
          inc MoveStarsNow
        .endif

    		push edi
    		mov	esi,OFFSET rectScroll
    		mov	edi,OFFSET rect
    		mov	ecx,sizeof rect shr 2
    		rep	movsd
    		mov	esi,OFFSET szScrollText
    	  mov eax,dwScrollX
    	  mov rect.left,eax

      @@more:
    	  mov eax,rectScroll.left
    	  mov ecx,rectScroll.right
        .if SDWORD PTR rect.left >= eax && SDWORD PTR rect.left <= ecx
      		mov al,byte ptr [esi]
      		mov ebx,OFFSET chrmap
      		xor ecx,ecx
          .while byte ptr [ebx] != al
            inc ecx
 		        inc ebx
 		      .endw
          imul ecx,GfxCharWidth
          mov off_set,ecx
          mov pFileMem,0
          xor ecx,ecx

          .while ecx < GfxCharWidth
        		fild rect.left
        		fild dwScrollX
        		fadd
        		fdiv frequency
        		fsin
        		fmul amplitude
        		fild rectScroll.top
        		fadd
        		fistp rect.top
        		add rect.top,10 ; magic Y value for this font - should be tidied...
  	        invoke BitBlt,hDCScroll,rect.left,rect.top,1,rectScroll.bottom,hDCGfxScroll,off_set,0,SRCPAINT
      		  inc rect.left
      		  inc off_set
      		  inc pFileMem
      		  mov ecx,pFileMem
      	  .endw
        .else
    		  add rect.left,GfxCharWidth
    		.endif
    		inc	esi
    		cmp byte ptr [esi],0
    		jne @@more
    		pop	edi
    		pop	esi

		    invoke BitBlt,hDC,0,ScrollYPos,rect.right,rectScroll.bottom,hDCScroll,0,0,SRCCOPY

  		  invoke FillRect,hDCBuf,ADDR rectLogo,hDlgBGBrush
  		  invoke FillRect,hDCBuf2,ADDR rectLogo,hDlgBGBrush
        inc dwX
        mov eax,logofrequency
		    .if dwX == eax
		      mov dwX,0
		    .endif
  
        xor ecx,ecx
        mov off_set,0
        .while ecx < 260
      		fild dwX
      		fild off_set
      		fadd
      		fdiv logofrequency
      		fsin
      		fmul logoamplitude
      		fistp dwY
      		add dwY,3
	        invoke BitBlt,hDCBuf,off_set,dwY,1,LogoHeight,hDCLogo,off_set,0,SRCCOPY
    		  inc off_set
    		  mov ecx,off_set
    	  .endw

        xor ecx,ecx
        mov off_set,0
        .while ecx < 78
      		fild dwX
      		fild off_set
      		fadd
      		fdiv logofrequency
      		fsin
      		fmul logoamplitude
      		fistp dwY
      		add dwY,5
	        invoke BitBlt,hDCBuf2,dwY,off_set,LogoWidth,1,hDCBuf,0,off_set,SRCCOPY
    		  inc off_set
    		  mov ecx,off_set
    	  .endw

		    invoke BitBlt,hDC,0,0,rectLogo.right,rectLogo.bottom,hDCBuf2,0,0,SRCCOPY

    .elseif uMsg == WM_DESTROY
        invoke GlobalFree,StarList
        invoke SelectObject,hDCGfxScroll,hOldGfxBmp
        invoke SelectObject,hDCScroll,hOld
        invoke SelectObject,hDCBuf,hOldBuf
        invoke SelectObject,hDCBuf2,hOldBuf2
        invoke SelectObject,hDCLogo,hOldLogo
        invoke DeleteObject,hLogoBmp
        invoke DeleteObject,hBuf
        invoke DeleteObject,hBuf2
        invoke DeleteObject,hGfxScrollBmp
        invoke DeleteObject,hDlgBGBrush
        invoke DeleteObject,hButPressBrush
        invoke DeleteObject,hButPressBmp
        invoke DeleteObject,hButBrush
        invoke DeleteObject,hButBmp     
        invoke DeleteObject,hBmp
        invoke DeleteObject,hSTEBBGCol
        invoke DeleteDC,hDCGfxScroll
        invoke DeleteDC,hDCScroll
        invoke DeleteDC,hDCLogo
        invoke DeleteDC,hDCBuf
        invoke DeleteDC,hDCBuf2
        invoke ReleaseDC,hWnd,hDC

    .elseif uMsg == WM_CLOSE
;        invoke mfmPlay,0          ; Stop the music
        invoke GlobalFree,pMusic  ; Free the memory used for the music
        invoke EndDialog,hWnd,0   ; end the program
    .endif
    
    xor eax,eax 
    ret
WndProc endp

HyperLinkWndProc PROC hWnd:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
LOCAL pt:POINT
    .if uMsg == WM_NCHITTEST
        mov eax,1 ; We want to handle the non client hit test so we return true or 1
        ret

    .elseif uMsg == WM_LBUTTONDOWN
        dec Hyperlink
        invoke ShowWindow,hParentWnd,SW_MINIMIZE
        invoke ShellExecute, NULL, OFFSET szOpen, OFFSET szDownLoad,\
                             NULL, NULL, SW_SHOWNORMAL

    .elseif uMsg == WM_SETCURSOR
        invoke SetCursor,hFinger

    .elseif uMsg == WM_MOUSEMOVE
        invoke GetCapture
        .if hWnd != eax
            inc Hyperlink
            invoke InvalidateRect,hWnd,0,0
            invoke SetCapture,hWnd
        .else
            invoke GetWindowRect,hWnd,ADDR rect
            movzx eax,WORD PTR [lParam]
            mov pt.x,eax
            movzx eax,WORD PTR [lParam+2]
            mov pt.y,eax

            invoke ClientToScreen,hWnd,ADDR pt
            invoke PtInRect,ADDR rect,pt.x,pt.y
            
            .if !eax
                dec Hyperlink
                invoke InvalidateRect,hWnd,0,0
                invoke ReleaseCapture
            .endif
        .endif        

    .else
        invoke GetWindowLong, hWnd, GWL_USERDATA 
        invoke CallWindowProc, eax, hWnd, uMsg, wParam, lParam 
    .endif    

    xor eax,eax
    ret
HyperLinkWndProc endp

; Function to draw the custom buttons
DrawItem PROC hWnd: HWND, lParam: LPARAM

    push esi
    mov esi,lParam
    assume esi: ptr DRAWITEMSTRUCT
    
    .if [esi].itemState & ODS_SELECTED
       invoke FillRect,[esi].hdc,ADDR [esi].rcItem,hButPressBrush
    .else
       invoke FillRect,[esi].hdc,ADDR [esi].rcItem,hButBrush
    .endif

    .if [esi].itemState & ODS_SELECTED
      invoke OffsetRect,ADDR [esi].rcItem,1,1
    .endif
    
    ; Write the text
    invoke GetDlgItemText,hWnd,[esi].CtlID,ADDR szBtnText,SIZEOF szBtnText
    invoke SetBkMode,[esi].hdc,TRANSPARENT
    invoke DrawText,[esi].hdc,ADDR szBtnText,-1,ADDR [esi].rcItem,DT_CENTER or DT_VCENTER or DT_SINGLELINE
    
    assume esi:nothing
    pop esi

    xor eax,eax
    inc eax
    ret
DrawItem ENDP

end start
