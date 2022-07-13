;/*==========================================================================;
; *
; *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
; *
; *  File:   d3d9.inc
; *  Content:    Direct3D include file
; *
; *  Translated to .ASM by: Siekmanski
; *
; ****************************************************************************/

ifndef _D3D9_H_
_D3D9_H_ equ 1

ifndef DIRECT3D_VERSION
DIRECT3D_VERSION	equ 0900h
endif  ;//DIRECT3D_VERSION

;// include this file content only if compiling for DX9 interfaces
if (DIRECT3D_VERSION ge 00900h)

D3D_SDK_VERSION		equ 32

; Interface IID's 
; {81BDCBCA-64D4-426d-AE8D-AD0147F4275C}
IID_IDirect3D9				TEXTEQU <{081bdcbcah,064d4h,0426dh,{0aeh,08dh,0adh,001h,047h,0f4h,027h,05ch}}>
; {D0223B96-BF7A-43fd-92BD-A43B0D82B9EB}
IID_IDirect3DDevice9			TEXTEQU <{0d0223b96h,0bf7ah,043fdh,{092h,0bdh,0a4h,03bh,00dh,082h,0b9h,0ebh}}>
; {05EEC05D-8F7D-4362-B999-D1BAF357C704}
IID_IDirect3DResource9			TEXTEQU <{005eec05dh,08f7dh,04362h,{0b9h,099h,0d1h,0bah,0f3h,057h,0c7h,004h}}>
; {580CA87E-1D3C-4d54-991D-B7D3E3C298CE}
IID_IDirect3DBaseTexture9		TEXTEQU <{0580ca87eh,01d3ch,04d54h,{099h,01dh,0b7h,0d3h,0e3h,0c2h,098h,0ceh}}>
; {85C31227-3DE5-4f00-9B3A-F11AC38C18B5}
IID_IDirect3DTexture9			TEXTEQU <{085c31227h,03de5h,04f00h,{09bh,03ah,0f1h,01ah,0c3h,08ch,018h,0b5h}}>
; {FFF32F81-D953-473a-9223-93D652ABA93F}
IID_IDirect3DCubeTexture9		TEXTEQU <{0fff32f81h,0d953h,0473ah,{092h,023h,093h,0d6h,052h,0abh,0a9h,03fh}}>
; {2518526C-E789-4111-A7B9-47EF328D13E6}
IID_IDirect3DVolumeTexture9		TEXTEQU <{02518526ch,0e789h,04111h,{0a7h,0b9h,047h,0efh,032h,08dh,013h,0e6h}}>
; {B64BB1B5-FD70-4df6-BF91-19D0A12455E3}
IID_IDirect3DVertexBuffer9		TEXTEQU <{0b64bb1b5h,0fd70h,04df6h,{0bfh,091h,019h,0d0h,0a1h,024h,055h,0e3h}}>
; {7C9DD65E-D3F7-4529-ACEE-785830ACDE35}
IID_IDirect3DIndexBuffer9		TEXTEQU <{07c9dd65eh,0d3f7h,04529h,{0ach,0eeh,078h,058h,030h,0ach,0deh,035h}}>
; {0CFBAF3A-9FF6-429a-99B3-A2796AF8B89B}
IID_IDirect3DSurface9			TEXTEQU <{00cfbaf3ah,09ff6h,0429ah,{099h,0b3h,0a2h,079h,06ah,0f8h,0b8h,09bh}}>
; {24F416E6-1F67-4aa7-B88E-D33F6F3128A1}
IID_IDirect3DVolume9			TEXTEQU <{024f416e6h,01f67h,04aa7h,{0b8h,08eh,0d3h,03fh,06fh,031h,028h,0a1h}}>
; {794950F2-ADFC-458a-905E-10A10B0B503B}
IID_IDirect3DSwapChain9		TEXTEQU <{0794950f2h,0adfch,0458ah,{090h,05eh,010h,0a1h,00bh,00bh,050h,03bh}}>
; {DD13C59C-36FA-4098-A8FB-C7ED39DC8546}
IID_IDirect3DVertexDeclaration9	TEXTEQU <{0dd13c59ch,036fah,04098h,{0a8h,0fbh,0c7h,0edh,039h,0dch,085h,046h}}>
; {EFC5557E-6265-4613-8A94-43857889EB36}
IID_IDirect3DVertexShader9		TEXTEQU <{0efc5557eh,06265h,04613h,{08ah,094h,043h,085h,078h,089h,0ebh,036h}}>
; {6D3BDBDC-5B02-4415-B852-CE5E8BCCB289}
IID_IDirect3DPixelShader9		TEXTEQU <{06d3bdbdch,05b02h,04415h,{0b8h,052h,0ceh,05eh,08bh,0cch,0b2h,089h}}>
; {B07C4FE5-310D-4ba8-A23C-4F0F206F218B}
IID_IDirect3DStateBlock9		TEXTEQU <{0b07c4fe5h,0310dh,04ba8h,{0a2h,03ch,04fh,00fh,020h,06fh,021h,08bh}}>
; {d9771460-a695-4f26-bbd3-27b840b541cc}
IID_IDirect3DQuery9			TEXTEQU <{0d9771460h,0a695h,04f26h,{0bbh,0d3h,027h,0b8h,040h,0b5h,041h,0cch}}>

