;/*==========================================================================;
; *
; *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
; *
; *  File:       d3d9caps.inc
; *  Content:    Direct3D capabilities include file
; *
; *  Translated to .ASM by: Siekmanski
; *
; ***************************************************************************/

ifndef _d3d9CAPS_H
_d3d9CAPS_H equ 1

ifndef DIRECT3D_VERSION
DIRECT3D_VERSION	equ 00900h
endif  ;//DIRECT3D_VERSION

;// include this file content only if compiling for DX9 interfaces
if (DIRECT3D_VERSION ge 00900h)

_D3DVSHADERCAPS2_0 struct
	Caps				DWORD ?
	DynamicFlowControlDepth		DWORD ?
	NumTemps			DWORD ?
	StaticFlowControlDepth		DWORD ?
_D3DVSHADERCAPS2_0 ends

D3DVSHADERCAPS2_0	typedef	_D3DVSHADERCAPS2_0

D3DVS20CAPS_PREDICATION			equ (1 shl 0)

D3DVS20_MAX_DYNAMICFLOWCONTROLDEPTH	equ 24
D3DVS20_MIN_DYNAMICFLOWCONTROLDEPTH	equ 0
D3DVS20_MAX_NUMTEMPS			equ 32
D3DVS20_MIN_NUMTEMPS			equ 12
D3DVS20_MAX_STATICFLOWCONTROLDEPTH	equ 4
D3DVS20_MIN_STATICFLOWCONTROLDEPTH	equ 1

_D3DPSHADERCAPS2_0 struct
	Caps				DWORD ?
	DynamicFlowControlDepth		DWORD ?
	NumTemps			DWORD ?
	StaticFlowControlDepth		DWORD ?
	NumInstructionSlots		DWORD ?
_D3DPSHADERCAPS2_0 ends

D3DPSHADERCAPS2_0	typedef	_D3DPSHADERCAPS2_0

D3DPS20CAPS_ARBITRARYSWIZZLE		equ (1 shl 0)
D3DPS20CAPS_GRADIENTINSTRUCTIONS	equ (1 shl 1)
D3DPS20CAPS_PREDICATION			equ (1 shl 2)
D3DPS20CAPS_NODEPENDENTREADLIMIT	equ (1 shl 3)
D3DPS20CAPS_NOTEXINSTRUCTIONLIMIT	equ (1 shl 4)

D3DPS20_MAX_DYNAMICFLOWCONTROLDEPTH	equ 24
D3DPS20_MIN_DYNAMICFLOWCONTROLDEPTH	equ 0
D3DPS20_MAX_NUMTEMPS			equ 32
D3DPS20_MIN_NUMTEMPS			equ 12
D3DPS20_MAX_STATICFLOWCONTROLDEPTH	equ 4
D3DPS20_MIN_STATICFLOWCONTROLDEPTH	equ 0
D3DPS20_MAX_NUMINSTRUCTIONSLOTS		equ 512
D3DPS20_MIN_NUMINSTRUCTIONSLOTS		equ 96

D3DMIN30SHADERINSTRUCTIONS		equ 512
D3DMAX30SHADERINSTRUCTIONS		equ 32768

_D3DCAPS9 struct
;	/* Device Info */
 	DeviceType			D3DDEVTYPE ?
	AdapterOrdinal			UINT ?

;	/* Caps from DX7 Draw */
	Caps				DWORD ?
	Caps2				DWORD ?
	Caps3				DWORD ?
	PresentationIntervals		DWORD ?

;	/* Cursor Caps */
	CursorCaps 			DWORD ?

