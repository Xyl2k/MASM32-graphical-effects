; Fireworks - with MMX blur and light effects
; by ronybc from Kerala,INDIA 
; website: http://www.ronybc.8k.com

.686p
.MMX
.model flat,stdcall
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\gdi32.inc
include \masm32\include\user32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\user32.lib

; struct spark {float x,xv,y,yv;};
; struct FireShell {DWORD life; float air; spark d[250];};
; sizeof FireShell = 250*4*4+8 = 4008 bytes

EXX   EQU 4
EXY   EQU 8
AIR   EQU 12
SPARC EQU 16

.data
ClassName db "apocalypse",0
AppName   db "Fireworks MMX ...by ronybc",0,0,0,0,0,0
info      db "Fireworks Version: 3.40229 - Freeware",13,10
          db  13,10
          db "WARNING: This is a Fireware, softwares that push CPU temperature",13,10
          db "to its maximum. It does No harm, but overclockers better stay away :)",13,10
          db "Entire source code of this program is free available at my website. ",13,10
          db  13,10
          db "If you like the work, help the author with donations.",13,10
          db "see http://www.ronybc.8k.com/support.htm",13,10
          db  13,10
          db "SPACE & ENTER keys toggles 'Gravity and Air' and",13,10
          db "'Light and Smoke' effects respectively.",13,10
          db "And clicks explode..! close clicks produce more light",13,10
          db  13,10
          db "Manufactured, bottled and distributed by",13,10
          db "Silicon Fumes Digital Distilleries, Kerala, INDIA",13,10
          db 13,10
          db "Copyright 1999-2004 © Rony B Chandran. All Rights Reserved",13,10
          db 13,10
          db "This isn't the Final Version",13,10
          db "check http://www.ronybc.8k.com for updates and more",0
          
fps       db 64 dup (0)
fmat      db "fps = %u   [www.ronybc.8k.com]",0          
seed      dd 2037280626
wwidth    dd 680               ; 1:1.618, The ratio of beauty ;)
wheight   dd 420               ; smaller the window faster the fires
maxx      dd 123               ; 123: values set on execution
maxy      dd 123               ; this thing is best for comparing
lightx    dd 123               ; cpu performance.
lighty    dd 123
flash     dd 123
flfactor  dd 0.92
adg       dd 0.00024           ; 0.00096 acceleration due to gravity
xcut      dd 0.00064
nb        dd 5                 ; number of shells
nd        dd 400               ; sparks per shell
sb        dd 0                 ; value set on execution
maxpower  dd 5
minlife   dd 500               ; altered @WndProc:WM_COMMAND:1300
motionQ   dd 16                ; 01-25, altered @WndProc:WM_COMMAND:1210
fcount    dd 0
GMode     dd 1                 ; atmosphere or outer-space
CMode     dd 0                 ; color shifter
EMode     dd 1                 ; special effects
click     dd 0
stop      dd 0
fadelvl   dd 1
chemtable dd 00e0a0ffh, 00f08030h, 00e6c080h, 0040b070h,  00aad580h

bminf     BITMAPINFO <<40,0,0,1,24,0,0,0,0,0,0>>

.data?
hInstance HINSTANCE ?
hwnd      LPVOID ?
hmnu      HWND ?
wnddc     HDC ?
hFThread  HANDLE ?
hHeap     HANDLE ?
idThread1 DWORD ?
idThread2 DWORD ?
bitmap1   LPVOID ?
bitmap2   LPVOID ?
hFShells  LPVOID ?
msg       MSG <>
wc        WNDCLASSEX <>

.code

random PROC uses edx base:DWORD         ; Park Miller random number algorithm
    mov eax, seed              ; from M32lib/nrand.asm
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
    mov seed, ecx
    div base
    mov eax, edx
    ret
