;/*==========================================================================;
; *
; *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
; *
; *
; *  File:       d3d9types.inc
; *  Content:    Direct3D capabilities include file
; *
; *  Translated to .ASM by: Siekmanski
; *
; ***************************************************************************/

ifndef _d3d9TYPES_H_
_d3d9TYPES_H_ equ 1

ifndef DIRECT3D_VERSION
DIRECT3D_VERSION	equ 00900h
endif  ;//DIRECT3D_VERSION

;// include this file content only if compiling for DX9 interfaces
if (DIRECT3D_VERSION ge 00900h)

;// D3DCOLOR is equivalent to D3DFMT_A8R8G8B8
D3DCOLOR	typedef DWORD

;// maps unsigned 8 bits/channel to D3DCOLOR
;D3DCOLOR_ARGB MACRO a:REQ,r:REQ,g:REQ,b:REQ
;	EXITM %((D3DCOLOR)((a and 0ffh) shl 24) or ((r and 0ffh) shl 16) or ((g and 0ffh) shl 8) or (b and 0ffh))
;ENDM

LPFLOAT	typedef	PTR FLOAT
float	textequ <FLOAT>

D3DCOLOR_ARGB MACRO a:REQ,r:REQ,g:REQ,b:REQ
	EXITM %(((a and 0ffh) shl 24) or ((r and 0ffh) shl 16) or ((g and 0ffh) shl 8) or (b and 0ffh))
ENDM

D3DCOLOR_RGBA MACRO r,g,b,a
	EXITM D3DCOLOR_ARGB(a,r,g,b)
ENDM

D3DCOLOR_XRGB MACRO r,g,b
	EXITM D3DCOLOR_ARGB(0ffh,r,g,b)
ENDM

D3DCOLOR_XYUV MACRO y,u,v
	EXITM D3DCOLOR_ARGB(0ffh,y,u,v)
ENDM

D3DCOLOR_AYUV MACRO a,y,u,v
	EXITM D3DCOLOR_ARGB(a,y,u,v)
ENDM

;// maps floating point channels (0.f to 1.f range) to D3DCOLOR
D3DCOLOR_COLORVALUE MACRO r,g,b,a
	EXITM %(D3DCOLOR_RGBA((DWORD)((r)*255.f),(DWORD)((g)*255.f),(DWORD)((b)*255.f),(DWORD)((a)*255.f)))
ENDM D3DCOLOR_COLORVALUE

_D3DVECTOR struct
	x FLOAT ?
	y FLOAT ?
	z FLOAT ?
_D3DVECTOR ends

D3DVECTOR	typedef _D3DVECTOR
D3DVECTOR3	typedef _D3DVECTOR
LPD3DVECTOR3	typedef PTR D3DVECTOR3

_D3DVECTOR4 struct
	x FLOAT ?
	y FLOAT ?
	z FLOAT ?
	w FLOAT ?
_D3DVECTOR4 ends

D3DVECTOR4	typedef _D3DVECTOR4
LPD3DVECTOR4	typedef PTR D3DVECTOR4

_D3DCOLORVALUE struct
	r FLOAT ?
	g FLOAT ?
	b FLOAT ?
	a FLOAT ?
_D3DCOLORVALUE ends

D3DCOLORVALUE 	typedef _D3DCOLORVALUE

_D3DRECT struct
	x1 LONG ?
	x2 LONG ?
	y1 LONG ?
	y2 LONG ?
_D3DRECT ends

D3DRECT		typedef _D3DRECT

_D3DMATRIX struct
	_11 FLOAT ?
	_12 FLOAT ?
	_13 FLOAT ?
	_14 FLOAT ?
	_21 FLOAT ?
	_22 FLOAT ?
	_23 FLOAT ?
	_24 FLOAT ?
	_31 FLOAT ?
	_32 FLOAT ?
	_33 FLOAT ?
	_34 FLOAT ?
	_41 FLOAT ?
	_42 FLOAT ?
	_43 FLOAT ?
	_44 FLOAT ?
_D3DMATRIX ends

D3DMATRIX	typedef _D3DMATRIX
LPD3DMATRIX	typedef PTR D3DMATRIX

_D3DVIEWPORT9 struct
	X		DWORD ?
	Y 		DWORD ?	;/* Viewport Top left */
	dx_Width 	DWORD ?	; MASM conflict !!, so Width == dx_Width
	dx_Height 	DWORD ?	;/* Viewport Dimensions */ Keep it the same type as Width
	MinZ 		FLOAT ?	;/* Min/max of clip Volume */
	MaxZ 		FLOAT ?
_D3DVIEWPORT9 ends

D3DVIEWPORT9	typedef _D3DVIEWPORT9

;/*
; * Values for clip fields.
; */

;// Max number of user clipping planes, supported in D3D.
D3DMAXUSERCLIPPLANES	equ 32

;// These bits could be ORed together to use with D3DRS_CLIPPLANEENABLE
D3DCLIPPLANE0		equ (1 shl 0)
D3DCLIPPLANE1		equ (1 shl 1)
D3DCLIPPLANE2		equ (1 shl 2)
D3DCLIPPLANE3		equ (1 shl 3)
D3DCLIPPLANE4		equ (1 shl 4)
D3DCLIPPLANE5		equ (1 shl 5)

;// The following bits are used in the ClipUnion and ClipIntersection
;// members of the D3DCLIPSTATUS9
D3DCS_LEFT		equ 0001h
D3DCS_RIGHT		equ 0002h
D3DCS_TOP		equ 0004h
D3DCS_BOTTOM		equ 0008h
D3DCS_FRONT		equ 0010h
D3DCS_BACK		equ 0020h
D3DCS_PLANE0		equ 0040h
D3DCS_PLANE1		equ 0080h
D3DCS_PLANE2		equ 0100h
D3DCS_PLANE3		equ 0200h
D3DCS_PLANE4		equ 0400h
D3DCS_PLANE5		equ 0800h

D3DCS_ALL		equ 	(D3DCS_LEFT   or \
				 D3DCS_RIGHT  or \
				 D3DCS_TOP    or \
				 D3DCS_BOTTOM or \
				 D3DCS_FRONT  or \
				 D3DCS_BACK   or \
				 D3DCS_PLANE0 or \
				 D3DCS_PLANE1 or \
				 D3DCS_PLANE2 or \
				 D3DCS_PLANE3 or \
				 D3DCS_PLANE4 or \
				 D3DCS_PLANE5)

_D3DCLIPSTATUS9 struct 
	ClipUnion 		DWORD ?
	ClipIntersection 	DWORD ?
_D3DCLIPSTATUS9 ends

D3DCLIPSTATUS9		typedef _D3DCLIPSTATUS9

_D3DMATERIAL9 struct
	Diffuse		D3DCOLORVALUE <?> ;/* Diffuse color RGBA */
	Ambient 	D3DCOLORVALUE <?> ;/* Ambient color RGB */
	Specular 	D3DCOLORVALUE <?> ;/* Specular 'shininess' */
	Emissive 	D3DCOLORVALUE <?> ;/* Emissive color RGB */
	Power 		FLOAT ?		  ;/* Sharpness if specular highlight */
_D3DMATERIAL9 ends

D3DMATERIAL9		typedef _D3DMATERIAL9

D3DLIGHT_POINT		equ 1
D3DLIGHT_SPOT		equ 2
D3DLIGHT_DIRECTIONAL	equ 3
D3DLIGHT_FORCE_DWORD	equ 7fffffffh ;/* force 32-bit size enum */

D3DLIGHTTYPE	typedef DWORD

_D3DLIGHT9 struct
	dx_Type		D3DLIGHTTYPE ?
	Diffuse 	D3DCOLORVALUE <?>
	Specular 	D3DCOLORVALUE <?>
	Ambient 	D3DCOLORVALUE <?>
	Position 	D3DVECTOR <?>
	Direction 	D3DVECTOR <?>
	Range		FLOAT ?
	Falloff		FLOAT ?
	Attenuation0	FLOAT ? ;/* Constant attenuation */
	Attenuation1	FLOAT ? ;/* Linear attenuation */
	Attenuation2	FLOAT ? ;/* Quadratic attenuation */
	Theta		FLOAT ? ;/* Inner angle of spotlight cone */
	Phi		FLOAT ? ;/* Outer angle of spotlight cone */
_D3DLIGHT9 ends

D3DLIGHT9		typedef _D3DLIGHT9
LPD3DLIGHT9		typedef PTR _D3DLIGHT9

D3DCLEAR_TARGET			equ 1h
D3DCLEAR_ZBUFFER 		equ 2h
D3DCLEAR_STENCIL		equ 4h

D3DSHADE_FLAT			equ 1
D3DSHADE_GOURAUD		equ 2
D3DSHADE_PHONG			equ 3
D3DSHADE_FORCE_DWORD		equ 07fffffffh

D3DSHADEMODE		typedef DWORD

D3DFILL_POINT			equ 1
D3DFILL_WIREFRAME		equ 2
D3DFILL_SOLID			equ 3
D3DFILL_FORCE_DWORD		equ 07fffffffh

D3DFILLMODE		typedef DWORD

D3DBLEND_ZERO			equ 1
D3DBLEND_ONE			equ 2
D3DBLEND_SRCCOLOR		equ 3
D3DBLEND_INVSRCCOLOR		equ 4
D3DBLEND_SRCALPHA		equ 5
D3DBLEND_INVSRCALPHA		equ 6
D3DBLEND_DESTALPHA		equ 7
D3DBLEND_INVDESTALPHA		equ 8
D3DBLEND_DESTCOLOR		equ 9
D3DBLEND_INVDESTCOLOR		equ 10
D3DBLEND_SRCALPHASAT		equ 11
D3DBLEND_BOTHSRCALPHA		equ 12
D3DBLEND_BOTHINVSRCALPHA	equ 13
D3DBLEND_BLENDFACTOR		equ 14 ;/* Only supported if D3DPBLENDCAPS_BLENDFACTOR is on */
D3DBLEND_INVBLENDFACTOR		equ 15 ;/* Only supported if D3DPBLENDCAPS_BLENDFACTOR is on */
D3DBLEND_FORCE_DWORD		equ 07fffffffh

D3DBLEND		typedef DWORD

D3DBLENDOP_ADD			equ 1
D3DBLENDOP_SUBTRACT 		equ 2
D3DBLENDOP_REVSUBTRACT		equ 3
D3DBLENDOP_MIN			equ 4
D3DBLENDOP_MAX			equ 5
D3DBLENDOP_FORCE_DWORD		equ 07fffffffh

D3DBLENDOP		typedef DWORD

D3DTADDRESS_WRAP		equ 1
D3DTADDRESS_MIRROR		equ 2
D3DTADDRESS_CLAMP		equ 3
D3DTADDRESS_BORDER		equ 4
D3DTADDRESS_MIRRORONCE		equ 5
D3DTADDRESS_FORCE_DWORD		equ 07fffffffh

D3DTEXTUREADDRESS	typedef DWORD

D3DCULL_NONE			equ 1
D3DCULL_CW			equ 2
D3DCULL_CCW			equ 3
D3DCULL_FORCE_DWORD		equ 07fffffffh

D3DCULL			typedef DWORD