;	/* 3D Device Caps */
	DevCaps				DWORD ?

	PrimitiveMiscCaps		DWORD ?
	RasterCaps			DWORD ?
	ZCmpCaps			DWORD ?
	SrcBlendCaps			DWORD ?
	DestBlendCaps			DWORD ?
	AlphaCmpCaps			DWORD ?
	ShadeCaps			DWORD ?
	TextureCaps			DWORD ?
	TextureFilterCaps		DWORD ? ;// D3DPTFILTERCAPS for IDirect3DTexture9's
	CubeTextureFilterCaps		DWORD ? ;// D3DPTFILTERCAPS for IDirect3DCubeTexture9's
	VolumeTextureFilterCaps		DWORD ? ;// D3DPTFILTERCAPS for IDirect3DVolumeTexture9's
	TextureAddressCaps		DWORD ? ;// D3DPTADDRESSCAPS for IDirect3DTexture9's
	VolumeTextureAddressCaps	DWORD ? ;// D3DPTADDRESSCAPS for IDirect3DVolumeTexture9's

	LineCaps			DWORD ? ;// D3DLINECAPS

	MaxTextureWidth			DWORD ?
	MaxTextureHeight		DWORD ?
	MaxVolumeExtent			DWORD ?

	MaxTextureRepeat		DWORD ?
	MaxTextureAspectRatio		DWORD ?
	MaxAnisotropy			DWORD ?
	MaxVertexW			FLOAT ?

	GuardBandLeft			FLOAT ?
	GuardBandTop			FLOAT ?
	GuardBandRight			FLOAT ?
	GuardBandBottom			FLOAT ?

	ExtentsAdjust			FLOAT ?
	StencilCaps			DWORD ?

	FVFCaps				DWORD ?
	TextureOpCaps			DWORD ?
	MaxTextureBlendStages		DWORD ?
	MaxSimultaneousTextures		DWORD ?

	VertexProcessingCaps		DWORD ?
	MaxActiveLights			DWORD ?
	MaxUserClipPlanes		DWORD ?
	MaxVertexBlendMatrices		DWORD ?
	MaxVertexBlendMatrixIndex	DWORD ?

	MaxPointSize			FLOAT ?

	MaxPrimitiveCount		DWORD ? ;// max number of primitives per DrawPrimitive call
	MaxVertexIndex			DWORD ?
	MaxStreams			DWORD ?
	MaxStreamStride			DWORD ? ;// max stride for SetStreamSource

	VertexShaderVersion		DWORD ?
	MaxVertexShaderConst		DWORD ? ;// number of vertex shader constant registers

	PixelShaderVersion		DWORD ?
	PixelShader1xMaxValue		FLOAT ? ;// max value storable in registers of ps.1.x shaders

	;//Here are the DX9 specific ones
	DevCaps2			DWORD ?

	MaxNpatchTessellationLevel	FLOAT ?
	Reserved5			DWORD ?

	MasterAdapterOrdinal		UINT ? ;// ordinal of master adaptor for adapter group	
	AdapterOrdinalInGroup		UINT ? ;// ordinal inside the adapter group
	NumberOfAdaptersInGroup		UINT ? ;// number of adapters in this adapter group (only if master)
	DeclTypes			DWORD ? ;// Data types, supported in vertex declarations
	NumSimultaneousRTs		DWORD ? ;// Will be at least 1
	StretchRectFilterCaps		DWORD ? ;// Filter caps supported by StretchRect
	VS20Caps			D3DVSHADERCAPS2_0 <?>
	PS20Caps			D3DPSHADERCAPS2_0 <?>
	VertexTextureFilterCaps			DWORD ? ;// D3DPTFILTERCAPS for IDirect3DTexture9's for texture, used in vertex shaders
	MaxVShaderInstructionsExecuted		DWORD ? ;// maximum number of vertex shader instructions that can be executed
	MaxPShaderInstructionsExecuted		DWORD ? ;// maximum number of pixel shader instructions that can be executed
	MaxVertexShader30InstructionSlots	DWORD ?
	MaxPixelShader30InstructionSlots	DWORD ?
_D3DCAPS9 ends

D3DCAPS9		typedef	_D3DCAPS9

;// BIT DEFINES FOR D3DCAPS9 DWORD MEMBERS

;// Caps
D3DCAPS_READ_SCANLINE		equ 000020000h

;//Caps2
D3DCAPS2_FULLSCREENGAMMA	equ 000020000h
D3DCAPS2_CANCALIBRATEGAMMA	equ 000100000h
D3DCAPS2_RESERVED		equ 002000000h
D3DCAPS2_CANMANAGERESOURCE	equ 010000000h
D3DCAPS2_DYNAMICTEXTURES	equ 020000000h
D3DCAPS2_CANAUTOGENMIPMAP	equ 040000000h