include dx9macros.inc
include d3d9types.inc
include d3d9caps.inc


Direct3DCreate9	PROTO :DWORD 


;/*
; * Direct3D interfaces
; */


_vtIDirect3D9 MACRO CastName:REQ
	_vtIUnknown CastName
	&CastName&_RegisterSoftwareDevice	comethod2 ?
	&CastName&_GetAdapterCount		comethod1 ?
	&CastName&_GetAdapterIdentifier		comethod4 ?
	&CastName&_GetAdapterModeCount		comethod3 ?
	&CastName&_EnumAdapterModes		comethod5 ?
	&CastName&_GetAdapterDisplayMode	comethod3 ?
	&CastName&_CheckDeviceType		comethod6 ?
	&CastName&_CheckDeviceFormat		comethod7 ?
	&CastName&_CheckDeviceMultiSampleType	comethod7 ?
	&CastName&_CheckDepthStencilMatch	comethod6 ?
	&CastName&_CheckDeviceFormatConversion	comethod5 ?
	&CastName&_GetDeviceCaps		comethod4 ?
	&CastName&_GetAdapterMonitor		comethod2 ?
	&CastName&_CreateDevice			comethod7 ?
ENDM

IDirect3D9 struct
	_vtIDirect3D9 IDirect3D9
IDirect3D9 ends

	LPDIRECT3D9	typedef PTR IDirect3D9
	PDIRECT3D9	typedef PTR IDirect3D9

