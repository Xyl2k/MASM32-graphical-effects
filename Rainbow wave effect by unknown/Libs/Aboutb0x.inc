; ---- Prototypes ---------------------------------------------------------
UpdateScroller		proto
CreateTVBox 		proto :dword
UpdateTVBox 		proto
Random 				proto :dword
BallSize 			proto :dword,:dword
BallFpu 			proto
DrawColorScroller	proto

; ---- Initialized data ---------------------------------------------------
.data
AboutFont LOGFONT	<13,6,NULL,NULL,0,FALSE,FALSE,FALSE,OEM_CHARSET,OUT_DEFAULT_PRECIS,\
			CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,DEFAULT_PITCH,"Terminal">

nrandom_seed	dd "O63."

szAboutText		db 13
db 13
db "              �  �             �߰��         ����",13
db "߰���   ����  ��     ��������� �߰����  ���        ܲ� �����߰����",13
db " ���  ��� ���߱��� ���۰��  ������  ��������      ���  ��  ���  ���",13
db " ��� ���� ��  ��� � ��۱���ܰ�۱���߱�  ���       ������   ����߱�",13
db " ��� ���  �   ���   ��۰��  �� ���  ���ܱ��� ܲ������ �    ���  ���",13
db "�    ���߰�� ���     ���      ���  ��  ��   ߱��� ��      ���  ��",13
db "     �   �                  �                           �",13
db 13
db " �߰��  �   ��         �߰��       �          �߰��          �   ��",13
db " ���  ��� ���   �      ��� ߰���������� ߰��� ���         ܱ�� ���",13
db "����� �� ߰�� ܲ�  �� ����� ��� ���  ��� ��� �����ܲ�����ܰ�� ߰��",13
db " ���  ��  ��� ���  ��� ���  ��� ����ܰ�� ���  ��� ���  ������  ���",13
db "ܱ��� ��  ��� ���  ���ܱ��� ��� ���  ��  ��� ܱ��ܰ��  ��� ��  ���",13
db " ��        ��  ����    ��   �   ��       �    ��  ��������      ��",13
db 13
db "ܲ",13
db "ܲ��",13
db " ���",13
db " ���",13
db " ���",13
db " �",13
db "CYBERCRiME-TRACKER.NET",13
db "� � �#� p r e z e n t s �#� � �",13
db 13
db "�   A � N E W � R E L E A S E � C A L L E D :   �",13
db "������������������������������������������������������������������������������",13
db "TEMARi.FR iNViTATiON 1",13
db "������������������������������������������������������������������������������",13
db 13
db "�������������������������Ĵ RELEASE iNFO �������������������������Ŀ",13
db "������������������������������������������������������������������������Ŀ",13
db "�                                                                        �",13
db "�  SUPPLiER   : XYLiTOL                RELEASE DATE  : 04-02-17          �",13
db "�  PACKAGER   : XYLiTOL                DiSKS         : 1                 �",13
db "�  CRACKER    : N/A                    SOFTWARE TYPE : iNViTATiON        �",13
db "�  PROTECTION : N/A                    DiFiCULTY     : [��        ]      �",13
db "�                                                                        �",13
db "�                     TEMARi.FR.iNViTATiON.1.zip                         �",13
db "�                                                                        �",13
db "�����[DESCRiPTiON]������������������������������������������������������Ĵ",13
db "�                                                                        �",13
db "�  FiND THE SERiAL FOR: iNViTATiON                                       �",13
db "�  Win32asm > *                                                          �",13
db "�                                                                        �",13
db "�                                                                        �",13
db "�                                                                        �",13
db "��������������������������������������������������������������������������",13
db 13
db " ������������������������������������������������������������������������������",13
db "GREETiNGS TO ALL OUR FRiENDS  ....BECAUSE NOBODY iS COOL AS WE ARE.....",13
db 13
db 13
db 13
db "������������������������������������������������������������������������������",13
db "MEMBERS AND BOARDS ARE NOT SHOWN BECAUSE THE FUNNY BUSTS EVERYWHERE",13
db "BUT WE HOPE THAT YOU KNOW OUR MEMBERS AND OUR FiRST NODE ELiTE BOARDS.",13
db "������������������������������������������������������������������������������",13
db 13
db 13
db "CRUSHiNG THE COMPETiTiON",13
db "CYBERCRiME-TRACKER",13
db 0


; ---- Uninitialized data -------------------------------------------------
.data?
szbla		dd	30 dup (?)
WX   		equ 476
WY   		equ 202
left 		equ 0
top  		equ 30
ppv			dd	?
srcdc		dd	?
hdcx		dd	?
thread		dd	?
threadID	dd	?

; ---- Code ---------------------------------------------------------------
.code
divisor:
dd 700.000
dd 25.00000
dd 435.000
dd 22.00000
dd 480.000
dd 42.00000
dd 412.000
dd 22.00000
dd 450.000
dd 25.00000
dd 435.000
dd 41.00000
dd 410.000
dd 65.00000
dd 475.000
dd 21.00000