;// Caps3
D3DCAPS3_RESERVED		equ 08000001fh

;// Indicates that the device can respect the ALPHABLENDENABLE render state
;// when fullscreen while using the FLIP or DISCARD swap effect.
;// COPY and COPYVSYNC swap effects work whether or not this flag is set.
D3DCAPS3_ALPHA_FULLSCREEN_FLIP_OR_DISCARD	equ 020h

;// Indicates that the device can perform a gamma correction from 
;// a windowed back buffer containing linear content to the sRGB desktop.
D3DCAPS3_LINEAR_TO_SRGB_PRESENTATION 	equ 080h

D3DCAPS3_COPY_TO_VIDMEM		equ 000000100h ;/* Device can acclerate copies from sysmem to local vidmem */
D3DCAPS3_COPY_TO_SYSTEMMEM	equ 000000200h ;/* Device can acclerate copies from local vidmem to sysmem */

;// PresentationIntervals

D3DPRESENT_INTERVAL_DEFAULT	equ 000000000h
D3DPRESENT_INTERVAL_ONE		equ 000000001h
D3DPRESENT_INTERVAL_TWO		equ 000000002h
D3DPRESENT_INTERVAL_THREE	equ 000000004h
D3DPRESENT_INTERVAL_FOUR	equ 000000008h
D3DPRESENT_INTERVAL_IMMEDIATE	equ 080000000h

;// CursorCaps

;// Driver supports HW color cursor in at least hi-res modes(height >=400)
D3DCURSORCAPS_COLOR		equ 000000001h
;// Driver supports HW cursor also in low-res modes(height < 400)
D3DCURSORCAPS_LOWRES		equ 000000002h

;// DevCaps

D3DDEVCAPS_EXECUTESYSTEMMEMORY		equ 00000010h ;/* Device can use execute buffers from system memory */
D3DDEVCAPS_EXECUTEVIDEOMEMORY		equ 00000020h ;/* Device can use execute buffers from video memory */
D3DDEVCAPS_TLVERTEXSYSTEMMEMORY		equ 00000040h ;/* Device can use TL buffers from system memory */
D3DDEVCAPS_TLVERTEXVIDEOMEMORY		equ 00000080h ;/* Device can use TL buffers from video memory */
D3DDEVCAPS_TEXTURESYSTEMMEMORY		equ 00000100h ;/* Device can texture from system memory */
D3DDEVCAPS_TEXTUREVIDEOMEMORY		equ 00000200h ;/* Device can texture from device memory */
D3DDEVCAPS_DRAWPRIMTLVERTEX		equ 00000400h ;/* Device can draw TLVERTEX primitives */
D3DDEVCAPS_CANRENDERAFTERFLIP		equ 00000800h ;/* Device can render without waiting for flip to complete */
D3DDEVCAPS_TEXTURENONLOCALVIDMEM	equ 00001000h ;/* Device can texture from nonlocal video memory */
D3DDEVCAPS_DRAWPRIMITIVES2		equ 00002000h ;/* Device can support DrawPrimitives2 */
D3DDEVCAPS_SEPARATETEXTUREMEMORIES	equ 00004000h ;/* Device is texturing from separate memory pools */
D3DDEVCAPS_DRAWPRIMITIVES2EX		equ 00008000h ;/* Device can support Extended DrawPrimitives2 i.e. DX7 compliant driver*/
D3DDEVCAPS_HWTRANSFORMANDLIGHT		equ 00010000h ;/* Device can support transformation and lighting in hardware and DRAWPRIMITIVES2EX must be also */
D3DDEVCAPS_CANBLTSYSTONONLOCAL		equ 00020000h ;/* Device supports a Tex Blt from system memory to non-local vidmem */
D3DDEVCAPS_HWRASTERIZATION		equ 00080000h ;/* Device has HW acceleration for rasterization */
D3DDEVCAPS_PUREDEVICE			equ 00100000h ;/* Device supports D3DCREATE_PUREDEVICE */
D3DDEVCAPS_QUINTICRTPATCHES		equ 00200000h ;/* Device supports quintic Beziers and BSplines */
D3DDEVCAPS_RTPATCHES			equ 00400000h ;/* Device supports Rect and Tri patches */
D3DDEVCAPS_RTPATCHHANDLEZERO		equ 00800000h ;/* Indicates that RT Patches may be drawn efficiently using handle 0 */
D3DDEVCAPS_NPATCHES			equ 01000000h ;/* Device supports N-Patches */