D3DCMP_NEVER			equ 1
D3DCMP_LESS			equ 2
D3DCMP_EQUAL			equ 3
D3DCMP_LESSEQUAL		equ 4
D3DCMP_GREATER			equ 5
D3DCMP_NOTEQUAL			equ 6
D3DCMP_GREATEREQUAL		equ 7
D3DCMP_ALWAYS			equ 8
D3DCMP_FORCE_DWORD		equ 07fffffffh

D3DCMPFUNC		typedef DWORD

D3DSTENCILOP_KEEP		equ 1
D3DSTENCILOP_ZERO		equ 2
D3DSTENCILOP_REPLACE		equ 3
D3DSTENCILOP_INCRSAT		equ 4
D3DSTENCILOP_DECRSAT		equ 5
D3DSTENCILOP_INVERT		equ 6
D3DSTENCILOP_INCR		equ 7
D3DSTENCILOP_DECR		equ 8
D3DSTENCILOP_FORCE_DWORD	equ 07fffffffh

D3DSTENCILOP		typedef DWORD

D3DFOG_NONE			equ 0
D3DFOG_EXP			equ 1
D3DFOG_EXP2			equ 2
D3DFOG_LINEAR			equ 3
D3DFOG_FORCE_DWORD		equ 07fffffffh

D3DFOGMODE		typedef DWORD

D3DZB_FALSE			equ 0
D3DZB_TRUE			equ 1
D3DZB_USEW			equ 2
D3DZB_FORCE_DWORD		equ 07fffffffh

D3DZBUFFERTYPE		typedef DWORD

;// Primitives supported by draw-primitive API
D3DPT_POINTLIST			equ 1
D3DPT_LINELIST			equ 2
D3DPT_LINESTRIP			equ 3
D3DPT_TRIANGLELIST		equ 4
D3DPT_TRIANGLESTRIP		equ 5
D3DPT_TRIANGLEFAN		equ 6
D3DPT_FORCE_DWORD		equ 07fffffffh

D3DPRIMITIVETYPE	typedef DWORD

D3DTS_VIEW			equ 2
D3DTS_PROJECTION		equ 3
D3DTS_TEXTURE0			equ 16
D3DTS_TEXTURE1			equ 17
D3DTS_TEXTURE2			equ 18
D3DTS_TEXTURE3			equ 19
D3DTS_TEXTURE4			equ 20
D3DTS_TEXTURE5			equ 21
D3DTS_TEXTURE6			equ 22
D3DTS_TEXTURE7			equ 23
D3DTS_FORCE_DWORD		equ 07fffffffh

D3DTRANSFORMSTATETYPE	typedef DWORD


D3DTS_WORLDMATRIX MACRO index:REQ
	EXITM %(index + 256)
ENDM

D3DTS_WORLD			TEXTEQU D3DTS_WORLDMATRIX(0)
D3DTS_WORLD1			TEXTEQU D3DTS_WORLDMATRIX(1)
D3DTS_WORLD2			TEXTEQU D3DTS_WORLDMATRIX(2)
D3DTS_WORLD3			TEXTEQU D3DTS_WORLDMATRIX(3)


D3DRS_ZENABLE				equ 7    ;/* D3DZBUFFERTYPE (or TRUE/FALSE for legacy) */
D3DRS_FILLMODE				equ 8    ;/* D3DFILLMODE */
D3DRS_SHADEMODE				equ 9    ;/* D3DSHADEMODE */
D3DRS_ZWRITEENABLE			equ 14   ;/* TRUE to enable z writes */
D3DRS_ALPHATESTENABLE			equ 15   ;/* TRUE to enable alpha tests */
D3DRS_LASTPIXEL				equ 16   ;/* TRUE for last-pixel on lines */
D3DRS_SRCBLEND				equ 19   ;/* D3DBLEND */
D3DRS_DESTBLEND				equ 20   ;/* D3DBLEND */
D3DRS_CULLMODE				equ 22   ;/* D3DCULL */
D3DRS_ZFUNC				equ 23   ;/* D3DCMPFUNC */
D3DRS_ALPHAREF				equ 24   ;/* D3DFIXED */
D3DRS_ALPHAFUNC				equ 25   ;/* D3DCMPFUNC */
D3DRS_DITHERENABLE			equ 26   ;/* TRUE to enable dithering */
D3DRS_ALPHABLENDENABLE			equ 27   ;/* TRUE to enable alpha blending */
D3DRS_FOGENABLE				equ 28   ;/* TRUE to enable fog blending */
D3DRS_SPECULARENABLE			equ 29   ;/* TRUE to enable specular */
D3DRS_FOGCOLOR				equ 34   ;/* D3DCOLOR */
D3DRS_FOGTABLEMODE			equ 35   ;/* D3DFOGMODE */
D3DRS_FOGSTART				equ 36   ;/* Fog start (for both vertex and pixel fog) */
D3DRS_FOGEND				equ 37   ;/* Fog end      */
D3DRS_FOGDENSITY			equ 38   ;/* Fog density  */
D3DRS_RANGEFOGENABLE			equ 48   ;/* Enables range-based fog */
D3DRS_STENCILENABLE			equ 52   ;/* BOOL enable/disable stenciling */
D3DRS_STENCILFAIL			equ 53   ;/* D3DSTENCILOP to do if stencil test fails */
D3DRS_STENCILZFAIL			equ 54   ;/* D3DSTENCILOP to do if stencil test passes and Z test fails */
D3DRS_STENCILPASS			equ 55   ;/* D3DSTENCILOP to do if both stencil and Z tests pass */
D3DRS_STENCILFUNC			equ 56   ;/* D3DCMPFUNC fn.  Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true */
D3DRS_STENCILREF			equ 57   ;/* Reference value used in stencil test */
D3DRS_STENCILMASK			equ 58   ;/* Mask value used in stencil test */
D3DRS_STENCILWRITEMASK			equ 59   ;/* Write mask applied to values written to stencil buffer */
D3DRS_TEXTUREFACTOR			equ 60   ;/* D3DCOLOR used for multi-texture blend */
D3DRS_WRAP0				equ 128  ;/* wrap for 1st texture coord. set */
D3DRS_WRAP1				equ 129  ;/* wrap for 2nd texture coord. set */
D3DRS_WRAP2				equ 130  ;/* wrap for 3rd texture coord. set */
D3DRS_WRAP3				equ 131  ;/* wrap for 4th texture coord. set */
D3DRS_WRAP4				equ 132  ;/* wrap for 5th texture coord. set */
D3DRS_WRAP5				equ 133  ;/* wrap for 6th texture coord. set */
D3DRS_WRAP6				equ 134  ;/* wrap for 7th texture coord. set */
D3DRS_WRAP7				equ 135  ;/* wrap for 8th texture coord. set */
D3DRS_CLIPPING				equ 136
D3DRS_LIGHTING				equ 137
D3DRS_AMBIENT				equ 139
D3DRS_FOGVERTEXMODE			equ 140
D3DRS_COLORVERTEX			equ 141
D3DRS_LOCALVIEWER			equ 142
D3DRS_NORMALIZENORMALS			equ 143
D3DRS_DIFFUSEMATERIALSOURCE		equ 145
D3DRS_SPECULARMATERIALSOURCE		equ 146
D3DRS_AMBIENTMATERIALSOURCE		equ 147
D3DRS_EMISSIVEMATERIALSOURCE		equ 148
D3DRS_VERTEXBLEND			equ 151
D3DRS_CLIPPLANEENABLE			equ 152
D3DRS_POINTSIZE				equ 154   ;/* float point size */
D3DRS_POINTSIZE_MIN			equ 155   ;/* float point size min threshold */
D3DRS_POINTSPRITEENABLE			equ 156   ;/* BOOL point texture coord control */
D3DRS_POINTSCALEENABLE			equ 157   ;/* BOOL point size scale enable */
D3DRS_POINTSCALE_A			equ 158   ;/* float point attenuation A value */
D3DRS_POINTSCALE_B			equ 159   ;/* float point attenuation B value */
D3DRS_POINTSCALE_C			equ 160   ;/* float point attenuation C value */
D3DRS_MULTISAMPLEANTIALIAS		equ 161   ;// BOOL - set to do FSAA with multisample buffer
D3DRS_MULTISAMPLEMASK			equ 162   ;// DWORD - per-sample enable/disable
D3DRS_PATCHEDGESTYLE			equ 163   ;// Sets whether patch edges will use float style tessellation
D3DRS_DEBUGMONITORTOKEN			equ 165   ;// DEBUG ONLY - token to debug monitor
D3DRS_POINTSIZE_MAX			equ 166   ;/* float point size max threshold */
D3DRS_INDEXEDVERTEXBLENDENABLE		equ 167
D3DRS_COLORWRITEENABLE			equ 168   ;// per-channel write enable
D3DRS_TWEENFACTOR			equ 170   ;// float tween factor
D3DRS_BLENDOP				equ 171   ;// D3DBLENDOP setting
D3DRS_POSITIONDEGREE			equ 172   ;// NPatch position interpolation degree. D3DDEGREE_LINEAR or D3DDEGREE_CUBIC (default)
D3DRS_NORMALDEGREE			equ 173   ;// NPatch normal interpolation degree. D3DDEGREE_LINEAR (default) or D3DDEGREE_QUADRATIC
D3DRS_SCISSORTESTENABLE			equ 174
D3DRS_SLOPESCALEDEPTHBIAS		equ 175
D3DRS_ANTIALIASEDLINEENABLE		equ 176
D3DRS_MINTESSELLATIONLEVEL		equ 178
D3DRS_MAXTESSELLATIONLEVEL		equ 179
D3DRS_ADAPTIVETESS_X			equ 180
D3DRS_ADAPTIVETESS_Y			equ 181
D3DRS_ADAPTIVETESS_Z			equ 182
D3DRS_ADAPTIVETESS_W			equ 183
D3DRS_ENABLEADAPTIVETESSELLATION	equ 184
D3DRS_TWOSIDEDSTENCILMODE		equ 185   ;/* BOOL enable/disable 2 sided stenciling */
D3DRS_CCW_STENCILFAIL			equ 186   ;/* D3DSTENCILOP to do if ccw stencil test fails */
D3DRS_CCW_STENCILZFAIL			equ 187   ;/* D3DSTENCILOP to do if ccw stencil test passes and Z test fails */
D3DRS_CCW_STENCILPASS			equ 188   ;/* D3DSTENCILOP to do if both ccw stencil and Z tests pass */
D3DRS_CCW_STENCILFUNC			equ 189   ;/* D3DCMPFUNC fn.  ccw Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true */
D3DRS_COLORWRITEENABLE1			equ 190   ;/* Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS */
D3DRS_COLORWRITEENABLE2			equ 191   ;/* Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS */
D3DRS_COLORWRITEENABLE3			equ 192   ;/* Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS */
D3DRS_BLENDFACTOR			equ 193   ;/* D3DCOLOR used for a constant blend factor during alpha blending for devices that support D3DPBLENDCAPS_BLENDFACTOR */
D3DRS_SRGBWRITEENABLE			equ 194   ;/* Enable rendertarget writes to be DE-linearized to SRGB (for formats that expose D3DUSAGE_QUERY_SRGBWRITE) */
D3DRS_DEPTHBIAS				equ 195
D3DRS_WRAP8				equ 198   ;/* Additional wrap states for vs_3_0+ attributes with D3DDECLUSAGE_TEXCOORD */
D3DRS_WRAP9				equ 199
D3DRS_WRAP10				equ 200
D3DRS_WRAP11				equ 201
D3DRS_WRAP12				equ 202
D3DRS_WRAP13				equ 203
D3DRS_WRAP14				equ 204
D3DRS_WRAP15				equ 205
D3DRS_SEPARATEALPHABLENDENABLE		equ 206  ;/* TRUE to enable a separate blending function for the alpha channel */
D3DRS_SRCBLENDALPHA			equ 207  ;/* SRC blend factor for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE */
D3DRS_DESTBLENDALPHA			equ 208  ;/* DST blend factor for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE */
D3DRS_BLENDOPALPHA			equ 209  ;/* Blending operation for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE */
D3DRS_FORCE_DWORD			equ 07fffffffh

