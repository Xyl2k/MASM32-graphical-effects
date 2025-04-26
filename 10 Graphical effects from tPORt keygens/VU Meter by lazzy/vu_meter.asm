
comment */

	included in:
	
	- Altdo_AVI_MPEG_RM_WMV_MOV_ASF_Converter&Burner_v2.2.Patch.LaZzy.tPORt.zip
	- Amor_Photo_Downloader_1.4.Patch.LaZzy.tPORt.zip
	- CoffeeCup_Visual_Site_Designer_v5.8.Patch.LaZzy.tPORt.zip
	- ConvertVid_v1.0.0.18.Patch.LaZzy.tPORt.zip
	- Core_FTP_pro_v2.0.Patch.LaZzy.tPORt.zip
	- DreamCoder_for_MySQL_Enterprise_v4.4.Patch.LaZzy.tPORt.zip
	- Extended_Hex_Editor_Delphi_5_VCL_Control_v1.1.Patch.LaZzy.tPORt.zip
	- FairStars_Recorder_3.10.Patch.LaZzy.tPORt.zip
	- FirmTools_Panorama_Composer_v_3.1.Patch.LaZzy.tPORt.zip
	- iPod_PC_Transfer.Patch.LaZzy.tPORt.zip
	- Jam_ShellBrowser_Components_for_Delphi_v6.03.Patch.LaZzy.tPORt.zip
	- JamDTA_Component_for_Delphi.Patch.LaZzy.tPORt.zip
	- PC_Washer__V2.0.0.Patch.LaZzy.tPORt.zip
	- Personnal_avi_to_Video_Converter_all.Patch.LaZzy.tPORt.zip
	- TuneUp_Utilities_2007_v_6.0.2200.Patch.LaZzy.tPORt.zip
	
	coded initially by LaZzy, ripped by r0ger.
	
*/

vuInit		PROTO	:DWORD
vuMeter		PROTO	:DWORD

.const
vuWidth		equ	5
vuHeight	equ	8

.data

vuRC			RECT <>
vuCol_Low1 db 0E1h
vuCol_Low2 db 0E1h
vuCol_Low3 db 0E1h
vuCol_Mid1 db 0B5h
vuCol_Mid2 db 0B5h
vuCol_Mid3 db 0B5h
vuCol_High db 0FFh
vuCol_foregr1 db 0
vuCol_foregr2 db 0
vuCol_foregr3 db 0
vuCol_foregr4 db 0
vuCol_foregr5 db 0
vu_xPos dd 245
vu_yPos dd 49
nWidth 	dd 78h
nHeight dd 19h
vu_L 	dd 0
vu_R 	dd 0
vuDC 	dd 0
hDC 	dd 0
h 		dd 0
vuMeterBg 	 dd 0

.data?
vuMeterId	dd	?


.code
vuInit proc near hWnd:DWORD

		call vuBgInit
		invoke GetDC,hWnd
		mov vuDC, eax
		invoke CreateThread,0,0,offset vuMeter,0,0,offset vuMeterId
		mov vuMeterId, eax
		ret

vuInit endp

vuBgInit proc near

		invoke CreateCompatibleDC,0
		mov hDC, eax
		invoke CreateBitmap,nWidth,nHeight,1,20h,0
		mov h, eax
		invoke CreateCompatibleDC,0
		mov vuMeterBg, eax
		invoke SelectObject,hDC,h
		invoke SelectObject,vuMeterBg,hIMG
		ret

vuBgInit endp

vuMeter proc near lpThreadParameter:DWORD
LOCAL var_13:BYTE
LOCAL var_12:BYTE
LOCAL var_11:BYTE
LOCAL var_10:DWORD
LOCAL var_C:DWORD
LOCAL var_8:DWORD


loc_40ED42:
		call uFMOD_GetStats ; <--- !! iMPORTANT - to make VU meter sync with XM !! ---
		xor ecx, ecx
		mov cx, ax
		push eax
		call vuChInit
		mov vu_L, eax
		pop ecx
		shr ecx, 10h
		call vuChInit
		mov vu_R, eax
		invoke BitBlt,hDC,0,0,nWidth,nHeight,vuMeterBg,vu_xPos,vu_yPos,SRCCOPY
		mov [var_10], 2
		xor eax, eax
		xor esi, esi
		mov eax, 0
		mov [var_8], eax

loc_40EDAA:
		pusha
		mov eax, [var_10]
		test eax, eax
		jz loc_40EF08
		cmp eax, 2
		jnz loc_40EDC4
		mov eax, 5
		mov edi, eax
		jmp loc_40EDCB

loc_40EDC4:
		mov eax, 0Fh
		mov edi, eax

