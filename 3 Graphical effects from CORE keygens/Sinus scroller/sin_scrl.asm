;##########################################################################
.386
.model flat, stdcall
option casemap:none
title Scroller
;##########################################################################
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\gdi32.lib
include \masm32\macros\macros.asm
include crtdll.inc
includelib crtdll.lib



;##########################################################################
;##########################################################################
	hExStyle		equ			0
	hStyle			equ			WS_SYSMENU ;OR WS_MINIMIZEBOX
	dwWidth			equ			400
	dwHeight		equ			300
;##########################################################################
WndProc		PROTO	:DWORD,:DWORD,:DWORD,:DWORD
ExceptionFilter	PROTO	:DWORD
;##########################################################################
.const
	szAppTitle	db		"Sinus Scroll", 0
	szAppClass	db		"SCROLLER32", 0


	szError		db		"Error", 0
	szErrorFinal	db		"Error at %08Xh", 13, 10, "Quitting...", 0
	fnt		LOGFONT		<16, 0, 0, 0, FW_EXTRABOLD, 0, 0, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH OR FF_DONTCARE, "Courier">
	rcScrollerArea	RECT		<0, 0, dwWidth,50>
	frequency	real4		10.0
	amplitude	real4		08.5
;##########################################################################
.data
	wc		WNDCLASSEX	<sizeof WNDCLASSEX, CS_HREDRAW OR CS_VREDRAW, OFFSET WndProc, 0, 0, 0, 0, 0, 0, 0, OFFSET szAppClass, 0>

include bss.inc
include data.inc



;##########################################################################
.data?
	hFont		dd		?
	hDC		dd		?
	hDCScroller	dd		?
	hBmpScroller	dd		?
	ps		PAINTSTRUCT	<>
	x		dd		?
	szMessage	db		256 dup (?)
	seh		dd		6 dup (?)

	msg		MSG		<>
	data_start	equ		$
	mbp		MSGBOXPARAMS	<>
	rcScroller	RECT		<>
	rc		RECT		<>
	sz		SIZEL		<>
	data_size	equ		$ - data_start

	hbmp dd ?
	hbmp0 dd ?
	
	
	
	_hDC DWORD ?
    memDC DWORD ?
hWin dd ?
animwnd dd ?




;##########################################################################
.code
start:	

	invoke	GetModuleHandle, 0
	xor	ecx, ecx
	mov	[wc.hInstance], eax
	mov	[mbp.hInstance], eax
	push	ecx
	push	eax
	push	ecx
	push	ecx
	invoke	LoadIcon, eax, 2
	mov	[wc.hIcon], eax
	invoke	LoadImage, [wc.hInstance], 2, IMAGE_ICON, 16, 16, 0
	mov	[wc.hIconSm], eax
	invoke	LoadCursor, 0, IDC_ARROW
	mov	[wc.hCursor], eax
	invoke	GetStockObject, BLACK_BRUSH
	mov	[wc.hbrBackground], eax
	invoke	RegisterClassEx, ADDR wc
	push	dwHeight
	push	dwWidth
	invoke	GetSystemMetrics, SM_CYSCREEN
	sar	eax, 1
	sub	eax, dwHeight/2
	push	eax
	invoke	GetSystemMetrics, SM_CXSCREEN
	sar	eax, 1
	sub	eax, dwWidth/2
	push	eax
	push	hStyle
	push	OFFSET szAppTitle
	push	OFFSET szAppClass
	push	hExStyle

	call	CreateWindowEx	;invoke	CreateWindowEx, hExStyle, ADDR szAppClass, ADDR szAppTitle, hStyle, ecx, eax, dwWidth, dwHeight, 0, 0, [wc.hInstance], 0
	mov	[mbp.hwndOwner], eax
	push	eax
	invoke	ShowWindow, eax, SW_SHOW
	call	UpdateWindow

@@mloop:xor	eax, eax
	invoke	GetMessage, ADDR msg, eax, eax, eax
	test	eax, eax
	jz	@@mend
	mov	eax, OFFSET msg
	push	eax
	invoke	TranslateMessage, eax
	call	DispatchMessage
	jmp	@@mloop