;// PrimitiveMiscCaps

D3DPMISCCAPS_MASKZ			equ 0000002h
D3DPMISCCAPS_CULLNONE			equ 0000010h
D3DPMISCCAPS_CULLCW			equ 0000020h
D3DPMISCCAPS_CULLCCW			equ 0000040h
D3DPMISCCAPS_COLORWRITEENABLE		equ 0000080h
D3DPMISCCAPS_CLIPPLANESCALEDPOINTS 	equ 0000100h ;/* Device correctly clips scaled points to clip planes */
D3DPMISCCAPS_CLIPTLVERTS		equ 0000200h ;/* device will clip post-transformed vertex primitives */
D3DPMISCCAPS_TSSARGTEMP			equ 0000400h ;/* device supports D3DTA_TEMP for temporary register */
D3DPMISCCAPS_BLENDOP			equ 0000800h ;/* device supports D3DRS_BLENDOP */
D3DPMISCCAPS_NULLREFERENCE		equ 0001000h ;/* Reference Device that doesnt render */
D3DPMISCCAPS_INDEPENDENTWRITEMASKS	equ 0004000h ;/* Device supports independent write masks for MET or MRT */
D3DPMISCCAPS_PERSTAGECONSTANT		equ 0008000h ;/* Device supports per-stage constants */
D3DPMISCCAPS_FOGANDSPECULARALPHA	equ 0010000h ;/* Device supports separate fog and specular alpha (many devices use the specular alpha channel to store fog factor) */
D3DPMISCCAPS_SEPARATEALPHABLEND		equ 0020000h ;/* Device supports separate blend settings for the alpha channel */
D3DPMISCCAPS_MRTINDEPENDENTBITDEPTHS	equ 0040000h ;/* Device supports different bit depths for MRT */
D3DPMISCCAPS_MRTPOSTPIXELSHADERBLENDING	equ 0080000h ;/* Device supports post-pixel shader operations for MRT */
D3DPMISCCAPS_FOGVERTEXCLAMPED		equ 0100000h ;/* Device clamps fog blend factor per vertex */


;// LineCaps

D3DLINECAPS_TEXTURE			equ 0000001h
D3DLINECAPS_ZTEST			equ 0000002h
D3DLINECAPS_BLEND			equ 0000004h
D3DLINECAPS_ALPHACMP			equ 0000008h
D3DLINECAPS_FOG				equ 0000010h
D3DLINECAPS_ANTIALIAS			equ 0000020h

;// RasterCaps

D3DPRASTERCAPS_DITHER			equ 00000001h
D3DPRASTERCAPS_ZTEST			equ 00000010h
D3DPRASTERCAPS_FOGVERTEX		equ 00000080h
D3DPRASTERCAPS_FOGTABLE			equ 00000100h
D3DPRASTERCAPS_MIPMAPLODBIAS		equ 00002000h
D3DPRASTERCAPS_ZBUFFERLESSHSR		equ 00008000h
D3DPRASTERCAPS_FOGRANGE			equ 00010000h
D3DPRASTERCAPS_ANISOTROPY		equ 00020000h
D3DPRASTERCAPS_WBUFFER			equ 00040000h
D3DPRASTERCAPS_WFOG			equ 00100000h
D3DPRASTERCAPS_ZFOG			equ 00200000h
D3DPRASTERCAPS_COLORPERSPECTIVE		equ 00400000h ;/* Device iterates colors perspective correct */
D3DPRASTERCAPS_SCISSORTEST		equ 01000000h
D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS	equ 02000000h
D3DPRASTERCAPS_DEPTHBIAS		equ 04000000h 
D3DPRASTERCAPS_MULTISAMPLE_TOGGLE	equ 08000000h

