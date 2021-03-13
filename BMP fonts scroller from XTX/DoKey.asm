AboutProc	PROTO:DWORD,:DWORD,:DWORD,:DWORD
DoKey		   proto:DWORD,:DWORD,:DWORD,:DWORD

.data


szDefault		db	"Keygen coded by sp0ke",0

TABLE2  dd 000000000h, 077073096h, 0EE0E612Ch, 0990951BAh, 0076DC419h, 0706AF48Fh, 0E963A535h, 09E6495A3h
db 032h, 088h, 0DBh, 00Eh, 0A4h, 0B8h, 0DCh, 079h
db 01Eh, 0E9h, 0D5h, 0E0h, 088h, 0D9h, 0D2h, 097h
db 02Bh, 04Ch, 0B6h, 009h, 0BDh, 07Ch, 0B1h, 07Eh
db 007h, 02Dh, 0B8h, 0E7h, 091h, 01Dh, 0BFh, 090h
db 064h, 010h, 0B7h, 01Dh, 0F2h, 020h, 0B0h, 06Ah
db 048h, 071h, 0B9h, 0F3h, 0DEh, 041h, 0BEh, 084h
db 07Dh, 0D4h, 0DAh, 01Ah, 0EBh, 0E4h, 0DDh, 06Dh
db 051h, 0B5h, 0D4h, 0F4h, 0C7h, 085h, 0D3h, 083h
db 056h, 098h, 06Ch, 013h, 0C0h, 0A8h, 06Bh, 064h
db 07Ah, 0F9h, 062h, 0FDh, 0ECh, 0C9h, 065h, 08Ah
db 04Fh, 05Ch, 001h, 014h, 0D9h, 06Ch, 006h, 063h
db 063h, 03Dh, 00Fh, 0FAh, 0F5h, 00Dh, 008h, 08Dh
db 0C8h, 020h, 06Eh, 03Bh, 05Eh, 010h, 069h, 04Ch
db 0E4h, 041h, 060h, 0D5h, 072h, 071h, 067h, 0A2h
db 0D1h, 0E4h, 003h, 03Ch, 047h, 0D4h, 004h, 04Bh
db 0FDh, 085h, 00Dh, 0D2h, 06Bh, 0B5h, 00Ah, 0A5h
db 0FAh, 0A8h, 0B5h, 035h, 06Ch, 098h, 0B2h, 042h
db 0D6h, 0C9h, 0BBh, 0DBh, 040h, 0F9h, 0BCh, 0ACh
db 0E3h, 06Ch, 0D8h, 032h, 075h, 05Ch, 0DFh, 045h
db 0CFh, 00Dh, 0D6h, 0DCh, 059h, 03Dh, 0D1h, 0ABh
db 0ACh, 030h, 0D9h, 026h, 03Ah, 000h, 0DEh, 051h
db 080h, 051h, 0D7h, 0C8h, 016h, 061h, 0D0h, 0BFh
db 0B5h, 0F4h, 0B4h, 021h, 023h, 0C4h, 0B3h, 056h
db 099h, 095h, 0BAh, 0CFh, 00Fh, 0A5h, 0BDh, 0B8h
db 09Eh, 0B8h, 002h, 028h, 008h, 088h, 005h, 05Fh
db 0B2h, 0D9h, 00Ch, 0C6h, 024h, 0E9h, 00Bh, 0B1h
db 087h, 07Ch, 06Fh, 02Fh, 011h, 04Ch, 068h, 058h
db 0ABh, 01Dh, 061h, 0C1h, 03Dh, 02Dh, 066h, 0B6h
db 090h, 041h, 0DCh, 076h, 006h, 071h, 0DBh, 001h
db 0BCh, 020h, 0D2h, 098h, 02Ah, 010h, 0D5h, 0EFh
db 089h, 085h, 0B1h, 071h, 01Fh, 0B5h, 0B6h, 006h
db 0A5h, 0E4h, 0BFh, 09Fh, 033h, 0D4h, 0B8h, 0E8h
db 0A2h, 0C9h, 007h, 078h, 034h, 0F9h, 000h, 00Fh
db 08Eh, 0A8h, 009h, 096h, 018h, 098h, 00Eh, 0E1h
db 0BBh, 00Dh, 06Ah, 07Fh, 02Dh, 03Dh, 06Dh, 008h
db 097h, 06Ch, 064h, 091h, 001h, 05Ch, 063h, 0E6h
db 0F4h, 051h, 06Bh, 06Bh, 062h, 061h, 06Ch, 01Ch
db 0D8h, 030h, 065h, 085h, 04Eh, 000h, 062h, 0F2h
db 0EDh, 095h, 006h, 06Ch, 07Bh, 0A5h, 001h, 01Bh
db 0C1h, 0F4h, 008h, 082h, 057h, 0C4h, 00Fh, 0F5h
db 0C6h, 0D9h, 0B0h, 065h, 050h, 0E9h, 0B7h, 012h
db 0EAh, 0B8h, 0BEh, 08Bh, 07Ch, 088h, 0B9h, 0FCh
db 0DFh, 01Dh, 0DDh, 062h, 049h, 02Dh, 0DAh, 015h
db 0F3h, 07Ch, 0D3h, 08Ch, 065h, 04Ch, 0D4h, 0FBh
db 058h, 061h, 0B2h, 04Dh, 0CEh, 051h, 0B5h, 03Ah
db 074h, 000h, 0BCh, 0A3h, 0E2h, 030h, 0BBh, 0D4h
db 041h, 0A5h, 0DFh, 04Ah, 0D7h, 095h, 0D8h, 03Dh
db 06Dh, 0C4h, 0D1h, 0A4h, 0FBh, 0F4h, 0D6h, 0D3h
db 06Ah, 0E9h, 069h, 043h, 0FCh, 0D9h, 06Eh, 034h
db 046h, 088h, 067h, 0ADh, 0D0h, 0B8h, 060h, 0DAh
db 073h, 02Dh, 004h, 044h, 0E5h, 01Dh, 003h, 033h
db 05Fh, 04Ch, 00Ah, 0AAh, 0C9h, 07Ch, 00Dh, 0DDh
db 03Ch, 071h, 005h, 050h, 0AAh, 041h, 002h, 027h
db 010h, 010h, 00Bh, 0BEh, 086h, 020h, 00Ch, 0C9h
db 025h, 0B5h, 068h, 057h, 0B3h, 085h, 06Fh, 020h
db 009h, 0D4h, 066h, 0B9h, 09Fh, 0E4h, 061h, 0CEh
db 00Eh, 0F9h, 0DEh, 05Eh, 098h, 0C9h, 0D9h, 029h
db 022h, 098h, 0D0h, 0B0h, 0B4h, 0A8h, 0D7h, 0C7h
db 017h, 03Dh, 0B3h, 059h, 081h, 00Dh, 0B4h, 02Eh
db 03Bh, 05Ch, 0BDh, 0B7h, 0ADh, 06Ch, 0BAh, 0C0h
db 020h, 083h, 0B8h, 0EDh, 0B6h, 0B3h, 0BFh, 09Ah
db 00Ch, 0E2h, 0B6h, 003h, 09Ah, 0D2h, 0B1h, 074h
db 039h, 047h, 0D5h, 0EAh, 0AFh, 077h, 0D2h, 09Dh
db 015h, 026h, 0DBh, 004h, 083h, 016h, 0DCh, 073h
db 012h, 00Bh, 063h, 0E3h, 084h, 03Bh, 064h, 094h
db 03Eh, 06Ah, 06Dh, 00Dh, 0A8h, 05Ah, 06Ah, 07Ah
db 00Bh, 0CFh, 00Eh, 0E4h, 09Dh, 0FFh, 009h, 093h
db 027h, 0AEh, 000h, 00Ah, 0B1h, 09Eh, 007h, 07Dh
db 044h, 093h, 00Fh, 0F0h, 0D2h, 0A3h, 008h, 087h
db 068h, 0F2h, 001h, 01Eh, 0FEh, 0C2h, 006h, 069h
db 05Dh, 057h, 062h, 0F7h, 0CBh, 067h, 065h, 080h
db 071h, 036h, 06Ch, 019h, 0E7h, 006h, 06Bh, 06Eh
db 076h, 01Bh, 0D4h, 0FEh, 0E0h, 02Bh, 0D3h, 089h
db 05Ah, 07Ah, 0DAh, 010h, 0CCh, 04Ah, 0DDh, 067h
db 06Fh, 0DFh, 0B9h, 0F9h, 0F9h, 0EFh, 0BEh, 08Eh
db 043h, 0BEh, 0B7h, 017h, 0D5h, 08Eh, 0B0h, 060h
db 0E8h, 0A3h, 0D6h, 0D6h, 07Eh, 093h, 0D1h, 0A1h
db 0C4h, 0C2h, 0D8h, 038h, 052h, 0F2h, 0DFh, 04Fh
db 0F1h, 067h, 0BBh, 0D1h, 067h, 057h, 0BCh, 0A6h
db 0DDh, 006h, 0B5h, 03Fh, 04Bh, 036h, 0B2h, 048h
db 0DAh, 02Bh, 00Dh, 0D8h, 04Ch, 01Bh, 00Ah, 0AFh
db 0F6h, 04Ah, 003h, 036h, 060h, 07Ah, 004h, 041h
db 0C3h, 0EFh, 060h, 0DFh, 055h, 0DFh, 067h, 0A8h
db 0EFh, 08Eh, 06Eh, 031h, 079h, 0BEh, 069h, 046h
db 08Ch, 0B3h, 061h, 0CBh, 01Ah, 083h, 066h, 0BCh
db 0A0h, 0D2h, 06Fh, 025h, 036h, 0E2h, 068h, 052h
db 095h, 077h, 00Ch, 0CCh, 003h, 047h, 00Bh, 0BBh
db 0B9h, 016h, 002h, 022h, 02Fh, 026h, 005h, 055h
db 0BEh, 03Bh, 0BAh, 0C5h, 028h, 00Bh, 0BDh, 0B2h
db 092h, 05Ah, 0B4h, 02Bh, 004h, 06Ah, 0B3h, 05Ch
db 0A7h, 0FFh, 0D7h, 0C2h, 031h, 0CFh, 0D0h, 0B5h
db 08Bh, 09Eh, 0D9h, 02Ch, 01Dh, 0AEh, 0DEh, 05Bh
db 0B0h, 0C2h, 064h, 09Bh, 026h, 0F2h, 063h, 0ECh
db 09Ch, 0A3h, 06Ah, 075h, 00Ah, 093h, 06Dh, 002h
db 0A9h, 006h, 009h, 09Ch, 03Fh, 036h, 00Eh, 0EBh
db 085h, 067h, 007h, 072h, 013h, 057h, 000h, 005h
db 082h, 04Ah, 0BFh, 095h, 014h, 07Ah, 0B8h, 0E2h
db 0AEh, 02Bh, 0B1h, 07Bh, 038h, 01Bh, 0B6h, 00Ch
db 09Bh, 08Eh, 0D2h, 092h, 00Dh, 0BEh, 0D5h, 0E5h
db 0B7h, 0EFh, 0DCh, 07Ch, 021h, 0DFh, 0DBh, 00Bh
db 0D4h, 0D2h, 0D3h, 086h, 042h, 0E2h, 0D4h, 0F1h
db 0F8h, 0B3h, 0DDh, 068h, 06Eh, 083h, 0DAh, 01Fh
db 0CDh, 016h, 0BEh, 081h, 05Bh, 026h, 0B9h, 0F6h
db 0E1h, 077h, 0B0h, 06Fh, 077h, 047h, 0B7h, 018h
db 0E6h, 05Ah, 008h, 088h, 070h, 06Ah, 00Fh, 0FFh
db 0CAh, 03Bh, 006h, 066h, 05Ch, 00Bh, 001h, 011h
db 0FFh, 09Eh, 065h, 08Fh, 069h, 0AEh, 062h, 0F8h
db 0D3h, 0FFh, 06Bh, 061h, 045h, 0CFh, 06Ch, 016h
db 078h, 0E2h, 00Ah, 0A0h, 0EEh, 0D2h, 00Dh, 0D7h
db 054h, 083h, 004h, 04Eh, 0C2h, 0B3h, 003h, 039h
db 061h, 026h, 067h, 0A7h, 0F7h, 016h, 060h, 0D0h
db 04Dh, 047h, 069h, 049h, 0DBh, 077h, 06Eh, 03Eh
db 04Ah, 06Ah, 0D1h, 0AEh, 0DCh, 05Ah, 0D6h, 0D9h
db 066h, 00Bh, 0DFh, 040h, 0F0h, 03Bh, 0D8h, 037h
db 053h, 0AEh, 0BCh, 0A9h, 0C5h, 09Eh, 0BBh, 0DEh
db 07Fh, 0CFh, 0B2h, 047h, 0E9h, 0FFh, 0B5h, 030h
db 01Ch, 0F2h, 0BDh, 0BDh, 08Ah, 0C2h, 0BAh, 0CAh
db 030h, 093h, 0B3h, 053h, 0A6h, 0A3h, 0B4h, 024h
db 005h, 036h, 0D0h, 0BAh, 093h, 006h, 0D7h, 0CDh
db 029h, 057h, 0DEh, 054h, 0BFh, 067h, 0D9h, 023h
db 02Eh, 07Ah, 066h, 0B3h, 0B8h, 04Ah, 061h, 0C4h
db 002h, 01Bh, 068h, 05Dh, 094h, 02Bh, 06Fh, 02Ah
db 037h, 0BEh, 00Bh, 0B4h, 0A1h, 08Eh, 00Ch, 0C3h
db 01Bh, 0DFh, 005h, 05Ah, 08Dh, 0EFh, 002h, 02Dh,0