@@mend:	invoke	ExitProcess, [msg.wParam]
;#########################################################################
WndProc proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
	
	
 var_14          = dword ptr -14h
 var_4           = dword ptr -4
 arg_0           = dword ptr  8
 arg_4           = dword ptr  0Ch
 arg_8           = word ptr  10h
	
	
	
	
	
	.if [uMsg]==WM_CREATE
		
		push hWnd
		pop hWin
		
		
	
		
		                 push offset fnt
		                 call    CreateFontIndirectA
                         mov     ds:dword_40201C, eax
                         ;push    29Ah
                         ;push    [ebp+arg_0]
                         ;call    GetDlgItem
                         
                         invoke CreateWindowEx,0,SADD("STATIC"),0, WS_CHILD or WS_VISIBLE ,\
                       60,210,345,100,hWnd,1000,[wc.hInstance],0
                         
                         
                         
                         
                         
                         mov     ds:dword_402020, eax
                         push    hWnd;[ebp+arg_0]
                         call    GetDC
                         mov     ds:dword_40207C, eax
                         push    ds:dword_40207C
                         call    CreateCompatibleDC
                         mov     ds:dword_402094, eax
                         push    ds:dword_40201C
                         push    ds:dword_402094
                         call    SelectObject
                         push    1
                         push    ds:dword_402094
                         call    SetBkMode
                         push    0FFh
                         push    ds:dword_402094
                         call    SetTextColor
                         push    dword_4030E4
                         call    lstrlenA
                         mov     edi, eax
                         push    offset dword_402008
                         push    edi
                         push    dword_4030E4
                         push    ds:dword_402094
                         call    GetTextExtentPoint32A
                         push    dword_4030DC
                         push    ds:dword_402008
                         push    ds:dword_40207C
                         call    CreateCompatibleBitmap
                         mov     ds:dword_402090, eax
                         push    ds:dword_402090
                         push    ds:dword_402094
                         call    SelectObject
                         mov     ds:dword_402000, 0
                         mov     ds:dword_402004, 0
                         mov     edi, dword_4030DC
                         mov     ds:dword_40200C, edi
                         ;push    0;0Fh
                         ;call    GetSysColorBrush
                         
                         invoke	GetStockObject,BLACK_BRUSH
                         
                         mov     edi, eax
                         push    edi
                         push    offset dword_402000
                         push    ds:dword_402094
                         call    FillRect
                         push    dword_4030E4
                         call    lstrlenA
                         mov     edi, eax
                         push    64h
                         push    offset dword_402000
                         push    edi
                         push    dword_4030E4
                         push    ds:dword_402094
                         call    DrawTextA
                         push    ds:dword_40207C
                         push    hWnd;[ebp+arg_0]
                         call    ReleaseDC
                         push    0
                         push    32h
                         push    1
                         push    [ebp+arg_0]
                         call    SetTimer
	
	
	
	.elseif [uMsg]==WM_TIMER
	
	                     sub     dword_4030E0, 2
                         mov     edi, dword_4030E0
                         cmp     edi, 0
                         jge     short loc_401524
                         push    dword_4030E0
                         call    abs
                         add     esp, 4
                         cmp     eax, ds:dword_402008
                         jle     short loc_401524
                         mov     edi, dword_4030D8
                         mov     dword_4030E0, edi
         
         loc_401524:                             ; CODE XREF: sub_4012F1+20Fj
                                                 ; sub_4012F1+225j
                         push    1
                         push    0
                         push    0
                         push    [ebp+arg_0]
                         call    RedrawWindow
	
	
	
	
	.elseif [uMsg]==WM_PAINT
		loc_401537:                             ; CODE XREF: sub_4012F1+Dj
                         lea     edi, ds:dword_402080
                         lea     esi, ds:dword_402000;402000h
                         mov     ecx, 10h
                         rep movsb
                         push    offset unk_402030
                         push    ds:dword_402020
                         call    BeginPaint
                         mov     ds:dword_40207C, eax
                         ;push    0;0Fh
                         ;call    GetSysColorBrush
                         invoke	GetStockObject,BLACK_BRUSH
                         
                         mov     edi, eax
                         push    edi
                         push    offset dword_402000
                         push    ds:dword_402094
                         call    FillRect
                         push    dword_4030E4
                         call    sub_401804
                         add     esp, 4
                         mov     ds:dword_402010, eax
                         mov     ds:dword_402018, 0
                         jmp     loc_401654
         ; ---------------------------------------------------------------------------
         
         loc_40159B:                             ; CODE XREF: sub_4012F1+36Fj
                         mov     edi, ds:dword_402080
                         add     edi, dword_4030E0
                         push    edi
                         fild    [esp+14h+var_14]
                         add     esp, 4
                         fstp    ds:flt_402078
                         fld     ds:flt_402078
                         fdiv    flt_4030E8
                         sub     esp, 4
                         fstp    [esp+14h+var_14]
                         call    sub_401714
                         add     esp, 4
                         fstp    [ebp+var_4]
                         fld     [ebp+var_4]
                         fmul    flt_4030EC
                         push    ds:dword_402004
                         fild    [esp+14h+var_14]
                         add     esp, 4
                         faddp   st(1), st
                         fstp    ds:flt_402078
                         fld     ds:flt_402078
                         mov     edi, eax
                         call    sub_40177C
                         xchg    eax, edi
                         mov     ds:dword_402084, edi
                         push    64h
                         push    offset dword_402080
                         push    1
                         mov     edi, ds:dword_402018
                         add     edi, dword_4030E4
                         push    edi
                         push    ds:dword_402094
                         call    DrawTextA
                         push    offset dword_402070
                         push    1
                         mov     edi, ds:dword_402018
                         add     edi, dword_4030E4
                         push    edi
                         push    ds:dword_402094
                         call    GetTextExtentPoint32A
                         mov     edi, ds:dword_402070
                         add     ds:dword_402080, edi
                         inc     ds:dword_402018
         
         loc_401654:                             ; CODE XREF: sub_4012F1+2A5j
                         mov     edi, ds:dword_402010
                         cmp     ds:dword_402018, edi
                         jl      loc_40159B
                         push    0CC0020h;SRCCOPY
                         push    0
                         mov     edi, dword_4030E0
                         neg     edi
                         push    edi
                         push    ds:dword_402094
                         push    ds:dword_40200C
                         push    300;0C3h
                         push    0
                         push    0
                         push    ds:dword_40207C
                         call    BitBlt
                         push    offset unk_402030
                         push    ds:dword_402020
                         call    EndPaint
		
		
	.elseif [uMsg]==WM_CLOSE 
		
		;invoke SetCursorPos, 100, 100
		;ret
		
		
		invoke	KillTimer, [hWnd], 1
		invoke	DeleteDC, [hDCScroller]
		invoke	DeleteObject, [hBmpScroller]
		invoke	DeleteObject, [hFont]
		invoke	DestroyIcon, [wc.hIcon]
		invoke	DestroyIcon, [wc.hIconSm]
	.elseif [uMsg]==WM_DESTROY
		invoke	PostQuitMessage, 0
		xor	eax, eax
		ret
	.endif

	invoke	DefWindowProc, [hWnd], [uMsg], [wParam], [lParam]
	ret