loc_40EDCB:
		mov edx, 10h
		mov esi, 5
		add esi, 1

loc_40EDD8:
		mov eax, 5
		add eax, 1
		add eax, esi
		pusha
		mov al, vuCol_foregr5
		push eax 	; char
		mov al, vuCol_foregr4
		push eax 	; char
		mov al, vuCol_foregr3
		push eax 	; char
		push vuHeight 	; int
		push vuWidth 	; int
		push edi 	; int
		push esi 	; int
		push hDC 	; hDC
		call InitVuBar
		popa
		mov esi, eax
		dec edx
		test edx, edx
		jnz loc_40EDD8
		popa
		mov eax, [var_10]
		test eax, eax
		jz loc_40EF08
		cmp eax, 2
		jnz loc_40EE36
		mov eax, vu_L
		test eax, eax
		jz loc_40EEF1
		mov eax, 5
		mov [var_C], eax
		jmp loc_40EE4B

loc_40EE36:
		mov eax, vu_R
		test eax, eax
		jz loc_40EEF1
		mov eax, 0Fh
		mov [var_C], eax

loc_40EE4B:
		mov eax, 5
		add eax, 1
		add eax, [var_8]
		mov [var_8], eax
		cmp esi, 7
		jg loc_40EE78
		mov al, vuCol_Low1
		mov [var_11], al
		mov al, vuCol_Low2
		mov [var_12], al
		mov al, vuCol_Low3
		mov [var_13], al
		jmp loc_40EEAF

loc_40EE78:
		cmp esi, 0Bh
		jg loc_40EE97
		mov al, vuCol_Mid1
		mov [var_11], al
		mov al, vuCol_Mid2
		mov [var_12], al
		mov al, vuCol_Mid3
		mov [var_13], al
		jmp loc_40EEAF

loc_40EE97:
		mov al, vuCol_High
		mov [var_11], al
		mov al, vuCol_foregr1
		mov [var_12], al
		mov al, vuCol_foregr2
		mov [var_13], al

loc_40EEAF:
		mov al, [var_13]
		push eax 	; char
		mov al, [var_12]
		push eax 	; char
		mov al, [var_11]
		push eax 	; char
		push vuHeight 	; int
		push vuWidth 	; int
		push [var_C] ; int
		push [var_8] ; int
		push hDC 	; hDC
		call InitVuBar
		inc esi
		cmp [var_10], 2
		jnz loc_40EEE5
		cmp esi, vu_L
		jl loc_40EE4B
		jmp loc_40EEF1

loc_40EEE5:
		cmp esi, vu_R
		jl loc_40EE4B

loc_40EEF1:
		mov eax, 0
		mov esi, eax
		mov eax, 0
		mov [var_8], eax
		dec [var_10]
		jmp loc_40EDAA

loc_40EF08:
		invoke BitBlt,vuDC,vu_xPos,vu_yPos,nWidth,nHeight,hDC,0,0,SRCCOPY
		invoke Sleep,10 ;0Fh
		jmp loc_40ED42

vuMeter endp

vuChInit proc near

var_4 	= dword ptr -4

		test ecx, ecx
		push ecx
		jz loc_40EC74
		fldlg2
		fild [esp+4+var_4]
		fyl2x
		fldpi
		fmulp st(1), st
		fistp [esp+4+var_4]

loc_40EC74:
		pop eax
		retn
vuChInit endp

InitVuBar proc near _hDC:DWORD,arg_4:DWORD,arg_8:DWORD,arg_C:DWORD,arg_10:DWORD,arg_14:BYTE,arg_18:BYTE,arg_1C:BYTE
LOCAL hbr:DWORD

		xor eax, eax
		mov al, byte ptr [arg_1C]
		rol eax, 8
		mov al, byte ptr [arg_18]
		rol eax, 8
		mov al, byte ptr [arg_14]
		invoke CreateSolidBrush,eax
		mov dword ptr [hbr], eax
		push dword ptr [arg_4]
		pop dword ptr [vuRC.left]
		push dword ptr [arg_8]
		pop dword ptr [vuRC.top]
		mov eax, dword ptr [arg_4]
		add dword ptr [arg_C], eax
		push dword ptr [arg_C]
		pop dword ptr [vuRC.right]
		mov eax, dword ptr [arg_8]
		add dword ptr [arg_10], eax
		push dword ptr [arg_10]
		pop dword ptr [vuRC.bottom]
		push dword ptr [hbr] ; hbr
		lea eax, dword ptr [vuRC]
		push eax 	; lprc
		push dword ptr [_hDC] ; hDC
		call FillRect
		invoke DeleteObject,dword ptr [hbr]
		ret

InitVuBar endp