Table_Rand			db "0EF012BCD34AB0123456789C56789ABC789DEF",0


Vide			     db	"Enter your Name plz ! ",0
Court		     db	"5 char minimum ! ",0
Format 	               db		"%02X-%s",0
SerialBuffer2	     dd  ?
buff2                        db	128 dup(?)

.data?

nbcar                  dd	?
NameBuffer	db	128 dup(?)
NameLen		dd	?
Counter		dd	?
Tick		         dd	?	
_part1		dd	?
_part2		dd	?
_part3		dd	?
szName		dd	?
SerialBuffer3	db	128 dup(?)
buff1                  dd  ?
bufnum              dd  ?
szSerial		db		40 dup(?)

.const
AboutDlg	=	700

.code
Randomize	proc	Var:DWORD
		push ebx
		mov eax,Var
		xor ebx,ebx
		imul edx,dword ptr ds:[ebx+Tick],08088405h
		inc edx
		mov dword ptr ds:[ebx+Tick],edx
		mul edx
		mov eax,edx
		pop ebx
		ret
Randomize EndP

DoKey	proc	hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
		push hWnd ; ====> evite la perte d'handle lors de l'affichage du serial parfois
		pop hWND
		

;================================= Génération des caractères par la fonction Rand ========================
		call InitCheck
		xor eax,eax
		invoke GetTickCount
		mov Tick,eax
		
	@Loop:
		;--------------
		;Genere un serial random 
		xor ecx,ecx
		mov edi,SerialBuffer2	;Buffer du serial 
	jmp @N1
	@@:
		push 24   ; Pousse sur la pile le nombre de carac de la Table en Hexa
		call Randomize
		movsx eax,byte ptr ds:[eax+Table_Rand]	;appel le random sur des carac de la Table
		mov byte ptr ds:[ecx+edi],al		;met les carac dans un buffer ecx
		inc ecx
	@N1:
		cmp ecx,6           ;  verifie qu'il y a bien 6 carac en ecx 
	jnz @b
