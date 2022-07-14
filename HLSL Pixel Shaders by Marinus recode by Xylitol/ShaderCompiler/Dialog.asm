; Siekmanski's Direct3D9 Pixel shader compiler.
; To compile a shader you need one of the D3DX9 wrapper libs (D3DX9_XX.dll)
; If you don't have one you can download it here:
; DirectX End-User Runtimes (June 2010) https://www.microsoft.com/en-us/download/details.aspx?id=8109
; http://jamie-wong.com/2016/07/15/ray-marching-signed-distance-functions/

.686p
.model flat, stdcall
.xmm
option casemap :none

include                 \masm32\include\windows.inc ; main windows include file
include                 \masm32\include\kernel32.inc
include                 \masm32\include\user32.inc
include                 \masm32\include\ole32.inc
include                 \masm32\include\msvcrt.inc
include                 Includes\d3d9.inc
include                 Includes\d3d9extra.Inc

includelib              \masm32\lib\kernel32.lib
includelib              \masm32\lib\user32.lib
includelib              \masm32\lib\ole32.lib
includelib              \masm32\lib\msvcrt.lib
includelib              Libs\d3d9.lib
includelib              Libs\d3d9extra.lib

DlgProc                 PROTO :DWORD,:DWORD,:DWORD,:DWORD

.const
IDD_DIALOGBOX           equ 2001
IDB_QUIT                equ 2003
IDB_SHADER_SQUAD        equ 2004
IDB_TOGGLE_TEXT         equ 2005
IDB_SAVE_SHADER         equ 2006

IID_ID3DXBuffer TEXTEQU <{08ba5fb08h,05195h,040e2h,{0ach,058h,00dh,098h,09ch,03ah,001h,002h}}>

_vtID3DXBuffer MACRO CastName:REQ
    _vtIUnknown CastName
    &CastName&_GetBufferPointer comethod1 ?
    &CastName&_GetBufferSize    comethod1 ?
ENDM

ID3DXBuffer struct
    _vtID3DXBuffer  ID3DXBuffer
ID3DXBuffer ends

LPD3DXBUFFER        typedef PTR DWORD

D3DXSHADER_DEBUG                          equ  1
D3DXSHADER_SKIPVALIDATION                 equ (1 shl 1)
D3DXSHADER_SKIPOPTIMIZATION               equ (1 shl 2)
D3DXSHADER_PACKMATRIX_ROWMAJOR            equ (1 shl 3)
D3DXSHADER_PACKMATRIX_COLUMNMAJOR         equ (1 shl 4)
D3DXSHADER_PARTIALPRECISION               equ (1 shl 5)
D3DXSHADER_FORCE_VS_SOFTWARE_NOOPT        equ (1 shl 6)
D3DXSHADER_FORCE_PS_SOFTWARE_NOOPT        equ (1 shl 7)
D3DXSHADER_NO_PRESHADER                   equ (1 shl 8)
D3DXSHADER_AVOID_FLOW_CONTROL             equ (1 shl 9)
D3DXSHADER_PREFER_FLOW_CONTROL            equ (1 shl 10)
D3DXSHADER_ENABLE_BACKWARDS_COMPATIBILITY equ (1 shl 12)
D3DXSHADER_IEEE_STRICTNESS                equ (1 shl 13)
D3DXSHADER_USE_LEGACY_D3DX9_31_DLL        equ (1 shl 16)

; optimization level flags
D3DXSHADER_OPTIMIZATION_LEVEL0            equ (1 shl 14)
D3DXSHADER_OPTIMIZATION_LEVEL1            equ  0
D3DXSHADER_OPTIMIZATION_LEVEL2            equ ((1 shl 14) or (1 shl 15))
D3DXSHADER_OPTIMIZATION_LEVEL3            equ (1 shl 15)

