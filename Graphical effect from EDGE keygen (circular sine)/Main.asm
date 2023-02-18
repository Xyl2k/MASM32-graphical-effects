.386
.model	flat, stdcall
option	casemap:none

include     /masm32/include/windows.inc
include     /masm32/include/kernel32.inc 
include     /masm32/include/user32.inc 
include     /masm32/include/gdi32.inc  
include     /masm32/include/masm32.inc
include	Keygen.inc

includelib	/masm32/lib/kernel32.lib
includelib	/masm32/lib/user32.lib
includelib	/masm32/lib/gdi32.lib
includelib	/masm32/lib/masm32.lib

DlgProc	proto	:DWORD,:DWORD,:DWORD,:DWORD
WinMain	proto	:DWORD,:DWORD,:DWORD,:DWORD
Thread_Effect	proto
rand		proto

.data

.data?
hInstance		HINSTANCE ? 
CommandLine		LPSTR ?

.code
start:
invoke GetModuleHandle, NULL            ; get the instance handle of our program. 
                                                                       ; Under Win32, hmodule==hinstance mov hInstance,eax 
mov hInstance,eax 
invoke GetCommandLine                        ; get the command line. You don't have to call this function IF 
                                                                       ; your program doesn't process the command line. 
mov CommandLine,eax 
invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT        ; call the main function 
invoke ExitProcess, eax                           ; quit our program. The exit code is returned in eax from WinMain.

WinMain proc hIns:HINSTANCE, hPrevInstance:HINSTANCE, lpCmdLine:LPSTR, nShowCmd:DWORD
	LOCAL WndClass:WNDCLASS
	LOCAL msg:MSG
	LOCAL hWnd: HWND
	LOCAL Rect:RECT
	
	invoke	CreateSolidBrush,0
	mov		dword_80E888, eax
	invoke	CreateSolidBrush,0C0C0C0h
	mov		hbr, eax
	mov		WndClass.style, 3
	mov		WndClass.lpfnWndProc, offset DlgProc
	mov		WndClass.cbClsExtra, 0
	mov		WndClass.cbWndExtra,DLGWINDOWEXTRA 
	push	hInstance
	pop		WndClass.hInstance
	invoke	LoadIcon,hIns,100
	mov		WndClass.hIcon, eax
	mov		WndClass.lpszMenuName, 0
	invoke	LoadCursor,NULL,IDC_ARROW
	mov		WndClass.hCursor, eax
	push	dword_80E888
	pop		WndClass.hbrBackground
	mov		WndClass.lpszClassName,offset ClassName
	invoke	RegisterClass, addr WndClass
	invoke	CreateDialogParam,hIns, addr ClassName, 0, 0, 0
	mov		hDlg, eax
	mov		hWnd, eax
	invoke	LoadBitmap,hIns,110
	invoke	SendDlgItemMessage,hWnd, 1002, BM_SETIMAGE, NULL, eax
	invoke	LoadBitmap,hIns,111
	invoke	SendDlgItemMessage,hWnd, 1007,BM_SETIMAGE, NULL, eax
	invoke	LoadBitmap,hIns,112
	invoke	SendDlgItemMessage,hWnd, 1008, BM_SETIMAGE, NULL, eax
	invoke	GetWindowRect,hWnd, addr Rect
	mov		rc.bottom, 25
	mov		rc.top, 5
	mov		rc.left, 5
	mov		eax, Rect.right
	mov		ecx, Rect.left
	sub		eax, ecx
	sub		eax, 5
	mov		rc.right, eax
	;CreateThread here
	invoke	CreateThread,0,0, addr Thread_Effect,0,0,0
	
	invoke	ShowWindow,hWnd,nShowCmd
	
	 .while TRUE                                                         ; Enter message loop 
                invoke GetMessage, ADDR msg,NULL,0,0 
                .break .if (!eax) 
                invoke TranslateMessage, ADDR msg 
                invoke DispatchMessage, ADDR msg 
   	.endw
   	mov     eax,msg.wParam                                            ; return exit code in eax 
	Ret
WinMain EndP

DlgProc proc hWnd:HWND, uMsg: UINT, wParam:WPARAM, lParam:LPARAM
	LOCAL v4:HDC
	LOCAL Paint:PAINTSTRUCT 
	.if uMsg == WM_INITDIALOG || uMsg == 1
		invoke	SendMessage,hWnd,WM_SETTEXT,0,addr WindowTittle
	.elseif uMsg == WM_LBUTTONDOWN
		invoke	SendMessage,hWnd,WM_NCLBUTTONDOWN,2,0
	.elseif uMsg == WM_DESTROY
