


tagRECT		struc ;	(sizeof=0x10, standard type)
left		dd ?
top		dd ?
right		dd ?
bottom		dd ?
tagRECT		ends

; ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ

tagPOINT	struc ;	(sizeof=0x8, standard type)
x		dd ?
y		dd ?
tagPOINT	ends




; Segment type:	Pure data
; Segment permissions: Read/Write
Clon		segment	para public 'DATA' use32
		assume cs:Clon
		;org 407000h

include ab.inc


dword_407006	dd 0			; DATA XREF: sub_401884+3w
					; sub_401884+Dr ...
dword_40700A	dd 0			; DATA XREF: sub_401884+33w
					; sub_401985+3o ...
dword_40700E	dd 0			; DATA XREF: sub_401884+3Dw
					; sub_4021FF+6Er ...
dword_407012	dd 0			; DATA XREF: sub_401884+47w
					; sub_4021FF+CDr ...
dword_407016	dd 1			; DATA XREF: sub_401884+6Fw
					; sub_401985+Er
dword_40701A	dd 2			; DATA XREF: sub_401884+79w
					; sub_401985+17r
dword_40701E	dd 3			; DATA XREF: sub_401884+83w
					; sub_401985+22r
dword_407022	dd 0			; DATA XREF: sub_401DBE+23Ar
					; sub_4021FF+127w
dword_407026	dd 0			; DATA XREF: sub_401DBE+259r
					; sub_4021FF+132w
dword_40702A	dd 0			; DATA XREF: sub_401DBE+227r
					; sub_401DBE+230w ...
; HGDIOBJ dword_40702E
dword_40702E	dd 0			; DATA XREF: DialogFunc+295w
					; sub_401A71+DBr
; HGDIOBJ dword_407032
dword_407032	dd 0			; DATA XREF: DialogFunc+280w
					; sub_401A71+C4r
; HDC dword_407036
dword_407036	dd 0			; DATA XREF: DialogFunc+BCr
					; sub_401A71+D6w ...
; HDC dword_40703A
dword_40703A	dd 0			; DATA XREF: DialogFunc+C7r
					; sub_401A71+BFw ...
dword_40703E	dd 0			; DATA XREF: sub_401884+51w
					; sub_401DBE+175w ...
dword_407042	dd 0			; DATA XREF: sub_401884+5Bw
					; sub_401DBE+E7r ...
dword_407046	dd 0			; DATA XREF: sub_401884+65w
					; sub_401DBE+109r ...


;######### Points to 3D Object: ################################################
off_40704A	dd offset unk_407908;          DATA XREF: sub_401884+12o
				
		dd offset unk_4077E4;kub
		dd offset unk_407908;treugolnik
		dd offset unk_407A2C
		dd offset unk_407B50
		dd offset unk_407C74
		dd offset unk_407D98
		dd offset unk_4076C0
		dd offset unk_40741E
		dd offset unk_407120
		dd offset unk_40707A; kvadrat
		db    0
		db    0
		db    0
		db    0
;######################### 3D Objects: ###################################################

unk_40707A	db  1Bh			; DATA XREF: C:00407072o
		db    0
		db    0
		db    0
		db 0E7h	; Á
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db    0
		db    0
		db 0E7h	; Á
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db  19h
		db    0
		db 0E7h	; Á
		db 0FFh
		db    0
		db    0
		db 0E7h	; Á
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0E7h	; Á
		db 0FFh
		db    0
		db    0
		db  19h
		db    0
		db 0E7h	; Á
		db 0FFh
		db  19h
		db    0
		db 0E7h	; Á
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db  19h
		db    0
		db    0
		db    0
		db 0E7h	; Á
		db 0FFh
		db  19h
		db    0
		db  19h
		db    0
		db 0E7h	; Á
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db    0
		db    0
		db 0E7h	; Á
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0E7h	; Á
		db 0FFh
		db  19h
		db    0
		db    0
		db    0
		db    0
		db    0
		db 0E7h	; Á
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  19h
		db    0
		db    0
		db    0
		db  19h
		db    0
		db 0E7h	; Á
		db 0FFh
		db    0
		db    0
		db  19h
		db    0
		db    0
		db    0
		db    0
		db    0
		db  19h
		db    0
		db  19h
		db    0
		db    0
		db    0
		db 0E7h	; Á
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db  19h
		db    0
		db 0E7h	; Á
		db 0FFh
		db    0
		db    0
		db  19h
		db    0
		db 0E7h	; Á
		db 0FFh
		db  19h
		db    0
		db  19h
		db    0
		db    0
		db    0
		db 0E7h	; Á
		db 0FFh
		db  19h
		db    0
		db    0
		db    0
		db    0
		db    0
		db  19h
		db    0
		db    0
		db    0
		db  19h
		db    0
		db  19h
		db    0
		db  19h
		db    0
		db 0E7h	; Á
		db 0FFh
		db  19h
		db    0
		db  19h
		db    0
		db    0
		db    0
		db  19h
		db    0
		db  19h
		db    0
		db  19h
		db    0
		db  19h
		db    0
