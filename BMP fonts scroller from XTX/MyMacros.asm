literal MACRO quoted_text:VARARG
LOCAL local_text
.data
	local_text db quoted_text,0
align 4
.code
	EXITM <local_text>
ENDM
SADD MACRO quoted_text:VARARG
	EXITM <ADDR literal(quoted_text)>
ENDM
szText MACRO Name, Text:VARARG
LOCAL lbl
jmp lbl
	Name db Text,0
lbl:
ENDM
m2m MACRO M1, M2
	push M2
	pop  M1
ENDM
FUNC MACRO parameters:VARARG
	invoke parameters
	EXITM <eax>
ENDM

return MACRO arg
	mov eax, arg
	ret
ENDM

RGB MACRO red, green, blue
        xor eax, eax
        mov ah, blue    ; blue
        mov al, green   ; green
        rol eax, 8
        mov al, red     ; red
ENDM

chr$ MACRO any_text:VARARG
	LOCAL txtname
	.data
		txtname db any_text,0
	.code
	EXITM <OFFSET txtname>
ENDM

      dsText MACRO Name, Text:VARARG
      .data
        Name db Text,0
        align 4
      .code
      ENDM

AllowSingleInstance MACRO lpTitle
        invoke FindWindow,NULL,lpTitle
        cmp eax, 0
        je @F
          push eax
          invoke ShowWindow,eax,SW_RESTORE
          pop eax
          invoke SetForegroundWindow,eax
          mov eax, 0
          ret
        @@:
      ENDM