;===========================================================================================		
		xor eax,eax                         
		xor ecx,ecx                         
		xor edx,edx                          
		xor ebx,ebx             
		
		mov ecx,6
		xor ebx,ebx
		mov edx,-1
		
	@progress_004011E2:
			
		mov esi,dword ptr ss:[SerialBuffer2]
		movzx eax,byte ptr ds:[ebx+esi]
		xor eax,edx
		and eax,0ffh
		imul eax,4
		shr edx,8
		xor edx,dword ptr ds:[eax+TABLE2]
		inc ebx
		cmp ebx,ecx
	jne @progress_004011E2
		xor edx,0ffffffffh
		mov eax,edx		
		push eax ;pousse sur la pile  la valeur du resultat de la boucle de generation du hash calculé sur les 6 caracteres generés par la fontion Rand
		
		xor ebx,ebx
		invoke GetDlgItemText,hWnd,EditName,addr NameBuffer,80
		
		cmp eax,4
	Je @Court
	         cmp eax,0
	Je @Vide      
		     
		lea edi,dword ptr ds:[NameBuffer]
		mov ecx,eax
		mov dword ptr ds:[bufnum],ecx
		xor eax,eax
;====================================== boucle1 xor sur chaque carac du nom (1er partie du serial en Hexa au format (%02X)) debut ================================		   
	@@:
		
		xor al,byte ptr ds:[edi]
		inc edi
		loopd @b
			