_vtIDirect3DDevice9 MACRO CastName:REQ
	_vtIUnknown CastName
	&CastName&_TestCooperativeLevel		comethod1 ?
	&CastName&_GetAvailableTextureMem	comethod1 ?
	&CastName&_EvictManagedResources	comethod1 ?
	&CastName&_GetDirect3D			comethod2 ?
	&CastName&_GetDeviceCaps		comethod2 ?
	&CastName&_GetDisplayMode		comethod3 ?
	&CastName&_GetCreationParameters	comethod2 ?
	&CastName&_SetCursorProperties		comethod4 ?
	&CastName&_SetCursorPosition		comethod4 ?
	&CastName&_ShowCursor			comethod2 ?
	&CastName&_CreateAdditionalSwapChain	comethod3 ?
	&CastName&_GetSwapChain			comethod3 ?
	&CastName&_GetNumberOfSwapChains	comethod1 ?
	&CastName&_Reset			comethod2 ?
	&CastName&_Present			comethod5 ?
	&CastName&_GetBackBuffer		comethod5 ?
	&CastName&_GetRasterStatus		comethod3 ?
	&CastName&_SetDialogBoxMode		comethod2 ?
	&CastName&_SetGammaRamp			comethod4 ?
	&CastName&_GetGammaRamp			comethod3 ?
	&CastName&_CreateTexture		comethod9 ?
	&CastName&_CreateVolumeTexture		comethod10 ?
	&CastName&_CreateCubeTexture		comethod8 ?
	&CastName&_CreateVertexBuffer		comethod7 ?
	&CastName&_CreateIndexBuffer		comethod7 ?
	&CastName&_CreateRenderTarget		comethod9 ?
	&CastName&_CreateDepthStencilSurface	comethod9 ?
	&CastName&_UpdateSurface		comethod5 ?
	&CastName&_UpdateTexture		comethod3 ?
	&CastName&_GetRenderTargetData		comethod3 ?
	&CastName&_GetFrontBufferData		comethod3 ?
	&CastName&_StretchRect			comethod6 ?
	&CastName&_ColorFill			comethod4 ?
	&CastName&_CreateOffscreenPlainSurface	comethod7 ?
	&CastName&_SetRenderTarget		comethod3 ?
	&CastName&_GetRenderTarget		comethod3 ?
	&CastName&_SetDepthStencilSurface	comethod2 ?
	&CastName&_GetDepthStencilSurface	comethod2 ?
	&CastName&_BeginScene			comethod1 ?
	&CastName&_EndScene			comethod1 ?
	&CastName&_Clear			comethod7 ?
	&CastName&_SetTransform			comethod3 ?
	&CastName&_GetTransform			comethod3 ?
	&CastName&_MultiplyTransform		comethod3 ?
	&CastName&_SetViewport			comethod2 ?
	&CastName&_GetViewport			comethod2 ?
	&CastName&_SetMaterial			comethod2 ?
	&CastName&_GetMaterial			comethod2 ?
	&CastName&_SetLight			comethod3 ?
	&CastName&_GetLight			comethod3 ?
	&CastName&_LightEnable			comethod3 ?
	&CastName&_GetLightEnable		comethod3 ?
	&CastName&_SetClipPlane			comethod3 ?
	&CastName&_GetClipPlane			comethod3 ?
	&CastName&_SetRenderState		comethod3 ?
	&CastName&_GetRenderState		comethod3 ?
	&CastName&_CreateStateBlock		comethod3 ?
	&CastName&_BeginStateBlock		comethod1 ?
	&CastName&_EndStateBlock		comethod2 ?
	&CastName&_SetClipStatus		comethod2 ?
	&CastName&_GetClipStatus		comethod2 ?
	&CastName&_GetTexture			comethod3 ?
	&CastName&_SetTexture			comethod3 ?
	&CastName&_GetTextureStageState		comethod4 ?
	&CastName&_SetTextureStageState		comethod4 ?
	&CastName&_GetSamplerState		comethod4 ?
	&CastName&_SetSamplerState		comethod4 ?
	&CastName&_ValidateDevice		comethod2 ?
	&CastName&_SetPaletteEntries		comethod3 ?
	&CastName&_GetPaletteEntries		comethod3 ?
	&CastName&_SetCurrentTexturePalette	comethod2 ?
	&CastName&_GetCurrentTexturePalette	comethod2 ?
	&CastName&_SetScissorRect		comethod2 ?
	&CastName&_GetScissorRect		comethod2 ?
	&CastName&_SetSoftwareVertexProcessing	comethod2 ?
	&CastName&_GetSoftwareVertexProcessing	comethod1 ?
	&CastName&_SetNPatchMode		comethod2 ?
	&CastName&_GetNPatchMode		comethod1 ?
	&CastName&_DrawPrimitive		comethod4 ?
	&CastName&_DrawIndexedPrimitive		comethod7 ?
	&CastName&_DrawPrimitiveUP		comethod5 ?
	&CastName&_DrawIndexedPrimitiveUP	comethod9 ?
	&CastName&_ProcessVertices		comethod7 ?
	&CastName&_CreateVertexDeclaration	comethod3 ?
	&CastName&_SetVertexDeclaration		comethod2 ?
	&CastName&_GetVertexDeclaration		comethod2 ?
	&CastName&_SetFVF			comethod2 ?
	&CastName&_GetFVF			comethod2 ?
	&CastName&_CreateVertexShader		comethod3 ?
	&CastName&_SetVertexShader		comethod2 ?
	&CastName&_GetVertexShader		comethod2 ?
	&CastName&_SetVertexShaderConstantF	comethod4 ?
	&CastName&_GetVertexShaderConstantF	comethod4 ?
	&CastName&_SetVertexShaderConstantI	comethod4 ?
	&CastName&_GetVertexShaderConstantI	comethod4 ?
	&CastName&_SetVertexShaderConstantB	comethod4 ?
	&CastName&_GetVertexShaderConstantB	comethod4 ?
	&CastName&_SetStreamSource		comethod5 ?
	&CastName&_GetStreamSource		comethod5 ?
	&CastName&_SetStreamSourceFreq		comethod3 ?
	&CastName&_GetStreamSourceFreq		comethod3 ?
	&CastName&_SetIndices			comethod2 ?
	&CastName&_GetIndices			comethod2 ?
	&CastName&_CreatePixelShader		comethod3 ?
	&CastName&_SetPixelShader		comethod2 ?
	&CastName&_GetPixelShader		comethod2 ?
	&CastName&_SetPixelShaderConstantF	comethod4 ?
	&CastName&_GetPixelShaderConstantF	comethod4 ?
	&CastName&_SetPixelShaderConstantI	comethod4 ?
	&CastName&_GetPixelShaderConstantI	comethod4 ?
	&CastName&_SetPixelShaderConstantB	comethod4 ?
	&CastName&_GetPixelShaderConstantB	comethod4 ?
	&CastName&_DrawRectPatch		comethod4 ?
	&CastName&_DrawTriPatch			comethod4 ?
	&CastName&_DeletePatch			comethod2 ?
	&CastName&_CreateQuery			comethod3 ?
