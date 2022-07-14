; Original: http://masm32.com/board/index.php?topic=6904.0
; This version is using DialogBox instead of CreateWindow
; The shader squad is tied to a ressource control

.686p
.model flat, stdcall
.xmm
option casemap :none

include                 \masm32\include\windows.inc ; main windows include file
include                 \masm32\include\kernel32.inc
include                 \masm32\include\user32.inc
include                 \masm32\include\ole32.inc
include                 Includes\d3d9.inc
include                 Includes\d3d9extra.Inc

includelib              \masm32\lib\kernel32.lib
includelib              \masm32\lib\user32.lib
includelib              \masm32\lib\ole32.lib
includelib              Libs\d3d9.lib
includelib              Libs\d3d9extra.lib

DlgProc                 PROTO :DWORD,:DWORD,:DWORD,:DWORD

.const
IDC_TEXT                equ 2002
IDB_QUIT                equ 2003
IDB_SHADER_SQUAD        equ 2004

;=============================================================
;=============================================================

;****************
.data
align 4
g_pD3D                  LPDIRECT3D9 NULL    
g_pD3DDevice            LPDIRECT3DDEVICE9 NULL
g_pPixelShader          LPDIRECT3DPIXELSHADER9 NULL
BackgroundColor         dd D3DCOLOR_XRGB(0,0,0)
align 16
Screen_Quad             real4 0.0, 0.0, 0.5, 1.0, 0.0, 0.0 ; left top     ( X,Y,Z,W,U,V )
                        real4 0.0, 0.0, 0.5, 1.0, 1.0, 0.0 ; right top    ( X,Y,Z,W,U,V ) 
                        real4 0.0, 0.0, 0.5, 1.0, 0.0, 1.0 ; left bottom  ( X,Y,Z,W,U,V ) 
                        real4 0.0, 0.0, 0.5, 1.0, 1.0, 1.0 ; right bottom ( X,Y,Z,W,U,V )  

PixelShaderConstants    real4 0.0, 0.0, 0.0, 0.0;
DlgName                 db "MyDialog",0
szBtnQuit               db "Close",0
szCptText               db "Original shader window code by Marinus",10,13
                        db "DialogBox embedded shader version by Xylitol",10,13,10,13
                        db "Now waiting for your new awesome shaders templates :D",0

; Uncomment a pre-compiled PixelShader and run it.
; To compile a PixelShader have a look on ShaderCompiler.

include PixelShaders\cracktro3.Inc
;include PixelShaders\cracktro2.Inc
;include PixelShaders\cracktro1.Inc
;include PixelShaders\Angels.Inc
;include PixelShaders\The road to Hell.Inc
;include PixelShaders\Alien Tech.Inc
;include PixelShaders\basic1.Inc
;include PixelShaders\basic2.Inc
;include PixelShaders\basic3.Inc
;include PixelShaders\Eye Candy.Inc
;include PixelShaders\Shadertoy New.Inc
;include PixelShaders\Tutorial palm tree.Inc
;include PixelShaders\Simple3D.Inc
;include PixelShaders\Camera3D.Inc
;include PixelShaders\5 point star.Inc
;include PixelShaders\Mandelbrot smooth.Inc
;include PixelShaders\Plasma effect.Inc
;include PixelShaders\eye trap.Inc
;include PixelShaders\Galaxy of Universes.Inc
;include PixelShaders\Everythng Glowing III.Inc
;include PixelShaders\Another Kaliset Mod.Inc
;include PixelShaders\JuliaTrap1.Inc
;include PixelShaders\Raymarched plasma.Inc
;include PixelShaders\Deform - flower.Inc
;include PixelShaders\CrclMov.Inc
;include PixelShaders\Perlin Noise.Inc
;include PixelShaders\RandNoise.Inc
;include PixelShaders\shdPlasma.Inc
;include PixelShaders\Mandelbulb Rk and Qk.Inc

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

;=============================================================
;=============================================================
.code