;====================================== boucle2 additionne chaque carac du nom en EBX debut ========================	
		mov dword ptr ds:[buff1],eax
		xor ebx,ebx
		lea esi,dword ptr ds:[NameBuffer]
		xor ecx,ecx
		 mov ecx,dword ptr ds:[bufnum]
	@@:
		xor edx,edx
		mov dl,byte ptr ds:[esi]
		add ebx,edx
		inc esi
	loopd @b
		pop eax  ; Rappel la valeur du resultat de la boucle de generation du hash calcule sur les 6 caracteres genere par la fontion Rand
		cmp al,bl  ;compare a valeur de al  a celle de bl, bl etant la valeur de poid faible de ebx(valeur de l'addition des valeurs hexa du nom)
		
	jnz @Loop;  boucle jusqu a ce que ces 2 valeurs  soient egales
	
		mov eax,DWORD ptr Ds:[buff1]
		mov edx,dword ptr Ds:[SerialBuffer2]
		invoke wsprintf,addr szSerial,addr Format,eax,edx 
		invoke SetDlgItemText,hWND,EditSerial,addr szSerial
		invoke SetClipboard,addr szSerial
		ret
		call DestroyKey	
	@Maj:	
		invoke GetWindowRect,hWnd,addr PosRect
		mov AboutFlag,0
		invoke DialogBoxParam,hInstance,AboutDlg,hWnd,addr AboutProc,NULL
		ret
	@Court:
		invoke SetDlgItemText, hWND, EditName , addr Court
		ret
	@Vide:
		invoke SetDlgItemText, hWND,EditName , addr Vide	
		ret	
	
DoKey EndP

InitCheck	proc
		invoke GlobalAlloc,GPTR,100h
		mov SerialBuffer2,eax
		ret
InitCheck EndP

DestroyKey	proc
		invoke GlobalFree,szSerial
		ret
DestroyKey EndP