position:
dd WX/2
dd WX/5
dd WY
dd WX/4
dd WX/2
dd WX/6
dd WX/2
dd WX/5

; -------------------------------------------------------------------------
align dword
align 4
UpdateScroller proc 
	local rect:RECT
	local int_position:dword
	local local_match:dword

	mov int_position, WY
	mov local_match,2

	@@:
    invoke UpdateTVBox   
    
	invoke SetRect,addr rect, left,  int_position, WX, WY
	invoke lstrlen,addr szAboutText
	mov edi,eax
	invoke DrawText,srcdc,addr szAboutText,edi,addr rect,DT_CENTER or DT_TOP
	invoke  BitBlt, hdcx, left, top, WX, WY, srcdc, 0, 0, SRCCOPY

        	.if int_position == -0300h ; Reset position
	mov int_position, WY
	.endif

	dec local_match

	 .if local_match == 1
	dec int_position
	mov local_match,4
	.endif

	invoke Sleep,13

	jmp @B
	ret
UpdateScroller endp

align 4
CreateTVBox proc hwnd:dword
	local bmpi:BITMAPINFO

	invoke GetWindowDC,hwnd
	mov hdcx,eax
	invoke CreateCompatibleDC, eax
	mov srcdc, eax
	invoke RtlZeroMemory,addr bmpi, sizeof BITMAPINFO
	mov bmpi.bmiHeader.biSize, sizeof bmpi.bmiHeader
	mov bmpi.bmiHeader.biBitCount, 32
	mov eax,WX
	imul eax,eax,4
	imul eax,eax,WY
	mov bmpi.bmiHeader.biSizeImage, eax
	mov bmpi.bmiHeader.biPlanes, 1
	mov bmpi.bmiHeader.biWidth, WX
	mov bmpi.bmiHeader.biHeight, WY
 	invoke  CreateDIBSection, srcdc, addr bmpi, DIB_RGB_COLORS, addr ppv, 0, 0
	invoke  SelectObject, srcdc, eax
	invoke CreateFontIndirect,addr AboutFont
	invoke  SelectObject, srcdc, eax
	invoke  SetBkMode, srcdc, TRANSPARENT
	invoke  SetTextColor, srcdc, 0FEFEFEh ;0B0CDA8h

	invoke CreateThread,0,0,offset UpdateScroller,0,0,addr thread
	mov threadID,eax
	invoke SetThreadPriority,eax,THREAD_PRIORITY_LOWEST
	ret
CreateTVBox endp
align 4

UpdateTVBox proc uses edi esi ebx

	mov edi,ppv
        	xor ecx,ecx
	xor esi,esi

	.while ecx != WX*WY

		.if ebx  == 1 && esi  == 0  &&  ebx == WX-1 && esi == WY-1
		xor eax, eax
		.else
		push ecx
		invoke Random, 150
		add al, 9
		mov ah, al
		shl eax, 8
		mov al, ah
		pop ecx
		.endif
		stosd
		inc ebx
		.if ebx == WX
		xor ebx, ebx
		inc esi
		.endif
		inc ecx
		.endw

	invoke BallFpu
	mov edi,ppv
	xor  ecx, ecx
	xor ebx,ebx
	xor esi,esi

	.while ecx != WX*WY

		inc ebx

		.if ebx == WX
		xor ebx,ebx
		inc esi
		.endif

		.if ebx  > 1 && esi  > 0  &&  ebx < WX-1 && esi < WY-1

		push ecx
		invoke BallSize,ebx,esi

		.if eax > 500

		mov eax,dword ptr [edi]
		and eax,0FEFEFEh
		shr eax,1
		mov dword ptr [edi],eax

		.else

		.if eax > 400

		mov eax,dword ptr [edi]
		and eax,1
		add eax,1
		shr eax,1
		mov dword ptr [edi],eax

		.endif
		.endif

		pop ecx

		.endif

		add edi,4
		inc ecx
	.endw
	ret
UpdateTVBox endp

align 4

Random proc uses edx ecx, base:dword
	mov eax, nrandom_seed
	xor edx, edx
	mov ecx, 127773
	div ecx
	mov ecx, eax
	mov eax, 16807
	mul edx
	mov edx, ecx
	mov ecx, eax
	mov eax, 2836
	mul edx
	sub ecx, eax
	xor edx, edx
	mov eax, ecx
	mov nrandom_seed, ecx
	div base
	mov eax, edx
	ret
Random endp

align 4