ExitApp:
		invoke	PostQuitMessage,0
	.elseif uMsg == WM_COMMAND
		.if wParam == 1002 || wParam == 1008
			jmp	ExitApp
		.endif
	.elseif uMsg == WM_PAINT	
		invoke	BeginPaint,hWnd, addr Paint
		mov		v4, eax
		invoke	CreateFont,16,0,0,0,700,0,0,0,1,0,0,0,0, addr FontName
		invoke	SelectObject, v4, eax
		invoke	FrameRect, v4, addr rc, hbr
		invoke	SetTextColor, v4, 0C0C0C0h
		invoke	SetBkColor, v4, 0
		invoke	TextOut, v4, 28, 7, addr WindowTittle, sizeof WindowTittle-1
		invoke	LoadIcon, hInstance, 100
		invoke	DrawIconEx, v4, 7, 7, eax, 16, 16, 0, 0, 2
		invoke	DeleteDC, v4
	.elseif uMsg >= 0133h && uMsg <= 0138h
		invoke	SetBkMode,wParam,OPAQUE
		invoke	SetBkColor,wParam, 0
		invoke	SetTextColor,wParam, 0C0C0C0h
		mov		eax, dword_80E888
		ret
	.endif
	invoke	DefWindowProc,hWnd,uMsg,wParam,lParam
	Ret
DlgProc EndP

Thread_Effect proc
	LOCAL v6:HDC
	LOCAL v7:REAL4	;ESP+10h
	LOCAL v8:REAL4	;ESP+14h
	
	invoke	GetTickCount
	invoke	nseed, eax
	xor		esi, esi
	mov		bmi.bmiHeader.biSize, 40
	mov		bmi.bmiHeader.biWidth, 360
	mov		bmi.bmiHeader.biHeight, -200
	mov		bmi.bmiHeader.biPlanes, 1
	mov		bmi.bmiHeader.biBitCount, 32
	mov		bmi.bmiHeader.biCompression, esi
	mov		bmi.bmiHeader.biSizeImage, esi
 	mov		bmi.bmiHeader.biXPelsPerMeter, esi
 	mov		bmi.bmiHeader.biYPelsPerMeter, esi
 	mov		bmi.bmiHeader.biClrUsed, esi
 	mov		bmi.bmiHeader.biClrImportant, esi
 	call		rand
	lea 		ecx,dword ptr ds:[eax+eax*4]
        	lea 		eax,dword ptr ds:[eax+ecx*8]
        	mov 		ecx,0ffh
        	lea 		eax,dword ptr ds:[eax+eax*2]
        	cdq
        	idiv 		ecx
        	mov 		v7,edx
        	fild 		v7
        	fmul 		qword ptr ds:[dbl_806138]
        	fstp 		qword ptr ds:[dword_824558]
        	call		rand
        	lea 		edx,dword ptr ds:[eax+eax*4]
	mov 		ecx,0ffh
	lea 		eax,dword ptr ds:[eax+edx*8]
	lea 		eax,dword ptr ds:[eax+eax*2]
	cdq
	idiv 		ecx
	mov 		v7,edx
	fild 		v7
	fmul 		qword ptr ds:[dbl_806138]
	fstp 		qword ptr ds:[dbl_829CF8]
	call		rand
	lea 		edx,dword ptr ds:[eax+eax*4]
	mov 		ecx,0ffh
	lea 		eax,dword ptr ds:[eax+edx*8]
	lea 		eax,dword ptr ds:[eax+eax*2]
	cdq
	idiv 		ecx
	mov 		v7,edx
	fild 		v7
	mov 		v7,esi
	fmul 		qword ptr ds:[dbl_806138]
	fstp 		qword ptr ds:[dbl_80E868]
@dumped__0080200a:
	call		rand
	lea 		edx,dword ptr ds:[eax+eax*4]
	mov 		ecx,0ffh
	lea 		eax,dword ptr ds:[eax+edx*8]
	lea 		eax,dword ptr ds:[eax+eax*2]
	cdq
	idiv 		ecx
	mov 		v8,edx
	fild 		v8
	fmul 		qword ptr ds:[dbl_806138]
	fsub 		qword ptr ds:[dbl_806150]
	fmul 		qword ptr ds:[dbl_806148]
	fstp 		qword ptr ds:[esi+dword_829D50]
	call 		rand
	lea 		edx,dword ptr ds:[eax+eax*4]
	mov 		ecx,0ffh
	add 		esi,8
	lea 		eax,dword ptr ds:[eax+edx*8]
	lea 		eax,dword ptr ds:[eax+eax*2]
	cdq
	idiv 		ecx
	cmp 		esi,05780h
	mov 		v8,edx
	fild 		v8
	fmul 		qword ptr ds:[dbl_806138]
	fsub 		qword ptr ds:[dbl_806150]
	fmul 		qword ptr ds:[dbl_806148]
	fstp 		qword ptr ds:[esi+dword_81ED50]
	fld 		v7
	fstp 		qword ptr ds:[esi+dword_824558]
	fld 		v7
	fadd 		dword ptr ds:[dbl_806140]
	fstp 		v7
	jl 		@dumped__0080200a
	