WndProc endp



      sub_401804      proc near               ; CODE XREF: sub_4012F1+28Ep
         
         arg_0           = dword ptr  4
         
                         mov     ecx, [esp+arg_0]
                         or      ecx, ecx
                         jz      short loc_40186C
                         test    cl, 3
                         jnz     short loc_40186F
         
         loc_401811:                             ; CODE XREF: sub_401804+23j
                                                 ; sub_401804+3Ej ...
                         mov     eax, [ecx]
                         mov     edx, 7EFEFEFFh
                         add     edx, eax
                         xor     eax, 0FFFFFFFFh
                         xor     eax, edx
                         add     ecx, 4
                         test    eax, 81010100h
                         jz      short loc_401811
                         mov     eax, [ecx-4]
                         test    al, al
                         jz      short loc_401862
                         test    ah, ah
                         jz      short loc_401858
                         test    eax, 0FF0000h
                         jz      short loc_40184E
                         test    eax, 0FF000000h
                         jz      short loc_401844
                         jmp     short loc_401811
         ; ---------------------------------------------------------------------------
         
         loc_401844:                             ; CODE XREF: sub_401804+3Cj
                                                 ; sub_401804+72j
                         lea     eax, [ecx-1]
                         mov     ecx, [esp+arg_0]
                         sub     eax, ecx
                         retn
         ; ---------------------------------------------------------------------------
         
         loc_40184E:                             ; CODE XREF: sub_401804+35j
                         lea     eax, [ecx-2]
                         mov     ecx, [esp+arg_0]
                         sub     eax, ecx
                         retn
         ; ---------------------------------------------------------------------------
         
         loc_401858:                             ; CODE XREF: sub_401804+2Ej
                         lea     eax, [ecx-3]
                         mov     ecx, [esp+arg_0]
                         sub     eax, ecx
                         retn
         ; ---------------------------------------------------------------------------
         
         loc_401862:                             ; CODE XREF: sub_401804+2Aj
                         lea     eax, [ecx-4]
                         mov     ecx, [esp+arg_0]
                         sub     eax, ecx
                         retn
         ; ---------------------------------------------------------------------------
         
         loc_40186C:                             ; CODE XREF: sub_401804+6j
                         xor     eax, eax
                         retn
         ; ---------------------------------------------------------------------------
         
         loc_40186F:                             ; CODE XREF: sub_401804+Bj
                                                 ; sub_401804+77j
                         mov     al, [ecx]
                         add     ecx, 1
                         test    al, al
                         jz      short loc_401844
                         test    cl, 3
                         jnz     short loc_40186F
                         jmp     short loc_401811
         sub_401804      endp
                         
                         
        sub_401714      proc near               ; CODE XREF: sub_4012F1+2D5p
         
         arg_0           = dword ptr  4
         
                         fld     [esp+arg_0]
                         call    sub_4016E8
                         retn
         sub_401714      endp
         
         ; ---------------------------------------------------------------------------
                         fild    dword ptr [esp+4]
                         call    sub_4016E8
                         retn
         ; ---------------------------------------------------------------------------
                         mov     eax, [esp+4]
                         push    eax
                         push    0
                         fild    qword ptr [esp]
                         add     esp, 8
                         call    sub_4016E8
                         retn
         ; ---------------------------------------------------------------------------
                         fld     qword ptr [esp+4]
                         call    sub_4016E8
                         retn
         ; ---------------------------------------------------------------------------
                         fild    qword ptr [esp+4]
                         call    sub_4016E8
                         retn
         ; ---------------------------------------------------------------------------
                         mov     eax, [esp+4]
                         mov     edx, [esp+8]
                         push    20h
                         fild    dword ptr [esp]
                         mov     dword ptr [esp], 0
                         push    edx
                         fild    qword ptr [esp]
                         fscale
                         mov     [esp], eax
                         fild    qword ptr [esp]
                         faddp   st(1), st
                         add     esp, 8
                         fstp    st(1)
                         call    sub_4016E8
                         retn
         
         ; --------------- S U B R O U T I N E ---------------------------------------
         
         ; Attributes: bp-based frame
         
         sub_40177C      proc near               ; CODE XREF: sub_4012F1+305p
         
         var_1C          = dword ptr -1Ch
         var_4           = word ptr -4
         var_2           = word ptr -2
         
                         push    ebp
                         mov     ebp, esp
                         sub     esp, 1Ch
                         fnstcw  [ebp+var_2]
                         mov     ax, [ebp+var_2]
                         or      ah, 0Ch
                         mov     [ebp+var_4], ax
                         fldcw   [ebp+var_4]
                         fistp   [esp+1Ch+var_1C]
                         mov     eax, [esp+1Ch+var_1C]
                         fldcw   [ebp+var_2]
                         leave
                         retn
         sub_40177C      endp




sub_4016E8      proc near               ; CODE XREF: .text:004016E0p
                                                 ; .text:0040170Ep ...
                         fsin
                         fnstsw  ax
                         test    eax, 400h
                         jnz     short loc_4016F4
                         retn
         ; ---------------------------------------------------------------------------
         
         loc_4016F4:                             ; CODE XREF: sub_4016E8+9j
                         fldpi
                         fadd    st, st
                         fxch    st(1)
         
         loc_4016FA:                             ; CODE XREF: sub_4016E8+1Bj
                         fprem1
                         fnstsw  ax
                         test    eax, 400h
                         jnz     short loc_4016FA
                         fstp    st(1)
                         fsin
                         retn
         sub_4016E8      endp


end start