.686
.model flat,stdcall
option casemap:none

include NFO Viewer V2.inc

.code
start:
invoke GetModuleHandle,NULL
mov hInstance,eax

invoke LoadIcon,hInstance,300
mov hIcon,eax
invoke LoadCursor,hInstance,400
mov hCursor,eax

call Initialize

invoke InitCommonControls
invoke DialogBoxParam,hInstance,NFODLG,0,addr NFOProc,0
invoke CloseHandle,hFile
invoke CloseHandle,hFileMap
invoke UnmapViewOfFile,hViewMap
invoke DeleteObject,hpen
invoke DeleteObject,hBgColor
invoke DeleteObject,hFontTitle
invoke DeleteObject,hNFOFont
invoke ExitProcess,NULL

Initialize	proc
invoke CreateSolidBrush,COLORDLG
mov hBgColor,eax
mov hpen,FUNC(CreatePen,PS_SOLID,0,COLORPEN)

mov hFontTitle,FUNC(CreateFont,13, 0, 0, 0, FW_NORMAL, 0, 0, 0, 0, 0, 0, 0, 0, SADD(TITLEFONT))  
mov hFontAbout,FUNC(CreateFont,13, 0, 0, 0, FW_NORMAL, 0, 0, 0, 0, 0, 0, 0, 0, SADD(ABOUTFONT))
invoke CreateFontIndirect,addr NFOFont
mov hNFOFont,eax

invoke CreateFile,addr szNFOName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
cmp eax,-1
je @F
mov hFile,eax
invoke CreateFileMapping,eax,0,PAGE_READONLY,0,0,0
mov hFileMap,eax
invoke MapViewOfFile,eax,FILE_MAP_READ,0,0,0
mov hViewMap,eax
invoke GetFileSize,hFile,0
mov hFileSize,eax
ret

@@:
invoke MessageBox,0,chr$("IRC.nFO tidak ditemukan!"),chr$("Whatz the hell !"),MB_ICONERROR
invoke ExitProcess,NULL
	Ret
Initialize EndP

NFOProc	proc	hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
LOCAL	ps:PAINTSTRUCT
LOCAL	hdc:HDC
LOCAL	Wwd:DWORD
LOCAL	Wht:DWORD
LOCAL	Wtx:DWORD
LOCAL	Wty:DWORD

push hWnd
pop hWND

.if uMsg == WM_INITDIALOG
invoke SetWindowText,hWnd,chr$("IRC nFO Viewer V2b")
mov Wwd, 525
mov Wht, 400

invoke GetSystemMetrics,SM_CXSCREEN
invoke TopXY,Wwd,eax
mov Wtx, eax

invoke GetSystemMetrics,SM_CYSCREEN
invoke TopXY,Wht,eax
mov Wty, eax

invoke MoveWindow,hWnd,Wtx,Wty,Wwd,Wht,TRUE
invoke SetWindowPos,hWnd,HWND_TOPMOST,0,0,0,0,SWP_NOMOVE + SWP_NOSIZE
invoke GetParent,hWnd
invoke GetClientRect,hWnd,ADDR AboutRect
mov hdc,FUNC(GetDC,hWnd)
mov chdc,FUNC(CreateCompatibleDC,hdc)
mov hbmp,FUNC(CreateCompatibleBitmap,hdc,AboutRect.right,AboutRect.bottom)
invoke SelectObject,chdc,hbmp
m2m rClientAbout.right,AboutRect.right
m2m rClientAbout.bottom,AboutRect.bottom

invoke FillRect,chdc,ADDR AboutRect,hBgColor
invoke FrameRect,chdc,ADDR rClientAbout,hpen
invoke SelectObject,chdc,hpen
invoke MoveToEx,chdc,rClientAbout.left,19,NULL
invoke LineTo,chdc,rClientAbout.right,19

invoke SetTextColor,chdc,COLORCAPTION
invoke SetBkColor,chdc,hBgColor
invoke SetBkMode,chdc,TRANSPARENT
invoke SelectObject,chdc,hFontTitle

mov rClientAbout.bottom,SIZEOFTITLEBAR
invoke DrawText,chdc,addr szHeader,-1,ADDR rClientAbout,DT_CENTER or DT_SINGLELINE or DT_VCENTER or DT_NOCLIP

inc rClientAbout.left
dec rClientAbout.right
m2m rClientAbout.bottom,AboutRect.bottom
sub rClientAbout.bottom,SIZEOFTITLEBAR
add rClientAbout.top,SIZEOFTITLEBAR
add rClientAbout.top,22

mov edi,rClientAbout.top
dec edi
invoke MoveToEx,chdc,rClientAbout.left,edi,NULL
invoke LineTo,chdc,rClientAbout.right,edi

mov edi,rClientAbout.bottom
invoke MoveToEx,chdc,rClientAbout.left,edi,NULL
invoke LineTo,chdc,rClientAbout.right,edi

sub rClientAbout.bottom,22
mov edi,rClientAbout.bottom
invoke MoveToEx,chdc,rClientAbout.left,edi,NULL
invoke LineTo,chdc,rClientAbout.right,edi

push rClientAbout.bottom
add rClientAbout.bottom,380
invoke DrawText,chdc,addr szFooter,-1,ADDR rClientAbout,DT_SINGLELINE or DT_VCENTER or DT_NOCLIP
pop rClientAbout.bottom

invoke FindResource,hInstance,600,RT_RCDATA
mov hResInfo,eax
invoke LoadResource,hInstance,hResInfo
mov hResData,eax
invoke SizeofResource,hInstance,hResInfo
mov hResSize,eax
invoke LockResource,hResData
mov hRgnData,eax
invoke ExtCreateRegion,NULL,hResSize,hRgnData
invoke SetWindowRgn,hWnd,eax,TRUE