.data
align 4
g_pD3D                  LPDIRECT3D9 NULL    
g_pD3DDevice            LPDIRECT3DDEVICE9 NULL
g_pPixelShader          LPDIRECT3DPIXELSHADER9 NULL
g_pShaderTemp           LPD3DXBUFFER NULL
g_pShaderMessage        LPD3DXBUFFER NULL
BackgroundColor         dd  D3DCOLOR_XRGB(0,0,0)

pShaderBufferPtr        dd NULL
dwShaderBufferSize      dd NULL

D3DCompiler_Library     dd NULL
D3DCompileFunc          dd NULL
D3DCompileFromFileFunc  dd NULL
D3DCompileFromFile_     db "D3DXCompileShaderFromFileA",0
D3DCompiler_Lib         db "D3DX9_XX.dll",0 ; 32 - 43
CompilerVersionTable    db "43","42","41","40","39","38","37","36","35","34","33","32" ; try to find 1 of the 12 D3DX9 wrapper libs to get the compiler function.

hFileOut                dd NULL
dwBytesDone             dd 0

align 16
Screen_Quad             real4 0.0, 0.0, 0.5, 1.0, 0.0, 0.0 ; left top     ( X,Y,Z,W,U,V )
                        real4 0.0, 0.0, 0.5, 1.0, 1.0, 0.0 ; right top    ( X,Y,Z,W,U,V )
                        real4 0.0, 0.0, 0.5, 1.0, 0.0, 1.0 ; left bottom  ( X,Y,Z,W,U,V )
                        real4 0.0, 0.0, 0.5, 1.0, 1.0, 1.0 ; right bottom ( X,Y,Z,W,U,V )

                             ; X    Y    Z    W
PixelShaderConstants    real4 0.0, 0.0, 0.0, 0.0  ; copy this to the pixel shader input register(c0)
                                                  ; X,Y,Z is the pixel shader viewport resolution (Z is the pixel aspect ratio, usually 1.0)
                                                  ; W is the time in seconds ( used for animation )
TextPos                 real4 0.0
TextPos2                real4 0.0
ToggleText              dd 1

DlgName                 db "Siekmanski PixelShader Compiler.",0
szBtnQuit               db "Close",0
szBtnToogleText         db "Toogle text",0
szBtnSave               db "Save shader code",0

; Uncomment a "PixelShaderFile" to compile and run it.

; Siekmanski's HLSL very basic tutorials:
; To get an idea how pixels are drawn in a Pixel shader.

;PixelShaderFile            db "PixelShaders\basic1.hlsl",0
;PixelShaderFile            db "PixelShaders\basic2.hlsl",0
;PixelShaderFile            db "PixelShaders\basic3.hlsl",0
PixelShaderFile            db "PixelShaders\Eye Candy.hlsl",0

; Some shaders draw by the MASM32 community board:

;PixelShaderFile            db "PixelShaders\RandNoise.hlsl",0
;PixelShaderFile            db "PixelShaders\Perlin Noise.hlsl",0
;PixelShaderFile            db "PixelShaders\shdPlasma.hlsl",0
;PixelShaderFile            db "PixelShaders\CrclMov.hlsl",0

; Warez'ish shaders:

;PixelShaderFile            db "PixelShaders\cracktro1.hlsl",0
;PixelShaderFile            db "PixelShaders\cracktro2.hlsl",0
;PixelShaderFile            db "PixelShaders\cracktro3.hlsl",0

; WebGL (GLSL) Shadertoy tutorials converted to HLSL pixel shaders:

;PixelShaderFile            db "PixelShaders\Shadertoy New.hlsl",0
;PixelShaderFile            db "PixelShaders\Tutorial palm tree.hlsl",0
;PixelShaderFile            db "PixelShaders\Simple3D.hlsl",0
;PixelShaderFile            db "PixelShaders\Camera3D.hlsl",0

; Some nice Shadertoy examples I converted to learn converting from GLSL to HLSL:
; Some are not 100% exact, but they look cool.( still learning... )

