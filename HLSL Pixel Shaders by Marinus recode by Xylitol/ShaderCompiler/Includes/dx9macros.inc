;//////////////////////////////////////////////////////////////////////////////
;//
;//  File:       d3dx9macros.inc
;//  Content:    coinvoke and some other usefull macros for D3D9 
;//
;//  by: Siekmanski ( except for the coinvoke stuff )
;//
;//////////////////////////////////////////////////////////////////////////////

coinvoke MACRO pInterface:REQ, Interface:REQ, Function:REQ, args:VARARG
    LOCAL istatement, arg
    FOR arg, <args>     ;; run thru args to see if edx is lurking in there
        IFIDNI <&arg>, <edx>
            .ERR <edx is not allowed as a coinvoke parameter>
        ENDIF
    ENDM
    IFIDNI <&pInterface>, <edx>
        .ERR <edx is not allowed as a coinvoke parameter>
    ENDIF
    istatement CATSTR <invoke (Interface PTR[edx]).&Interface>,<_>,<&Function, pInterface>
    IFNB <args>     ;; add the list of parameter arguments if any
        istatement CATSTR istatement, <, >, <&args> 
    ENDIF 
    mov edx, pInterface
    mov edx, [edx]
    istatement
ENDM

comethod1Proto      typedef proto :DWORD
comethod2Proto      typedef proto :DWORD, :DWORD
comethod3Proto      typedef proto :DWORD, :DWORD, :DWORD
comethod4Proto      typedef proto :DWORD, :DWORD, :DWORD, :DWORD
comethod5Proto      typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
comethod6Proto      typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD
comethod7Proto      typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD
comethod8Proto      typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD
comethod9Proto      typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD
comethod10Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
comethod11Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD
comethod12Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD
comethod13Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD
comethod14Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD
comethod15Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
comethod16Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD
comethod17Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD
comethod18Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD
comethod19Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD
comethod20Proto     typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD,    :DWORD, :DWORD, :DWORD, :DWORD, :DWORD

comethod1           typedef ptr comethod1Proto
comethod2           typedef ptr comethod2Proto
comethod3           typedef ptr comethod3Proto
comethod4           typedef ptr comethod4Proto
comethod5           typedef ptr comethod5Proto
comethod6           typedef ptr comethod6Proto
comethod7           typedef ptr comethod7Proto
comethod8           typedef ptr comethod8Proto
comethod9           typedef ptr comethod9Proto
comethod10          typedef ptr comethod10Proto
comethod11          typedef ptr comethod11Proto
comethod12          typedef ptr comethod12Proto
comethod13          typedef ptr comethod13Proto
comethod14          typedef ptr comethod14Proto
comethod15          typedef ptr comethod15Proto
comethod16          typedef ptr comethod16Proto
comethod17          typedef ptr comethod17Proto
comethod18          typedef ptr comethod18Proto
comethod19          typedef ptr comethod19Proto
comethod20          typedef ptr comethod20Proto


_vtIUnknown MACRO CastName:REQ
	&CastName&_QueryInterface	comethod3 ?
	&CastName&_AddRef		comethod1 ?
	&CastName&_Release		comethod1 ?
ENDM

IUnknown struct
	_vtIUnknown IUnknown
IUnknown ends

SAFE_RELEASE MACRO pInterface:REQ
	.if pInterface != 0
	    coinvoke pInterface,IUnknown,Release
	mov pInterface,0
	.endif
ENDM

;---------------------------------------------------------------------
; equate primitives for use with other structures besides .IF
SUCCEEDED   TEXTEQU     <!!SIGN?>
FAILED      TEXTEQU     <!!SUCCEEDED>

;---------------------------------------------------------------------
; tests the value in eax to determine if the previous COM call
; issued a passing hresult
if_SUCCEEDED MACRO
    test eax, eax
    .if SUCCEEDED
ENDM
;
;---------------------------------------------------------------------
; tests the value in eax to determine if the previous COM call
; issued a failing hresult
if_FAILED   MACRO
    test eax, eax
    .IF FAILED
ENDM


; The following 2 macro's need this piece of code
; at the start of your program!!.
; .data
;	Heap dd 0
; .code
;	invoke		GetProcessHeap
;	mov		Heap,eax

Alloc_mem MACRO mem_ptr:REQ,how_much:REQ
	 invoke	HeapAlloc,Heap,HEAP_ZERO_MEMORY,how_much
	mov	mem_ptr,eax
ENDM

Delete_mem MACRO mem_ptr:REQ
	.if mem_ptr != 0
	 invoke	HeapFree,Heap,NULL,mem_ptr
	.endif
ENDM

GUID_ADDR MACRO guid_text:REQ
	LOCAL guid_data
	.data
	 guid_data GUID guid_text
	.code
	EXITM <addr (guid_data)>
ENDM

GUID_ MACRO guid_text:REQ
	LOCAL guid_data
	.data
	 guid_data GUID guid_text
	.code
	EXITM <offset (guid_data)>
ENDM

GUID_COPY MACRO guid_dest:REQ,guid_src:REQ
	mov eax,[guid_src]
	mov [guid_dest],eax
	mov eax,[guid_src + 4]
	mov [guid_dest + 4],eax
	mov eax,[guid_src + 8]
	mov [guid_dest + 8],eax
	mov eax,[guid_src + 12]
	mov [guid_dest + 12],eax
ENDM

TEXT_ MACRO your_text:VARARG
	LOCAL text_string
	.data
	 text_string db your_text,0
	.code
	EXITM <addr text_string>
ENDM

FLT4 MACRO float_number:REQ
LOCAL float_num
	.data
	 align 4
	 float_num real4 float_number
	.code
	EXITM <float_num>
ENDM

FLT8 MACRO float_number:REQ
LOCAL float_num
	.data
	 align 8
	 float_num real8 float_number
	.code
	EXITM <float_num>
ENDM

m2m MACRO M1:REQ,M2:REQ
	push M2
	pop  M1
ENDM


return MACRO dit:REQ
	mov eax,dit
	ret
ENDM


MAKE_HRESULT MACRO severity:REQ,facility:REQ,code:REQ
	EXITM %((severity shl 31) or ((facility and 0fffh) shl 16) or (code and 0ffffh))
ENDM

GUID_NULL	TEXTEQU <{0,0,0,{0,0,0,0,0,0,0,0}}>

Shuffle MACRO V0,V1,V2,V3
    EXITM %((V0 shl 6) or (V1 shl 4) or (V2 shl 2) or (V3))
ENDM