D3DRENDERSTATETYPE	typedef DWORD

;// Maximum number of simultaneous render targets D3D supports
D3D_MAX_SIMULTANEOUS_RENDERTARGETS	equ 4

;// Values for material source
D3DMCS_MATERIAL				equ 0	;// Color from material is used
D3DMCS_COLOR1				equ 1 	;// Diffuse vertex color is used
D3DMCS_COLOR2				equ 2 	;// Specular vertex color is used
D3DMCS_FORCE_DWORD			equ 07fffffffh

D3DMATERIALCOLORSOURCE	typedef DWORD

;// Bias to apply to the texture coordinate set to apply a wrap to.
D3DRENDERSTATE_WRAPBIAS			equ 128

;/* Flags to construct the WRAP render states */
D3DWRAP_U				equ 1h
D3DWRAP_V				equ 2h
D3DWRAP_W				equ 4h

;/* Flags to construct the WRAP render states for 1D thru 4D texture coordinates */
D3DWRAPCOORD_0				equ 1	;// same as D3DWRAP_U
D3DWRAPCOORD_1				equ 2	;// same as D3DWRAP_V
D3DWRAPCOORD_2				equ 4	;// same as D3DWRAP_W
D3DWRAPCOORD_3				equ 8

;/* Flags to construct D3DRS_COLORWRITEENABLE */
D3DCOLORWRITEENABLE_RED			equ (1 shl 0)
D3DCOLORWRITEENABLE_GREEN		equ (1 shl 1)
D3DCOLORWRITEENABLE_BLUE		equ (1 shl 2)
D3DCOLORWRITEENABLE_ALPHA		equ (1 shl 3)

;/*
; * State enumerants for per-stage processing of fixed function pixel processing
; * Two of these affect fixed function vertex processing as well: TEXTURETRANSFORMFLAGS and TEXCOORDINDEX.
; */

D3DTSS_COLOROP				equ 1 ;/* D3DTEXTUREOP - per-stage blending controls for color channels */
D3DTSS_COLORARG1			equ 2 ;/* D3DTA_* (texture arg) */
D3DTSS_COLORARG2			equ 3 ;/* D3DTA_* (texture arg) */
D3DTSS_ALPHAOP				equ 4 ;/* D3DTEXTUREOP - per-stage blending controls for alpha channel */
D3DTSS_ALPHAARG1			equ 5 ;/* D3DTA_* (texture arg) */
D3DTSS_ALPHAARG2			equ 6 ;/* D3DTA_* (texture arg) */
D3DTSS_BUMPENVMAT00			equ 7 ;/* float (bump mapping matrix) */
D3DTSS_BUMPENVMAT01			equ 8 ;/* float (bump mapping matrix) */
D3DTSS_BUMPENVMAT10			equ 9 ;/* float (bump mapping matrix) */
D3DTSS_BUMPENVMAT11			equ 10 ;/* float (bump mapping matrix) */
D3DTSS_TEXCOORDINDEX			equ 11 ;/* identifies which set of texture coordinates index this texture */
D3DTSS_BUMPENVLSCALE			equ 22 ;/* float scale for bump map luminance */
D3DTSS_BUMPENVLOFFSET			equ 23 ;/* float offset for bump map luminance */
D3DTSS_TEXTURETRANSFORMFLAGS		equ 24 ;/* D3DTEXTURETRANSFORMFLAGS controls texture transform */
D3DTSS_COLORARG0			equ 26 ;/* D3DTA_* third arg for triadic ops */
D3DTSS_ALPHAARG0			equ 27 ;/* D3DTA_* third arg for triadic ops */
D3DTSS_RESULTARG			equ 28 ;/* D3DTA_* arg for result (CURRENT or TEMP) */
D3DTSS_CONSTANT				equ 32 ;/* Per-stage constant D3DTA_CONSTANT */
D3DTSS_FORCE_DWORD			equ 07fffffffh ;/* force 32-bit size enum */

D3DTEXTURESTAGESTATETYPE	typedef DWORD

;/*
; * State enumerants for per-sampler texture processing.
; */

D3DSAMP_ADDRESSU			equ 1 ;/* D3DTEXTUREADDRESS for U coordinate */
D3DSAMP_ADDRESSV			equ 2 ;/* D3DTEXTUREADDRESS for V coordinate */
D3DSAMP_ADDRESSW			equ 3 ;/* D3DTEXTUREADDRESS for W coordinate */
D3DSAMP_BORDERCOLOR			equ 4 ;/* D3DCOLOR */
D3DSAMP_MAGFILTER			equ 5 ;/* D3DTEXTUREFILTER filter to use for magnification */
D3DSAMP_MINFILTER			equ 6 ;/* D3DTEXTUREFILTER filter to use for minification */
D3DSAMP_MIPFILTER			equ 7 ;/* D3DTEXTUREFILTER filter to use between mipmaps during minification */
D3DSAMP_MIPMAPLODBIAS			equ 8 ;/* float Mipmap LOD bias */
D3DSAMP_MAXMIPLEVEL			equ 9 ;/* DWORD 0..(n-1) LOD index of largest map to use (0 == largest) */
D3DSAMP_MAXANISOTROPY			equ 10 ;/* DWORD maximum anisotropy */
D3DSAMP_SRGBTEXTURE			equ 11 ;/* Default = 0 (which means Gamma 1.0, no correction required.) else correct for Gamma = 2.2 */
D3DSAMP_ELEMENTINDEX			equ 12 ;/* When multi-element texture is assigned to sampler, this indicates which element index to use.  Default = 0.  */
D3DSAMP_DMAPOFFSET			equ 13 ;/* Offset in vertices in the pre-sampled displacement map. Only valid for D3DDMAPSAMPLER sampler  */
D3DSAMP_FORCE_DWORD			equ 07fffffffh

D3DSAMPLERSTATETYPE		typedef DWORD

;/* Special sampler which is used in the tesselator */
D3DDMAPSAMPLER				equ 256
;// Samplers used in vertex shaders
D3DVERTEXTEXTURESAMPLER0		equ D3DDMAPSAMPLER+1
D3DVERTEXTEXTURESAMPLER1		equ D3DDMAPSAMPLER+2
D3DVERTEXTEXTURESAMPLER2		equ D3DDMAPSAMPLER+3
D3DVERTEXTEXTURESAMPLER3		equ D3DDMAPSAMPLER+4

;// Values, used with D3DTSS_TEXCOORDINDEX, to specify that the vertex data(position
;// and normal in the camera space) should be taken as texture coordinates
;// Low 16 bits are used to specify texture coordinate index, to take the WRAP mode from
D3DTSS_TCI_PASSTHRU			equ 000000h
D3DTSS_TCI_CAMERASPACENORMAL		equ 010000h
D3DTSS_TCI_CAMERASPACEPOSITION		equ 020000h
D3DTSS_TCI_CAMERASPACEREFLECTIONVECTOR	equ 030000h
D3DTSS_TCI_SPHEREMAP			equ 040000h


;/*
; * Enumerations for COLOROP and ALPHAOP texture blending operations set in
; * texture processing stage controls in D3DTSS.
; */

;// Control
D3DTOP_DISABLE				equ 1 ;// disables stage
D3DTOP_SELECTARG1			equ 2 ;// the default
D3DTOP_SELECTARG2			equ 3
;// Modulate
D3DTOP_MODULATE				equ 4 ;// multiply args together
D3DTOP_MODULATE2X			equ 5 ;// multiply and  1 bit
D3DTOP_MODULATE4X			equ 6 ;// multiply and  2 bits
;// Add
D3DTOP_ADD				equ 7 ;// add arguments together
D3DTOP_ADDSIGNED			equ 8 ;// add with -0.5 bias
D3DTOP_ADDSIGNED2X			equ 9 ;// as above but left  1 bit
D3DTOP_SUBTRACT				equ 10 ;// Arg1 - Arg2, with no saturation
D3DTOP_ADDSMOOTH			equ 11 ;// add 2 args, subtract product, Arg1 + Arg2 - Arg1*Arg2 = Arg1 + (1-Arg1)*Arg2
;// Linear alpha blend: Arg1*(Alpha) + Arg2*(1-Alpha)
D3DTOP_BLENDDIFFUSEALPHA		equ 12 ;// iterated alpha
D3DTOP_BLENDTEXTUREALPHA		equ 13 ;// texture alpha
D3DTOP_BLENDFACTORALPHA			equ 14 ;// alpha from D3DRS_TEXTUREFACTOR
;// Linear alpha blend with pre-multiplied arg1 input: Arg1 + Arg2*(1-Alpha)
D3DTOP_BLENDTEXTUREALPHAPM		equ 15 ;// texture alpha
D3DTOP_BLENDCURRENTALPHA		equ 16 ;// by alpha of current color
;// Specular mapping
D3DTOP_PREMODULATE			equ 17 ;// modulate with next texture before use
D3DTOP_MODULATEALPHA_ADDCOLOR		equ 18 ;// Arg1.RGB + Arg1.A*Arg2.RGB COLOROP only
D3DTOP_MODULATECOLOR_ADDALPHA		equ 19 ;// Arg1.RGB*Arg2.RGB + Arg1.A COLOROP only
D3DTOP_MODULATEINVALPHA_ADDCOLOR	equ 20 ;// (1-Arg1.A)*Arg2.RGB + Arg1.RGB COLOROP only
D3DTOP_MODULATEINVCOLOR_ADDALPHA	equ 21 ;// (1-Arg1.RGB)*Arg2.RGB + Arg1.A COLOROP only
;// Bump mapping
D3DTOP_BUMPENVMAP			equ 22 ;// per pixel env map perturbation
D3DTOP_BUMPENVMAPLUMINANCE		equ 23 ;// with luminance channel
;// This can do either diffuse or specular bump mapping with correct input.
;// Performs the function (Arg1.R*Arg2.R + Arg1.G*Arg2.G + Arg1.B*Arg2.B)
;// where each component has been scaled and offset to make it signed.
;// The result is replicated into all four (including alpha) channels.
;// This is a valid COLOROP only.

D3DTOP_DOTPRODUCT3			equ 24
;// Triadic ops
D3DTOP_MULTIPLYADD			equ 25 ;// Arg0 + Arg1*Arg2
D3DTOP_LERP				equ 26 ;// (Arg0)*Arg1 + (1-Arg0)*Arg2
D3DTOP_FORCE_DWORD			equ 07fffffffh

D3DTEXTUREOP		typedef DWORD