MainLoop:
	mov 		ecx,011940h
	xor 		eax,eax
	mov 		edi,offset dword_82F4F8
	rep stos 	dword ptr es:[edi]
	call		DrawStar
	call		Draw_MainText
	call		Draw_ScrollText
	xor edi,edi
	mov esi,2

@dumped__008020cf:

	movsx 	ecx,byte ptr ds:[edi+ScreenText]
	mov 		eax,ecx
	push 	0c0c0c0h
	cdq
	and 		edx,0fh
	push 	030h
	add 		eax,edx
	push 	080h
	sar 		eax,4
	and 		ecx,08000000fh
	lea 		edx,dword ptr ds:[eax*8-010h]
	push 	edx
	jns @dumped__00802102
	dec 		ecx
	or 		ecx,0fffffff0h
	inc 		ecx
	
@dumped__00802102:
	
	shl 		ecx,3
	push 	ecx
	push 	8
	push 	8
	push 	0beh                                    ; <= ScreenText Y
	push 	esi
	call 		Out_ScreenText
	add 		esp,024h
	add 		esi,9
	inc 		edi
	cmp 		esi,0161h
	jl 		@dumped__008020cf
	mov 		ecx,0168h
	mov 		eax,0c0c0c0h
	mov 		edi, offset dword_82F4F8
	rep stos 	dword ptr es:[edi]
	mov 		ecx,0168h
	mov 		edi,offset dword_82F4F8 + 286560
	rep stos 	dword ptr es:[edi]
	mov 		eax, offset dword_82F4F8
	
	@dumped__00802146:
	
	mov 		dword ptr ds:[eax],0c0c0c0h
	add 		eax,05a0h
	cmp 		eax,offset dword_82F4F8 + 288000
	jl 		@dumped__00802146
	mov 		eax,offset dword_82F4F8 + 1436
	
	@dumped__0080215d:
	
	mov 		dword ptr ds:[eax],0c0c0c0h
	add 		eax,05a0h
	cmp 		eax,offset dword_82F4F8 + 289436
	jl @dumped__0080215d
	mov		xDest, 10
	mov		yDest, 40
	mov		dword_80E894, 370
	mov		dword_80E898, 240
	invoke	GetDC, hDlg
	mov		v6, eax
	invoke	StretchDIBits, eax, xDest, yDest, 360, 200, 0, 0, 360, 200, offset dword_82F4F8, offset bmi, 0, 0CC0020h
	invoke	ReleaseDC, hDlg, v6
	add		dword_82F4F0, 2
	invoke	Sleep,25
	jmp		MainLoop
	Ret
Thread_Effect EndP

rand proc
	invoke	nrandom, 0FFFFh
	Ret
rand EndP


;CODE RIPPER PART

_ftol:                                       ;<= Procedure Start

        push ebp
        mov ebp,esp
        add esp,-0ch
        wait
        fstcw word ptr ss:[ebp-2]
        wait
        mov ax,word ptr ss:[ebp-2]
        or ah,0ch
        mov word ptr ss:[ebp-4],ax
        fldcw word ptr ss:[ebp-4]
        fistp qword ptr ss:[ebp-0ch]
        fldcw word ptr ss:[ebp-2]
        mov eax,dword ptr ss:[ebp-0ch]
        mov edx,dword ptr ss:[ebp-8]
        leave
        retn                                 ;<= Procedure End



