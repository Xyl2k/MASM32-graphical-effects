GenKey		PROTO		:DWORD
Rndproc		PROTO		:DWORD
Ismail		PROTO 		:DWORD,:DWORD

.data
NameBuffer 		db 1000h dup(0) ;<--- i know it's too high but if i set it to less than 4096 it may either
								;     crash the keygen or just losing some of the GDI objects. or it just
								;     doesnt generate anymore.
FinalBuffer 	db 1000h dup(0)
FirstRndval 	dd 0AAAAAAAAh
ScndRndval 		dd 0BBBBBBBBh
ThirdRndval 	dd 0CCCCCCCCh
FourthRndval 	dd 0DDDDDDDDh
SerialBuffer 	db 1000h dup(0)
RndBuffer 		dd 0


.code

Rndproc proc RndValue:DWORD

		push ebx
		push edx
		cmp RndBuffer, 0
		jnz beginrnd
		call GetTickCount
		mov RndBuffer, eax

beginrnd:
		mov eax, [RndValue]
		xor ebx, ebx
		imul edx, RndBuffer[ebx], 8088405h
		inc edx
		mov RndBuffer[ebx], edx
		mul edx
		mov eax, edx
		pop ebx
		pop edx
		ret

Rndproc endp

HexSwap proc near
	
		push esi
		mov esi, eax
		xor edx, edx
		test esi, esi
		mov [edi], edx
		jnz secondpart

firstpart:
		xor eax, eax
		pop esi
		retn

secondpart:
		movzx eax, byte ptr [esi]
		test ax, ax
		mov ecx, 1
		jz firstpart
		lea esp, [esp]

thirdpart:
		cmp ax, 20h
		jz fourthpart
		cmp ax, 9
		jz fourthpart
		movzx eax, ax
		imul eax, ecx
		xor eax, 415D9482h
		add edx, 1
		cmp edx, 1Eh
		mov ecx, eax
		jge finalize

fourthpart:
		movzx eax, byte ptr [esi+1]
		add esi, 1
		test ax, ax
		jnz thirdpart

finalize:
		cmp edx, 8
		jl firstpart
		mov [edi], ecx
		mov eax, 1
		pop esi
		ret

HexSwap endp

CustomRndProc proc near
	
		push ebx
		xor eax, 639C7044h
		xor ecx, 438B0921h
		mov ebx, edx
		xor ebx, 83557F37h
		imul ebx, ecx
		imul ebx, eax
		mov eax, 8421085h
		mul ebx
		mov eax, ebx
		sub eax, edx
		shr eax, 1
		add eax, edx
		shr eax, 4
		mov cl, 1Fh
		imul cl
		mov cl, bl
		sub cl, al
		rol ebx, cl
		mov eax, 8421085h
		xor ebx, 4296CD7Ah
		mul ebx
		mov eax, ebx
		sub eax, edx
		shr eax, 1
		add eax, edx
		shr eax, 4
		mov dl, 1Fh
		imul dl
		mov cl, bl
		sub cl, al
		mov eax, ebx
		rol eax, cl
		pop ebx
		ret

CustomRndProc endp

Ismail proc uses esi ecx Value:DWORD,szValue:DWORD ;snippet by TomaHawk[EDGE]

		mov esi, [ebp+8]
		mov ecx, [ebp+0ch]
		xor eax,eax
		mov edx, '@'
		a1:
		lodsb
		cmp eax, edx
		je a0
		loopne a1
		xor eax, eax
		Ret
		a0:
		mov eax, 1
		Ret

Ismail endp

Clean proc

		invoke RtlZeroMemory,offset SerialBuffer,400h
		invoke RtlZeroMemory,offset FinalBuffer,400h
		ret

Clean endp