random ENDP
; -------------------------------------------------------------------------
Light_Flash3  PROC uses ebx edx esi edi x1:DWORD, y1:DWORD, lum:DWORD, src:DWORD, des:DWORD
    LOCAL mx:DWORD, my:DWORD, x2:DWORD, y2:DWORD, tff:DWORD
    mov eax,lum
    shr eax,1                  ; Light_Flash: dynamic 2D lighting routine
    mov lum,eax                ; does not uses any pre-computed data
    mov tff,255                ; ie. pure light frum tha melting cpu core :)
    mov eax,maxx
    mov mx,eax
    mov eax,maxy
    dec eax
    mov my,eax
    mov esi,src
    mov edi,des
    xor eax,eax
    mov y2,eax
ylp3:                          ; 2x2 instead of per pixel lighting 
    xor eax,eax                ; half the quality, but higher speed
    mov x2,eax
xlp3:
    mov eax,y2
    sub eax,y1
    imul eax
    mov ebx,x2
    sub ebx,x1
    imul ebx,ebx
    add eax,ebx
    mov edx,lum
    imul edx,edx
    xor ebx,ebx
    cmp eax,edx
    ja @F                      ; jump to end causes time waves
    push eax
    fild dword ptr[esp]
    fsqrt
    fidiv lum                  ; this code is -nonlinear-
    fld1
    fsubrp st(1),st(0)
    fmul st(0),st(0)           ; curve
    fmul st(0),st(0)           ; curve more
    fimul tff
    fistp dword ptr[esp]

    pop ebx
    imul ebx,01010101h
@@:
    mov eax,y2
    imul maxx
    add eax,x2
    lea eax,[eax+eax*2]
    mov edx,maxx
    lea edx,[edx+edx*2]
    add edx,eax
    
    movd MM2,ebx               ; simply add with saturation
    movq MM0,[esi+eax]         ; gamma correction is against this code
    psllq MM2,32
    movq MM1,[esi+edx]
    movd MM3,ebx
    por MM2,MM3
    paddusb MM0,MM2
    movd dword ptr [edi+eax],MM0
    paddusb MM1,MM2
    psrlq MM0,32
    movd dword ptr [edi+edx],MM1
    movd ebx,MM0
    psrlq MM1,32
    mov word ptr [edi+eax+4],bx
    movd ecx,MM1
    mov [edi+edx+4],cx
    emms
@@:
    mov eax,x2
    add eax,2
    mov x2,eax
    cmp eax,mx
    jbe xlp3
    mov eax,y2
    add eax,2
    mov y2,eax
    cmp eax,my
    jbe ylp3
    ret
Light_Flash3 ENDP
; -------------------------------------------------------------------------
Blur_MMX2 PROC uses edi esi ebx edx                 ; 24bit color version
    mov edi,bitmap2            ; (Developed under an old SiS6326 graphic card
    mov esi,bitmap1            ;  which prefers 24bit for faster operation)
    mov bitmap1,edi            ;  Note: SiS315 is excellent, good rendering quality
    mov bitmap2,esi
    pxor MM7,MM7
    mov eax,fadelvl
    imul eax,00010001h
    mov [ebp-4],eax
    mov [ebp-8],eax
    movq MM6,[ebp-8]
    mov eax,maxx
    lea eax,[eax+eax*2]
    mov ebx,eax
    imul maxy
    push eax                   ; maxy*maxx*3
    lea edx,[ebx-3]
    lea ebx,[ebx+3]
    neg edx
    xor eax,eax
    lea esi,[esi-3]