;PixelShaderFile            db "PixelShaders\5 point star.hlsl",0
;PixelShaderFile            db "PixelShaders\Mandelbrot smooth.hlsl",0
;PixelShaderFile            db "PixelShaders\Plasma effect.hlsl",0
;PixelShaderFile            db "PixelShaders\eye trap.hlsl",0
;PixelShaderFile            db "PixelShaders\Galaxy of Universes.hlsl",0
;PixelShaderFile            db "PixelShaders\Everythng Glowing III.hlsl",0
;PixelShaderFile            db "PixelShaders\Another Kaliset Mod.hlsl",0
;PixelShaderFile            db "PixelShaders\JuliaTrap1.hlsl",0
;PixelShaderFile            db "PixelShaders\The road to Hell.hlsl",0

;PixelShaderFile            db "PixelShaders\Raymarched plasma.hlsl",0  ; still upside down
;PixelShaderFile            db "PixelShaders\Deform - flower.hlsl",0    ; not 100% exact
;PixelShaderFile            db "PixelShaders\Mandelbulb Rk and Qk.hlsl",0   ; something wrong with the camera settings ?
;PixelShaderFile            db "PixelShaders\Alien Tech.hlsl",0 ; removed the texture and the rotating star
;PixelShaderFile            db "PixelShaders\Angels.hlsl",0 ; not 100% exact

; Compile options -> D3DXSHADER_OPTIMIZATION_LEVEL3 for the best result. ( It takes a long time to compile ! please be patience. )
PixelShaderCompileFlags equ D3DXSHADER_OPTIMIZATION_LEVEL0 or D3DXSHADER_PREFER_FLOW_CONTROL ; -> fast compiling.

.data?
align 4
hInstance               HINSTANCE ?
Hwnd                    dd ?
Hwnd_d3d                dd ?

Screen_Width            dd ?
Screen_Height           dd ?

d3dcaps                 D3DCAPS9 <?>
d3dpp                   D3DPRESENT_PARAMETERS <?>

align 16
Timers                  MEDIATIMERS <?> ; must be 16 bytes aligned!

szString_buffer         db 512 dup (?)

.code

align 4
D3DCompileFromFile proc pFileName:DWORD,pDefines:DWORD,pInclude:DWORD,pEntrypoint:DWORD,pTarget:DWORD,Flags:DWORD,ppCode:DWORD,ppErrorMsgs:DWORD,ppConstantTable:DWORD

    push    ppConstantTable     ; [out]    Returns an ID3DXConstantTable interface, which can be used to access shader constants. This value may be NULL
    push    ppErrorMsgs         ; [out]    Returns a buffer containing a listing of errors and warnings that were encountered during the compile. This value may be NULL
    push    ppCode              ; [out]    Returns a buffer containing the created shader. This buffer contains the compiled shader code, as well as any embedded debug and symbol table information.
    push    Flags               ; [in]     Compile options identified by various flags.
    push    pTarget             ; [in]     Pointer to a shader profile which determines the shader instruction set.
    push    pEntrypoint         ; [in]     Pointer to the shader entry point function where execution begins. 
    push    pInclude            ; [in_opt] Optional interface pointer, ID3DXInclude, to use for handling #include directives.
    push    pDefines            ; [in_opt] An optional NULL terminated array of D3DXMACRO structures. This value may be NULL. 
    push    pFileName           ; [in]     Pointer to a string that specifies the filename of the file that contains the shader code.
    call    D3DCompileFromFileFunc
    ret
D3DCompileFromFile endp

align 4
FindCompilerLib proc uses esi edi
    
    lea     esi,D3DCompiler_Lib
    lea     edi,CompilerVersionTable
FindD3DXLib:
    mov     ax,word ptr[edi]
    mov     word ptr[esi+6],ax
    invoke  LoadLibrary,esi
    test    eax,eax
    jnz     LibFound
    cmp     word ptr[esi+6],"32"
    je      NoCompiler
    add     edi,2
    jmp     FindD3DXLib