Out_ScreenText:                              ;<= Procedure Start

	push ecx
	mov ecx,dword ptr ss:[esp+0ch]
	push ebx
	fild dword ptr ss:[esp+024h]
	lea eax,dword ptr ds:[ecx+ecx*4]
	push ebp
	push esi
	push edi
	fstp dword ptr ss:[esp+010h]
	lea edx,dword ptr ds:[eax+eax*8]
	mov eax,dword ptr ss:[esp+018h]
	cmp eax,0168h
	lea edi,dword ptr ds:[eax+edx*8]
	jge @dumped__0080193a
	mov ebx,dword ptr ss:[esp+020h]
	lea esi,dword ptr ds:[eax+ebx]
	test esi,esi
	jle @dumped__0080193a
	cmp ecx,0c8h
	jge @dumped__0080193a
	mov ebp,dword ptr ss:[esp+024h]
	lea edx,dword ptr ds:[ecx+ebp]
	test edx,edx
	jle @dumped__0080193a
	cmp esi,0168h
	jle @dumped__00801892
	mov ebx,0168h
	sub ebx,eax
	
	@dumped__00801892:
	
	cmp edx,0c8h
	jle @dumped__008018a1
	mov ebp,0c8h
	sub ebp,ecx
	
	@dumped__008018a1:
	
	test ebp,ebp
	mov dword ptr ss:[esp+030h],0
	jle @dumped__0080193a
	
	@dumped__008018b1:
	
	xor esi,esi
	test ebx,ebx
	mov dword ptr ss:[esp+01ch],esi
	jle @dumped__00801923
	fild dword ptr ss:[esp+030h]
	fiadd dword ptr ss:[esp+02ch]
	fmul dword ptr ds:[dbl_806160]
	call _ftol                                  
	mov dword ptr ss:[esp+018h],eax
	fild dword ptr ss:[esp+018h]
	fmul dword ptr ss:[esp+010h]
	fild dword ptr ss:[esp+028h]
	
	@dumped__008018de:
	
	fild dword ptr ss:[esp+01ch]
	fadd st,st(1)
	fmul dword ptr ds:[dbl_806160]
	call _ftol                                   
	mov dword ptr ss:[esp+01ch],eax
	fild dword ptr ss:[esp+01ch]
	fadd st,st(2)
	call _ftol                                   
	mov cl,byte ptr ds:[eax+dword_808020]
	test cl,cl
	je @dumped__00801916
	mov ecx,dword ptr ss:[esp+038h]
	lea eax,dword ptr ds:[edi+esi]
	mov dword ptr ds:[eax*4+dword_82F4F8],ecx
	
	@dumped__00801916:
	
	inc esi
	cmp esi,ebx
	mov dword ptr ss:[esp+01ch],esi
	jl @dumped__008018de
	fstp st
	fstp st
	
	@dumped__00801923:
	
	mov eax,dword ptr ss:[esp+030h]
	add edi,0168h
	inc eax
	cmp eax,ebp
	mov dword ptr ss:[esp+030h],eax
	jl @dumped__008018b1
	
	@dumped__0080193a:
	
	pop edi
	pop esi
	pop ebp
	pop ebx
	pop ecx
	retn                                         ;<= Procedure End


DrawStar:                                    ;<= Procedure Start

	fld qword ptr ds:[dword_824558]
	fadd qword ptr ds:[dbl_8061E0]
	sub esp,8
	xor ecx,ecx
	fstp qword ptr ds:[dword_824558]
	fld qword ptr ds:[dbl_829CF8]
	fadd qword ptr ds:[dbl_8061D8]
	fstp qword ptr ds:[dbl_829CF8]
	fld qword ptr ds:[dbl_80E868]
	fadd qword ptr ds:[dbl_8061D0]
	fstp qword ptr ds:[dbl_80E868]
	fld qword ptr ds:[dbl_829CF0]
	fadd qword ptr ds:[dbl_8061C8]
	fstp qword ptr ds:[dbl_829CF0]
	fld qword ptr ds:[dbl_80E848]
	fadd qword ptr ds:[dbl_8061C0]
	fstp qword ptr ds:[dbl_80E848]
	fld qword ptr ds:[dword_81ED50]
	fadd qword ptr ds:[dbl_8061B8]
	fst qword ptr ds:[dword_81ED50]
	fsin
	fld qword ptr ds:[dword_824558]
	fsin
	faddp st(1),st
	fmul qword ptr ds:[dbl_8061B0]
	fld qword ptr ds:[dbl_829CF0]
	fsin
	fld qword ptr ds:[dbl_829CF8]
	fsin
	faddp st(1),st
	fmul qword ptr ds:[dbl_8061B0]
	fld qword ptr ds:[dbl_80E848]
	fsin
	fld qword ptr ds:[dbl_80E868]
	fsin
	faddp st(1),st
	fmul qword ptr ds:[dbl_8061B0]
	