@@:
    movd MM0,dword ptr [esi]             ; code enlarged version
    punpcklbw MM0,MM7          ; optimized for speed, not size
    movd MM1,dword ptr [esi+8]
    movd MM2,dword ptr [esi+16]
    punpcklbw MM1,MM7
    punpcklbw MM2,MM7
    
    movd MM3,dword ptr [esi+6]
    movd MM4,dword ptr [esi+14]
    movd MM5,dword ptr [esi+22]
    punpcklbw MM3,MM7
    paddw MM0,MM3
    punpcklbw MM4,MM7
    paddw MM1,MM4
    punpcklbw MM5,MM7
    paddw MM2,MM5

    movd MM3,dword ptr [esi+ebx]
    punpcklbw MM3,MM7
    paddw MM0,MM3
    movd MM4,dword ptr [esi+ebx+8]
    movd MM5,dword ptr [esi+ebx+16]
    punpcklbw MM4,MM7
    paddw MM1,MM4
    punpcklbw MM5,MM7
    paddw MM2,MM5

    movd MM3,dword ptr [esi+edx]
    punpcklbw MM3,MM7
    paddw MM0,MM3
    movd MM4,dword ptr [esi+edx+8]
    movd MM5,dword ptr [esi+edx+16]
    punpcklbw MM4,MM7
    paddw MM1,MM4
    punpcklbw MM5,MM7
    paddw MM2,MM5

    psrlw MM0,2                ; neibours only, ie. smoky blur
    psrlw MM1,2
    psrlw MM2,2
    psubusw MM0,MM6            ; fade
    psubusw MM1,MM6
    psubusw MM2,MM6
    packuswb MM0,MM7
    lea esi,[esi+12]
    packuswb MM1,MM7
    packuswb MM2,MM7
    movd dword ptr [edi+eax],MM0
    movd dword ptr [edi+eax+8],MM1
    movd dword ptr [edi+eax+16],MM2
    lea eax,[eax+12]
    cmp eax,[esp]
    jbe @B
    pop eax
    emms                       ; free fpu registers for following
    ret                        ; floating-point functions
Blur_MMX2 ENDP
; -------------------------------------------------------------------------
FShell_explodeOS PROC  uses edi hb:DWORD
    mov edi,hb
    add edi,SPARC
    mov eax,nd
    dec eax
    shl eax,4
@@:
    fld dword ptr[edi+eax]     ; x coordinate
    fadd dword ptr[edi+eax+4]  ; x velocity
    fstp dword ptr[edi+eax]
    fld dword ptr[edi+eax+8]   ; y coordinate
    fadd dword ptr[edi+eax+12] ; y velocity
    fstp dword ptr[edi+eax+8]
    sub eax,16
    jnc @B
    dec dword ptr[edi-SPARC]
    mov eax,[edi-SPARC]        ; return(--life)
    ret
FShell_explodeOS ENDP
; -------------------------------------------------------------------------
FShell_explodeAG PROC  uses edi hb:DWORD
    mov edi,hb
    fld adg                    ; acceleration due to gravity
    fld dword ptr[edi+AIR]     ; air resistance
    add edi,SPARC
    mov eax,nd
    dec eax
    shl eax,4
@@:
    fld dword ptr[edi+eax+4]   ; x velocity
    fmul st(0),st(1)           ; deceleration by air
    fst dword ptr[edi+eax+4]
    fadd dword ptr[edi+eax]    ; x coordinate
    fstp dword ptr[edi+eax]
    fld dword ptr[edi+eax+12]  ; y velocity
    fmul st(0),st(1)           ; deceleration by air
    fadd st(0),st(2)           ; gravity
    fst dword ptr[edi+eax+12]
    fadd dword ptr[edi+eax+8]  ; y coordinate
    fstp dword ptr[edi+eax+8]
    sub eax,16
    jnc @B
    fcompp                     ; marks st(0) and st(1) empty
    dec dword ptr[edi-SPARC]
    mov eax,[edi-SPARC]        ; return(--life)
    ret
FShell_explodeAG ENDP
; -------------------------------------------------------------------------
FShell_render PROC uses edi esi ebx edx hb:DWORD, color:DWORD
    LOCAL expx:DWORD, expy:DWORD, dw1:DWORD, dw2:DWORD
    mov edi,hb
    mov eax,[edi+EXX]
    mov expx,eax
    mov eax,[edi+EXY]
    mov expy,eax
    add edi,SPARC
    mov ebx,color
    dec ebx
    ;and ebx,3
    mov ecx,offset chemtable
    mov edx,hFShells           ; floats are beautiful, and cheap source of
    add edx,32                 ; the chemical used for multi colored fires
    mov eax,CMode
    or eax,eax
    cmovz edx,ecx
    mov edx,[edx+ebx*4]
    mov ecx,nd
    dec ecx
    shl ecx,4
    mov esi,bitmap1
    push maxy                  ; using stack adds speed
    push maxx                  ; (local variables)
    push edx