;/*
; * Values for COLORARG0,1,2, ALPHAARG0,1,2, and RESULTARG texture blending
; * operations set in texture processing stage controls in D3DRENDERSTATE.
; */

D3DTA_SELECTMASK			equ 00fh ;// mask for arg selector
D3DTA_DIFFUSE				equ 000h ;// select diffuse color (read only)
D3DTA_CURRENT				equ 001h ;// select stage destination register (read/write)
D3DTA_TEXTURE				equ 002h ;// select texture color (read only)
D3DTA_TFACTOR				equ 003h ;// select D3DRS_TEXTUREFACTOR (read only)
D3DTA_SPECULAR				equ 004h ;// select specular color (read only)
D3DTA_TEMP				equ 005h ;// select temporary register color (read/write)
D3DTA_CONSTANT				equ 006h ;// select texture stage constant
D3DTA_COMPLEMENT			equ 010h ;// take 1.0 - x (read modifier)
D3DTA_ALPHAREPLICATE			equ 020h ;// replicate alpha to color components (read modifier)

;// Values for D3DSAMP_***FILTER texture stage states

D3DTEXF_NONE				equ 0 ;// filtering disabled (valid for mip filter only)
D3DTEXF_POINT				equ 1 ;// nearest
D3DTEXF_LINEAR				equ 2 ;// linear interpolation
D3DTEXF_ANISOTROPIC			equ 3 ;// anisotropic
D3DTEXF_PYRAMIDALQUAD			equ 6 ;// 4-sample tent
D3DTEXF_GAUSSIANQUAD			equ 7 ;// 4-sample gaussian
D3DTEXF_FORCE_DWORD			equ 07fffffffh

D3DTEXTUREFILTERTYPE		typedef DWORD

;/* Bits for Flags in ProcessVertices call */
D3DPV_DONOTCOPYDATA			equ (1 shl 0)

;// Flexible vertex format bits
D3DFVF_RESERVED0			equ 00001h
D3DFVF_POSITION_MASK			equ 0400eh
D3DFVF_XYZ				equ 00002h
D3DFVF_XYZRHW				equ 00004h
D3DFVF_XYZB1				equ 00006h
D3DFVF_XYZB2				equ 00008h
D3DFVF_XYZB3				equ 0000ah
D3DFVF_XYZB4				equ 0000ch
D3DFVF_XYZB5				equ 0000eh
D3DFVF_XYZW				equ 04002h

D3DFVF_NORMAL				equ 010h
D3DFVF_PSIZE				equ 020h
D3DFVF_DIFFUSE				equ 040h
D3DFVF_SPECULAR				equ 080h

D3DFVF_TEXCOUNT_MASK			equ 0f00h
D3DFVF_TEXCOUNT_SHIFT			equ 8
D3DFVF_TEX0				equ 0000h
D3DFVF_TEX1				equ 0100h
D3DFVF_TEX2				equ 0200h
D3DFVF_TEX3				equ 0300h
D3DFVF_TEX4				equ 0400h
D3DFVF_TEX5				equ 0500h
D3DFVF_TEX6				equ 0600h
D3DFVF_TEX7				equ 0700h
D3DFVF_TEX8				equ 0800h

D3DFVF_LASTBETA_UBYTE4			equ 01000h
D3DFVF_LASTBETA_D3DCOLOR		equ 08000h

D3DFVF_RESERVED2			equ 06000h ;// 2 reserved bits

;// Vertex Shaders

;// Vertex shader declaration

;// Vertex element semantics

D3DDECLUSAGE_POSITION			equ 0
D3DDECLUSAGE_BLENDWEIGHT		equ 1
D3DDECLUSAGE_BLENDINDICES		equ 2
D3DDECLUSAGE_NORMAL			equ 3
D3DDECLUSAGE_PSIZE			equ 4
D3DDECLUSAGE_TEXCOORD			equ 5
D3DDECLUSAGE_TANGENT			equ 6
D3DDECLUSAGE_BINORMAL			equ 7
D3DDECLUSAGE_TESSFACTOR			equ 8
D3DDECLUSAGE_POSITIONT			equ 9
D3DDECLUSAGE_COLOR			equ 10
D3DDECLUSAGE_FOG			equ 11
D3DDECLUSAGE_DEPTH			equ 12
D3DDECLUSAGE_SAMPLE			equ 13

D3DDECLUSAGE		typedef DWORD

MAXD3DDECLUSAGE				equ D3DDECLUSAGE_SAMPLE
MAXD3DDECLUSAGEINDEX			equ 15
MAXD3DDECLLENGTH			equ 64 ;// does not include "end" marker vertex element

D3DDECLMETHOD_DEFAULT 			equ 0
D3DDECLMETHOD_PARTIALU			equ 1
D3DDECLMETHOD_PARTIALV			equ 2
D3DDECLMETHOD_CROSSUV			equ 3 ;// Normal
D3DDECLMETHOD_UV			equ 4
D3DDECLMETHOD_LOOKUP			equ 5 ;// Lookup a displacement map
D3DDECLMETHOD_LOOKUPPRESAMPLED		equ 6 ;// Lookup a pre-sampled displacement map

D3DDECLMETHOD		typedef DWORD

MAXD3DDECLMETHOD			equ D3DDECLMETHOD_LOOKUPPRESAMPLED

;// Declarations for _Type fields

D3DDECLTYPE_FLOAT1			equ 0 ;// 1D float expanded to (value, 0., 0., 1.)
D3DDECLTYPE_FLOAT2			equ 1 ;// 2D float expanded to (value, value, 0., 1.)
D3DDECLTYPE_FLOAT3			equ 2 ;// 3D float expanded to (value, value, value, 1.)
D3DDECLTYPE_FLOAT4			equ 3 ;// 4D float
D3DDECLTYPE_D3DCOLOR			equ 4 ;// 4D packed unsigned bytes mapped to 0. to 1. range. Input is in D3DCOLOR format (ARGB) expanded to (R, G, B, A)
D3DDECLTYPE_UBYTE4			equ 5 ;// 4D unsigned byte
D3DDECLTYPE_SHORT2			equ 6 ;// 2D signed short expanded to (value, value, 0., 1.)
D3DDECLTYPE_SHORT4			equ 7 ;// 4D signed short

;// The following types are valid only with vertex shaders >= 2.0
D3DDECLTYPE_UBYTE4N			equ 8 ;// Each of 4 bytes is normalized by dividing to 255.0
D3DDECLTYPE_SHORT2N			equ 9 ;// 2D signed short normalized (v[0]/32767.0,v[1]/32767.0,0,1)
D3DDECLTYPE_SHORT4N			equ 10 ;// 4D signed short normalized (v[0]/32767.0,v[1]/32767.0,v[2]/32767.0,v[3]/32767.0)
D3DDECLTYPE_USHORT2N			equ 11 ;// 2D unsigned short normalized (v[0]/65535.0,v[1]/65535.0,0,1)
D3DDECLTYPE_USHORT4N			equ 12 ;// 4D unsigned short normalized (v[0]/65535.0,v[1]/65535.0,v[2]/65535.0,v[3]/65535.0)
D3DDECLTYPE_UDEC3			equ 13 ;// 3D unsigned 10 10 10 format expanded to (value, value, value, 1)
D3DDECLTYPE_DEC3N			equ 14 ;// 3D signed 10 10 10 format normalized and expanded to (v[0]/511.0, v[1]/511.0, v[2]/511.0, 1)
D3DDECLTYPE_FLOAT16_2			equ 15 ;// Two 16-bit floating point values, expanded to (value, value, 0, 1)
D3DDECLTYPE_FLOAT16_4			equ 16 ;// Four 16-bit floating point values
D3DDECLTYPE_UNUSED			equ 17 ;// When the type field in a decl is unused.

D3DDECLTYPE		typedef DWORD

MAXD3DDECLTYPE				equ D3DDECLTYPE_UNUSED

_D3DVERTEXELEMENT9 struct
	Stream 		WORD	?
	dx_Offset	WORD	?
	dx_Type		BYTE	?
	Method		BYTE	?
	Usage		BYTE	?
	UsageIndex	BYTE	?
_D3DVERTEXELEMENT9 ends

D3DVERTEXELEMENT9	typedef _D3DVERTEXELEMENT9
LPD3DVERTEXELEMENT9	typedef PTR _D3DVERTEXELEMENT9

;// This is used to initialize the last vertex element in a vertex declaration
;// array
D3DDECL_END		TEXTEQU <{0ffh,0,D3DDECLTYPE_UNUSED,0,0,0}>
;// Maximum supported number of texture coordinate sets
D3DDP_MAXTEXCOORD	equ 8

;//---------------------------------------------------------------------
;//
;// The internal format of Pixel Shader (PS) & Vertex Shader (VS)
;// Instruction Tokens is defined in the Direct3D Device Driver Kit
;//
;//---------------------------------------------------------------------

;// Instruction Token Bit Definitions

D3DSI_OPCODE_MASK	equ 0000ffffh

D3DSI_INSTLENGTH_MASK	equ 0f000000h
D3DSI_INSTLENGTH_SHIFT	equ 24

D3DSIO_NOP		equ 0
D3DSIO_MOV		equ 1
D3DSIO_ADD		equ 2
D3DSIO_SUB		equ 3
D3DSIO_MAD		equ 4
D3DSIO_MUL		equ 5
D3DSIO_RCP		equ 6
D3DSIO_RSQ		equ 7
D3DSIO_DP3		equ 8
D3DSIO_DP4		equ 9
D3DSIO_MIN		equ 10
D3DSIO_MAX		equ 11
D3DSIO_SLT		equ 12
D3DSIO_SGE		equ 13
D3DSIO_EXP		equ 14
D3DSIO_LOG		equ 15
D3DSIO_LIT		equ 16
D3DSIO_DST		equ 17
D3DSIO_LRP		equ 18
D3DSIO_FRC		equ 19
D3DSIO_M4x4		equ 20
D3DSIO_M4x3		equ 21
D3DSIO_M3x4		equ 22
D3DSIO_M3x3		equ 23
D3DSIO_M3x2		equ 24
D3DSIO_CALL		equ 25
D3DSIO_CALLNZ		equ 26
D3DSIO_LOOP		equ 27
D3DSIO_RET		equ 28
D3DSIO_ENDLOOP		equ 29
D3DSIO_LABEL		equ 30
D3DSIO_DCL		equ 31
D3DSIO_POW		equ 32
D3DSIO_CRS		equ 33
D3DSIO_SGN		equ 34
D3DSIO_ABS		equ 35
D3DSIO_NRM		equ 36
D3DSIO_SINCOS		equ 37
D3DSIO_REP		equ 38
D3DSIO_ENDREP		equ 39
D3DSIO_IF		equ 40
D3DSIO_IFC		equ 41
D3DSIO_ELSE		equ 42
D3DSIO_ENDIF		equ 43
D3DSIO_BREAK		equ 44
D3DSIO_BREAKC		equ 45
D3DSIO_MOVA		equ 46
D3DSIO_DEFB		equ 47
D3DSIO_DEFI		equ 48