@dumped__00801c63:
	
	fld qword ptr ds:[ecx+ offset dword_824558 + 8]
	fsub st,st(1)
	fst qword ptr ss:[esp]
	fstp qword ptr ds:[ecx+offset dword_824558 + 8]
	fld qword ptr ss:[esp]
	fcomp qword ptr ds:[dbl_8061A8]
	fld qword ptr ss:[esp]
	fstsw ax
	test ah,5
	jpe @dumped__00801c92
	fadd qword ptr ds:[dbl_8061A0]
	jmp @dumped__00801cab
	
@dumped__00801c92:
	
	fcomp qword ptr ds:[dbl_8061A0]
	fstsw ax
	and eax,04100h
	jnz @dumped__00801cb1
	fld qword ptr ss:[esp]
	fsub qword ptr ds:[dbl_8061A0]
	
@dumped__00801cab:
	
	fstp qword ptr ds:[ecx+offset dword_824558 + 8]
	
@dumped__00801cb1:
	
	fld qword ptr ds:[ecx+dword_829D50]
	fsub st,st(3)
	fst qword ptr ss:[esp]
	fstp qword ptr ds:[ecx+dword_829D50]
	fld qword ptr ss:[esp]
	fcomp qword ptr ds:[dbl_8061A8]
	fld qword ptr ss:[esp]
	fstsw ax
	test ah,5
	jpe @dumped__00801ce0
	fadd qword ptr ds:[dbl_806148]
	jmp @dumped__00801cf9
	
@dumped__00801ce0:
	
	fcomp qword ptr ds:[dbl_806148]
	fstsw ax
	and eax,04100h
	jnz @dumped__00801cff
	fld qword ptr ss:[esp]
	fsub qword ptr ds:[dbl_806148]
	
@dumped__00801cf9:
	
	fstp qword ptr ds:[ecx+dword_829D50]
	
@dumped__00801cff:
	
	fld qword ptr ds:[ecx+ offset dword_81ED50 + 8]
	fsub st,st(2)
	fst qword ptr ss:[esp]
	fstp qword ptr ds:[ecx+offset dword_81ED50 + 8]
	fld qword ptr ss:[esp]
	fcomp qword ptr ds:[dbl_8061A8]
	fld qword ptr ss:[esp]
	fstsw ax
	test ah,5
	jpe @dumped__00801d2e
	fadd qword ptr ds:[dbl_806148]
	jmp @dumped__00801d47
	
@dumped__00801d2e:
	
	fcomp qword ptr ds:[dbl_806148]
	fstsw ax
	and eax,04100h
	jnz @dumped__00801d4d
	fld qword ptr ss:[esp]
	fsub qword ptr ds:[dbl_806148]
	
@dumped__00801d47:
	
	fstp qword ptr ds:[ecx+offset dword_81ED50 + 8]
	
@dumped__00801d4d:
	
	add ecx,8
	cmp ecx,05780h
	jl @dumped__00801c63
	fstp st
	push ebx
	push esi
	fstp st
	push edi
	xor ebx,ebx
	fstp st
	
@dumped__00801d67:
	
	fld qword ptr ds:[ebx+offset dword_824558 + 8]
	fcom qword ptr ds:[dbl_8061A8]
	fstsw ax
	test ah,044h
	jpe @dumped__00801d82
	fstp st
	fld qword ptr ds:[dbl_806198]
	
@dumped__00801d82:
	
	fld qword ptr ds:[dbl_806190]
	fdiv st,st(1)
	fld qword ptr ds:[ebx+dword_829D50]
	fsub qword ptr ds:[dbl_806188]
	fmul st,st(1)
	fmul qword ptr ds:[dbl_806180]
	call _ftol 
	fld qword ptr ds:[ebx+offset dword_81ED50 + 8]
	fsub qword ptr ds:[dbl_806188]
	mov esi,0b4h
	sub esi,eax
	fmul st,st(1)
	fmul qword ptr ds:[dbl_806180]
	call _ftol             
	fstp st
	fmul qword ptr ds:[dbl_806178]
	mov edi,064h
	sub edi,eax
	call _ftol                                  
	mov ecx,0ffh
	sub ecx,eax
	cmp esi,-010h
	jge @dumped__00801de6
	or ecx,0ffffffffh
	
@dumped__00801de6:
	
	cmp esi,0290h
	jle @dumped__00801df1
	or ecx,0ffffffffh
	
	@dumped__00801df1:
	
	cmp edi,-010h
	jge @dumped__00801df9
	or ecx,0ffffffffh
	