NoCompiler:
    mov     eax,D3DERR_INVALIDCALL
    ret
LibFound:
    mov     D3DCompiler_Library,eax
    invoke  GetProcAddress,eax,offset D3DCompileFromFile_   
    test    eax,eax
    jz      NoCompiler
    mov     D3DCompileFromFileFunc,eax
    mov     eax,D3D_OK
    ret
FindCompilerLib endp

align 4
SavePixelShaderCode proc uses esi edi
LOCAL   Counter,Rest:DWORD

    invoke  wsprintf,offset szString_buffer,TEXT_("%s"),offset PixelShaderFile
    invoke  lstrlen,offset szString_buffer

    lea     esi,szString_buffer
    dec     eax
RemoveExtension:
    cmp     byte ptr[esi+eax],"."
    jne     next_char
    mov     dword ptr[esi+eax],"cnI."
    mov     byte ptr[esi+eax+4],0
    jmp     string_done
next_char:
    dec     eax
    jnz     RemoveExtension
string_done:

    invoke  CreateFile,esi,GENERIC_WRITE,NULL,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL
    inc     eax
    jz      close_spsc
    dec     eax
    mov     hFileOut,eax

    invoke  wsprintf,offset szString_buffer,TEXT_("; Pixel Shader code size: %d bytes",13,10,"PSC"),dwShaderBufferSize
    invoke  lstrlen,offset szString_buffer
    invoke  WriteFile,hFileOut,offset szString_buffer,eax,addr dwBytesDone,0

    mov     esi,pShaderBufferPtr
    mov     eax,dwShaderBufferSize
    mov     ecx,eax
    and     ecx,31
    mov     Rest,ecx
    shr     eax,5
    jz      RLP1
    mov     Counter,eax
LP1:
    invoke  wsprintf,offset szString_buffer,TEXT_(9,"dd %09Xh,%09Xh,%09Xh,%09Xh,%09Xh,%09Xh,%09Xh,%09Xh",13,10),\
    dword ptr[esi],dword ptr[esi+4],dword ptr[esi+8],dword ptr[esi+12],dword ptr[esi+16],dword ptr[esi+20],dword ptr[esi+24],dword ptr[esi+28]
    add     esi,32

    invoke  lstrlen,offset szString_buffer
    invoke  WriteFile,hFileOut,offset szString_buffer,eax,addr dwBytesDone,0
    dec     Counter
    jnz     LP1
RLP1:
    mov     eax,Rest
    mov     ecx,eax
    and     ecx,3
    mov     Rest,ecx
    shr     eax,2
    jz      RLP2
    mov     Counter,eax

    invoke  wsprintf,offset szString_buffer,TEXT_(9,"dd %09Xh"),dword ptr[esi]
    add     esi,4

    invoke  lstrlen,offset szString_buffer
    invoke  WriteFile,hFileOut,offset szString_buffer,eax,addr dwBytesDone,0
    dec     Counter
    jnz     LP2
    lea     edi,szString_buffer
    mov     dword ptr[edi],0A0Dh
    invoke  WriteFile,hFileOut,offset szString_buffer,2,addr dwBytesDone,0
    jmp     RLP2
LP2:
    invoke  wsprintf,offset szString_buffer,TEXT_(",%09Xh"),dword ptr[esi]
    add     esi,4

    invoke  lstrlen,offset szString_buffer
    invoke  WriteFile,hFileOut,offset szString_buffer,eax,addr dwBytesDone,0
    dec     Counter
    jnz     LP2
    lea     edi,szString_buffer
    mov     dword ptr[edi],0A0Dh
    invoke  WriteFile,hFileOut,offset szString_buffer,2,addr dwBytesDone,0