D3DSIO_TEXCOORD		equ 64
D3DSIO_TEXKILL		equ 65
D3DSIO_TEX		equ 66
D3DSIO_TEXBEM		equ 67
D3DSIO_TEXBEML		equ 68
D3DSIO_TEXREG2AR	equ 69
D3DSIO_TEXREG2GB	equ 70
D3DSIO_TEXM3x2PAD	equ 71
D3DSIO_TEXM3x2TEX	equ 72
D3DSIO_TEXM3x3PAD	equ 73
D3DSIO_TEXM3x3TEX	equ 74
D3DSIO_RESERVED0	equ 75
D3DSIO_TEXM3x3SPEC	equ 76
D3DSIO_TEXM3x3VSPEC	equ 77
D3DSIO_EXPP		equ 78
D3DSIO_LOGP		equ 79
D3DSIO_CND		equ 80
D3DSIO_DEF		equ 81
D3DSIO_TEXREG2RGB	equ 82
D3DSIO_TEXDP3TEX 	equ 83
D3DSIO_TEXM3x2DEPTH	equ 84
D3DSIO_TEXDP3		equ 85
D3DSIO_TEXM3x3		equ 86
D3DSIO_TEXDEPTH		equ 87
D3DSIO_CMP		equ 88
D3DSIO_BEM		equ 89
D3DSIO_DP2ADD		equ 90
D3DSIO_DSX		equ 91
D3DSIO_DSY		equ 92
D3DSIO_TEXLDD		equ 93
D3DSIO_SETP		equ 94
D3DSIO_TEXLDL		equ 95
D3DSIO_BREAKP		equ 96

D3DSIO_PHASE		equ 0fffdh
D3DSIO_COMMENT		equ 0fffeh
D3DSIO_END		equ 0ffffh

D3DSIO_FORCE_DWORD	equ 07fffffffh

D3DSHADER_INSTRUCTION_OPCODE_TYPE	typedef DWORD

;//---------------------------------------------------------------------
;// Use these constants with D3DSIO_SINCOS macro as SRC2, SRC3
;//
D3DSINCOSCONST1 TEXTEQU <{-1.5500992e-006f,-2.1701389e-005f,0.0026041667f,0.00026041668f}>
D3DSINCOSCONST2 TEXTEQU <{-0.020833334f,-0.12500000f,1.0f,0.50000000f}>

;//---------------------------------------------------------------------
;// Co-Issue Instruction Modifier - if set then this instruction is to be
;// issued in parallel with the previous instruction(s) for which this bit
;// is not set.
D3DSI_COISSUE				equ 040000000h

;// Opcode specific controls
D3DSP_OPCODESPECIFICCONTROL_MASK	equ 000ff0000h
D3DSP_OPCODESPECIFICCONTROL_SHIFT	equ 16

;// ps_2_0 texld controls
D3DSI_TEXLD_PROJECT			equ (1 shl D3DSP_OPCODESPECIFICCONTROL_SHIFT)
D3DSI_TEXLD_BIAS			equ (2 shl D3DSP_OPCODESPECIFICCONTROL_SHIFT)

;// Comparison for dynamic conditional instruction opcodes (i.e. if, breakc)
D3DSPC_RESERVED0	equ 0 ;// 0 0 0
D3DSPC_GT		equ 1 ;// 0 0 1
D3DSPC_EQ		equ 2 ;// 0 1 0
D3DSPC_GE		equ 3 ;// 0 1 1
D3DSPC_LT		equ 4 ;// 1 0 0
D3DSPC_NE		equ 5 ;// 1 0 1
D3DSPC_LE		equ 6 ;// 1 1 0
D3DSPC_RESERVED1	equ 7 ;// 1 1 1

D3DSHADER_COMPARISON	typedef DWORD

;// Comparison is part of instruction opcode token:
D3DSHADER_COMPARISON_SHIFT		equ D3DSP_OPCODESPECIFICCONTROL_SHIFT
D3DSHADER_COMPARISON_MASK		equ (7 shl D3DSHADER_COMPARISON_SHIFT)

;// Predication flags on instruction token
D3DSHADER_INSTRUCTION_PREDICATED	equ (1 shl 28)

;// DCL Info Token Controls

;// For dcl info tokens requiring a semantic (usage + index)
D3DSP_DCL_USAGE_SHIFT		equ 0
D3DSP_DCL_USAGE_MASK		equ 00000000fh

D3DSP_DCL_USAGEINDEX_SHIFT	equ 16
D3DSP_DCL_USAGEINDEX_MASK	equ 0000f0000h

;// DCL pixel shader sampler info token.
D3DSP_TEXTURETYPE_SHIFT		equ 27
D3DSP_TEXTURETYPE_MASK		equ 078000000h

D3DSTT_UNKNOWN			equ (0 shl D3DSP_TEXTURETYPE_SHIFT) ;// uninitialized value
D3DSTT_2D			equ (2 shl D3DSP_TEXTURETYPE_SHIFT) ;// dcl_2d s# (for declaring a 2-D texture)
D3DSTT_CUBE			equ (3 shl D3DSP_TEXTURETYPE_SHIFT) ;// dcl_cube s# (for declaring a cube texture)
D3DSTT_VOLUME			equ (4 shl D3DSP_TEXTURETYPE_SHIFT) ;// dcl_volume s# (for declaring a volume texture)
D3DSTT_FORCE_DWORD		equ 07fffffffh

D3DSAMPLER_TEXTURE_TYPE	typedef DWORD

;// Parameter Token Bit Definitions
D3DSP_REGNUM_MASK		equ 0007FFh

;// destination parameter write mask
D3DSP_WRITEMASK_0		equ 010000h	;// Component 0 (X;Red)
D3DSP_WRITEMASK_1		equ 020000h	;// Component 1 (Y;Green)
D3DSP_WRITEMASK_2		equ 040000h	;// Component 2 (Z;Blue)
D3DSP_WRITEMASK_3		equ 080000h	;// Component 3 (W;Alpha)
D3DSP_WRITEMASK_ALL		equ 0f0000h	;// All Components

;// destination parameter modifiers
D3DSP_DSTMOD_SHIFT		equ 20
D3DSP_DSTMOD_MASK		equ 0f00000h

;// Bit masks for destination parameter modifiers
D3DSPDM_NONE			equ (0 shl D3DSP_DSTMOD_SHIFT) ;// nop
D3DSPDM_SATURATE		equ (1 shl D3DSP_DSTMOD_SHIFT) ;// clamp to 0. to 1. range
D3DSPDM_PARTIALPRECISION	equ (2 shl D3DSP_DSTMOD_SHIFT) ;// Partial precision hint
D3DSPDM_MSAMPCENTROID		equ (4 shl D3DSP_DSTMOD_SHIFT) ;// Relevant to multisampling only:
                                                               ;//      When the pixel center is not covered, sample
                                                               ;//      attribute or compute gradients/LOD
                                                               ;//      using multisample "centroid" location.
                                                               ;//      "Centroid" is some location within the covered
                                                               ;//      region of the pixel.

;// destination parameter 
D3DSP_DSTSHIFT_SHIFT		equ 24
D3DSP_DSTSHIFT_MASK		equ 00f000000h

;// destination/source parameter register type
D3DSP_REGTYPE_SHIFT		equ 28
D3DSP_REGTYPE_SHIFT2		equ  8
D3DSP_REGTYPE_MASK		equ 070000000h
D3DSP_REGTYPE_MASK2		equ 000001800h

D3DSPR_TEMP			equ  0 ;// Temporary Register File
D3DSPR_INPUT			equ  1 ;// Input Register File
D3DSPR_CONST			equ  2 ;// Constant Register File
D3DSPR_ADDR			equ  3 ;// Address Register (VS)
D3DSPR_TEXTURE			equ  3 ;// Texture Register File (PS)
D3DSPR_RASTOUT			equ  4 ;// Rasterizer Register File
D3DSPR_ATTROUT			equ  5 ;// Attribute Output Register File
D3DSPR_TEXCRDOUT		equ  6 ;// Texture Coordinate Output Register File
D3DSPR_OUTPUT			equ  6 ;// Output register file for VS3.0+
D3DSPR_CONSTINT			equ  7 ;// Constant Integer Vector Register File
D3DSPR_COLOROUT			equ  8 ;// Color Output Register File
D3DSPR_DEPTHOUT			equ  9 ;// Depth Output Register File
D3DSPR_SAMPLER			equ 10 ;// Sampler State Register File
D3DSPR_CONST2			equ 11 ;// Constant Register File  2048 - 4095
D3DSPR_CONST3			equ 12 ;// Constant Register File  4096 - 6143
D3DSPR_CONST4			equ 13 ;// Constant Register File  6144 - 8191
D3DSPR_CONSTBOOL		equ 14 ;// Constant Boolean register file
D3DSPR_LOOP			equ 15 ;// Loop counter register file
D3DSPR_TEMPFLOAT16		equ 16 ;// 16-bit float temp register file
D3DSPR_MISCTYPE			equ 17 ;// Miscellaneous (single) registers.
D3DSPR_LABEL			equ 18 ;// Label
D3DSPR_PREDICATE		equ 19 ;// Predicate register
D3DSPR_FORCE_DWORD		equ 07fffffffh

D3DSHADER_PARAM_REGISTER_TYPE	typedef	DWORD

;// The miscellaneous register file (D3DSPR_MISCTYPES)
;// contains register types for which there is only ever one
;// register (i.e. the register # is not needed).
;// Rather than use up additional register types for such
;// registers, they are defined
;// as particular offsets into the misc. register file:
D3DSMO_POSITION			equ 0 ;// Input position x,y,z,rhw (PS)
D3DSMO_FACE			equ 1 ;// Floating point primitive area (PS)

D3DSHADER_MISCTYPE_OFFSETS	typedef	DWORD

;// Register offsets in the Rasterizer Register File
D3DSRO_POSITION			equ 0
D3DSRO_FOG			equ 1
D3DSRO_POINT_SIZE		equ 2
D3DSRO_FORCE_DWORD		equ 07fffffffh

D3DVS_RASTOUT_OFFSETS	typedef	DWORD

;// Source operand addressing modes
D3DVS_ADDRESSMODE_SHIFT 	equ 13
D3DVS_ADDRESSMODE_MASK		equ (1 shl D3DVS_ADDRESSMODE_SHIFT)

D3DVS_ADDRMODE_ABSOLUTE		equ (0 shl D3DVS_ADDRESSMODE_SHIFT)
D3DVS_ADDRMODE_RELATIVE		equ (1 shl D3DVS_ADDRESSMODE_SHIFT)
D3DVS_ADDRMODE_FORCE_DWORD 	equ 07fffffffh

D3DVS_ADDRESSMODE_TYPE	typedef	DWORD

D3DSHADER_ADDRESSMODE_SHIFT	equ 13
D3DSHADER_ADDRESSMODE_MASK	equ (1 shl D3DSHADER_ADDRESSMODE_SHIFT)

D3DSHADER_ADDRMODE_ABSOLUTE	equ (0 shl D3DSHADER_ADDRESSMODE_SHIFT)
D3DSHADER_ADDRMODE_RELATIVE	equ (1 shl D3DSHADER_ADDRESSMODE_SHIFT)
D3DSHADER_ADDRMODE_FORCE_DWORD	equ 07fffffffh

D3DSHADER_ADDRESSMODE_TYPE	typedef	DWORD