ENDM

IDirect3DDevice9 struct
	_vtIDirect3DDevice9 IDirect3DDevice9
IDirect3DDevice9 ends

LPDIRECT3DDEVICE9		typedef PTR IDirect3DDevice9
PDIRECT3DDEVICE9		typedef PTR IDirect3DDevice9


_vtIDirect3DStateBlock9 MACRO CastName:REQ
	_vtIUnknown CastName
	&CastName&_GetDevice			comethod2 ?
	&CastName&_Capture			comethod1 ?
	&CastName&_Apply			comethod1 ?
ENDM

IDirect3DStateBlock9 struct
	_vtIDirect3DStateBlock9 IDirect3DStateBlock9
IDirect3DStateBlock9 ends

LPDIRECT3DSTATEBLOCK9		typedef PTR DWORD
PDIRECT3DSTATEBLOCK9		typedef PTR DWORD


_vtIDirect3DSwapChain9 MACRO CastName:REQ
	_vtIUnknown CastName
	&CastName&_Present			comethod6 ?
	&CastName&_GetFrontBufferData		comethod2 ?
	&CastName&_GetBackBuffer		comethod4 ?
	&CastName&_GetRasterStatus		comethod2 ?
	&CastName&_GetDisplayMode		comethod2 ?
	&CastName&_GetDevice			comethod2 ?
	&CastName&_GetPresentParameters		comethod2 ?
ENDM

IDirect3DSwapChain9 struct
	_vtIDirect3DSwapChain9 IDirect3DSwapChain9
IDirect3DSwapChain9 ends

LPDIRECT3DSWAPCHAIN9		typedef PTR DWORD
PDIRECT3DSWAPCHAIN9		typedef PTR DWORD


_vtIDirect3DResource9 MACRO CastName:REQ
	_vtIUnknown CastName
	&CastName&_GetDevice			comethod2 ?
	&CastName&_SetPrivateData		comethod5 ?
	&CastName&_GetPrivateData		comethod4 ?
	&CastName&_FreePrivateData		comethod2 ?
	&CastName&_SetPriority			comethod2 ?
	&CastName&_GetPriority			comethod1 ?
	&CastName&_PreLoad			comethod1 ?
	&CastName&_GetType			comethod1 ?
ENDM

IDirect3DResource9 struct
	_vtIDirect3DResource9 IDirect3DResource9
IDirect3DResource9 ends

LPDIRECT3DRESOURCE9		typedef PTR DWORD
PDIRECT3DRESOURCE9		typedef PTR DWORD


_vtIDirect3DVertexDeclaration9 MACRO CastName:REQ
	_vtIUnknown CastName
	&CastName&_GetDevice			comethod2 ?	
	&CastName&_GetDeclaration		comethod3 ?
ENDM

IDirect3DVertexDeclaration9 struct
	_vtIDirect3DVertexDeclaration9 IDirect3DVertexDeclaration9
IDirect3DVertexDeclaration9 ends

LPDIRECT3DVERTEXDECLARATION9	typedef PTR DWORD
PDIRECT3DVERTEXDECLARATION9	typedef PTR DWORD