RLP2:
    mov     eax,Rest
    test    eax,eax
    jz      close_file_out

    invoke  wsprintf,offset szString_buffer,TEXT_(9,"db %03Xh"),byte ptr[esi]
    add     esi,1
    
    invoke  lstrlen,offset szString_buffer
    invoke  WriteFile,hFileOut,offset szString_buffer,eax,addr dwBytesDone,0
    dec     Rest
    jnz     LP3
    lea     edi,szString_buffer
    mov     dword ptr[edi],0A0Dh
    invoke  WriteFile,hFileOut,offset szString_buffer,2,addr dwBytesDone,0
    jmp     close_file_out
LP3:
    invoke  wsprintf,offset szString_buffer,TEXT_(",%03Xh"),byte ptr[esi]
    add     esi,1

    invoke  lstrlen,offset szString_buffer
    invoke  WriteFile,hFileOut,offset szString_buffer,eax,addr dwBytesDone,0
    dec     Rest
    jnz     LP3
    lea     edi,szString_buffer
    mov     dword ptr[edi],0A0Dh
    invoke  WriteFile,hFileOut,offset szString_buffer,2,addr dwBytesDone,0

close_file_out:
    .if hFileOut
        invoke  CloseHandle,hFileOut
    .endif
    


close_spsc:
    ret

SavePixelShaderCode endp

align 4
RenderD3d proc
    coinvoke g_pD3DDevice,IDirect3DDevice9,Clear,0,NULL,D3DCLEAR_TARGET or D3DCLEAR_ZBUFFER,BackgroundColor,FLT4(1.0),0
    call UpdateTimers
    lea eax,PixelShaderConstants
    ;=========== actual time in seconds. (send this to the pixel shader to animate the scene) ===============
    movss xmm0,Timers.Timer1
    movss real4 ptr [eax+12],xmm0
    ;=========== copy constants to the GPU register c0 ===============
    coinvoke g_pD3DDevice,IDirect3DDevice9,SetPixelShaderConstantF,0,addr PixelShaderConstants,1
    coinvoke g_pD3DDevice,IDirect3DDevice9,BeginScene
    ;=========== run Pixel Shader ===============
    coinvoke g_pD3DDevice,IDirect3DDevice9,SetPixelShader,g_pPixelShader
    ;=========== current vertex stream declaration ===============
    coinvoke g_pD3DDevice,IDirect3DDevice9,SetFVF,D3DFVF_XYZRHW or D3DFVF_TEX1
    ;=========== draw the pixel shader result to the window ===============
    coinvoke g_pD3DDevice,IDirect3DDevice9,DrawPrimitiveUP,D3DPT_TRIANGLESTRIP,2,addr Screen_Quad,6*4

    .if ToggleText
        coinvoke g_pD3DDevice,IDirect3DDevice9,SetPixelShader,NULL
        invoke D3DStartTextMode,g_pD3DDevice
        invoke wsprintf,addr szString_buffer,TEXT_("Screen resolution: %d X %d"),d3dpp.BackBufferWidth,d3dpp.BackBufferHeight
        invoke D3DDrawText,g_pD3DDevice,FLT4(0.0),FLT4(0.0),FLT4(16.0),D3DCOLOR_ARGB(255,255,127,0),addr szString_buffer
        invoke wsprintf,addr szString_buffer,TEXT_("GPU code size: %d bytes"),dwShaderBufferSize
        invoke D3DDrawText,g_pD3DDevice,FLT4(0.0),FLT4(20.0),FLT4(16.0),D3DCOLOR_ARGB(255,255,127,0),addr szString_buffer
        invoke wsprintf,addr szString_buffer,TEXT_("Compiler from: %s"),addr D3DCompiler_Lib
        invoke D3DDrawText,g_pD3DDevice,FLT4(0.0),FLT4(40.0),FLT4(16.0),D3DCOLOR_ARGB(255,255,127,0),addr szString_buffer
        invoke crt_sprintf,addr szString_buffer,TEXT_("FPS: %0.03f  Timer: %0.03f"),Timers.FramesPerSecond,Timers.TimeElapsed
        invoke D3DDrawText,g_pD3DDevice,FLT4(0.0),TextPos2,FLT4(16.0),D3DCOLOR_ARGB(255,0,227,0),addr szString_buffer

    .endif

    coinvoke g_pD3DDevice,IDirect3DDevice9,EndScene
    coinvoke g_pD3DDevice,IDirect3DDevice9,Present,NULL,NULL,NULL,NULL
    ret