;// ZCmpCaps, AlphaCmpCaps

D3DPCMPCAPS_NEVER			equ 00000001h
D3DPCMPCAPS_LESS			equ 00000002h
D3DPCMPCAPS_EQUAL			equ 00000004h
D3DPCMPCAPS_LESSEQUAL			equ 00000008h
D3DPCMPCAPS_GREATER			equ 00000010h
D3DPCMPCAPS_NOTEQUAL			equ 00000020h
D3DPCMPCAPS_GREATEREQUAL		equ 00000040h
D3DPCMPCAPS_ALWAYS			equ 00000080h

;// SourceBlendCaps, DestBlendCaps

D3DPBLENDCAPS_ZERO			equ 00000001h
D3DPBLENDCAPS_ONE			equ 00000002h
D3DPBLENDCAPS_SRCCOLOR			equ 00000004h
D3DPBLENDCAPS_INVSRCCOLOR		equ 00000008h
D3DPBLENDCAPS_SRCALPHA			equ 00000010h
D3DPBLENDCAPS_INVSRCALPHA		equ 00000020h
D3DPBLENDCAPS_DESTALPHA			equ 00000040h
D3DPBLENDCAPS_INVDESTALPHA		equ 00000080h
D3DPBLENDCAPS_DESTCOLOR			equ 00000100h
D3DPBLENDCAPS_INVDESTCOLOR		equ 00000200h
D3DPBLENDCAPS_SRCALPHASAT		equ 00000400h
D3DPBLENDCAPS_BOTHSRCALPHA		equ 00000800h
D3DPBLENDCAPS_BOTHINVSRCALPHA		equ 00001000h
D3DPBLENDCAPS_BLENDFACTOR		equ 00002000h ;/* Supports both D3DBLEND_BLENDFACTOR and D3DBLEND_INVBLENDFACTOR */

;// ShadeCaps

D3DPSHADECAPS_COLORGOURAUDRGB		equ 00000008h
D3DPSHADECAPS_SPECULARGOURAUDRGB	equ 00000200h
D3DPSHADECAPS_ALPHAGOURAUDBLEND		equ 00004000h
D3DPSHADECAPS_FOGGOURAUD		equ 00080000h

;// TextureCaps

D3DPTEXTURECAPS_PERSPECTIVE		equ 00000001h ;/* Perspective-correct texturing is supported */
D3DPTEXTURECAPS_POW2			equ 00000002h ;/* Power-of-2 texture dimensions are required - applies to non-Cube/Volume textures only. */
D3DPTEXTURECAPS_ALPHA			equ 00000004h ;/* Alpha in texture pixels is supported */
D3DPTEXTURECAPS_SQUAREONLY		equ 00000020h ;/* Only square textures are supported */
D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE equ 0000040h ;/* Texture indices are not scaled by the texture size prior to interpolation */
D3DPTEXTURECAPS_ALPHAPALETTE		equ 00000080h ;/* Device can draw alpha from texture palettes */

;// Device can use non-POW2 textures if:
;// 1) D3DTEXTURE_ADDRESS is set to CLAMP for this texture's stage
;// 2) D3DRS_WRAP(N) is zero for this texture's coordinates
;// 3) mip mapping is not enabled (use magnification filter only)

