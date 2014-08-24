
PAINT proc @hWnd:dword


LOCAL Paint   :PAINTSTRUCT 
LOCAL var_4$    :dword 




                               lea     eax, [Paint]
                                push    eax             ; lpPaint
                                push    [@hWnd]      ; hWnd
                                call    BeginPaint
                                mov     [var_4$], eax
                                push    0               ; UINT
                                push    hMem            ; BITMAPINFO *
                                push    dword_40C484    ; void *
                                push    48h             ; UINT
                                push    0               ; UINT
                                push    0               ; int
                                push    0               ; int
                                push    48h             ; DWORD
                                push    0B5h            ; DWORD
                                push    5               ; int
                                push    7Ch             ; int
                                push    [var_4$]     ; HDC
                                call    SetDIBitsToDevice
                                ;push    [var_4]     ; HDC
                                ;push    [@hWnd]      ; int
                                ;call    sub_401E8E ; risuet knopki
                                lea     eax, [Paint]
                                push    eax             ; lpPaint
                                push    [@hWnd]      ; hWnd
                                call    EndPaint
                                leave
                                retn 4


PAINT endp



GetRes proc 
	LOCAL hResource		:DWORD
	LOCAL ResSize		:DWORD
	LOCAL lpResBuffer	:DWORD

	invoke FindResource,hInstance,1,RT_RCDATA ;get handle of resource
		mov hResource,eax				;preserve handle
		invoke SizeofResource,hInstance,hResource	;get size of resource
		mov ResSize,eax
		invoke LoadResource,hInstance,hResource
mov byte_406D19,eax

ret 
		
GetRes endp		
		