RenderD3d endp

align 4
start:
    invoke GetModuleHandle, NULL
    mov hInstance,eax
    invoke DialogBoxParam,hInstance,IDD_DIALOGBOX,Hwnd,addr DlgProc,NULL
    invoke ExitProcess,eax
    
DlgProc Proc hwndX:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM    
LOCAL msg:MSG
    .if uMsg == WM_INITDIALOG
            invoke LoadIcon,hInstance,200
            invoke SendMessage, hwndX, WM_SETICON, 1, eax
            invoke SetWindowText,hwndX,addr DlgName
            invoke SetDlgItemText,hwndX,IDB_QUIT,addr szBtnQuit
            invoke SetDlgItemText,hwndX,IDB_TOGGLE_TEXT,addr szBtnToogleText
            invoke SetDlgItemText,hwndX,IDB_SAVE_SHADER,addr szBtnSave
            invoke GetDlgItem,hwndX,IDB_SHADER_SQUAD
            cmp eax,0
            je close_program
            mov Hwnd_d3d,eax
            ;======== set direct3d9 version ========
            invoke Direct3DCreate9,D3D_SDK_VERSION
            test eax,eax
            jz close_program
            mov g_pD3D,eax

            coinvoke g_pD3D,IDirect3D9,GetDeviceCaps,D3DADAPTER_DEFAULT,D3DDEVTYPE_HAL,addr d3dcaps
            cmp eax,D3D_OK
            jne close_program

            ;======== check if video card supports PixelShaderVersion 3.0 =======
            mov eax,d3dcaps.PixelShaderVersion
            cmp eax,D3DPS_VERSION(3,0)
            jb close_program

            ;======== initialize the default graphics card ========
            invoke RtlZeroMemory,offset d3dpp,sizeof d3dpp
            mov d3dpp.SwapEffect,D3DSWAPEFFECT_DISCARD
            mov d3dpp.Windowed,TRUE

            ;======== create a Depth Buffer =======================
            mov d3dpp.EnableAutoDepthStencil,TRUE
            mov d3dpp.AutoDepthStencilFormat,D3DFMT_D24S8 ;D3DFMT_D16

            ;======== set a PresentationInterval type =============
            mov d3dpp.PresentationInterval,D3DPRESENT_INTERVAL_ONE

            ;======= Create a Device ===============================
            coinvoke g_pD3D,IDirect3D9,CreateDevice,D3DADAPTER_DEFAULT,D3DDEVTYPE_HAL,Hwnd_d3d,D3DCREATE_HARDWARE_VERTEXPROCESSING,offset d3dpp,offset g_pD3DDevice
            cmp eax,D3D_OK
            jne close_program

            ;=========== create the screen_quad ===============
            mov eax,962
            cvtsi2ss xmm0,eax
            mov eax,531
            cvtsi2ss xmm1,eax

            ;=========== screen bottom text positions ===============
            movss xmm2,xmm1
            subss xmm2,FLT4(18.0)
            movss TextPos2,xmm2
            subss xmm2,FLT4(20.0)
            movss TextPos,xmm2

            lea eax,Screen_Quad
            movss real4 ptr[eax+24],xmm0
            movss real4 ptr[eax+52],xmm1
            movss real4 ptr[eax+72],xmm0
            movss real4 ptr[eax+76],xmm1

            ;=========== create a shader constant pool for the Pixel Shader viewport ===============
            lea eax,PixelShaderConstants
            movss real4 ptr[eax],xmm0
            movss real4 ptr[eax+4],xmm1
            movss xmm1,FLT4(1.0)
            movss real4 ptr[eax+8],xmm1

            ;=========== Try to find a shader compiler library. ===============
            call FindCompilerLib
            cmp eax,D3D_OK
            jne close_program

            ;=========== OK, we found one, let's compile the pixel shader from file. ===============
            invoke D3DCompileFromFile,offset PixelShaderFile,0,0,TEXT_("ps_main"),TEXT_("ps_3_0"),PixelShaderCompileFlags,addr g_pShaderTemp,addr g_pShaderMessage,0
            cmp eax,D3D_OK
            je GetShaderCode

            ;=========== Show compile error messages. ===============
            coinvoke g_pShaderMessage,ID3DXBuffer,GetBufferPointer
            invoke MessageBox,hwndX,eax,TEXT_("Pixel shader compiler messages."),MB_ICONERROR
            jmp close_objects

            ;=========== Shader compiled without errors. Get a pointer to the shader code. ===============
            GetShaderCode:
            coinvoke g_pShaderTemp,ID3DXBuffer,GetBufferPointer
            mov pShaderBufferPtr,eax
            coinvoke g_pShaderTemp,ID3DXBuffer,GetBufferSize
            mov dwShaderBufferSize,eax

            ;=========== Create the pixel shader on the GPU. ===============
            coinvoke g_pD3DDevice,IDirect3DDevice9,CreatePixelShader,pShaderBufferPtr,addr g_pPixelShader
            cmp eax,D3D_OK
            jne close_program

            ;=========== initialize the text routine ( to put some info to the screen ) ===============
            invoke  InitD3DDrawText,g_pD3DDevice
            test eax,eax
            js close_program

            ;===== initialize the timers ======
            invoke  InitTimers,addr Timers,ENABLE_PRINT_FPS

    .elseif uMsg == WM_COMMAND
            mov eax,wParam
            mov edx,eax
            shr edx,16
            and eax,0FFFFh
            .if wParam == IDB_QUIT
                   ;invoke UpdateWindow,hwndX
                   invoke SendMessage,hwndX,WM_CLOSE,0,0
            .elseif wParam == IDB_TOGGLE_TEXT
                   xor ToggleText,1
            .elseif wParam == IDB_SAVE_SHADER
                   call SavePixelShaderCode
           .endif
    .elseif uMsg == WM_CLOSE
            SAFE_RELEASE g_pShaderMessage
            SAFE_RELEASE g_pShaderTemp
            SAFE_RELEASE g_pPixelShader
            call ReleaseD3DDrawText
            SAFE_RELEASE g_pD3DDevice
            SAFE_RELEASE g_pD3D
            .if D3DCompiler_Library
                   invoke FreeLibrary,D3DCompiler_Library
            .endif   
            invoke EndDialog, hwndX,NULL
    .elseif uMsg == WM_PAINT
            invoke RenderD3d
    .else            
        mov eax,FALSE
        ret
    .endif
    
    mov eax,TRUE
    ret

    ;----------------------
close_program:
    invoke  MessageBox,hwndX,TEXT_("Sorry, this program will not run on your computer."),TEXT_("ERROR !"),MB_ICONERROR

close_objects: ; Clean up everything we created

    SAFE_RELEASE g_pShaderMessage
    SAFE_RELEASE g_pShaderTemp
    SAFE_RELEASE g_pPixelShader

    call ReleaseD3DDrawText

    SAFE_RELEASE g_pD3DDevice
    SAFE_RELEASE g_pD3D

    .if D3DCompiler_Library
        invoke FreeLibrary,D3DCompiler_Library
    .endif        
        ret

DlgProc endp
end start