;// Source operand swizzle definitions
D3DVS_SWIZZLE_SHIFT		equ 16
D3DVS_SWIZZLE_MASK		equ 0ff0000h
;X
D3DVS_X_X			equ (0 shl D3DVS_SWIZZLE_SHIFT)
D3DVS_X_Y			equ (1 shl D3DVS_SWIZZLE_SHIFT)
D3DVS_X_Z			equ (2 shl D3DVS_SWIZZLE_SHIFT)
D3DVS_X_W			equ (3 shl D3DVS_SWIZZLE_SHIFT)
;Y
D3DVS_Y_X			equ (0 shl (D3DVS_SWIZZLE_SHIFT + 2))
D3DVS_Y_Y			equ (1 shl (D3DVS_SWIZZLE_SHIFT + 2))
D3DVS_Y_Z			equ (2 shl (D3DVS_SWIZZLE_SHIFT + 2))
D3DVS_Y_W			equ (3 shl (D3DVS_SWIZZLE_SHIFT + 2))
;Z
D3DVS_Z_X			equ (0 shl (D3DVS_SWIZZLE_SHIFT + 4))
D3DVS_Z_Y			equ (1 shl (D3DVS_SWIZZLE_SHIFT + 4))
D3DVS_Z_Z			equ (2 shl (D3DVS_SWIZZLE_SHIFT + 4))
D3DVS_Z_W			equ (3 shl (D3DVS_SWIZZLE_SHIFT + 4))
;W
D3DVS_W_X			equ (0 shl (D3DVS_SWIZZLE_SHIFT + 6))
D3DVS_W_Y			equ (1 shl (D3DVS_SWIZZLE_SHIFT + 6))
D3DVS_W_Z			equ (2 shl (D3DVS_SWIZZLE_SHIFT + 6))
D3DVS_W_W			equ (3 shl (D3DVS_SWIZZLE_SHIFT + 6))

;// Value when there is no swizzle (X is taken from X, Y is taken from Y,
;// Z is taken from Z, W is taken from W
D3DVS_NOSWIZZLE 		equ (D3DVS_X_X or D3DVS_Y_Y or D3DVS_Z_Z or D3DVS_W_W)

;// source parameter swizzle
D3DSP_SWIZZLE_SHIFT		equ 16
D3DSP_SWIZZLE_MASK		equ 0ff0000h

D3DSP_NOSWIZZLE			equ ((0 shl (D3DSP_SWIZZLE_SHIFT + 0)) or \
				     (1 shl (D3DSP_SWIZZLE_SHIFT + 2)) or \
				     (2 shl (D3DSP_SWIZZLE_SHIFT + 4)) or \
				     (3 shl (D3DSP_SWIZZLE_SHIFT + 6)))
;// pixel-shader swizzle ops
D3DSP_REPLICATERED		equ ((0 shl (D3DSP_SWIZZLE_SHIFT + 0)) or \
				     (0 shl (D3DSP_SWIZZLE_SHIFT + 2)) or \
				     (0 shl (D3DSP_SWIZZLE_SHIFT + 4)) or \
				     (0 shl (D3DSP_SWIZZLE_SHIFT + 6)))

D3DSP_REPLICATEGREEN		equ ((1 shl (D3DSP_SWIZZLE_SHIFT + 0)) or \
				     (1 shl (D3DSP_SWIZZLE_SHIFT + 2)) or \
				     (1 shl (D3DSP_SWIZZLE_SHIFT + 4)) or \
				     (1 shl (D3DSP_SWIZZLE_SHIFT + 6)))

D3DSP_REPLICATEBLUE		equ ((2 shl (D3DSP_SWIZZLE_SHIFT + 0)) or \
				     (2 shl (D3DSP_SWIZZLE_SHIFT + 2)) or \
				     (2 shl (D3DSP_SWIZZLE_SHIFT + 4)) or \
				     (2 shl (D3DSP_SWIZZLE_SHIFT + 6)))

D3DSP_REPLICATEALPHA		equ ((3 shl (D3DSP_SWIZZLE_SHIFT + 0)) or \
				     (3 shl (D3DSP_SWIZZLE_SHIFT + 2)) or \
				     (3 shl (D3DSP_SWIZZLE_SHIFT + 4)) or \
				     (3 shl (D3DSP_SWIZZLE_SHIFT + 6)))

D3DSP_SRCMOD_SHIFT		equ 24
D3DSP_SRCMOD_MASK		equ 0f000000h

D3DSPSM_NONE		equ (0 shl D3DSP_SRCMOD_SHIFT) ;// nop
D3DSPSM_NEG		equ (1 shl D3DSP_SRCMOD_SHIFT) ;// negate
D3DSPSM_BIAS		equ (2 shl D3DSP_SRCMOD_SHIFT) ;// bias
D3DSPSM_BIASNEG		equ (3 shl D3DSP_SRCMOD_SHIFT) ;// bias and negate
D3DSPSM_SIGN		equ (4 shl D3DSP_SRCMOD_SHIFT) ;// sign
D3DSPSM_SIGNNEG		equ (5 shl D3DSP_SRCMOD_SHIFT) ;// sign and negate
D3DSPSM_COMP		equ (6 shl D3DSP_SRCMOD_SHIFT) ;// complement
D3DSPSM_X2		equ (7 shl D3DSP_SRCMOD_SHIFT) ;// *2
D3DSPSM_X2NEG		equ (8 shl D3DSP_SRCMOD_SHIFT) ;// *2 and negate
D3DSPSM_DZ		equ (9 shl D3DSP_SRCMOD_SHIFT) ;// divide through by z component
D3DSPSM_DW		equ (10 shl D3DSP_SRCMOD_SHIFT) ;// divide through by w component
D3DSPSM_ABS		equ (11 shl D3DSP_SRCMOD_SHIFT) ;// abs()
D3DSPSM_ABSNEG		equ (12 shl D3DSP_SRCMOD_SHIFT) ;// -abs()
D3DSPSM_NOT		equ (13 shl D3DSP_SRCMOD_SHIFT) ;// for predicate register: "!p0"
D3DSPSM_FORCE_DWORD	equ 07fffffffh

D3DSHADER_PARAM_SRCMOD_TYPE	typedef DWORD

;// pixel shader version token
D3DPS_VERSION MACRO _Major:REQ, _Minor:REQ
	EXITM %(0ffff0000h or ((_Major) shl 8) or (_Minor))
ENDM

;// vertex shader version token
D3DVS_VERSION MACRO _Major:REQ, _Minor:REQ
	EXITM %(0fffe0000h or ((_Major) shl 8) or (_Minor))
ENDM

;// extract major/minor from version cap
D3DSHADER_VERSION_MAJOR MACRO _Version:REQ
	EXITM %((_Version shr 8) and 0ffh)
ENDM

D3DSHADER_VERSION_MINOR MACRO _Version:REQ 
	EXITM %(_Version and 0ffh)
ENDM

;// destination/source parameter register type
D3DSI_COMMENTSIZE_SHIFT		equ 16
D3DSI_COMMENTSIZE_MASK		equ 07fff0000h

D3DSHADER_COMMENT MACRO _DWordSize:REQ
	EXITM %((((_DWordSize) shl D3DSI_COMMENTSIZE_SHIFT) and D3DSI_COMMENTSIZE_MASK) or D3DSIO_COMMENT)
ENDM

;// pixel/vertex shader end token
D3DPS_END			equ 0ffffh
D3DVS_END			equ 0ffffh

;// High order surfaces
D3DBASIS_BEZIER			equ 0
D3DBASIS_BSPLINE		equ 1
D3DBASIS_CATMULL_ROM		equ 2 ;/* In D3D8 this used to be D3DBASIS_INTERPOLATE */
D3DBASIS_FORCE_DWORD		equ 07fffffffh

D3DBASISTYPE		typedef	DWORD

D3DDEGREE_LINEAR		equ 1
D3DDEGREE_QUADRATIC		equ 2
D3DDEGREE_CUBIC			equ 3
D3DDEGREE_QUINTIC		equ 5
D3DDEGREE_FORCE_DWORD		equ 07fffffffh

D3DDEGREETYPE		typedef	DWORD

D3DPATCHEDGE_DISCRETE		equ 0
D3DPATCHEDGE_CONTINUOUS		equ 1
D3DPATCHEDGE_FORCE_DWORD	equ 07fffffffh

D3DPATCHEDGESTYLE	typedef	DWORD

D3DSBT_ALL			equ 1 ;// capture all state
D3DSBT_PIXELSTATE		equ 2 ;// capture pixel state
D3DSBT_VERTEXSTATE		equ 3 ;// capture vertex state
D3DSBT_FORCE_DWORD		equ 07fffffffh

D3DSTATEBLOCKTYPE	typedef	DWORD

;// The D3DVERTEXBLENDFLAGS type is used with D3DRS_VERTEXBLEND state.
D3DVBF_DISABLE			equ 0 ;// Disable vertex blending
D3DVBF_1WEIGHTS			equ 1 ;// 2 matrix blending
D3DVBF_2WEIGHTS			equ 2 ;// 3 matrix blending
D3DVBF_3WEIGHTS			equ 3 ;// 4 matrix blending
D3DVBF_TWEENING			equ 255 ;// blending using D3DRS_TWEENFACTOR
D3DVBF_0WEIGHTS			equ 256 ;// one matrix is used with weight 1.0
D3DVBF_FORCE_DWORD		equ 0x7fffffffh

D3DVERTEXBLENDFLAGS	typedef	DWORD

D3DTTFF_DISABLE			equ 0 ;// texture coordinates are passed directly
D3DTTFF_COUNT1			equ 1 ;// rasterizer should expect 1-D texture coords
D3DTTFF_COUNT2			equ 2 ;// rasterizer should expect 2-D texture coords
D3DTTFF_COUNT3			equ 3 ;// rasterizer should expect 3-D texture coords
D3DTTFF_COUNT4			equ 4 ;// rasterizer should expect 4-D texture coords
D3DTTFF_PROJECTED		equ 256 ;// texcoords to be divided by COUNTth element
D3DTTFF_FORCE_DWORD		equ 07fffffffh

D3DTEXTURETRANSFORMFLAGS	typedef	DWORD

;// Macros to set texture coordinate format bits in the FVF id
D3DFVF_TEXTUREFORMAT2		equ 0 ;// Two floating point values
D3DFVF_TEXTUREFORMAT1		equ 3 ;// One floating point value
D3DFVF_TEXTUREFORMAT3		equ 1 ;// Three floating point values
D3DFVF_TEXTUREFORMAT4		equ 2 ;// Four floating point values

D3DFVF_TEXCOORDSIZE3 MACRO CoordIndex:REQ
	EXITM %(D3DFVF_TEXTUREFORMAT3 shl (CoordIndex*2 + 16))
ENDM

D3DFVF_TEXCOORDSIZE2 		equ D3DFVF_TEXTUREFORMAT2

D3DFVF_TEXCOORDSIZE4 MACRO CoordIndex:REQ 
	EXITM %(D3DFVF_TEXTUREFORMAT4 shl (CoordIndex*2 + 16))
ENDM

D3DFVF_TEXCOORDSIZE1 MACRO CoordIndex:REQ
	EXITM %(D3DFVF_TEXTUREFORMAT1 shl (CoordIndex*2 + 16))
ENDM


;/* Direct3D9 Device types */
D3DDEVTYPE_HAL			equ 1
D3DDEVTYPE_REF			equ 2
D3DDEVTYPE_SW			equ 3
D3DDEVTYPE_FORCE_DWORD		equ 07fffffffh