@dumped__00801df9:
	
	cmp edi,01f0h
	jg @dumped__00801e39
	test ecx,ecx
	jl @dumped__00801e39
	test esi,esi
	jl @dumped__00801e39
	cmp esi,0168h
	jge @dumped__00801e39
	test edi,edi
	jl @dumped__00801e39
	cmp edi,0c8h
	jge @dumped__00801e39
	mov edx,ecx
	lea eax,dword ptr ds:[edi+edi*4]
	shl edx,8
	add edx,ecx
	lea eax,dword ptr ds:[eax+eax*8]
	shl edx,8
	add edx,ecx
	lea ecx,dword ptr ds:[esi+eax*8]
	mov dword ptr ds:[ecx*4+dword_82F4F8],edx
	
@dumped__00801e39:
	
	add ebx,8
	cmp ebx,05780h
	jl @dumped__00801d67
	pop edi
	pop esi
	pop ebx
	add esp,8
	retn                                         ;<= Procedure End



Draw_ScrollText:                             ;<= Procedure Start

	sub esp,038h
	mov ecx,dword ptr ds:[dword_875A00]
	push ebx
	mov ebx,dword ptr ds:[dword_8759FC]
	mov dword ptr ss:[esp+028h],ecx
	cmp ebx,0168h
	jge @dumped__00801b62
	mov eax,dword ptr ds:[dword_82F4F0]
	push ebp
	push esi
	push edi
	lea edx,dword ptr ds:[ebx+eax*8]
	lea edi,dword ptr ds:[eax*8]
	shl edx,4
	mov dword ptr ss:[esp+02ch],edx
	lea edx,dword ptr ds:[eax+eax*2]
	sub edi,eax
	lea edx,dword ptr ds:[ebx+edx*2]
	add edi,ebx
	shl edx,4
	mov dword ptr ss:[esp+028h],edx
	lea edx,dword ptr ds:[eax+eax*4]
	shl edi,4
	lea ebp,dword ptr ds:[ebx+edx*2]
	lea edx,dword ptr ds:[ebx+eax*2]
	add eax,edx
	mov dword ptr ss:[esp+038h],edi
	shl ebp,4
	shl eax,5
	mov dword ptr ss:[esp+03ch],ebp
	mov dword ptr ss:[esp+024h],eax
	
	@dumped__008019aa:
	
	movsx eax,byte ptr ds:[ecx+ offset ScrollText]
	mov ecx,eax
	and ecx,08000000fh
	jns @dumped__008019c0
	dec ecx
	or ecx,0fffffff0h
	inc ecx
	
	@dumped__008019c0:
	
	cdq
	and edx,0fh
	mov dword ptr ss:[esp+01ch],edi
	add eax,edx
	mov edx,dword ptr ss:[esp+024h]
	sar eax,4
	shl ecx,3
	lea eax,dword ptr ds:[eax*8-010h]
	mov dword ptr ss:[esp+020h],edx
	mov edx,dword ptr ss:[esp+02ch]
	mov dword ptr ss:[esp+044h],eax
	mov eax,dword ptr ss:[esp+028h]
	mov edi,ecx
	mov esi,ebx
	mov dword ptr ss:[esp+018h],ebp
	mov dword ptr ss:[esp+014h],eax
	mov dword ptr ss:[esp+010h],edx
	sub edi,ebx
	mov dword ptr ss:[esp+030h],8
	
	@dumped__00801a05:
	
	fild dword ptr ss:[esp+010h]
	fmul qword ptr ds:[dbl_806170]
	fsin
	fmul qword ptr ds:[dbl_806168]
	call _ftol                                  
	fild dword ptr ss:[esp+014h]
	mov ebp,eax
	sar ebp,6
	fmul qword ptr ds:[dbl_806170]
	shl ebp,8
	fsin
	fmul qword ptr ds:[dbl_806168]
	call _ftol     
	fild dword ptr ss:[esp+018h]
	sar eax,6
	add ebp,eax
	mov eax,07f7f7fh
	fmul qword ptr ds:[dbl_806170]
	shl ebp,8
	sub eax,ebp
	fsin
	mov ebp,eax
	fmul qword ptr ds:[dbl_806168]
	call _ftol 
	fild dword ptr ss:[esp+01ch]
	lea ecx,dword ptr ds:[edi+esi]
	sar eax,6
	fmul qword ptr ds:[dbl_806170]
	sub ebp,eax
	mov eax,dword ptr ss:[esp+044h]
	push ebp
	push 030h
	fsin
	push 080h
	push eax
	push ecx
	push 8
	push 1
	fmul qword ptr ds:[dbl_806168]
	call _ftol 
	fild dword ptr ss:[esp+03ch]
	sar eax,8
	mov ebp,060h
	fmul qword ptr ds:[dbl_806170]
	sub ebp,eax
	fsin
	fmul qword ptr ds:[dbl_806168]
	call _ftol  
	sar eax,8
	sub ebp,eax
	push ebp
	push esi
	call Out_ScreenText 
	mov ebp,dword ptr ss:[esp+034h]
	mov edx,dword ptr ss:[esp+038h]
	mov ecx,dword ptr ss:[esp+03ch]
	mov eax,010h
	add ebp,eax
	add edx,eax
	mov dword ptr ss:[esp+034h],ebp
	mov ebp,dword ptr ss:[esp+040h]
	mov dword ptr ss:[esp+038h],edx
	mov edx,dword ptr ss:[esp+044h]
	add ecx,eax
	add ebp,eax
	mov eax,dword ptr ss:[esp+054h]
	add esp,024h
	add edx,020h
	inc esi
	dec eax
	mov dword ptr ss:[esp+018h],ecx
	mov dword ptr ss:[esp+01ch],ebp
	mov dword ptr ss:[esp+020h],edx
	mov dword ptr ss:[esp+030h],eax
	jnz @dumped__00801a05
	mov edi,dword ptr ss:[esp+024h]
	mov ecx,dword ptr ss:[esp+034h]
	mov ebp,dword ptr ss:[esp+03ch]
	mov esi,dword ptr ss:[esp+028h]
	mov edx,dword ptr ss:[esp+02ch]
	add edi,0120h
	mov dword ptr ss:[esp+024h],edi
	mov edi,dword ptr ss:[esp+038h]
	mov eax,090h
	add ebx,9
	inc ecx
	add edi,eax
	add ebp,eax
	add esi,eax
	add edx,eax
	cmp ebx,0168h
	mov dword ptr ss:[esp+034h],ecx
	mov dword ptr ss:[esp+038h],edi
	mov dword ptr ss:[esp+03ch],ebp
	mov dword ptr ss:[esp+028h],esi
	mov dword ptr ss:[esp+02ch],edx
	jl @dumped__008019aa
	pop edi
	pop esi
	pop ebp
	
	@dumped__00801b62:
	
	mov eax,dword ptr ds:[dword_8759FC]
	pop ebx
	dec eax
	cmp eax,-010h
	mov dword ptr ds:[dword_8759FC],eax
	jg @dumped__00801b88
	mov eax,dword ptr ds:[dword_875A00]
	mov dword ptr ds:[dword_8759FC],-8
	inc eax
	mov dword ptr ds:[dword_875A00],eax
	
	@dumped__00801b88:
	
	cmp byte ptr ds:[ecx+ offset ScrollText],07eh
	jnz @dumped__00801b9d
	xor eax,eax
	mov dword ptr ds:[dword_875A00],eax
	mov dword ptr ds:[dword_8759FC],eax
	
	@dumped__00801b9d:
	
	add esp,038h
	retn                                         ;<= Procedure End
	

