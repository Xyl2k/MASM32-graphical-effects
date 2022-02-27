
comment */

  some line animation ripped from HTB's keygens - by r0ger^PRF 
  ( this time with Code Snippet Creator plugin from IDA 6.8 ;) ) :
  
  - Quick Screenshot Maker v2.1.0 keygen by HTBTeam
  - Total_Commander_6.53_patch_by_HTBTeam
  - crac3k 18 wheel of steel crk.exe (idk just got it from some forum idk its original rls name...)
 
 
  but also in UnderPL's keygens :
  
  - 3D.Blocks.2006.v2.62.WinAll.Incl.Keygen-UnderPl
  - Alive.Video.Converter.v2.2.0.8.Incl.Keygen-UnderPl
  - Apollo.MPEG.to.DVD.Burner.v2.4.0.WinAll.Incl.Keygen-UnderPl
  - Awesome.50-Play.Poker.v1.1c.Keygen.Only-UnderPl
  - Ease.Audio.Converter.v2.70.Incl.Keygen-UnderPl
  - Fanix.Software.As-U-Type.v3.0.Incl.Keygen-UnderPl
  - FlashGet.v1.71.WinALL.Keygen.Only-UnderPl
  - WMA.WAV.MP3.to.Audio.CD.Maker.v1.0.4.WinAll.Keygen.Only-UnderPl
  ( actually that is what i've got with these similar effects in my crack collection. :E )
 
/*

.const
; you should specify the size of the window so the line anim can adjust the size automatically with -1 value (y'know.. 350 - 1 / 15Eh - 1)
xWidth	equ	350
xHeight	equ	159

.data
LineCol	dd	0FFFFFFh ; 00FF802Bh - every colour works in this line anim so ur choice - the color applied in this anim is white and it's original.

.code
LineAnim proc near

var_38 	= dword ptr -38h
var_34 	= dword ptr -34h
var_30 	= dword ptr -30h
var_2C 	= dword ptr -2Ch
var_28 	= dword ptr -28h
var_24 	= dword ptr -24h
var_20 	= dword ptr -20h
var_1C 	= dword ptr -1Ch
var_18 	= dword ptr -18h
var_14 	= dword ptr -14h
yAxs 	= dword ptr -10h
xAxs 	= dword ptr -0Ch
var_8 	= dword ptr -8
LineDC 	= dword ptr -4
hWnd 	= dword ptr  8

		push ebp
		mov ebp, esp
		add esp, 0FFFFFFC8h
		; initialize dc for the lines
		invoke GetDC,[ebp+hWnd]
		; and all its values
		mov [ebp+LineDC], eax
		mov [ebp+var_38], 0
		mov [ebp+xAxs], 1Eh
		mov [ebp+yAxs], 0
		mov [ebp+var_18], 0
		mov [ebp+var_1C], 1Eh
		mov [ebp+var_24], 13Fh
		mov [ebp+var_28], xHeight-1
		mov [ebp+var_30], xWidth-1
		mov [ebp+var_34], 80h

loc_401B8A:
		inc [ebp+var_38]
		cmp [ebp+var_38], 5
		jnz loc_linesinit
		invoke Sleep,9 ; animation speed
		mov [ebp+var_38], 0
; initialize lines and its colours.
loc_linesinit: 			
		invoke SetPixel,[ebp+LineDC],[ebp+xAxs],[ebp+yAxs],LineCol
		invoke SetPixel,[ebp+LineDC],[ebp+var_18],[ebp+var_1C],0
		invoke SetPixel,[ebp+LineDC],[ebp+var_24],[ebp+var_28],LineCol
		invoke SetPixel,[ebp+LineDC],[ebp+var_30],[ebp+var_34],0
; start animation from here:
loc_401BE7:
		cmp [ebp+var_8], 1
		jz loc_401C09
		cmp [ebp+xAxs], xWidth-1
		jz loc_401BFB
		inc [ebp+xAxs]
		jmp loc_401C2F

loc_401BFB:
		cmp [ebp+yAxs], xHeight-1
		jz loc_401C09
		inc [ebp+yAxs]
		jmp loc_401C2F

loc_401C09:
		mov [ebp+var_8], 1
		cmp [ebp+xAxs], 0
		jz loc_401C1B
		dec [ebp+xAxs]
		jmp loc_401C2F

loc_401C1B:
		cmp [ebp+yAxs], 0
		jnz loc_401C2A
		mov [ebp+var_8], 0
		jmp loc_401BE7

loc_401C2A:
		dec [ebp+yAxs]
		jmp $+2

loc_401C2F:
		cmp [ebp+var_14], 1
		jz loc_401C4E
		cmp [ebp+var_1C], 0
		jz loc_401C40
		dec [ebp+var_1C]
		jmp loc_401C77

loc_401C40:
		cmp [ebp+var_18], xWidth-1
		jz loc_401C4E
		inc [ebp+var_18]
		jmp loc_401C77

loc_401C4E:
		mov [ebp+var_14], 1
		cmp [ebp+var_1C], xHeight-1
		jz loc_401C63
		inc [ebp+var_1C]
		jmp loc_401C77

loc_401C63:
		cmp [ebp+var_18], 0
		jnz loc_401C72
		mov [ebp+var_14], 0
		jmp loc_401C2F

loc_401C72:
		dec [ebp+var_18]
		jmp $+2

loc_401C77:
		cmp [ebp+var_20], 1
		jz loc_401C93
		cmp [ebp+var_24], 0
		jz loc_401C88
		dec [ebp+var_24]
		jmp loc_401CBF

loc_401C88:
		cmp [ebp+var_28], 0
		jz loc_401C93
		dec [ebp+var_28]
		jmp loc_401CBF

loc_401C93:
		mov [ebp+var_20], 1
		cmp [ebp+var_24], xWidth-1
		jz loc_401CA8
		inc [ebp+var_24]
		jmp loc_401CBF

loc_401CA8:
		cmp [ebp+var_28], xHeight-1
		jnz loc_401CBA
		mov [ebp+var_20], 0
		jmp loc_401C77

loc_401CBA:
		inc [ebp+var_28]
		jmp $+2

loc_401CBF:
		cmp [ebp+var_2C], 1
		jz loc_401CE4
		cmp [ebp+var_34], xHeight-1
		jz loc_401CD6
		inc [ebp+var_34]
		jmp loc_401B8A

loc_401CD6:
		cmp [ebp+var_30], 0
		jz loc_401CE4
		dec [ebp+var_30]
		jmp loc_401B8A

loc_401CE4:
		mov [ebp+var_2C], 1
		cmp [ebp+var_34], 0
		jz loc_401CF9
		dec [ebp+var_34]
		jmp loc_401B8A

loc_401CF9:
		cmp [ebp+var_30], xWidth-1
		jnz loc_401D0B
		mov [ebp+var_2C], 0
		jmp loc_401CBF

loc_401D0B:
		inc [ebp+var_30]
		jmp loc_401B8A
;ends here and then loops over & over again.
LineAnim endp