@@:
    fld dword ptr[edi+ecx+4]
    fabs
    fld xcut                   ; low cost code for independant burnouts
    fcomip st(0),st(1)
    fistp dw1
    jae forget

    fld dword ptr[edi+ecx]
    fistp dw1
    fld dword ptr[edi+ecx+8]
    fistp dw2
    mov eax,dw2
    cmp eax,[esp+8]
    jae forget
    mov ebx,dw1
    cmp ebx,[esp+4]
    jae forget
    imul dword ptr[esp+4]
    add eax,ebx
    lea eax,[eax+eax*2]
    mov edx,[esp]
    mov [esi+eax],dx
    shr edx,16
    mov [esi+eax+2],dl
forget:
    sub ecx,16
    jnc @B
    ;add esp,12  'leave'ing (ENDP)
    ret
FShell_render ENDP
; -------------------------------------------------------------------------
FShell_recycle PROC uses edi ebx hb:DWORD, x:DWORD, y:DWORD
	LOCAL	power:DWORD
	LOCAL	divisor:DWORD
	
    mov edi,hb
    mov eax,x
    mov [edi+EXX],eax
    mov eax,y
    mov [edi+EXY],eax
    mov eax,x
    mov lightx,eax             ; Light last one
    mov eax,y
    mov lighty,eax
    mov eax,flash              ; having only one light source
    add eax,3200               ; 3200 million jouls...! 
    mov flash,eax              ; add if previous lighting not extinguished
    invoke random,20
    inc eax
    imul minlife
    mov ebx,eax                ; sync explosions by mouse clicks with rest
    mov eax,[edi]              ; by maintaining minimum delay of 'minlife'
    xor edx,edx
    idiv minlife
    add edx,ebx
    mov [edi],edx
    invoke random,30           ; like its real world counterpart, creation process
    add eax,10                 ; is long and boring but the end product is explodin..
    mov power,eax            ; refer C++ source also. Most of the below area
    mov eax,10000              ; is blind translation of that original C code
    mov divisor,eax            ; i crawled on that code as a Human C compiler...!
    fld1
    fild power
    fidiv divisor
    fsubp st(1),st(0)
    fstp dword ptr[edi+AIR]
    add edi,SPARC
    fild y
    fild x
    mov eax,1000
    mov power,eax
    fild power      ; 1000 (constant)
    invoke random,maxpower
    inc eax
    mov power,eax
    fild power      ; power
    mov ecx,nd
    dec ecx
    shl ecx,4
@@:
    push ecx
    invoke random,2000
    mov power,eax
    fild power
    fsub st(0),st(2)
    fdiv st(0),st(2)
    fmul st(0),st(1)
    mov ecx,[esp]
    fstp dword ptr[edi+ecx+4]
    fld st(0)
    fmul st(0),st(0)
    fld dword ptr[edi+ecx+4]
    fmul st(0),st(0)
    fsubp st(1),st(0)
    fsqrt
    invoke random,2000
    mov power,eax
    fild power
    fsub st(0),st(3)
    fdiv st(0),st(3)
    fmulp st(1),st(0)
    mov ecx,[esp]
    fstp dword ptr[edi+ecx+12]
    fld st(2)
    fstp dword ptr[edi+ecx]
    fld st(3)
    fstp dword ptr[edi+ecx+8]
    pop ecx
    sub ecx,16
    jnc @B
    fcompp
    fcompp
    ret
FShell_recycle ENDP
; -------------------------------------------------------------------------