D3DPTEXTURECAPS_NONPOW2CONDITIONAL	equ 00000100h
D3DPTEXTURECAPS_PROJECTED		equ 00000400h ;/* Device can do D3DTTFF_PROJECTED */
D3DPTEXTURECAPS_CUBEMAP			equ 00000800h ;/* Device can do cubemap textures */
D3DPTEXTURECAPS_VOLUMEMAP		equ 00002000h ;/* Device can do volume textures */
D3DPTEXTURECAPS_MIPMAP			equ 00004000h ;/* Device can do mipmapped textures */
D3DPTEXTURECAPS_MIPVOLUMEMAP		equ 00008000h ;/* Device can do mipmapped volume textures */
D3DPTEXTURECAPS_MIPCUBEMAP		equ 00010000h ;/* Device can do mipmapped cube maps */
D3DPTEXTURECAPS_CUBEMAP_POW2		equ 00020000h ;/* Device requires that cubemaps be power-of-2 dimension */
D3DPTEXTURECAPS_VOLUMEMAP_POW2		equ 00040000h ;/* Device requires that volume maps be power-of-2 dimension */
D3DPTEXTURECAPS_NOPROJECTEDBUMPENV	equ 00200000h ;/* Device does not support projected bump env lookup operation in programmable and fixed function pixel shaders */

;// TextureFilterCaps, StretchRectFilterCaps

D3DPTFILTERCAPS_MINFPOINT		equ 00000100h ;/* Min Filter */
D3DPTFILTERCAPS_MINFLINEAR		equ 00000200h
D3DPTFILTERCAPS_MINFANISOTROPIC		equ 00000400h
D3DPTFILTERCAPS_MINFPYRAMIDALQUAD	equ 00000800h
D3DPTFILTERCAPS_MINFGAUSSIANQUAD	equ 00001000h
D3DPTFILTERCAPS_MIPFPOINT		equ 00010000h ;/* Mip Filter */
D3DPTFILTERCAPS_MIPFLINEAR		equ 00020000h
D3DPTFILTERCAPS_MAGFPOINT		equ 01000000h ;/* Mag Filter */
D3DPTFILTERCAPS_MAGFLINEAR		equ 02000000h
D3DPTFILTERCAPS_MAGFANISOTROPIC		equ 04000000h
D3DPTFILTERCAPS_MAGFPYRAMIDALQUAD	equ 08000000h
D3DPTFILTERCAPS_MAGFGAUSSIANQUAD	equ 10000000h

;// TextureAddressCaps

D3DPTADDRESSCAPS_WRAP			equ 00000001h
D3DPTADDRESSCAPS_MIRROR			equ 00000002h
D3DPTADDRESSCAPS_CLAMP			equ 00000004h
D3DPTADDRESSCAPS_BORDER			equ 00000008h
D3DPTADDRESSCAPS_INDEPENDENTUV		equ 00000010h
D3DPTADDRESSCAPS_MIRRORONCE		equ 00000020h

;// StencilCaps

D3DSTENCILCAPS_KEEP			equ 00000001h
D3DSTENCILCAPS_ZERO			equ 00000002h
D3DSTENCILCAPS_REPLACE			equ 00000004h
D3DSTENCILCAPS_INCRSAT			equ 00000008h
D3DSTENCILCAPS_DECRSAT			equ 00000010h
D3DSTENCILCAPS_INVERT			equ 00000020h
D3DSTENCILCAPS_INCR			equ 00000040h
D3DSTENCILCAPS_DECR			equ 00000080h
D3DSTENCILCAPS_TWOSIDED			equ 00000100h

;// TextureOpCaps

D3DTEXOPCAPS_DISABLE			equ 00000001h
D3DTEXOPCAPS_SELECTARG1			equ 00000002h
D3DTEXOPCAPS_SELECTARG2			equ 00000004h
D3DTEXOPCAPS_MODULATE			equ 00000008h
D3DTEXOPCAPS_MODULATE2X			equ 00000010h
D3DTEXOPCAPS_MODULATE4X			equ 00000020h
D3DTEXOPCAPS_ADD			equ 00000040h
D3DTEXOPCAPS_ADDSIGNED			equ 00000080h
D3DTEXOPCAPS_ADDSIGNED2X		equ 00000100h
D3DTEXOPCAPS_SUBTRACT			equ 00000200h
D3DTEXOPCAPS_ADDSMOOTH			equ 00000400h
D3DTEXOPCAPS_BLENDDIFFUSEALPHA		equ 00000800h
D3DTEXOPCAPS_BLENDTEXTUREALPHA		equ 00001000h
D3DTEXOPCAPS_BLENDFACTORALPHA		equ 00002000h
D3DTEXOPCAPS_BLENDTEXTUREALPHAPM	equ 00004000h
D3DTEXOPCAPS_BLENDCURRENTALPHA		equ 00008000h
D3DTEXOPCAPS_PREMODULATE		equ 00010000h
D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR	equ 00020000h
D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA	equ 00040000h
D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR	equ 00080000h
D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA	equ 00100000h
D3DTEXOPCAPS_BUMPENVMAP			equ 00200000h
D3DTEXOPCAPS_BUMPENVMAPLUMINANCE	equ 00400000h
D3DTEXOPCAPS_DOTPRODUCT3		equ 00800000h
D3DTEXOPCAPS_MULTIPLYADD		equ 01000000h
D3DTEXOPCAPS_LERP			equ 02000000h