D3DDEVTYPE			typedef	DWORD

;/* Multi-Sample buffer types */
D3DMULTISAMPLE_NONE		equ 0
D3DMULTISAMPLE_NONMASKABLE	equ 1
D3DMULTISAMPLE_2_SAMPLES	equ 2
D3DMULTISAMPLE_3_SAMPLES	equ 3
D3DMULTISAMPLE_4_SAMPLES	equ 4
D3DMULTISAMPLE_5_SAMPLES	equ 5
D3DMULTISAMPLE_6_SAMPLES	equ 6
D3DMULTISAMPLE_7_SAMPLES	equ 7
D3DMULTISAMPLE_8_SAMPLES	equ 8
D3DMULTISAMPLE_9_SAMPLES	equ 9
D3DMULTISAMPLE_10_SAMPLES	equ 10
D3DMULTISAMPLE_11_SAMPLES	equ 11
D3DMULTISAMPLE_12_SAMPLES	equ 12
D3DMULTISAMPLE_13_SAMPLES	equ 13
D3DMULTISAMPLE_14_SAMPLES	equ 14
D3DMULTISAMPLE_15_SAMPLES	equ 15
D3DMULTISAMPLE_16_SAMPLES	equ 16
D3DMULTISAMPLE_FORCE_DWORD	equ 07fffffffh

D3DMULTISAMPLE_TYPE		typedef	DWORD

;/* Formats
; * Most of these names have the following convention:
; *      A = Alpha
; *      R = Red
; *      G = Green
; *      B = Blue
; *      X = Unused Bits
; *      P = Palette
; *      L = Luminance
; *      U = dU coordinate for BumpMap
; *      V = dV coordinate for BumpMap
; *      S = Stencil
; *      D = Depth (e.g. Z or W buffer)
; *      C = Computed from other channels (typically on certain read operations)
; *
; *      Further, the order of the pieces are from MSB first; hence
; *      D3DFMT_A8L8 indicates that the high byte of this two byte
; *      format is alpha.
; *
; *      D16 indicates:
; *           - An integer 16-bit value.
; *           - An app-lockable surface.
; *
; *      All Depth/Stencil formats except D3DFMT_D16_LOCKABLE indicate:
; *          - no particular bit ordering per pixel, and
; *          - are not app lockable, and
; *          - the driver is allowed to consume more than the indicated
; *            number of bits per Depth channel (but not Stencil channel).
; */

MAKEFOURCC MACRO ch0:REQ, ch1:REQ, ch2:REQ, ch3:REQ
	EXITM %(ch0 or (ch1 shl 8) or (ch2 shl 16) or (ch3 shl 24))
ENDM

D3DFMT_UNKNOWN			equ 0

D3DFMT_R8G8B8			equ 20
D3DFMT_A8R8G8B8			equ 21
D3DFMT_X8R8G8B8			equ 22
D3DFMT_R5G6B5			equ 23
D3DFMT_X1R5G5B5			equ 24
D3DFMT_A1R5G5B5			equ 25
D3DFMT_A4R4G4B4			equ 26
D3DFMT_R3G3B2			equ 27
D3DFMT_A8			equ 28
D3DFMT_A8R3G3B2			equ 29
D3DFMT_X4R4G4B4			equ 30
D3DFMT_A2B10G10R10		equ 31
D3DFMT_A8B8G8R8			equ 32
D3DFMT_X8B8G8R8			equ 33
D3DFMT_G16R16			equ 34
D3DFMT_A2R10G10B10		equ 35
D3DFMT_A16B16G16R16		equ 36

D3DFMT_A8P8			equ 40
D3DFMT_P8			equ 41

D3DFMT_L8			equ 50
D3DFMT_A8L8			equ 51
D3DFMT_A4L4			equ 52

D3DFMT_V8U8			equ 60
D3DFMT_L6V5U5			equ 61
D3DFMT_X8L8V8U8			equ 62
D3DFMT_Q8W8V8U8			equ 63
D3DFMT_V16U16			equ 64
D3DFMT_A2W10V10U10		equ 67

D3DFMT_UYVY			TEXTEQU MAKEFOURCC('U', 'Y', 'V', 'Y')
D3DFMT_R8G8_B8G8		TEXTEQU MAKEFOURCC('R', 'G', 'B', 'G')
D3DFMT_YUY2			TEXTEQU MAKEFOURCC('Y', 'U', 'Y', '2')
D3DFMT_G8R8_G8B8		TEXTEQU MAKEFOURCC('G', 'R', 'G', 'B')
D3DFMT_DXT1			TEXTEQU MAKEFOURCC('D', 'X', 'T', '1')
D3DFMT_DXT2			TEXTEQU MAKEFOURCC('D', 'X', 'T', '2')
D3DFMT_DXT3			TEXTEQU MAKEFOURCC('D', 'X', 'T', '3')
D3DFMT_DXT4			TEXTEQU MAKEFOURCC('D', 'X', 'T', '4')
D3DFMT_DXT5			TEXTEQU MAKEFOURCC('D', 'X', 'T', '5')

D3DFMT_D16_LOCKABLE		equ 70
D3DFMT_D32			equ 71
D3DFMT_D15S1			equ 73
D3DFMT_D24S8			equ 75
D3DFMT_D24X8			equ 77
D3DFMT_D24X4S4			equ 79
D3DFMT_D16			equ 80

D3DFMT_D32F_LOCKABLE		equ 82
D3DFMT_D24FS8			equ 83

D3DFMT_L16			equ 81

D3DFMT_VERTEXDATA		equ 100
D3DFMT_INDEX16			equ 101
D3DFMT_INDEX32			equ 102

D3DFMT_Q16W16V16U16		equ 110

D3DFMT_MULTI2_ARGB8		TEXTEQU MAKEFOURCC('M','E','T','1')

;// Floating point surface formats

;// s10e5 formats (16-bits per channel)

D3DFMT_R16F			equ 111
D3DFMT_G16R16F			equ 112
D3DFMT_A16B16G16R16F		equ 113

;// IEEE s23e8 formats (32-bits per channel)
D3DFMT_R32F			equ 114
D3DFMT_G32R32F			equ 115
D3DFMT_A32B32G32R32F		equ 116

D3DFMT_CxV8U8			equ 117

D3DFMT_FORCE_DWORD		equ 07fffffffh

D3DFORMAT		typedef	DWORD

;/* Display Modes */
_D3DDISPLAYMODE struct
	dx_Width	UINT ?
	dx_Height	UINT ?
	RefreshRate	UINT ?
	Format		D3DFORMAT ?
_D3DDISPLAYMODE ends

D3DDISPLAYMODE	typedef _D3DDISPLAYMODE

;/* Creation Parameters */
_D3DDEVICE_CREATION_PARAMETERS struct
	AdapterOrdinal	UINT ?
	DeviceType	D3DDEVTYPE ?
	hFocusWindow	HWND ?
	BehaviorFlags	DWORD ?
_D3DDEVICE_CREATION_PARAMETERS ends

D3DDEVICE_CREATION_PARAMETERS	typedef _D3DDEVICE_CREATION_PARAMETERS

;/* SwapEffects */
D3DSWAPEFFECT_DISCARD		equ 1
D3DSWAPEFFECT_FLIP		equ 2
D3DSWAPEFFECT_COPY		equ 3
D3DSWAPEFFECT_FORCE_DWORD	equ 07fffffffh

D3DSWAPEFFECT		typedef	DWORD

;/* Pool types */
D3DPOOL_DEFAULT			equ 0
D3DPOOL_MANAGED			equ 1
D3DPOOL_SYSTEMMEM		equ 2
D3DPOOL_SCRATCH			equ 3
D3DPOOL_FORCE_DWORD		equ 07fffffffh

D3DPOOL			typedef	DWORD

;/* RefreshRate pre-defines */
D3DPRESENT_RATE_DEFAULT		equ 0

;/* Resize Optional Parameters */
_D3DPRESENT_PARAMETERS struct
	BackBufferWidth			UINT ?
	BackBufferHeight		UINT ?
	BackBufferFormat		D3DFORMAT ?
	BackBufferCount			UINT ?

	MultiSampleType			D3DMULTISAMPLE_TYPE ?
	MultiSampleQuality		DWORD ?

	SwapEffect			D3DSWAPEFFECT ?
	hDeviceWindow			HWND ?
	Windowed			BOOL ?
	EnableAutoDepthStencil		BOOL ?
	AutoDepthStencilFormat		D3DFORMAT ?
	Flags				DWORD ?

;/* FullScreen_RefreshRateInHz must be zero for Windowed mode */
	FullScreen_RefreshRateInHz	UINT ?
	PresentationInterval		UINT ?
_D3DPRESENT_PARAMETERS ends

D3DPRESENT_PARAMETERS	typedef _D3DPRESENT_PARAMETERS

;// Values for D3DPRESENT_PARAMETERS.Flags
D3DPRESENTFLAG_LOCKABLE_BACKBUFFER	equ 1
D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL	equ 2
D3DPRESENTFLAG_DEVICECLIP		equ 4
D3DPRESENTFLAG_VIDEO			equ 010h

;/* Gamma Ramp: Same as DX7 */
_D3DGAMMARAMP struct
	red	WORD	256 dup(?)
	green	WORD	256 dup(?)
	blue	WORD	256 dup(?)
_D3DGAMMARAMP ends

D3DGAMMARAMP		typedef _D3DGAMMARAMP

;/* Back buffer types */
D3DBACKBUFFER_TYPE_MONO		equ 0
D3DBACKBUFFER_TYPE_LEFT		equ 1
D3DBACKBUFFER_TYPE_RIGHT	equ 2
D3DBACKBUFFER_TYPE_FORCE_DWORD	equ 07fffffffh

D3DBACKBUFFER_TYPE	typedef DWORD

;/* Types */
D3DRTYPE_SURFACE		equ 1
D3DRTYPE_VOLUME			equ 2
D3DRTYPE_TEXTURE		equ 3
D3DRTYPE_VOLUMETEXTURE		equ 4
D3DRTYPE_CUBETEXTURE		equ 5
D3DRTYPE_VERTEXBUFFER		equ 6
D3DRTYPE_INDEXBUFFER		equ 7
D3DRTYPE_FORCE_DWORD            equ 07fffffffh

D3DRESOURCETYPE	typedef DWORD

;/* Usages */
D3DUSAGE_RENDERTARGET		equ 1
D3DUSAGE_DEPTHSTENCIL		equ 2
D3DUSAGE_DYNAMIC		equ 0200h

;// When passed to CheckDeviceFormat, D3DUSAGE_AUTOGENMIPMAP may return
;// D3DOK_NOAUTOGEN if the device doesn't support autogeneration for that format.
;// D3DOK_NOAUTOGEN is a success code, not a failure code... the SUCCEEDED and FAILED macros
;// will return true and false respectively for this code.
D3DUSAGE_AUTOGENMIPMAP		equ 00400h
D3DUSAGE_DMAP			equ 04000h