FireThread PROC dwParameter:DWORD
	LOCAL	ShellsToMake:DWORD
	LOCAL	SparksToMake:DWORD
	LOCAL	ShellMemory:DWORD
	LOCAL	dwPrecision:DWORD
	
	
    invoke SetThreadPriority,idThread1,THREAD_PRIORITY_HIGHEST
    invoke GetDC,hwnd
    mov wnddc,eax
    invoke GetProcessHeap
    mov hHeap,eax
    invoke HeapAlloc,hHeap,HEAP_ZERO_MEMORY,4194304
    push eax
    add eax,4096               ; blur: -1'th line problem
    mov bitmap1,eax
    pop eax
    invoke RtlZeroMemory, eax, 4194304
    invoke HeapAlloc,hHeap,HEAP_ZERO_MEMORY,4194304
    push eax
    add eax,4096               ; blur: -1'th line problem
    mov bitmap2,eax
    pop eax
    invoke RtlZeroMemory, eax, 4194304
    mov eax,nd
    shl eax,4
    add eax,SPARC
    mov sb,eax                 ; size of FShell = nd*16+8
    imul nb                    ; array size   = nb*sb
    push eax
    invoke HeapAlloc,hHeap,HEAP_ZERO_MEMORY,eax
    mov hFShells,eax
    pop ecx
    invoke RtlZeroMemory, eax, ecx

    finit                      ; initialise floating point unit
    mov eax,07fh                ; low precision floats
    mov dwPrecision,eax     ; fireworks... not space rockets
    fldcw word ptr[dwPrecision]

    ;sub ebp,12                 ; as 3 local variables

    mov eax,nb
    mov ShellsToMake,eax
    mov eax,hFShells 
    mov ShellMemory,eax
initshells:
    ;mov eax,maxx              ; naah... not needed
    ;shr eax,1                 ; trusting auto-zero
    ;invoke FShell_recycle,[ebp+4],eax,maxy
    ;mov eax,sb
    ;add [ebp+4],eax
    ;dec dword ptr[ebp]
    ;jnz initFShells
    ;mov flash,6400
lp1:
    mov eax,motionQ
    mov SparksToMake,eax
lp2:
    mov eax,nb
    mov ShellsToMake,eax
    mov eax,hFShells
    mov ShellMemory,eax
lp3:
    invoke FShell_render,ShellMemory,ShellsToMake
    mov eax,GMode
    mov ecx,offset FShell_explodeAG
    mov ebx,offset FShell_explodeOS
    test eax,eax
    cmovz ecx,ebx
    push ShellMemory
    call ecx
    test eax,eax
    jns @F
    invoke random,maxy
    push eax
    mov eax,maxx
    add eax,eax
    invoke random,eax
    mov edx,maxx
    shr edx,1
    sub eax,edx
    push eax
    push ShellMemory
    call FShell_recycle
@@:
    mov eax,sb
    add ShellMemory,eax
    dec ShellsToMake
    jnz lp3
    dec SparksToMake
    jnz lp2
    mov eax,EMode
    test eax,eax
    jz r1
    mov eax,CMode              ; switch pre/post blur according to -
    test eax,eax               ; current chemical in fire
    jz @F
    invoke Blur_MMX2
@@:
    invoke Light_Flash3,lightx,lighty,flash,bitmap1,bitmap2
    invoke SetDIBitsToDevice,wnddc,0,0,maxx,maxy,\
           0,0,0,maxy,bitmap2,ADDR bminf,DIB_RGB_COLORS
    mov eax,CMode
    test eax,eax
    jnz r2
    invoke Blur_MMX2
    jmp r2
r1:
    invoke SetDIBitsToDevice,wnddc,0,0,maxx,maxy,\
           0,0,0,maxy,bitmap1,ADDR bminf,DIB_RGB_COLORS
    mov eax,maxx
    imul maxy
    lea eax,[eax+eax*2]
    invoke RtlZeroMemory,bitmap1,eax