unk_407120	db  54h	; T		; DATA XREF: C:0040706Eo
		db    0
		db    0
		db    0
		db    0
		db    0
		db  2Dh	; -
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  1Eh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  1Eh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db  1Eh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db  1Eh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  1Eh
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  1Eh
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  1Eh
		db    0
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db  1Eh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db  1Eh
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db  1Eh
		db    0
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db 0D3h	; ”
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0D3h	; ”
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0D3h	; ”
		db 0FFh
		db  0Fh
		db    0
		db    0
		db    0
		db 0D3h	; ”
		db 0FFh
		db  1Eh
		db    0
		db    0
		db    0
		db 0D3h	; ”
		db 0FFh
		db  2Dh	; -
		db    0
		db    0
		db    0
		db 0D3h	; ”
		db 0FFh
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  1Eh
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  2Dh	; -
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  1Eh
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  2Dh	; -
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  2Dh	; -
		db    0
		db    0
		db    0
		db    0
		db    0
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  2Dh	; -
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db  1Eh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  1Eh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  2Dh	; -
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db  2Dh	; -
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  2Dh	; -
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  2Dh	; -
		db    0
		db    0
		db    0
		db    0
		db    0
		db  2Dh	; -
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  2Dh	; -
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  2Dh	; -
		db    0
		db  2Dh	; -
		db    0
		db    0
		db    0
		db  2Dh	; -
		db    0
		db    9
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  1Eh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  1Eh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  1Eh
		db    0
		db    0
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  11h
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  1Eh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  1Eh
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  1Eh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
unk_40741E	db  46h	; F		; DATA XREF: C:0040706Ao
		db    0
		db    0
		db    0
		db    0
		db    0
		db  32h	; 2
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  23h	; #
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  23h	; #
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db  23h	; #
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db  23h	; #
		db    0
		db    0
		db    0
		db    0
		db    0
		db  23h	; #
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  23h	; #
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  23h	; #
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  23h	; #
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db  23h	; #
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  14h
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db  14h
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  14h
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db  14h
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  1Eh
		db    0
		db  14h
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db  14h
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db  14h
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  14h
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db  14h
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  1Eh
		db    0
		db  14h
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db  14h
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  14h
		db    0
		db    0
		db    0
		db    0
		db    0
		db  14h
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  14h
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  14h
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  14h
		db    0
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  14h
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  14h
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db  14h
		db    0
		db  0Fh
		db    0
		db  1Eh
		db    0
		db  14h
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  14h
		db    0
		db  1Eh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  14h
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  14h
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db  14h
		db    0
		db  1Eh
		db    0
		db  1Eh
		db    0
		db  14h
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  0Fh
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db  1Eh
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  0Fh
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db  1Eh
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db    0
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  0Fh
		db    0
		db 0E2h	; ‚
		db 0FFh
		db    0
		db    0
		db  1Eh
		db    0
		db 0F1h	; Ò
		db 0FFh
		db    0
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  0Fh
		db    0
		db    0
		db    0
		db  1Eh
		db    0
		db  1Eh
		db    0
		db    0
		db    0
		db  1Eh
		db    0