;// The following usages are valid only for querying CheckDeviceFormat
D3DUSAGE_QUERY_LEGACYBUMPMAP		equ 0008000h
D3DUSAGE_QUERY_SRGBREAD			equ 0010000h
D3DUSAGE_QUERY_FILTER			equ 0020000h
D3DUSAGE_QUERY_SRGBWRITE		equ 0040000h
D3DUSAGE_QUERY_POSTPIXELSHADER_BLENDING	equ 0080000h
D3DUSAGE_QUERY_VERTEXTEXTURE		equ 0100000h

;/* Usages for Vertex/Index buffers */
D3DUSAGE_WRITEONLY		equ 0008h
D3DUSAGE_SOFTWAREPROCESSING	equ 0010h
D3DUSAGE_DONOTCLIP		equ 0020h
D3DUSAGE_POINTS			equ 0040h
D3DUSAGE_RTPATCHES		equ 0080h
D3DUSAGE_NPATCHES		equ 0100h

;/* CubeMap Face identifiers */
D3DCUBEMAP_FACE_POSITIVE_X	equ 0
D3DCUBEMAP_FACE_NEGATIVE_X	equ 1
D3DCUBEMAP_FACE_POSITIVE_Y	equ 2
D3DCUBEMAP_FACE_NEGATIVE_Y	equ 3
D3DCUBEMAP_FACE_POSITIVE_Z	equ 4
D3DCUBEMAP_FACE_NEGATIVE_Z	equ 5
D3DCUBEMAP_FACE_FORCE_DWORD	equ 07fffffffh

D3DCUBEMAP_FACES	typedef	DWORD

;/* Lock flags */
D3DLOCK_READONLY		equ 00010h
D3DLOCK_DISCARD			equ 02000h
D3DLOCK_NOOVERWRITE		equ 01000h
D3DLOCK_NOSYSLOCK		equ 00800h
D3DLOCK_DONOTWAIT		equ 04000h

D3DLOCK_NO_DIRTY_UPDATE		equ 08000h

;/* Vertex Buffer Description */
_D3DVERTEXBUFFER_DESC struct
	Format		D3DFORMAT ?
	dx_Type		D3DRESOURCETYPE	?
	Usage		DWORD	?
	Pool		D3DPOOL	?
	dx_Size		UINT	?
	FVF		DWORD	?
_D3DVERTEXBUFFER_DESC ends

D3DVERTEXBUFFER_DESC	typedef	_D3DVERTEXBUFFER_DESC

;/* Index Buffer Description */
_D3DINDEXBUFFER_DESC struct
	Format		D3DFORMAT ?
	dx_Type		D3DRESOURCETYPE	?
	Usage		DWORD	?
	Pool		D3DPOOL	?
	dx_Size		UINT	?
_D3DINDEXBUFFER_DESC ends

D3DINDEXBUFFER_DESC	typedef	_D3DINDEXBUFFER_DESC

;/* Surface Description */
_D3DSURFACE_DESC struct
	Format			D3DFORMAT ?
	dx_Type			D3DRESOURCETYPE	?
	Usage			DWORD	?
	Pool			D3DPOOL	?
	MultiSampleType		D3DMULTISAMPLE_TYPE ?
	MultiSampleQuality	DWORD	?
	dx_Width		UINT	?
	dx_Height		UINT	?
_D3DSURFACE_DESC ends

D3DSURFACE_DESC	typedef	_D3DSURFACE_DESC

_D3DVOLUME_DESC struct
	Format		D3DFORMAT ?
	dx_Type		D3DRESOURCETYPE	?
	Usage		DWORD	?
	Pool		D3DPOOL	?
	dx_Width	UINT	?
	dx_Height	UINT	?
	Depth		UINT	?
_D3DVOLUME_DESC ends

D3DVOLUME_DESC	typedef	_D3DVOLUME_DESC

;/* Structure for LockRect */
_D3DLOCKED_RECT struct
	Pitch	DWORD	?
	pBits	DWORD	?
_D3DLOCKED_RECT ends

D3DLOCKED_RECT	typedef	_D3DLOCKED_RECT

_D3DBOX struct
	Left	UINT ?
	Top	UINT ?
	Right	UINT ?
	Bottom	UINT ?
	Front	UINT ?
	Back	UINT ?
_D3DBOX ends

D3DBOX		typedef	_D3DBOX

_D3DLOCKED_BOX struct
	RowPitch	DWORD ?
	SlicePitch	DWORD ?
	pBits		DWORD ?
_D3DLOCKED_BOX ends

D3DLOCKED_BOX	typedef	_D3DLOCKED_BOX

;/* Structures for LockRange */
_D3DRANGE struct
	dx_Offset	UINT ?
	dx_Size		UINT ?
_D3DRANGE ends

D3DRANGE	typedef	_D3DRANGE

;/* Structures for high order primitives */
_D3DRECTPATCH_INFO struct
	StartVertexOffsetWidth	UINT ?
	StartVertexOffsetHeight	UINT ?
	dx_Width		UINT ?
	dx_Height		UINT ?
	Stride			UINT ?
	Basis			D3DBASISTYPE ?
	Degree			D3DDEGREETYPE ?
_D3DRECTPATCH_INFO ends

D3DRECTPATCH_INFO	typedef	_D3DRECTPATCH_INFO

_D3DTRIPATCH_INFO struct
	StartVertexOffset	UINT ?
	NumVerticies		UINT ?
	Basis			D3DBASISTYPE ?
	Degree			D3DDEGREETYPE ?
_D3DTRIPATCH_INFO ends

D3DTRIPATCH_INFO	typedef	_D3DTRIPATCH_INFO

;/* Adapter Identifier */
MAX_DEVICE_IDENTIFIER_STRING	equ 512


_D3DADAPTER_IDENTIFIER9 struct
	Driver			BYTE	MAX_DEVICE_IDENTIFIER_STRING dup(?)
	Description		BYTE	MAX_DEVICE_IDENTIFIER_STRING dup(?)
	DeviceName		BYTE	32 dup(?)
	DriverVersion		QWORD	?
	VendorId		DWORD	?
	DeviceId		DWORD	?
	SubSysId		DWORD	?
	Revision		DWORD	?
	DeviceIdentifier	GUID	<?>
	WHQLLevel		DWORD	?
_D3DADAPTER_IDENTIFIER9 ends

D3DADAPTER_IDENTIFIER9	typedef	_D3DADAPTER_IDENTIFIER9

;/* Raster Status structure returned by GetRasterStatus */
_D3DRASTER_STATUS struct
	InVBlank	BOOL	?
	ScanLine	UINT	?
_D3DRASTER_STATUS ends

D3DRASTER_STATUS	typedef	_D3DRASTER_STATUS

;/* Debug monitor tokens (DEBUG only)
;
;   Note that if D3DRS_DEBUGMONITORTOKEN is set, the call is treated as
;   passing a token to the debug monitor.  For example, if, after passing
;   D3DDMT_ENABLE/DISABLE to D3DRS_DEBUGMONITORTOKEN other token values
;   are passed in, the enabled/disabled state of the debug
;   monitor will still persist.
;
;   The debug monitor defaults to enabled.
;
;   Calling GetRenderState on D3DRS_DEBUGMONITORTOKEN is not of any use.
;*/

D3DDMT_ENABLE		equ 0 ;// enable debug monitor
D3DDMT_DISABLE		equ 1 ;// disable debug monitor
D3DDMT_FORCE_DWORD	equ 07fffffffh

D3DDEBUGMONITORTOKENS	typedef	DWORD

;// Async feedback
D3DQUERYTYPE_VCACHE			equ 4 ;/* D3DISSUE_END */
D3DQUERYTYPE_RESOURCEMANAGER		equ 5 ;/* D3DISSUE_END */
D3DQUERYTYPE_VERTEXSTATS		equ 6 ;/* D3DISSUE_END */
D3DQUERYTYPE_EVENT			equ 8 ;/* D3DISSUE_END */
D3DQUERYTYPE_OCCLUSION			equ 9 ;/* D3DISSUE_BEGIN, D3DISSUE_END */

D3DQUERYTYPE		typedef	DWORD

;// Flags field for Issue
D3DISSUE_END		equ (1 shl 0) ;// Tells the runtime to issue the end of a query, changing it's state to "non-signaled".
D3DISSUE_BEGIN		equ (1 shl 1) ;// Tells the runtime to issue the beginng of a query.

;// Flags field for GetData
D3DGETDATA_FLUSH	equ (1 shl 0) ;// Tells the runtime to flush if the query is outstanding.

_D3DRESOURCESTATS struct
;// Data collected since last Present()
	bThrashing		DWORD	? ;/* indicates if thrashing */
	ApproxBytesDownloaded	DWORD	? ;/* Approximate number of bytes downloaded by resource manager */
	NumEvicts		DWORD	? ;/* number of objects evicted */
	NumVidCreated		DWORD	? ;/* number of objects created in video memory */
	LastPri			DWORD	? ;/* priority of last object evicted */
	NumUsed			DWORD	? ;/* number of objects set to the device */
	NumUsedInVidMem		DWORD	? ;/* number of objects set to the device, which are already in video memory */
;// Persistent data
	WorkingSet		DWORD	? ;/* number of objects in video memory */
	WorkingSetBytes		DWORD	? ;/* number of bytes in video memory */
	TotalManaged		DWORD	? ;/* total number of managed objects */
	TotalBytes		DWORD	? ;/* total number of bytes of managed objects */
_D3DRESOURCESTATS ends

D3DRESOURCESTATS	typedef	_D3DRESOURCESTATS

D3DRTYPECOUNT		equ D3DRTYPE_INDEXBUFFER + 1

_D3DDEVINFO_RESOURCEMANAGER	struct
	stats	D3DRESOURCESTATS	D3DRTYPECOUNT dup(<?>)		
_D3DDEVINFO_RESOURCEMANAGER ends

D3DDEVINFO_RESOURCEMANAGER	typedef _D3DDEVINFO_RESOURCEMANAGER 
LPD3DDEVINFO_RESOURCEMANAGER	typedef PTR _D3DDEVINFO_RESOURCEMANAGER

_D3DDEVINFO_D3DVERTEXSTATS struct
	NumRenderedTriangles		DWORD	? ;/* total number of triangles that are not clipped in this frame */
	NumExtraClippingTriangles	DWORD	? ;/* Number of new triangles generated by clipping */
_D3DDEVINFO_D3DVERTEXSTATS ends

D3DDEVINFO_D3DVERTEXSTATS	typedef _D3DDEVINFO_D3DVERTEXSTATS
LPD3DDEVINFO_D3DVERTEXSTATS	typedef PTR _D3DDEVINFO_D3DVERTEXSTATS

_D3DDEVINFO_VCACHE struct
	Pattern		DWORD	? ;/* bit pattern, return value must be FOUR_CC(‘C’, ‘A’, ‘C’, ‘H’) */
	OptMethod	DWORD	? ;/* optimization method 0 means longest strips, 1 means vertex cache based */
	CacheSize	DWORD	? ;/* cache size to optimize for  (only required if type is 1) */
	MagicNumber	DWORD	? ;/* used to determine when to restart strips (only required if type is 1)*/
_D3DDEVINFO_VCACHE ends

D3DDEVINFO_VCACHE	typedef _D3DDEVINFO_VCACHE
LPD3DDEVINFO_VCACHE	typedef PTR _D3DDEVINFO_VCACHE

endif ;/* (DIRECT3D_VERSION >= 0x0900) */
endif ;/* _d3d9TYPES(P)_H_ */