@dumped__008016c0:                           ;<= Procedure Start
	
	push ecx
	mov ecx,dword ptr ss:[esp+0ch]
	push ebp
	fild dword ptr ss:[esp+024h]
	lea eax,dword ptr ds:[ecx+ecx*4]
	push esi
	push edi
	fstp dword ptr ss:[esp+0ch]
	lea edx,dword ptr ds:[eax+eax*8]
	mov eax,dword ptr ss:[esp+014h]
	cmp eax,0168h
	lea edi,dword ptr ds:[eax+edx*8]
	jge @dumped__00801823
	mov ebp,dword ptr ss:[esp+01ch]
	lea esi,dword ptr ds:[eax+ebp]
	test esi,esi
	jle @dumped__00801823
	cmp ecx,0c8h
	jge @dumped__00801823
	mov edx,dword ptr ss:[esp+020h]
	add edx,ecx
	test edx,edx
	jle @dumped__00801823
	cmp esi,0168h
	jle @dumped__00801720
	mov ebp,0168h
	sub ebp,eax
	
	@dumped__00801720:
	
	cmp edx,0c8h
	jle @dumped__00801733
	mov eax,0c8h
	sub eax,ecx
	mov dword ptr ss:[esp+020h],eax
	
	@dumped__00801733:
	
	mov eax,dword ptr ss:[esp+020h]
	mov dword ptr ss:[esp+02ch],0
	test eax,eax
	jle @dumped__00801823
	push ebx
	
	@dumped__00801748:
	
	xor esi,esi
	test ebp,ebp
	mov dword ptr ss:[esp+01ch],esi
	jle @dumped__00801807
	fild dword ptr ss:[esp+028h]
	fild dword ptr ss:[esp+030h]
	fiadd dword ptr ss:[esp+02ch]
	fmul dword ptr ds:[dbl_806160]
	call _ftol 
	mov dword ptr ss:[esp+018h],eax
	fild dword ptr ss:[esp+018h]
	fmul dword ptr ss:[esp+010h]
	
	@dumped__00801779:
	
	fild dword ptr ss:[esp+01ch]
	fadd st,st(2)
	fmul dword ptr ds:[dbl_806160]
	call _ftol 
	mov dword ptr ss:[esp+01ch],eax
	fild dword ptr ss:[esp+01ch]
	fadd st,st(1)
	fld st
	call _ftol 
	fld dword ptr ds:[dbl_806140]
	fadd st,st(1)
	xor ebx,ebx
	mov bh,byte ptr ds:[eax+ offset dword_80E020]
	call _ftol
	fld dword ptr ds:[dword_80615C]
	mov bl,byte ptr ds:[eax+offset dword_80E020]
	fadd st,st(1)
	shl ebx,8
	call _ftol 
	fadd dword ptr ds:[dword_806158]
	xor ecx,ecx
	mov cl,byte ptr ds:[eax+offset dword_80E020]
	or ebx,ecx
	shl ebx,8
	call _ftol 
	xor edx,edx
	mov dl,byte ptr ds:[eax+offset dword_80E020]
	or ebx,edx
	mov eax,ebx
	je @dumped__008017f6
	lea ecx,dword ptr ds:[edi+esi]
	mov dword ptr ds:[ecx*4+offset dword_82F4F8],eax
	
	@dumped__008017f6:
	
	inc esi
	cmp esi,ebp
	mov dword ptr ss:[esp+01ch],esi
	jl @dumped__00801779
	fstp st
	fstp st
	
	@dumped__00801807:
	
	mov eax,dword ptr ss:[esp+030h]
	mov ecx,dword ptr ss:[esp+024h]
	inc eax
	add edi,0168h
	cmp eax,ecx
	mov dword ptr ss:[esp+030h],eax
	jl @dumped__00801748
	pop ebx
	
	@dumped__00801823:
	
	pop edi
	pop esi
	pop ebp
	pop ecx
	retn                                         ;<= Procedure End