r2:
    inc fcount                 ; count the frames
    fild flash
    fmul flfactor
    fistp flash
    invoke Sleep,5             ; control, if frames rate goes too high
    mov eax,stop
    test eax,eax
    jz lp1
    invoke ReleaseDC,hwnd,wnddc 
    invoke HeapFree,hHeap,0,bitmap1
    invoke HeapFree,hHeap,0,bitmap2
    invoke HeapFree,hHeap,0,hFShells
    mov idThread1,-1
    invoke ExitThread,2003
    ;hlt                        ; ...! i8085 memories
FireThread EndP
; -------------------------------------------------------------------------


MoniThread PROC dwParameter:DWORD
    invoke Sleep,1000
    invoke wsprintf,ADDR fps,ADDR fmat,fcount
    invoke SetWindowText,hwnd,ADDR fps
    xor eax,eax
    mov fcount,eax
    mov eax,stop
    test eax,eax
    jz MoniThread
    mov idThread2,-1
    invoke ExitThread,2003
MoniThread ENDP
; -------------------------------------------------------------------------
Switch PROC uses ebx edx oMode:DWORD, iid:DWORD
    xor eax,eax
    mov edx,oMode
    or al,byte ptr [edx]
    setz  byte ptr [edx]
    mov eax,[edx]
    mov ebx,MF_CHECKED
    shl eax,3
    and eax,ebx
    or eax,MF_BYCOMMAND
    invoke CheckMenuItem,hmnu,iid,eax
    ret
Switch ENDP
; -------------------------------------------------------------------------
WndProc PROC  uses edi esi ebx edx hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    .IF uMsg==WM_MOUSEMOVE && wParam==MK_CONTROL
        xor edx,edx
        mov flash,2400
        mov eax,lParam
        mov dx,ax
        shr eax,16
        mov lightx,edx
        mov lighty,eax
    .ELSEIF uMsg==WM_SIZE && wParam!=SIZE_MINIMIZED
        xor edx,edx
        mov eax,lParam
        mov dx,ax
        shr eax,16
        shr edx,2
        shl edx,2
        mov maxx,edx
        mov maxy,eax
        mov bminf.bmiHeader.biWidth,edx
        neg eax          ; -maxy
        mov bminf.bmiHeader.biHeight,eax
    .ELSEIF uMsg==WM_KEYDOWN && wParam==VK_SPACE
        invoke Switch,OFFSET GMode,1200
    .ELSEIF uMsg==WM_KEYDOWN && wParam==VK_RETURN
        invoke Switch,OFFSET EMode,1220
        mov flash,0
    .ELSEIF uMsg==WM_RBUTTONDOWN
        invoke MessageBox,hWnd,ADDR info,ADDR AppName,MB_OK or MB_ICONASTERISK
    .ELSEIF uMsg==WM_LBUTTONDOWN
        xor edx,edx
        mov eax,lParam
        mov dx,ax
        shr eax,16
        push eax
        push edx
        mov edx,nb
        dec edx
        mov eax,click
        dec eax
        cmovs eax,edx
        mov click,eax
        imul sb
        add eax,hFShells
        push eax
        call FShell_recycle
    .ELSEIF uMsg==WM_CLOSE
        mov stop,1                  ; stop running threads
        invoke Sleep,100            ; avoid FireThread drawing without window
        invoke DestroyWindow,hwnd
        invoke PostQuitMessage,0
    .ELSEIF uMsg==WM_COMMAND
       .IF wParam==1010
        invoke SendMessage,hwnd,WM_CLOSE,0,0
       .ELSEIF wParam==1000
        invoke SuspendThread,hFThread ; suffering technical difiiculties :)
        mov eax,maxx                  ; major motiv - to see ZeroMem in acion
        imul maxy
        lea eax,[eax+eax*2]
        invoke RtlZeroMemory,bitmap1,eax ; this thing is fast,
        invoke RtlZeroMemory,bitmap2,eax ; but hidden from some API docs
        push nb
        push hFShells
    @@: 
        mov eax,maxx
       ;shr eax,1
         shr eax,2
         mov edx,[esp+4]
         dec edx
         imul eax,edx
        mov ebx,maxy
        shr ebx,1
        invoke FShell_recycle,[esp+8],eax,ebx
        mov eax,sb
        add [esp],eax
        dec dword ptr[esp+4]
        jnz @B
        ;mov flash,6400
        invoke ResumeThread,hFThread
        pop eax
        pop eax
       .ELSEIF wParam==1200
        invoke Switch,OFFSET GMode,1200
       .ELSEIF wParam==1210
        invoke Switch,OFFSET CMode,1210
        mov ecx,CMode
        mov eax,16
        shr eax,cl
        mov motionQ,eax        ; changing motionQ affects speed
       .ELSEIF wParam==1220
        invoke Switch,OFFSET EMode,1220
        mov flash,0
       .ELSEIF wParam==1300
        invoke CheckMenuItem,hmnu,1310,MF_BYCOMMAND or MF_UNCHECKED
        invoke CheckMenuItem,hmnu,1300,MF_BYCOMMAND or MF_CHECKED
        mov minlife,500        ; long interval between shoots
       .ELSEIF wParam==1310
        invoke CheckMenuItem,hmnu,1300,MF_BYCOMMAND or MF_UNCHECKED
        invoke CheckMenuItem,hmnu,1310,MF_BYCOMMAND or MF_CHECKED
        mov minlife,100        ; short interval
       .ELSEIF wParam==1400
        invoke MessageBox,hWnd,ADDR info,ADDR AppName,MB_OK or MB_ICONASTERISK
       .ENDIF
    .ELSE
        invoke DefWindowProc,hWnd,uMsg,wParam,lParam        
        ret
    .ENDIF
    xor eax,eax
    ret
