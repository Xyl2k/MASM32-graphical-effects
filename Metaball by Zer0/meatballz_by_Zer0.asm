
comment */

  Zer0's version of meatballs effect from WDYL keygens like:
  
  - Flash2X.Flash.Hunter.v2.0.1.Incl.Keygen-WDYL
  - Becky.Internet.Mail.v2.20.01.Incl.Keygen-WDYL
  - Xara.3D.v6.0.Keygen.Only-WDYL
  - WinTools.Net.Professional.v6.0.Incl.Keygen-WDYL
  - WinBoost.v4.90.Keygen.Only-WDYL
    (...and basically a few other keygens with the same temp.)
    
  and btw..
  
  the fileid.inc is a new file_id for PRF, drawn by H7[iMPURE/TiTAN], thanx 2 him.
  used bin2dbex to convert the custom ascii chars.
  (p.s. this would be also used when i'm also gonna get a new NFO from other TiTAN 
  ascii artists...but first i really need to draw him a graffiti with his name on 
  it as a..."payment" :v...then i'll get to 5m's instagram to contact him for the 
  new nfo for PRF.
  
  ripped and recoded by r0ger^PRF.
  
/*

MeatballzInit  PROTO	:DWORD
StartMeatballz PROTO

.const
BoxWidth	equ	105h
BoxHeight	equ	5Bh

xPos		equ 0CDh
yPos		equ 10

.data 
include fileid.inc
Logfont LOGFONT <8,6,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY, 0,"Terminal">

; once again,array of dwords & floatz.

dword_4073A4 	dd    2
dword_4073A8 	dd 	  0Ah
flt_4073AC 		real4 150.0
flt_4073B0 		real4 310.0
flt_4073B4 		real4 15.0
flt_4073B8 		real4 20.0
flt_4073BC 		real4 80.0
flt_4073C0 		real4 100.0
flt_4073C4		real4 12.0
flt_4073C8		real4 20.0
flt_4073CC 		real4 450.0
flt_4073D0 		real4 250.0
flt_4073D4 		real4 35.0
flt_4073D8 		real4 15.0
flt_4073DC 		real4 310.0
flt_4073E0 		real4 150.0
flt_4073E4 		real4 75.0
flt_4073E8 		real4 9.0
dword_407490 	dd 	  0BC614Eh

.data?
ppvBits 		dd ?
hdc 			dd ?
MeatballzDC 	dd ?
MeatballzId 	dd ?
ThreadId 		dd ?
TextLength 		dd ?
ArrSea 			RECT <?>
dword_4074E8 	dd ?
dword_4074EC 	dd ?
dword_4074F0 	dd ?
dword_4074F4 	dd ?
dword_4074F8 	dd ?

.code

MeatballzInit proc near hWnd:DWORD
LOCAL bmi:BITMAPINFO

		invoke GetWindowDC,hWnd
		mov MeatballzDC, eax
		invoke CreateCompatibleDC,0
		mov hdc, eax
		push 0
		push 2Ch
		lea eax, [bmi]
		push eax
		call MemInit
		mov [bmi.bmiHeader.biSize], 28h
		mov [bmi.bmiHeader.biBitCount], 20h
		mov eax, BoxWidth
		imul eax, 4
		imul eax, BoxHeight
		mov [bmi.bmiHeader.biSizeImage], eax
		mov [bmi.bmiHeader.biPlanes], 1
		mov [bmi.bmiHeader.biWidth], BoxWidth
		mov [bmi.bmiHeader.biHeight], BoxHeight
		push 0 	; offset
		push 0 	; hSection
		push offset ppvBits ; ppvBits
		push 0 	; usage
		lea eax, [bmi]
		push eax 	; lpbmi
		push 0 	; hdc
		call CreateDIBSection
		invoke SelectObject,hdc,eax
		invoke CreateFontIndirect,addr Logfont
		invoke SelectObject,hdc,eax
		invoke SetBkMode,hdc,1
		invoke SetTextColor,hdc,White
		push offset VerticalTxt
		call TextProc
		mov TextLength, eax
		invoke CreateThread,0,0,offset StartMeatballz,0,0,offset ThreadId
		mov MeatballzId, eax
		invoke SetThreadPriority,eax,THREAD_PRIORITY_ABOVE_NORMAL
		ret
MeatballzInit endp

MemInit proc near

arg_0 	= dword ptr  8
arg_4 	= dword ptr  0Ch
arg_8 	= dword ptr  10h

		push ebp
		mov ebp, esp
		mov edx, [ebp+arg_0]
		mov eax, [ebp+arg_8]
		mov ecx, [ebp+arg_4]
		shr ecx, 5
		cmp ecx, 0
		jz loc_401EB1

loc_401E94:
		mov [edx], eax
		mov [edx+4], eax
		mov [edx+8], eax
		mov [edx+0Ch], eax
		mov [edx+10h], eax
		mov [edx+14h], eax
		mov [edx+18h], eax
		mov [edx+1Ch], eax
		add edx, 20h
		dec ecx
		jnz loc_401E94

loc_401EB1:
		and [ebp+arg_4], 1Fh
		cmp [ebp+arg_4], 0
		jz locret_401EC9
		mov ecx, [ebp+arg_4]
		shr ecx, 2

loc_401EC1:
		mov [edx], eax
		add edx, 4
		dec ecx
		jnz loc_401EC1

locret_401EC9:
		leave
		retn 0Ch
MemInit endp
TextProc proc near

arg_0 	= dword ptr  8

		push ebp
		mov ebp, esp
		mov eax, [ebp+arg_0]
		sub eax, 4

loc_401DE9:
		add eax, 4
		cmp byte ptr [eax], 0
		jz loc_401E21
		cmp byte ptr [eax+1], 0
		jz loc_401E17
		cmp byte ptr [eax+2], 0
		jz loc_401E0D
		cmp byte ptr [eax+3], 0
		jnz loc_401DE9
		sub eax, [ebp+arg_0]
		add eax, 3
		leave
		retn 4

loc_401E0D:
		sub eax, [ebp+arg_0]
		add eax, 2
		leave
		retn 4

loc_401E17:
		sub eax, [ebp+arg_0]
		add eax, 1
		leave
		retn 4

loc_401E21:
		sub eax, [ebp+arg_0]
		leave
		retn 4
TextProc endp
StartMeatballz proc near

var_8 	= dword ptr -8
yTop 	= dword ptr -4
lpThreadParameter= dword ptr  8

		push ebp
		mov ebp, esp
		add esp, 0FFFFFFF8h
		push BoxHeight
		pop [ebp+yTop]
		mov [ebp+var_8], 2

loc_4014BB:
		call DrawProc
		invoke SetRect,offset ArrSea,0,[ebp+yTop],BoxWidth,BoxHeight
		invoke DrawText,hdc,offset VerticalTxt,TextLength,offset ArrSea,DT_NOCLIP
		invoke BitBlt,MeatballzDC,xPos,yPos,BoxWidth,BoxHeight,hdc,0,0,SRCCOPY
		cmp [ebp+yTop], 0FFFFFF14h ; <-- end position
		jg loc_401529
		push BoxHeight
		pop [ebp+yTop]

loc_401529:
		dec [ebp+var_8]
		cmp [ebp+var_8], 1
		jnz loc_40153C
		dec [ebp+yTop]
		mov [ebp+var_8], 4

loc_40153C: 			
		invoke Sleep,12
		jmp loc_4014BB
StartMeatballz endp
DrawProc proc near
		push edi
		push esi
		push ebx
		mov edi, ppvBits
		xor ecx, ecx

loc_401411:
		push ecx
		push 78h
		call Rndproc
		mov ebx, eax
		rol eax, 10h
		mov ah, bl
		mov al, ah
		pop ecx
		mov [edi], eax
		inc ecx
		add edi, 4
		cmp ecx, 5E28h
		jnz loc_401411
		call MeatballFloat
		mov edi, ppvBits
		xor ecx, ecx
		xor ebx, ebx
		xor esi, esi

loc_401442:
		inc ebx
		cmp ebx, BoxWidth
		jnz loc_40144E
		xor ebx, ebx
		inc esi

loc_40144E:
		cmp ebx, 1
		jbe loc_401499
		cmp esi, 0
		jbe loc_401499
		cmp ebx, BoxWidth-1
		jnb loc_401499
		cmp esi, BoxHeight-1
		jnb loc_401499
		push ecx
		push esi
		push ebx
		call MeatballSizing
		cmp eax, 1F4h
		jbe loc_401481
		mov eax, [edi]
		and eax, 0FEFEFEh
		shr eax, 1
		mov [edi], eax
		jmp loc_401498

loc_401481:
		cmp eax, 1C2h
		jbe loc_401498
		mov eax, [edi]
		and eax, 0FEFEFEh
		add eax, 00FF5E5Eh
		shr eax, 1
		mov [edi], eax

loc_401498:
		pop ecx

loc_401499:
		add edi, 4
		inc ecx
		cmp ecx, 5E28h
		jnz loc_401442
		pop ebx
		pop esi
		pop edi
		retn
DrawProc endp

Rndproc proc near

arg_0 	= dword ptr  8

		push ebp
		mov ebp, esp
		mov eax, dword_407490
		xor edx, edx
		mov ecx, 1F31Dh
		div ecx
		mov ecx, eax
		mov eax, 41A7h
		mul edx
		mov edx, ecx
		mov ecx, eax
		mov eax, 0B14h
		mul edx
		sub ecx, eax
		xor edx, edx
		mov eax, ecx
		mov dword_407490, ecx
		div [ebp+arg_0]
		mov eax, edx
		leave
		retn 4
Rndproc endp

MeatballFloat proc near
		call GetTickCount
		mov dword_4073A8, eax
		fild dword_4073A8
		fdiv flt_4073AC
		fcos
		fmul flt_4073B4
		fistp dword_4073A4
		push dword_4073A4
		pop ArrSea.top
		add ArrSea.top, 14h
		fild dword_4073A8
		fdiv flt_4073B0
		fsin
		fmul flt_4073B8
		fistp dword_4073A4
		push dword_4073A4
		pop ArrSea.right
		add ArrSea.right, 39h
		fild dword_4073A8
		fdiv flt_4073BC
		fcos
		fmul flt_4073C4
		fistp dword_4073A4
		push dword_4073A4
		pop ArrSea.bottom
		add ArrSea.bottom, 37h
		fild dword_4073A8
		fdiv flt_4073C0
		fsin
		fmul flt_4073C8
		fistp dword_4073A4
		push dword_4073A4
		pop dword_4074E8
		add dword_4074E8, 25h
		fild dword_4073A8
		fdiv flt_4073CC
		fcos
		fmul flt_4073D4
		fistp dword_4073A4
		push dword_4073A4
		pop dword_4074EC
		add dword_4074EC, 37h
		fild dword_4073A8
		fdiv flt_4073D0
		fsin
		fmul flt_4073D8
		fistp dword_4073A4
		push dword_4073A4
		pop dword_4074F0
		add dword_4074F0, 11h
		fild dword_4073A8
		fdiv flt_4073DC
		fcos
		fmul flt_4073E4
		fistp dword_4073A4
		push dword_4073A4
		pop dword_4074F4
		add dword_4074F4, 37h
		fild dword_4073A8
		fdiv flt_4073E0
		fsin
		fmul flt_4073E8
		fistp dword_4073A4
		push dword_4073A4
		pop dword_4074F8
		add dword_4074F8, 25h
		retn
MeatballFloat endp

MeatballSizing proc near

arg_0 	= dword ptr  8
arg_4 	= dword ptr  0Ch

		push ebp
		mov ebp, esp
		push esi
		push edi
		push ebx
		mov esi, (offset ArrSea+4)
		xor edi, edi
		xor ebx, ebx

loc_40124D:
		mov eax, [esi]
		sub eax, [ebp+arg_0]
		cdq
		mul eax
		mov ecx, eax
		mov eax, [esi+4]
		sub eax, [ebp+arg_4]
		cdq
		mul eax
		add eax, ecx
		or eax, eax
		jnz loc_401274
		mov eax, 0FFFFFFFFh
		pop ebx
		pop edi
		pop esi
		leave
		retn 8
		jmp loc_401281

loc_401274:
		xor edx, edx
		mov ecx, eax
		mov eax, 2BF20h
		div ecx
		add ebx, eax

loc_401281:
		add esi, 8
		inc edi
		cmp edi, 4
		jnz loc_40124D
		mov eax, ebx
		pop ebx
		pop edi
		pop esi
		leave
		retn 8
MeatballSizing endp