Draw_MainText:                               ;<= Procedure Start

	mov eax,dword ptr ds:[dword_80E2C8]
	sub esp,8
	push ebx
	xor ebx,ebx
	cmp eax,ebx
	jle @dumped__00801f19
	push ebp
	push esi
	mov esi,dword ptr ds:[dword_82F4F0]
	push edi
	mov dword ptr ss:[esp+010h],ebx
	
	@dumped__00801e70:
	
	xor edi,edi
	lea ebp,dword ptr ds:[ebx+ offset MainText]
	
	@dumped__00801e78:
	
	cmp byte ptr ss:[ebp],02ah
	jnz @dumped__00801ef4
	lea eax,dword ptr ds:[ebx+esi*2]
	mov ecx,esi
	add ecx,eax
	push 7
	shl ecx,5
	mov dword ptr ss:[esp+018h],ecx
	push 7
	fild dword ptr ss:[esp+01ch]
	push 0
	push 0
	push 7
	push 7
	fmul qword ptr ds:[dbl_806170]
	fsin
	fmul qword ptr ds:[dbl_806168]
	call _ftol        
	mov ecx,dword ptr ss:[esp+028h]
	sar eax,8
	lea edx,dword ptr ds:[eax+edi+030h]
	lea eax,dword ptr ds:[esi+esi*2]
	push edx
	lea edx,dword ptr ds:[ecx+eax*8]
	mov dword ptr ss:[esp+030h],edx
	fild dword ptr ss:[esp+030h]
	fmul qword ptr ds:[dbl_806170]
	fsin
	fmul qword ptr ds:[dbl_806168]
	call _ftol    
	sar eax,5
	mov ecx,0aah
	sub ecx,eax
	push ecx
	call @dumped__008016c0   
	mov eax,dword ptr ds:[dword_80E2C8]
	add esp,020h
	
	@dumped__00801ef4:
	
	add edi,9
	add ebp,eax
	cmp edi,048h
	jl @dumped__00801e78
	mov edx,dword ptr ss:[esp+010h]
	inc ebx
	add edx,040h
	cmp ebx,eax
	mov dword ptr ss:[esp+010h],edx
	jl @dumped__00801e70
	pop edi
	pop esi
	pop ebp
	
	@dumped__00801f19:
	
	pop ebx
	add esp,8
	retn                                         ;<= Procedure End


end start