_vtIDirect3DVertexShader9 MACRO CastName:REQ
	_vtIUnknown CastName
	&CastName&_GetDevice			comethod2 ?
	&CastName&_GetFunction			comethod3 ?
ENDM

IDirect3DVertexShader9 struct
	_vtIDirect3DVertexShader9 IDirect3DVertexShader9
IDirect3DVertexShader9 ends

LPDIRECT3DVERTEXSHADER9		typedef PTR DWORD
PDIRECT3DVERTEXSHADER9		typedef PTR DWORD


_vtIDirect3DPixelShader9 MACRO CastName:REQ
	_vtIUnknown CastName
	&CastName&_GetDevice			comethod2 ?
	&CastName&_GetFunction			comethod3 ?
ENDM

IDirect3DPixelShader9 struct
	_vtIDirect3DPixelShader9 IDirect3DPixelShader9
IDirect3DPixelShader9 ends

LPDIRECT3DPIXELSHADER9		typedef PTR DWORD
PDIRECT3DPIXELSHADER9		typedef PTR DWORD


_vtIDirect3DBaseTexture9 MACRO CastName:REQ
	_vtIDirect3DResource9 CastName
	&CastName&_SetLOD			comethod2 ?
	&CastName&_GetLOD			comethod1 ?
	&CastName&_GetLevelCount		comethod1 ?
	&CastName&_SetAutoGenFilterType		comethod2 ?
	&CastName&_GetAutoGenFilterType		comethod1 ?
	&CastName&_GenerateMipSubLevels		comethod1 ?
ENDM

IDirect3DBaseTexture9 struct
	_vtIDirect3DBaseTexture9 IDirect3DBaseTexture9
IDirect3DBaseTexture9 ends

LPDIRECT3DBASETEXTURE9		typedef PTR DWORD
PDIRECT3DBASETEXTURE9		typedef PTR DWORD


_vtIDirect3DTexture9 MACRO CastName:REQ
	_vtIDirect3DBaseTexture9 CastName
	&CastName&_GetLevelDesc			comethod3 ?
	&CastName&_GetSurfaceLevel		comethod3 ?
	&CastName&_LockRect			comethod5 ?
	&CastName&_UnlockRect			comethod2 ?
	&CastName&_AddDirtyRect			comethod2 ?
ENDM

IDirect3DTexture9 struct
	_vtIDirect3DTexture9 IDirect3DTexture9
IDirect3DTexture9 ends

LPDIRECT3DTEXTURE9		typedef	PTR DWORD
PDIRECT3DTEXTURE9		typedef	PTR DWORD


_vtIDirect3DVolumeTexture9 MACRO CastName:REQ
	_vtIDirect3DBaseTexture9 CastName
	&CastName&_GetLevelDesc			comethod3 ?
	&CastName&_GetVolumeLevel		comethod3 ?
	&CastName&_LockBox			comethod5 ?
	&CastName&_UnlockBox			comethod2 ?
	&CastName&_AddDirtyBox			comethod2 ?
ENDM

IDirect3DVolumeTexture9 struct
	_vtIDirect3DVolumeTexture9 IDirect3DVolumeTexture9
IDirect3DVolumeTexture9 ends

LPDIRECT3DVOLUMETEXTURE9	typedef	PTR DWORD
PDIRECT3DVOLUMETEXTURE9		typedef	PTR DWORD


_vtIDirect3DCubeTexture9 MACRO CastName:REQ
	_vtIDirect3DBaseTexture9 CastName
	&CastName&_GetLevelDesc			comethod3 ?
	&CastName&_GetCubeMapSurface		comethod4 ?
	&CastName&_LockRect			comethod6 ?
	&CastName&_UnlockRect			comethod3 ?
	&CastName&_AddDirtyRect			comethod3 ?
ENDM

IDirect3DCubeTexture9 struct
	_vtIDirect3DVolumeTexture9 IDirect3DVolumeTexture9
IDirect3DCubeTexture9 ends

LPDIRECT3DCUBETEXTURE9		typedef	PTR DWORD
PDIRECT3DCUBETEXTURE9		typedef	PTR DWORD