BuildMatrix	Proc
;	*****************************
;	RGB Matrix, not needed here
;	*****************************
;		mov esi,hMatrix
;		mov x,0
;		mov y,0
;		mov R,255
;		mov G,0
;		mov B,0
;		mov R1,0
;		mov G1,0
;		mov B1,0
;		.repeat
;			.repeat
;				xor eax,eax
;				mov ecx,B
;				mov edx,B1
;				sub ecx,edx
;				mov ah,cl
;				rol eax,8
;				mov ecx,G
;				mov edx,G1
;				sub ecx,edx
;				mov ah,cl
;				mov ecx,R
;				mov edx,R1
;				add ecx,edx
;				mov al,cl
;				mov [esi],eax
;				add esi,4
;				invoke SetPixel,wDC,x,y,eax
;				inc G
;				.if G >= 255
;					inc G1
;				.endif
;				inc x
;			.until x == EFFECTS_WIDTH
;			mov x,0
;			mov G,0
;			mov G1,0
;			dec R
;			inc B
;				.if B >= 255
;					inc B1
;				.endif
;				.if R <= 0
;					inc R1
;				.endif
;			inc y
;		.until y == EFFECTS_HEIGHT
;	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
;
;	*****************************************************
;		HSV Matrix here, but only [344;1] vector needed
;		kinda lame implementation, but hey, it works :p
;	*****************************************************
	mov esi,hMatrix
	mov x,0
;	mov y,0
;	.repeat
		mov R,255
		mov G,0
		mov B,0
		.repeat
			xor eax,eax
			mov ecx,B
			mov ah,cl
			rol eax,8
			mov ecx,G
			mov ah,cl
			mov ecx,R
			mov al,cl
			mov [esi],eax
			add esi,4
			.if B1 != 1 && R >= 255 && B <= 0
				mov R,255
				mov B,0
				add G,5
				.if G >= 255
					mov G,255
					mov B1,1
				.endif
			.elseif B2 != 1 && G >= 255 && B <= 0
				mov G,255
				mov B,0
				sub R,5
				.if R == -1 ||  R == -2 ||  R == -3 || R <= 0
					mov R,0
					mov B2,1
				.endif
			.elseif B3 != 1 && R <= 0 && G >= 255
				mov R,0
				mov G,255
				add B,5
				.if B >= 255
					mov B,255
					mov B3,1
				.endif
			.elseif B4 != 1 && B >= 255 && R <= 0
				mov B,255
				mov R,0
				sub G,5
				.if  G == -1 ||  R == -2 ||  R == -3 ||  G <= 0
					mov G,0
					mov B4,1
				.endif
			.elseif B5 != 1 && G <= 0  && B >= 255
				mov G,0
				mov B,255
				add R,5
				.if R >= 255
					mov R,255
					mov B5,1
				.endif
			.elseif B6 != 1 && R >= 255 && G <= 0
				mov R,255
				mov G,0
				sub B,5
				.if  B == -1 ||  R == -2 ||  R == -3 ||  B <= 0
					mov B,0
					mov B6,1
				.endif
			.endif
			inc x
		.until x == EFFECTS_WIDTH
		mov x,0
		mov B1,0
		mov B2,0
		mov B3,0
		mov B4,0
		mov B5,0
		mov B6,0
;		inc y
;	.until y == EFFECTS_HEIGHT
;	mov y,0
	Ret
BuildMatrix endp

BallFpu proc
	local local_match:dword
	local local_result:dword

	invoke GetTickCount
	mov local_match,eax
	mov local_result,0
	xor edi,edi
	xor edx,edx
       
	.while edi != 16
		fild local_match
		fdiv dword ptr [divisor+edi*4]
		fcos
		inc edi	
		fmul dword ptr [divisor+edi*4]
		fistp local_result
		push local_result
		pop dword ptr [szbla+edx*4]
		mov eax,dword ptr [position+edx*4]
		add dword ptr [szbla+edx*4],eax
		fild local_match
		inc edi
		fdiv  dword ptr [divisor+edi*4]
		fsin
		inc edi
		fmul  dword ptr [divisor+edi*4]
		fistp local_result
		push local_result
		inc edx
		pop dword ptr [szbla+edx*4]
		mov eax,dword ptr [position+edx*4]
		add dword ptr [szbla+edx*4],eax
		inc edi
		inc edx
	.endw

	ret

BallFpu endp

align 4
BallSize proc uses esi edi ebx a:dword,b:dword
	mov esi,offset szbla
	xor edi,edi
	xor ebx,ebx

	.while edi != 4
		mov eax,dword ptr [esi]
		sub eax,a
		cdq
		mul eax
		mov ecx,eax
		mov eax,dword ptr [esi+4]
		sub eax,b
		cdq
		mul eax
		add eax,ecx
		.if !eax
		mov eax,-1
		ret
		.endif
		xor edx,edx
		mov ecx,eax
		mov eax,0445C4h
		div ecx
		add ebx,eax
		add esi,8
		inc edi
	.endw
	mov eax,ebx
	ret
BallSize endp