;********************** RenderD3d ******************************
align 4
RenderD3d proc
    coinvoke g_pD3DDevice,IDirect3DDevice9,Clear,0,NULL,D3DCLEAR_TARGET or D3DCLEAR_ZBUFFER,BackgroundColor,FLT4(1.0),0

    call UpdateTimers

    lea eax,PixelShaderConstants
    movss xmm0,Timers.Timer1  ; actual time in seconds. (send this to the pixel shader to animate the scene)
    movss real4 ptr [eax+12],xmm0
    coinvoke g_pD3DDevice,IDirect3DDevice9,SetPixelShaderConstantF,0,addr PixelShaderConstants,1 ; copy constants to the GPU register c0

    coinvoke g_pD3DDevice,IDirect3DDevice9,BeginScene

    coinvoke g_pD3DDevice,IDirect3DDevice9,SetPixelShader,g_pPixelShader ; run Pixel Shader
    coinvoke g_pD3DDevice,IDirect3DDevice9,SetFVF,D3DFVF_XYZRHW or D3DFVF_TEX1 ; current vertex stream declaration
    coinvoke g_pD3DDevice,IDirect3DDevice9,DrawPrimitiveUP,D3DPT_TRIANGLESTRIP,2,addr Screen_Quad,6*4 ; draw the pixel shader result to the background

    coinvoke g_pD3DDevice,IDirect3DDevice9,EndScene
    coinvoke g_pD3DDevice,IDirect3DDevice9,Present,NULL,NULL,NULL,NULL ; present it to the window
    ret
RenderD3d endp

;********************** START ******************************
start:
    invoke GetModuleHandle, NULL
    mov hInstance,eax
    invoke DialogBoxParam, hInstance, ADDR DlgName,Hwnd,addr DlgProc,NULL
    invoke ExitProcess,eax

DlgProc Proc hwndX:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM    
LOCAL msg:MSG
    .if uMsg == WM_INITDIALOG
            invoke LoadIcon,hInstance,200
            invoke SendMessage, hwndX, WM_SETICON, 1, eax
            invoke SetWindowText,hwndX,addr DlgName
            invoke SetDlgItemText,hwndX,IDB_QUIT,addr szBtnQuit
            invoke SetDlgItemText,hwndX,IDC_TEXT,addr szCptText
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
            mov eax,348 ; change to your need, accordingly to IDB_SHADER_SQUAD!
            cvtsi2ss xmm0,eax
            mov eax,215 ; change to your need, accordingly to IDB_SHADER_SQUAD!
            cvtsi2ss xmm1,eax
            lea eax,Screen_Quad
            movss real4 ptr[eax+24],xmm0
            movss real4 ptr[eax+52],xmm1
            movss real4 ptr[eax+72],xmm0
            movss real4 ptr[eax+76],xmm1

            ;====  create a shader constant pool for the Pixel Shader viewport ===
            lea eax,PixelShaderConstants
            movss real4 ptr[eax],xmm0
            movss real4 ptr[eax+4],xmm1
            movss xmm1,FLT4(1.0)
            movss real4 ptr[eax+8],xmm1

            ;==== Create the pixel shader on the GPU. ====
            coinvoke g_pD3DDevice,IDirect3DDevice9,CreatePixelShader,offset PSC,addr g_pPixelShader
            cmp eax,D3D_OK
            jne close_program

            ;===== initialize the timers ======
            invoke InitTimers,addr Timers,NULL

    .elseif uMsg == WM_COMMAND
            mov eax,wParam
            mov edx,eax
            shr edx,16
            and eax,0FFFFh
            .if wParam == IDB_QUIT
                   ;invoke UpdateWindow,hwndX
                   invoke SendMessage,hwndX,WM_CLOSE,0,0
            .endif
    .elseif uMsg == WM_CLOSE
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
        invoke MessageBox,hwndX,TEXT_("Sorry, this program will not run on your computer."),TEXT_("ERROR !"),MB_ICONERROR

    close_objects:                  
        SAFE_RELEASE g_pPixelShader
        SAFE_RELEASE g_pD3DDevice
        SAFE_RELEASE g_pD3D           
        ret

DlgProc endp
end start