_vtIDirect3DVertexBuffer9 MACRO CastName:REQ
	_vtIDirect3DResource9 CastName
	&CastName&_Lock				comethod5 ?	
	&CastName&_Unlock			comethod1 ?
	&CastName&_GetDesc			comethod2 ?
ENDM

IDirect3DVertexBuffer9 struct
	_vtIDirect3DVertexBuffer9 IDirect3DVertexBuffer9
IDirect3DVertexBuffer9 ends

LPDIRECT3DVERTEXBUFFER9		typedef PTR DWORD
PDIRECT3DVERTEXBUFFER9		typedef PTR DWORD


_vtIDirect3DIndexBuffer9 MACRO CastName:REQ
	_vtIDirect3DResource9 CastName
	&CastName&_Lock				comethod5 ?	
	&CastName&_Unlock			comethod1 ?
	&CastName&_GetDesc			comethod2 ?
ENDM

IDirect3DIndexBuffer9 struct
	_vtIDirect3DIndexBuffer9 IDirect3DIndexBuffer9
IDirect3DIndexBuffer9 ends

LPDIRECT3DINDEXBUFFER9		typedef PTR DWORD
PDIRECT3DINDEXBUFFER9		typedef PTR DWORD


_vtIDirect3DSurface9 MACRO CastName:REQ
	_vtIDirect3DResource9 CastName
	&CastName&_GetContainer			comethod3 ?
	&CastName&_GetDesc			comethod2 ?
	&CastName&_LockRect			comethod4 ?
	&CastName&_UnlockRect			comethod1 ?
	&CastName&_GetDC			comethod2 ?
	&CastName&_ReleaseDC			comethod2 ?
ENDM

IDirect3DSurface9 struct
	_vtIDirect3DSurface9 IDirect3DSurface9
IDirect3DSurface9 ends

LPDIRECT3DSURFACE9		typedef PTR DWORD
PDIRECT3DSURFACE9		typedef PTR DWORD


_vtIDirect3DVolume9 MACRO CastName:REQ
	_vtIUnknown CastName
	&CastName&_GetDevice			comethod2 ?
	&CastName&_SetPrivateData		comethod5 ?
	&CastName&_GetPrivateData		comethod4 ?
	&CastName&_FreePrivateData		comethod2 ?
	&CastName&_GetContainer			comethod3 ?
	&CastName&_GetDesc			comethod2 ?
	&CastName&_LockBox			comethod4 ?
	&CastName&_UnlockBox			comethod1 ?
ENDM

IDirect3DVolume9 struct
	_vtIDirect3DVolume9 IDirect3DVolume9
IDirect3DVolume9 ends

LPDIRECT3DVOLUME9		typedef PTR DWORD
PDIRECT3DVOLUME9		typedef PTR DWORD


_vtIDirect3DQuery9 MACRO CastName:REQ
	_vtIUnknown CastName
	&CastName&_GetDevice			comethod2 ?
	&CastName&_GetType			comethod1 ?
	&CastName&_GetDataSize			comethod1 ?
	&CastName&_Issue			comethod2 ?
	&CastName&_GetData			comethod4 ?
ENDM

IDirect3DQuery9 struct
	_vtIDirect3DVolume9 IDirect3DQuery9
IDirect3DQuery9 ends

LPDIRECT3DQUERY9		typedef PTR DWORD
PDIRECT3DQUERY9			typedef PTR DWORD

;Flags for SetPrivateData method on all D3D9 interfaces
D3DSPD_IUNKNOWN				equ 01h

;Flags for IDirect3D9::CreateDevice's BehaviorFlags
D3DCREATE_FPU_PRESERVE			equ 0002h
D3DCREATE_MULTITHREADED			equ 0004h
D3DCREATE_PUREDEVICE			equ 0010h
D3DCREATE_SOFTWARE_VERTEXPROCESSING	equ 0020h
D3DCREATE_HARDWARE_VERTEXPROCESSING	equ 0040h
D3DCREATE_MIXED_VERTEXPROCESSING	equ 0080h
D3DCREATE_DISABLE_DRIVER_MANAGEMENT	equ 0100h
D3DCREATE_ADAPTERGROUP_DEVICE		equ 0200h