invoke IntersectClipRect,chdc,rClientAbout.left,rClientAbout.top,rClientAbout.right,rClientAbout.bottom

invoke SelectObject,hdc,hNFOFont
invoke DrawText,hdc,hViewMap,-1,ADDR rScroll,DT_CALCRECT + DT_NOPREFIX + DT_TOP + DT_NOCLIP

m2m rScroll.right,rClientAbout.right
sub rScroll.right,5
add rScroll.top,GETV(rClientAbout.bottom)
add rScroll.bottom,eax	

invoke ReleaseDC,hWnd,hdc	

mov TimerID,FUNC(SetTimer,hWnd,IDC_TIMER,SCROLLSPEED,NULL)
mov ID,1

.elseif uMsg ==  WM_KEYDOWN
mov eax,wParam
.if eax == VK_ADD || eax ==  0BBh
cmp Speed,5
je @F
sub Speed,5
mov eax,Speed
mov SpeedCp,eax
mov TimerID,FUNC(SetTimer,hWnd,IDC_TIMER,Speed,NULL)
@@:

.elseif eax == VK_SUBTRACT || eax == 0BDh
cmp Speed,50
je @F
add Speed,5
mov eax,Speed
mov SpeedCp,eax
mov TimerID,FUNC(SetTimer,hWnd,IDC_TIMER,Speed,NULL)
@@:

.elseif eax == VK_X
invoke SendMessage,hWnd,WM_CLOSE,0,0

.elseif eax == VK_P
cmp ID,0
je @jalan
mov Speed,0fffffffh
mov TimerID,FUNC(SetTimer,hWnd,IDC_TIMER,Speed,NULL)
mov ID,0
jmp @f
@jalan:
mov Speed,0
mov eax,SpeedCp
add Speed,eax
mov TimerID,FUNC(SetTimer,hWnd,IDC_TIMER,Speed,NULL)
mov ID,1
@@:

.endif

.elseif uMsg == WM_PAINT
invoke BeginPaint,hWnd,addr ps
mov hdc,eax
invoke FillRect,chdc,ADDR rScroll,hBgColor
invoke SelectObject,chdc,hNFOFont
invoke DrawText,chdc,hViewMap,-1,ADDR rScroll,DT_TOP + DT_NOPREFIX + DT_NOCLIP
invoke BitBlt,hdc,0,0,AboutRect.right,AboutRect.bottom,chdc,0,0,SRCCOPY
invoke EndPaint,hWnd,addr ps

.elseif uMsg == WM_CTLCOLORDLG
return hBgColor

.elseif uMsg == WM_TIMER
add rScroll.top,GETV(ScrollOffset)
add rScroll.bottom,eax
.if SDWORD PTR rScroll.top >= GETV(rClientAbout.bottom)
mov ScrollOffset,-1
invoke SetTextColor,chdc,COLORTEXT
.else
.if SDWORD PTR rScroll.bottom <= GETV(rClientAbout.top)
mov ScrollOffset,1
invoke SetTextColor,chdc,COLORTEXT2
.endif
.endif
invoke InvalidateRect,hWnd,NULL,FALSE

.elseif uMsg == WM_RBUTTONDBLCLK
invoke SetCursor,hCursor

.elseif uMsg == WM_RBUTTONUP
invoke SetCursor,hCursor

.elseif uMsg == WM_LBUTTONDBLCLK
invoke SetCursor,hCursor

.elseif uMsg == WM_RBUTTONDOWN
invoke SetCursor,hCursor

.elseif uMsg==WM_LBUTTONDOWN
invoke SetCursor,hCursor
mov MoveDlg,TRUE
invoke SetCapture,hWnd
invoke GetCursorPos,addr OldPos
		
.elseif uMsg==WM_MOUSEMOVE
invoke SetCursor,hCursor
.if MoveDlg==TRUE
invoke GetWindowRect,hWnd,addr Rect
invoke GetCursorPos,addr NewPos
mov eax,NewPos.x
mov ecx,eax
sub eax,OldPos.x
mov OldPos.x,ecx
add eax,Rect.left
mov ebx,NewPos.y
mov ecx,ebx
sub ebx,OldPos.y
mov OldPos.y,ecx
add ebx,Rect.top
mov ecx,Rect.right
sub ecx,Rect.left
mov edx,Rect.bottom
sub edx,Rect.top
invoke MoveWindow,hWnd,eax,ebx,ecx,edx,TRUE
.endif
		
.elseif uMsg==WM_LBUTTONUP
invoke SetCursor,hCursor
mov MoveDlg,FALSE
invoke ReleaseCapture

.elseif uMsg == WM_MBUTTONDBLCLK
invoke SetCursor,hCursor

.elseif uMsg == WM_MBUTTONDOWN
invoke SetCursor,hCursor

.elseif uMsg == WM_MBUTTONUP
invoke SetCursor,hCursor

.elseif uMsg == WM_CLOSE
mov rScroll.top,0
mov rScroll.bottom,0
mov rScroll.left,0
mov rScroll.right,0
invoke DeleteDC,chdc
invoke DeleteObject,hbmp
invoke KillTimer,hWnd,TimerID
invoke EndDialog,hWnd,NULL

.else
  return FALSE
.endif
  return TRUE
  xor eax,eax 
	Ret
NFOProc EndP

TopXY proc wDim:DWORD, sDim:DWORD

    shr sDim, 1      ; divide screen dimension by 2
    shr wDim, 1      ; divide window dimension by 2
    mov eax, wDim    ; copy window dimension into eax
    sub sDim, eax    ; sub half win dimension from half screen dimension

    return sDim

TopXY endp
end start