scrl proc hwnd:dword

push    VK_UP;7Ah             ; vKey
call    GetAsyncKeyState
or eax,eax
jz @F
cmp nfo_rect.top,3
jz _ret

inc     nfo_rect.top;,3
jmp _ret
@@:
push    VK_DOWN;7Bh             ; vKey
call    GetAsyncKeyState
or eax,eax
jz @F
dec     nfo_rect.top;,3
jmp _ret

@@:
_ret:
ret

scrl endp