;Parameter for IDirect3D9::CreateDevice's iAdapter
D3DADAPTER_DEFAULT			equ 0
;Flags for IDirect3D9::EnumAdapters
D3DENUM_WHQL_LEVEL			equ 2
;Maximum number of back-buffers supported in DX8
D3DPRESENT_BACK_BUFFERS_MAX		equ 3
;Flags for IDirect3DDevice9::SetGammaRamp
D3DSGR_NO_CALIBRATION			equ 0
D3DSGR_CALIBRATE			equ 1
;Flags for IDirect3DDevice9::SetCursorPosition
D3DCURSOR_IMMEDIATE_UPDATE		equ 1
;Flags for IDirect3DSwapChain9::Present
D3DPRESENT_DONOTWAIT			equ 1
D3DPRESENT_LINEAR_CONTENT		equ 2

;/****************************************************************************
; *
; * Flags for DrawPrimitive/DrawIndexedPrimitive
; *   Also valid for Begin/BeginIndexed
; *   Also valid for VertexBuffer::CreateVertexBuffer
; ****************************************************************************/


;/*
; *  DirectDraw error codes
; */
_FACD3D	equ 0876h
MAKE_D3DHRESULT MACRO code:REQ
	EXITM %((1 shl 31) or ((_FACD3D and 0fffh) shl 16) or (code and 0ffffh))
ENDM

MAKE_D3DSTATUS MACRO code:REQ
	EXITM %((0 shl 31) or ((_FACD3D and 0fffh) shl 16) or (code and 0ffffh))
ENDM


;/*
; * Direct3D Errors
; */
D3D_OK equ S_OK

D3DERR_WRONGTEXTUREFORMAT		TEXTEQU MAKE_D3DHRESULT(2072)
D3DERR_UNSUPPORTEDCOLOROPERATION	TEXTEQU MAKE_D3DHRESULT(2073)
D3DERR_UNSUPPORTEDCOLORARG		TEXTEQU MAKE_D3DHRESULT(2074)
D3DERR_UNSUPPORTEDALPHAOPERATION	TEXTEQU MAKE_D3DHRESULT(2075)
D3DERR_UNSUPPORTEDALPHAARG		TEXTEQU MAKE_D3DHRESULT(2076)
D3DERR_TOOMANYOPERATIONS		TEXTEQU MAKE_D3DHRESULT(2077)
D3DERR_CONFLICTINGTEXTUREFILTER		TEXTEQU MAKE_D3DHRESULT(2078)
D3DERR_UNSUPPORTEDFACTORVALUE		TEXTEQU MAKE_D3DHRESULT(2079)
D3DERR_CONFLICTINGRENDERSTATE		TEXTEQU MAKE_D3DHRESULT(2081)
D3DERR_UNSUPPORTEDTEXTUREFILTER		TEXTEQU MAKE_D3DHRESULT(2082)
D3DERR_CONFLICTINGTEXTUREPALETTE	TEXTEQU MAKE_D3DHRESULT(2086)
D3DERR_DRIVERINTERNALERROR		TEXTEQU MAKE_D3DHRESULT(2087)

D3DERR_NOTFOUND				TEXTEQU MAKE_D3DHRESULT(2150)
D3DERR_MOREDATA				TEXTEQU MAKE_D3DHRESULT(2151)
D3DERR_DEVICELOST			TEXTEQU MAKE_D3DHRESULT(2152)
D3DERR_DEVICENOTRESET			TEXTEQU MAKE_D3DHRESULT(2153)
D3DERR_NOTAVAILABLE			TEXTEQU MAKE_D3DHRESULT(2154)
D3DERR_OUTOFVIDEOMEMORY			TEXTEQU MAKE_D3DHRESULT(380)
D3DERR_INVALIDDEVICE			TEXTEQU MAKE_D3DHRESULT(2155)
D3DERR_INVALIDCALL			TEXTEQU MAKE_D3DHRESULT(2156)
D3DERR_DRIVERINVALIDCALL		TEXTEQU MAKE_D3DHRESULT(2157)
D3DERR_WASSTILLDRAWING			TEXTEQU MAKE_D3DHRESULT(540)
D3DOK_NOAUTOGEN				TEXTEQU MAKE_D3DSTATUS(2159)


endif	;/* (DIRECT3D_VERSION >= 0x0900) */
endif	;/* _D3D_H_ */