unk_4076C0	db  30h	; 0		; DATA XREF: start+195o C:00407066o
		db    0
		db    0
		db    0
		db  4Fh	; O
		db    0
		db    0
		db    0
		db    0
		db    0
		db  45h	; E
		db    0
		db  27h	; '
		db    0
		db    0
		db    0
		db  28h	; (
		db    0
		db  45h	; E
		db    0
		db    0
		db    0
		db    0
		db    0
		db  4Fh	; O
		db    0
		db    0
		db    0
		db 0D9h	; Ÿ
		db 0FFh
		db  45h	; E
		db    0
		db    0
		db    0
		db 0BBh	; ª
		db 0FFh
		db  28h	; (
		db    0
		db    0
		db    0
		db 0B1h	; ±
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0BBh	; ª
		db 0FFh
		db 0D8h	; ÿ
		db 0FFh
		db    0
		db    0
		db 0D8h	; ÿ
		db 0FFh
		db 0BBh	; ª
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0B1h	; ±
		db 0FFh
		db    0
		db    0
		db  28h	; (
		db    0
		db 0BBh	; ª
		db 0FFh
		db    0
		db    0
		db  45h	; E
		db    0
		db 0D9h	; Ÿ
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  4Fh	; O
		db    0
		db    0
		db    0
		db  27h	; '
		db    0
		db  45h	; E
		db    0
		db    0
		db    0
		db  45h	; E
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db  4Fh	; O
		db    0
		db    0
		db    0
		db    0
		db    0
		db  45h	; E
		db    0
		db 0D9h	; Ÿ
		db 0FFh
		db    0
		db    0
		db  28h	; (
		db    0
		db 0BBh	; ª
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0B1h	; ±
		db 0FFh
		db    0
		db    0
		db 0D8h	; ÿ
		db 0FFh
		db 0BBh	; ª
		db 0FFh
		db    0
		db    0
		db 0BBh	; ª
		db 0FFh
		db 0D8h	; ÿ
		db 0FFh
		db    0
		db    0
		db 0B1h	; ±
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db 0BBh	; ª
		db 0FFh
		db  28h	; (
		db    0
		db    0
		db    0
		db 0D9h	; Ÿ
		db 0FFh
		db  45h	; E
		db    0
		db  38h	; 8
		db    0
		db    0
		db    0
		db  38h	; 8
		db    0
		db  30h	; 0
		db    0
		db  27h	; '
		db    0
		db  30h	; 0
		db    0
		db  1Ch
		db    0
		db  45h	; E
		db    0
		db  1Ch
		db    0
		db    0
		db    0
		db  4Fh	; O
		db    0
		db    0
		db    0
		db 0E4h	; ‰
		db 0FFh
		db  45h	; E
		db    0
		db 0E4h	; ‰
		db 0FFh
		db 0D0h	; –
		db 0FFh
		db  28h	; (
		db    0
		db 0D0h	; –
		db 0FFh
		db 0C8h	; »
		db 0FFh
		db    0
		db    0
		db 0C8h	; »
		db 0FFh
		db 0D0h	; –
		db 0FFh
		db 0D8h	; ÿ
		db 0FFh
		db 0D0h	; –
		db 0FFh
		db 0E4h	; ‰
		db 0FFh
		db 0BBh	; ª
		db 0FFh
		db 0E4h	; ‰
		db 0FFh
		db    0
		db    0
		db 0B1h	; ±
		db 0FFh
		db    0
		db    0
		db  1Ch
		db    0
		db 0BBh	; ª
		db 0FFh
		db  1Ch
		db    0
		db  30h	; 0
		db    0
		db 0D9h	; Ÿ
		db 0FFh
		db  30h	; 0
		db    0
		db  38h	; 8
		db    0
		db    0
		db    0
		db 0C8h	; »
		db 0FFh
		db  30h	; 0
		db    0
		db  27h	; '
		db    0
		db 0D0h	; –
		db 0FFh
		db  1Ch
		db    0
		db  45h	; E
		db    0
		db 0E4h	; ‰
		db 0FFh
		db    0
		db    0
		db  4Fh	; O
		db    0
		db    0
		db    0
		db 0E4h	; ‰
		db 0FFh
		db  45h	; E
		db    0
		db  1Ch
		db    0
		db 0D0h	; –
		db 0FFh
		db  28h	; (
		db    0
		db  30h	; 0
		db    0
		db 0C8h	; »
		db 0FFh
		db    0
		db    0
		db  38h	; 8
		db    0
		db 0D0h	; –
		db 0FFh
		db 0D8h	; ÿ
		db 0FFh
		db  30h	; 0
		db    0
		db 0E4h	; ‰
		db 0FFh
		db 0BBh	; ª
		db 0FFh
		db  1Ch
		db    0
		db    0
		db    0
		db 0B1h	; ±
		db 0FFh
		db    0
		db    0
		db  1Ch
		db    0
		db 0BBh	; ª
		db 0FFh
		db 0E4h	; ‰
		db 0FFh
		db  30h	; 0
		db    0
		db 0D9h	; Ÿ
		db 0FFh
		db 0D0h	; –
		db 0FFh
unk_4077E4	db  30h	; 0		; DATA XREF: start+1ADo C:0040704Eo
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  14h
		db    0
		db    0
		db    0
		db    0
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db    0
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  14h
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  28h	; (
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  3Ch	; <
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  14h
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db    0
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db    0
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db    0
		db    0
		db  14h
		db    0
		db    0
		db    0
		db  14h
		db    0
		db    0
		db    0
		db    0
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db    0
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  14h
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  28h	; (
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  3Ch	; <
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db  14h
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db  28h	; (
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db  3Ch	; <
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db  3Ch	; <
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db  28h	; (
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db  14h
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  14h
		db    0
		db  50h	; P
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  14h
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  3Ch	; <
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db  28h	; (
		db    0
		db  50h	; P
		db    0
		db  50h	; P
		db    0
		db  14h
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  3Ch	; <
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  28h	; (
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  14h
		db    0
		db  50h	; P
		db    0
		db  28h	; (
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  28h	; (
		db    0
		db  28h	; (
		db    0
		db  28h	; (
		db    0
		db  28h	; (
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  28h	; (
		db    0
		db  28h	; (
		db    0
unk_407908	db  30h	; 0		; DATA XREF: start+1B9o C:00407052o
		db    0
		db    0
		db    0
		db 0ECh	; Ï
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  14h
		db    0
		db    0
		db    0
		db    0
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db    0
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db    0
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db  14h
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db  28h	; (
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db  3Ch	; <
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  28h	; (
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  14h
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db 0ECh	; Ï
		db 0FFh
		db    0
		db    0
		db  50h	; P
		db    0
		db 0ECh	; Ï
		db 0FFh
		db    0
		db    0
		db  3Ch	; <
		db    0
		db 0ECh	; Ï
		db 0FFh
		db    0
		db    0
		db  28h	; (
		db    0
		db 0ECh	; Ï
		db 0FFh
		db    0
		db    0
		db  14h
		db    0
		db 0F0h	; 
		db 0FFh
		db  0Fh
		db    0
		db    4
		db    0
		db  37h	; 7
		db    0
		db  0Fh
		db    0
		db    4
		db    0
		db 0F0h	; 
		db 0FFh
		db  0Fh
		db    0
		db  4Bh	; K
		db    0
		db  37h	; 7
		db    0
		db  0Fh
		db    0
		db  4Bh	; K
		db    0
		db 0F4h	; Ù
		db 0FFh
		db  1Eh
		db    0
		db    8
		db    0
		db  33h	; 3
		db    0
		db  1Eh
		db    0
		db    8
		db    0
		db 0F4h	; Ù
		db 0FFh
		db  1Eh
		db    0
		db  47h	; G
		db    0
		db  33h	; 3
		db    0
		db  1Eh
		db    0
		db  47h	; G
		db    0
		db 0F9h	; ˘
		db 0FFh
		db  2Dh	; -
		db    0
		db  0Dh
		db    0
		db  2Eh	; .
		db    0
		db  2Dh	; -
		db    0
		db  0Dh
		db    0
		db 0F9h	; ˘
		db 0FFh
		db  2Dh	; -
		db    0
		db  42h	; B
		db    0
		db  2Eh	; .
		db    0
		db  2Dh	; -
		db    0
		db  42h	; B
		db    0
		db 0FDh	; ˝
		db 0FFh
		db  3Ch	; <
		db    0
		db  11h
		db    0
		db  2Ah	; *
		db    0
		db  3Ch	; <
		db    0
		db  11h
		db    0
		db 0FDh	; ˝
		db 0FFh
		db  3Ch	; <
		db    0
		db  3Eh	; >
		db    0
		db  2Ah	; *
		db    0
		db  3Ch	; <
		db    0
		db  3Eh	; >
		db    0
		db    2
		db    0
		db  4Bh	; K
		db    0
		db  16h
		db    0
		db  25h	; %
		db    0
		db  4Bh	; K
		db    0
		db  16h
		db    0
		db    2
		db    0
		db  4Bh	; K
		db    0
		db  39h	; 9
		db    0
		db  25h	; %
		db    0
		db  4Bh	; K
		db    0
		db  39h	; 9
		db    0
		db    6
		db    0
		db  5Ah	; Z
		db    0
		db  1Ah
		db    0
		db  21h	; !
		db    0
		db  5Ah	; Z
		db    0
		db  1Ah
		db    0
		db    6
		db    0
		db  5Ah	; Z
		db    0
		db  35h	; 5
		db    0
		db  21h	; !
		db    0
		db  5Ah	; Z
		db    0
		db  35h	; 5
		db    0
		db  0Bh
		db    0
		db  69h	; i
		db    0
		db  1Fh
		db    0
		db  1Ch
		db    0
		db  69h	; i
		db    0
		db  1Fh
		db    0
		db  0Bh
		db    0
		db  69h	; i
		db    0
		db  30h	; 0
		db    0
		db  1Ch
		db    0
		db  69h	; i
		db    0
		db  30h	; 0
		db    0
		db  0Fh
		db    0
		db  78h	; x
		db    0
		db  23h	; #
		db    0
		db  18h
		db    0
		db  78h	; x
		db    0
		db  23h	; #
		db    0
		db  0Fh
		db    0
		db  78h	; x
		db    0
		db  2Ch	; ,
		db    0
		db  18h
		db    0
		db  78h	; x
		db    0
		db  2Ch	; ,
		db    0
unk_407A2C	db  30h	; 0		; DATA XREF: start+1C5o C:00407056o
		db    0
		db    0
		db    0
		db  63h	; c
		db    0
		db    0
		db    0
		db    0
		db    0
		db  62h	; b
		db    0
		db    0
		db    0
		db  0Eh
		db    0
		db  5Fh	; _
		db    0
		db    0
		db    0
		db  1Ch
		db    0
		db  5Ah	; Z
		db    0
		db    0
		db    0
		db  2Ah	; *
		db    0
		db  53h	; S
		db    0
		db    0
		db    0
		db  37h	; 7
		db    0
		db  4Ah	; J
		db    0
		db    0
		db    0
		db  42h	; B
		db    0
		db  3Fh	; ?
		db    0
		db    0
		db    0
		db  4Ch	; L
		db    0
		db  34h	; 4
		db    0
		db    0
		db    0
		db  55h	; U
		db    0
		db  27h	; '
		db    0
		db    0
		db    0
		db  5Ch	; \
		db    0
		db  19h
		db    0
		db    0
		db    0
		db  60h	; `
		db    0
		db  0Ah
		db    0
		db    0
		db    0
		db  63h	; c
		db    0
		db 0FDh	; ˝
		db 0FFh
		db    0
		db    0
		db  63h	; c
		db    0
		db 0EEh	; Ó
		db 0FFh
		db    0
		db    0
		db  62h	; b
		db    0
		db 0E0h	; ‡
		db 0FFh
		db    0
		db    0
		db  5Eh	; ^
		db    0
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db  58h	; X
		db    0
		db 0C6h	; ∆
		db 0FFh
		db    0
		db    0
		db  51h	; Q
		db    0
		db 0BBh	; ª
		db 0FFh
		db    0
		db    0
		db  47h	; G
		db    0
		db 0B1h	; ±
		db 0FFh
		db    0
		db    0
		db  3Dh	; =
		db    0
		db 0A9h	; ©
		db 0FFh
		db    0
		db    0
		db  30h	; 0
		db    0
		db 0A3h	; £
		db 0FFh
		db    0
		db    0
		db  23h	; #
		db    0
		db  9Fh	; ü
		db 0FFh
		db    0
		db    0
		db  15h
		db    0
		db  9Dh	; ù
		db 0FFh
		db    0
		db    0
		db    7
		db    0
		db  9Dh	; ù
		db 0FFh
		db    0
		db    0
		db 0F9h	; ˘
		db 0FFh
		db  9Fh	; ü
		db 0FFh
		db    0
		db    0
		db 0EBh	; Î
		db 0FFh
		db 0A3h	; £
		db 0FFh
		db    0
		db    0
		db 0DDh	; ›
		db 0FFh
		db 0A9h	; ©
		db 0FFh
		db    0
		db    0
		db 0D0h	; –
		db 0FFh
		db 0B1h	; ±
		db 0FFh
		db    0
		db    0
		db 0C3h	; √
		db 0FFh
		db 0BBh	; ª
		db 0FFh
		db    0
		db    0
		db 0B9h	; π
		db 0FFh
		db 0C6h	; ∆
		db 0FFh
		db    0
		db    0
		db 0AFh	; Ø
		db 0FFh
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db 0A8h	; ®
		db 0FFh
		db 0E0h	; ‡
		db 0FFh
		db    0
		db    0
		db 0A2h	; ¢
		db 0FFh
		db 0EEh	; Ó
		db 0FFh
		db    0
		db    0
		db  9Eh	; û
		db 0FFh
		db 0FDh	; ˝
		db 0FFh
		db    0
		db    0
		db  9Dh	; ù
		db 0FFh
		db  0Ah
		db    0
		db    0
		db    0
		db  9Dh	; ù
		db 0FFh
		db  19h
		db    0
		db    0
		db    0
		db 0A0h	; †
		db 0FFh
		db  27h	; '
		db    0
		db    0
		db    0
		db 0A4h	; §
		db 0FFh
		db  34h	; 4
		db    0
		db    0
		db    0
		db 0ABh	; ´
		db 0FFh
		db  3Fh	; ?
		db    0
		db    0
		db    0
		db 0B4h	; ¥
		db 0FFh
		db  4Ah	; J
		db    0
		db    0
		db    0
		db 0BEh	; æ
		db 0FFh
		db  53h	; S
		db    0
		db    0
		db    0
		db 0C9h	; …
		db 0FFh
		db  5Ah	; Z
		db    0
		db    0
		db    0
		db 0D6h	; ÷
		db 0FFh
		db  5Fh	; _
		db    0
		db    0
		db    0
		db 0E4h	; ‰
		db 0FFh
		db  62h	; b
		db    0
		db    0
		db    0
		db 0F2h	; Ú
		db 0FFh
		db    0
		db    0
		db  14h
		db    0
		db    0
		db    0
		db    0
		db    0
		db 0ECh	; Ï
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db 0F4h	; Ù
		db 0FFh
		db 0F4h	; Ù
		db 0FFh
		db    0
		db    0
		db 0F4h	; Ù
		db 0FFh
		db  0Ch
		db    0
		db    0
		db    0
		db  0Ch
		db    0
unk_407B50	db  30h	; 0		; DATA XREF: start+1D1o C:0040705Ao
		db    0
		db    0
		db    0
		db 0E8h	; Ë
		db 0FFh
		db    0
		db    0
		db  48h	; H
		db    0
		db 0E8h	; Ë
		db 0FFh
		db    0
		db    0
		db 0B8h	; ∏
		db 0FFh
		db 0B8h	; ∏
		db 0FFh
		db    0
		db    0
		db 0E8h	; Ë
		db 0FFh
		db  48h	; H
		db    0
		db    0
		db    0
		db 0E8h	; Ë
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db  48h	; H
		db    0
		db    0
		db    0
		db    0
		db    0
		db 0B8h	; ∏
		db 0FFh
		db 0B8h	; ∏
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db  48h	; H
		db    0
		db    0
		db    0
		db    0
		db    0
		db  18h
		db    0
		db    0
		db    0
		db  48h	; H
		db    0
		db  18h
		db    0
		db    0
		db    0
		db 0B8h	; ∏
		db 0FFh
		db 0B8h	; ∏
		db 0FFh
		db    0
		db    0
		db  18h
		db    0
		db  48h	; H
		db    0
		db    0
		db    0
		db  18h
		db    0
		db 0D0h	; –
		db 0FFh
		db    0
		db    0
		db  18h
		db    0
		db 0D0h	; –
		db 0FFh
		db    0
		db    0
		db 0E8h	; Ë
		db 0FFh
		db  18h
		db    0
		db    0
		db    0
		db 0E8h	; Ë
		db 0FFh
		db  18h
		db    0
		db    0
		db    0
		db  18h
		db    0
		db 0E8h	; Ë
		db 0FFh
		db    0
		db    0
		db  30h	; 0
		db    0
		db 0E8h	; Ë
		db 0FFh
		db    0
		db    0
		db 0D0h	; –
		db 0FFh
		db 0E8h	; Ë
		db 0FFh
		db    0
		db    0
		db  18h
		db    0
		db 0E8h	; Ë
		db 0FFh
		db    0
		db    0
		db 0E8h	; Ë
		db 0FFh
		db  30h	; 0
		db    0
		db    0
		db    0
		db 0E8h	; Ë
		db 0FFh
		db  30h	; 0
		db    0
		db    0
		db    0
		db  18h
		db    0
		db  18h
		db    0
		db    0
		db    0
		db  30h	; 0
		db    0
		db  18h
		db    0
		db    0
		db    0
		db 0D0h	; –
		db 0FFh
		db  4Fh	; O
		db    0
		db  50h	; P
		db    0
		db    0
		db    0
		db  4Fh	; O
		db    0
		db 0B0h	; ∞
		db 0FFh
		db    0
		db    0
		db  45h	; E
		db    0
		db  50h	; P
		db    0
		db  27h	; '
		db    0
		db  45h	; E
		db    0
		db 0B0h	; ∞
		db 0FFh
		db  27h	; '
		db    0
		db  28h	; (
		db    0
		db  50h	; P
		db    0
		db  45h	; E
		db    0
		db  28h	; (
		db    0
		db 0B0h	; ∞
		db 0FFh
		db  45h	; E
		db    0
		db    0
		db    0
		db  50h	; P
		db    0
		db  4Fh	; O
		db    0
		db    0
		db    0
		db 0B0h	; ∞
		db 0FFh
		db  4Fh	; O
		db    0
		db 0D9h	; Ÿ
		db 0FFh
		db  50h	; P
		db    0
		db  45h	; E
		db    0
		db 0D9h	; Ÿ
		db 0FFh
		db 0B0h	; ∞
		db 0FFh
		db  45h	; E
		db    0
		db 0BBh	; ª
		db 0FFh
		db  50h	; P
		db    0
		db  28h	; (
		db    0
		db 0BBh	; ª
		db 0FFh
		db 0B0h	; ∞
		db 0FFh
		db  28h	; (
		db    0
		db 0B1h	; ±
		db 0FFh
		db  50h	; P
		db    0
		db    0
		db    0
		db 0B1h	; ±
		db 0FFh
		db 0B0h	; ∞
		db 0FFh
		db    0
		db    0
		db 0BBh	; ª
		db 0FFh
		db  50h	; P
		db    0
		db 0D8h	; ÿ
		db 0FFh
		db 0BBh	; ª
		db 0FFh
		db 0B0h	; ∞
		db 0FFh
		db 0D8h	; ÿ
		db 0FFh
		db 0D8h	; ÿ
		db 0FFh
		db  50h	; P
		db    0
		db 0BBh	; ª
		db 0FFh
		db 0D8h	; ÿ
		db 0FFh
		db 0B0h	; ∞
		db 0FFh
		db 0BBh	; ª
		db 0FFh
		db    0
		db    0
		db  50h	; P
		db    0
		db 0B1h	; ±
		db 0FFh
		db    0
		db    0
		db 0B0h	; ∞
		db 0FFh
		db 0B1h	; ±
		db 0FFh
		db  28h	; (
		db    0
		db  50h	; P
		db    0
		db 0BBh	; ª
		db 0FFh
		db  28h	; (
		db    0
		db 0B0h	; ∞
		db 0FFh
		db 0BBh	; ª
		db 0FFh
		db  45h	; E
		db    0
		db  50h	; P
		db    0
		db 0D9h	; Ÿ
		db 0FFh
		db  45h	; E
		db    0
		db 0B0h	; ∞
		db 0FFh
		db 0D9h	; Ÿ
		db 0FFh
unk_407C74	db  30h	; 0		; DATA XREF: start+1DDo C:0040705Eo
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Ch
		db    0
		db  20h
		db    0
		db    0
		db    0
		db  18h
		db    0
		db  36h	; 6
		db    0
		db    0
		db    0
		db  24h	; $
		db    0
		db  3Bh	; ;
		db    0
		db    0
		db    0
		db  30h	; 0
		db    0
		db  2Dh	; -
		db    0
		db    0
		db    0
		db  3Ch	; <
		db    0
		db  10h
		db    0
		db    0
		db    0
		db  48h	; H
		db    0
		db 0F0h	; 
		db 0FFh
		db    0
		db    0
		db  54h	; T
		db    0
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db  60h	; `
		db    0
		db 0C5h	; ≈
		db 0FFh
		db    0
		db    0
		db  6Ch	; l
		db    0
		db 0CAh	;  
		db 0FFh
		db    0
		db    0
		db  78h	; x
		db    0
		db 0E0h	; ‡
		db 0FFh
		db    0
		db    0
		db  84h	; Ñ
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Ch
		db    0
		db 0E0h	; ‡
		db 0FFh
		db    0
		db    0
		db  18h
		db    0
		db 0CAh	;  
		db 0FFh
		db    0
		db    0
		db  24h	; $
		db    0
		db 0C5h	; ≈
		db 0FFh
		db    0
		db    0
		db  30h	; 0
		db    0
		db 0D3h	; ”
		db 0FFh
		db    0
		db    0
		db  3Ch	; <
		db    0
		db 0F0h	; 
		db 0FFh
		db    0
		db    0
		db  48h	; H
		db    0
		db  10h
		db    0
		db    0
		db    0
		db  54h	; T
		db    0
		db  2Dh	; -
		db    0
		db    0
		db    0
		db  60h	; `
		db    0
		db  3Bh	; ;
		db    0
		db    0
		db    0
		db  6Ch	; l
		db    0
		db  36h	; 6
		db    0
		db    0
		db    0
		db  78h	; x
		db    0
		db  20h
		db    0
		db    0
		db    0
		db  84h	; Ñ
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Ch
		db    0
		db    0
		db    0
		db 0E0h	; ‡
		db 0FFh
		db  18h
		db    0
		db    0
		db    0
		db 0CAh	;  
		db 0FFh
		db  24h	; $
		db    0
		db    0
		db    0
		db 0C5h	; ≈
		db 0FFh
		db  30h	; 0
		db    0
		db    0
		db    0
		db 0D3h	; ”
		db 0FFh
		db  3Ch	; <
		db    0
		db    0
		db    0
		db 0F0h	; 
		db 0FFh
		db  48h	; H
		db    0
		db    0
		db    0
		db  10h
		db    0
		db  54h	; T
		db    0
		db    0
		db    0
		db  2Dh	; -
		db    0
		db  60h	; `
		db    0
		db    0
		db    0
		db  3Bh	; ;
		db    0
		db  6Ch	; l
		db    0
		db    0
		db    0
		db  36h	; 6
		db    0
		db  78h	; x
		db    0
		db    0
		db    0
		db  20h
		db    0
		db  84h	; Ñ
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Ch
		db    0
		db    0
		db    0
		db  20h
		db    0
		db  18h
		db    0
		db    0
		db    0
		db  36h	; 6
		db    0
		db  24h	; $
		db    0
		db    0
		db    0
		db  3Bh	; ;
		db    0
		db  30h	; 0
		db    0
		db    0
		db    0
		db  2Dh	; -
		db    0
		db  3Ch	; <
		db    0
		db    0
		db    0
		db  10h
		db    0
		db  48h	; H
		db    0
		db    0
		db    0
		db 0F0h	; 
		db 0FFh
		db  54h	; T
		db    0
		db    0
		db    0
		db 0D3h	; ”
		db 0FFh
		db  60h	; `
		db    0
		db    0
		db    0
		db 0C5h	; ≈
		db 0FFh
		db  6Ch	; l
		db    0
		db    0
		db    0
		db 0CAh	;  
		db 0FFh
		db  78h	; x
		db    0
		db    0
		db    0
		db 0E0h	; ‡
		db 0FFh
		db  84h	; Ñ
		db    0
		db    0
		db    0
		db    0
		db    0
unk_407D98	db  30h	; 0		; DATA XREF: start+1E9o C:00407062o
		db    0
		db    0
		db    0
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0D4h	; ‘
		db 0FFh
		db  32h	; 2
		db    0
		db 0DAh	; ⁄
		db 0FFh
		db    6
		db    0
		db  32h	; 2
		db    0
		db  26h	; &
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
		db 0D4h	; ‘
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db  26h	; &
		db    0
		db    6
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0DAh	; ⁄
		db 0FFh
		db 0DAh	; ⁄
		db 0FFh
		db  32h	; 2
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0DAh	; ⁄
		db 0FFh
		db  32h	; 2
		db    0
		db 0E7h	; Á
		db 0FFh
		db  0Ch
		db    0
		db  32h	; 2
		db    0
		db  19h
		db    0
		db 0DAh	; ⁄
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
		db 0DAh	; ⁄
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db  19h
		db    0
		db  0Ch
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db  32h	; 2
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0E0h	; ‡
		db 0FFh
		db  32h	; 2
		db    0
		db 0F3h	; Û
		db 0FFh
		db  12h
		db    0
		db  32h	; 2
		db    0
		db  0Dh
		db    0
		db 0E7h	; Á
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
		db 0E0h	; ‡
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db  0Dh
		db    0
		db  12h
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0F3h	; Û
		db 0FFh
		db 0F3h	; Û
		db 0FFh
		db  32h	; 2
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db  32h	; 2
		db    0
		db    0
		db    0
		db  19h
		db    0
		db  32h	; 2
		db    0
		db    0
		db    0
		db 0F3h	; Û
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
		db 0E7h	; Á
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db    0
		db    0
		db  19h
		db    0
		db 0CEh	; Œ
		db 0FFh
		db    0
		db    0
		db    0
		db    0
		db  32h	; 2
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0EDh	; Ì
		db 0FFh
		db  32h	; 2
		db    0
		db  0Ch
		db    0
		db  1Fh
		db    0
		db  32h	; 2
		db    0
		db 0F4h	; Ù
		db 0FFh
		db    0
		db    0
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
		db 0EDh	; Ì
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db 0F4h	; Ù
		db 0FFh
		db  1Fh
		db    0
		db 0CEh	; Œ
		db 0FFh
		db  0Ch
		db    0
		db  0Ch
		db    0
		db  32h	; 2
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0F3h	; Û
		db 0FFh
		db  32h	; 2
		db    0
		db  19h
		db    0
		db  25h	; %
		db    0
		db  32h	; 2
		db    0
		db 0E7h	; Á
		db 0FFh
		db  0Ch
		db    0
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
		db 0F3h	; Û
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db 0E7h	; Á
		db 0FFh
		db  25h	; %
		db    0
		db 0CEh	; Œ
		db 0FFh
		db  19h
		db    0
		db  19h
		db    0
		db  32h	; 2
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0F9h	; ˘
		db 0FFh
		db  32h	; 2
		db    0
		db  25h	; %
		db    0
		db  2Bh	; +
		db    0
		db  32h	; 2
		db    0
		db 0DBh	; €
		db 0FFh
		db  19h
		db    0
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
		db 0F9h	; ˘
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db 0DBh	; €
		db 0FFh
		db  2Bh	; +
		db    0
		db 0CEh	; Œ
		db 0FFh
		db  25h	; %
		db    0
		db  25h	; %
		db    0
		db  32h	; 2
		db    0
		db 0CEh	; Œ
		db 0FFh
		db    0
		db    0
		db  32h	; 2
		db    0
		db  32h	; 2
		db    0
		db  32h	; 2
		db    0
		db  32h	; 2
		db    0
		db 0CEh	; Œ
		db 0FFh
		db  25h	; %
		db    0
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
		db    0
		db    0
		db 0CEh	; Œ
		db 0FFh
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
		db 0CEh	; Œ
		db 0FFh
		db  32h	; 2
		db    0
;####################################################################################





handle		segment	para private 'BSS' use32
		assume cs:handle


dword_407EBC	dd ?			; DATA XREF: sub_401A71+Dw
					; sub_401DBE+307r ...
dword_407EC0	dd ?			; DATA XREF: sub_401A71+6w
					; sub_401A71+60w ...
byte_407EC4	db ?			; DATA XREF: fn:loc_401280w
					; DialogFunc+1E4w ...
byte_407EC5	db ?			; DATA XREF: fn+6Aw DialogFunc+1EBw ...
byte_407EC6	db ?			; DATA XREF: sub_401A71+14w
					; sub_401DBE+30Cr ...
		align 4
; struct tagPOINT Point
Point		tagPOINT <?>		; DATA XREF: DialogFunc+48Eo
					; sub_402343+27r ...
; struct tagPOINT stru_407ED0
stru_407ED0	tagPOINT <?>		; DATA XREF: sub_402343+3o
					; sub_402343+1Ar ...
; struct tagRECT Rect
Rect		tagRECT	<?>		; DATA XREF: sub_402343+Do
					; sub_402343+33r ...
dword_407EE8	dd ?			; DATA XREF: DialogFunc:loc_40172Dr
					; DialogFunc:loc_401747w ...



		align 10h
dword_408070	dd ?			; DATA XREF: sub_401884+8Do
					; sub_4021FF+20r ...
	db 408870h-408070h dup(?)	
			
dword_408870	dd ?			; DATA XREF: sub_401884+93o
	db 409070h-408870h dup (?)			
		
		
unk_409070	db    ?	;		; DATA XREF: sub_401DBE+218o
					; sub_401DBE+280o ...
		db 409524h-409070h dup(?)
			
unk_409524	db    ?	;		; DATA XREF: sub_401884+1Bo
					; sub_401DBE+102o ...
		db 4099D8h-409524h dup (?)
			
unk_4099D8	db    ?	;		; DATA XREF: sub_4019B6+10o
					; sub_401DBE+47o
		db 409F78h-4099D8h dup(?)
	
		
dword_409F78	dd ?			; DATA XREF: sub_4019B6+42w
					; sub_4019B6+80w ...
; HHOOK	hhk
hhk		dd ?			; DATA XREF: fn+7Cr DialogFunc+90r ...
; UINT uIDEvent
uIDEvent	dd ?			; DATA XREF: DialogFunc:loc_401354r
					; DialogFunc+89w ...
; HGDIOBJ dword_409F84
dword_409F84	dd ?			; DATA XREF: DialogFunc+FAr
					; sub_401A71+102w
; HGDIOBJ dword_409F88
dword_409F88	dd ?			; DATA XREF: DialogFunc+102r
					; sub_401A71+12Ew
; HGDIOBJ dword_409F8C
dword_409F8C	dd ?			; DATA XREF: DialogFunc+10Ar
					; DialogFunc+2A7w ...
; HDC dword_409F90
dword_409F90	dd ?			; DATA XREF: DialogFunc+D2r
					; sub_401A71+A8w ...
; int dword_409F94
dword_409F94	dd ?			; DATA XREF: DialogFunc+18Fr
					; DialogFunc+1B2r ...
; int dword_409F98
dword_409F98	dd ?			; DATA XREF: DialogFunc+195r
					; DialogFunc+1ACr
dword_409F9C	dd ?			; DATA XREF: DialogFunc+184r
dword_409FA0	dd ?			; DATA XREF: DialogFunc+189r
; HDC dword_409FA4
dword_409FA4	dd ?			; DATA XREF: DialogFunc+A6r
					; sub_401A71+EDw ...
; HDC dword_409FA8
dword_409FA8	dd ?			; DATA XREF: DialogFunc+B1r
					; DialogFunc+1A4r ...
; HWND hWnd
ds_hWnd		dd ?			; DATA XREF: fn+30r fn+4Er ...
; HINSTANCE hInstance
hInstance	dd ?			; DATA XREF: start+1FEw
					; DialogFunc+22Br ...
; LPCVOID lpBaseAddress
lpBaseAddress	dd ?			; DATA XREF: DialogFunc+37Ew
					; DialogFunc:loc_401692r ...
; HANDLE hObject
hObject		dd ?			; DATA XREF: DialogFunc+363w
					; DialogFunc+3C4r ...
; HANDLE hFile
hFile		dd ?			; DATA XREF: DialogFunc+31Dw
					; DialogFunc+32Dr ...
; HGDIOBJ dword_409FC0
dword_409FC0	dd ?			; DATA XREF: DialogFunc+EAr
					; DialogFunc+2B3w ...
; HBRUSH hbr
ds_hbr		dd ?			; DATA XREF: DialogFunc+2DDw
					; sub_401A71+17Br ...
; HGDIOBJ dword_409FC8
dword_409FC8	dd ?			; DATA XREF: DialogFunc+E2r
					; DialogFunc+171r ...
; HGDIOBJ dword_409FCC
dword_409FCC	dd ?			; DATA XREF: DialogFunc+F2r
					; DialogFunc+2C2w ...
; HGDIOBJ dword_409FD0
dword_409FD0	dd ?			; DATA XREF: DialogFunc+2E9w
					; sub_401A71+13Fr
dword_409FD4	dd ?			; DATA XREF: DialogFunc+341w
; HGLOBAL hMem
hMem		dd ?			; DATA XREF: DialogFunc+9Br
					; DialogFunc+252w ...
; char Filename[]
Filename	db 104h	dup(?)		; DATA XREF: DialogFunc+2EEo
; char Text[]
Text		db 200h	dup(?)		; DATA XREF: TopLevelExceptionFilter+18o
					; TopLevelExceptionFilter+25o ...
unk_40A2E0	db    ?	;		; DATA XREF: sub_401A71+21o
					; sub_401DBE+301o
	
		