WndProc ENDP
; -------------------------------------------------------------------------

start:
    invoke GetModuleHandle,NULL
    mov hInstance,eax
    mov wc.hInstance,eax
    mov wc.cbSize,SIZEOF WNDCLASSEX
    mov wc.style,CS_HREDRAW or CS_VREDRAW or CS_BYTEALIGNCLIENT
    mov wc.lpfnWndProc,OFFSET WndProc
    mov wc.cbClsExtra,NULL
    mov wc.cbWndExtra,NULL
    mov wc.hbrBackground,COLOR_MENUTEXT
    mov wc.lpszMenuName,NULL
    mov wc.lpszClassName,OFFSET ClassName
    invoke LoadCursor,NULL,IDC_ARROW
    mov wc.hCursor,eax
    invoke LoadIcon,hInstance,500
    mov wc.hIcon,eax
    mov wc.hIconSm,eax
    invoke RegisterClassEx,ADDR wc
    invoke CreateWindowEx,WS_EX_OVERLAPPEDWINDOW,ADDR ClassName,ADDR AppName,\
                          WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,\
                          CW_USEDEFAULT,wwidth,wheight,NULL,NULL,\
                          hInstance,NULL
    mov hwnd,eax
    add seed,eax          ;)
    invoke LoadMenu,hInstance,600
    mov hmnu,eax
    invoke SetMenu,hwnd,eax
    invoke CheckMenuItem,hmnu,1200,MF_BYCOMMAND or MF_CHECKED
    invoke CheckMenuItem,hmnu,1220,MF_BYCOMMAND or MF_CHECKED
    invoke CheckMenuItem,hmnu,1300,MF_BYCOMMAND or MF_CHECKED
    invoke ShowWindow,hwnd,SW_SHOWNORMAL
    invoke UpdateWindow,hwnd
    invoke CreateThread,0,4096,ADDR MoniThread,0,0,ADDR idThread1
    invoke CreateThread,0,4096,ADDR FireThread,0,0,ADDR idThread2
    mov hFThread,eax
    MsgLoop:
        invoke GetMessage,ADDR msg,0,0,0
        test eax,eax
        jz EndLoop
        invoke TranslateMessage,ADDR msg
        invoke DispatchMessage,ADDR msg
        jmp MsgLoop
    EndLoop:
    @@: mov eax,idThread1
        or  eax,idThread2
        not eax
        and eax,eax
        jnz @B
    invoke ExitProcess,eax

end start