;// FVFCaps

D3DFVFCAPS_TEXCOORDCOUNTMASK		equ 0000ffffh ;/* mask for texture coordinate count field */
D3DFVFCAPS_DONOTSTRIPELEMENTS		equ 00080000h ;/* Device prefers that vertex elements not be stripped */
D3DFVFCAPS_PSIZE			equ 00100000h ;/* Device can receive point size */

;// VertexProcessingCaps

D3DVTXPCAPS_TEXGEN			equ 00000001h ;/* device can do texgen */
D3DVTXPCAPS_MATERIALSOURCE7		equ 00000002h ;/* device can do DX7-level colormaterialsource ops */
D3DVTXPCAPS_DIRECTIONALLIGHTS		equ 00000008h ;/* device can do directional lights */
D3DVTXPCAPS_POSITIONALLIGHTS		equ 00000010h ;/* device can do positional lights (includes point and spot) */
D3DVTXPCAPS_LOCALVIEWER			equ 00000020h ;/* device can do local viewer */
D3DVTXPCAPS_TWEENING			equ 00000040h ;/* device can do vertex tweening */
D3DVTXPCAPS_TEXGEN_SPHEREMAP		equ 00000100h ;/* device supports D3DTSS_TCI_SPHEREMAP */
D3DVTXPCAPS_NO_TEXGEN_NONLOCALVIEWER	equ 00000200h ;/* device does not support TexGen in non-local viewer mode */

;// DevCaps2

D3DDEVCAPS2_STREAMOFFSET			equ 001h ;/* Device supports offsets in streams. Must be set by DX9 drivers */
D3DDEVCAPS2_DMAPNPATCH				equ 002h ;/* Device supports displacement maps for N-Patches*/
D3DDEVCAPS2_ADAPTIVETESSRTPATCH			equ 004h ;/* Device supports adaptive tesselation of RT-patches*/
D3DDEVCAPS2_ADAPTIVETESSNPATCH			equ 008h ;/* Device supports adaptive tesselation of N-patches*/
D3DDEVCAPS2_CAN_STRETCHRECT_FROM_TEXTURES	equ 010h ;/* Device supports StretchRect calls with a texture as the source*/
D3DDEVCAPS2_PRESAMPLEDDMAPNPATCH		equ 020h ;/* Device supports presampled displacement maps for N-Patches */
D3DDEVCAPS2_VERTEXELEMENTSCANSHARESTREAMOFFSET	equ 040h ;/* Vertex elements in a vertex declaration can share the same stream offset */

;// DeclTypes

D3DDTCAPS_UBYTE4			equ 00000001h
D3DDTCAPS_UBYTE4N			equ 00000002h
D3DDTCAPS_SHORT2N			equ 00000004h
D3DDTCAPS_SHORT4N			equ 00000008h
D3DDTCAPS_USHORT2N			equ 00000010h
D3DDTCAPS_USHORT4N			equ 00000020h
D3DDTCAPS_UDEC3				equ 00000040h
D3DDTCAPS_DEC3N				equ 00000080h
D3DDTCAPS_FLOAT16_2			equ 00000100h
D3DDTCAPS_FLOAT16_4			equ 00000200h

endif ;/* (DIRECT3D_VERSION >= 0x0900) */
endif ;/* _d3d9CAPS_H_ */
