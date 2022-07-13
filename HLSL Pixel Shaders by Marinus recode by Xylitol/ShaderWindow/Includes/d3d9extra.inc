; d3d9extra library includes by Siekmanski. ( I will comment the usage of the routines later )
.const

D3DFVF_IMAGEVERTEX          equ (D3DFVF_XYZRHW or D3DFVF_TEX1) ; Vertex format includes the position of a transformed vertex and will be displayed as 2D.

IMAGEVERTEX struct
   position         D3DVECTOR4 <?>  ; X,Y,Z,W   (W is the reciprocal homogeneous W (RHW) and is always 1.0)
   tu               real4 ?         ; texture x coordinate  (values are from 0.0 to 1.0)
   tv               real4 ?         ; texture y coordinate  (values are from 0.0 to 1.0)
IMAGEVERTEX ends

WINDOWCOORDINATES struct            ; do not change the order of the members!
    TopLeftX        dd ?            ; in pixels
    TopLeftY        dd ?            ; in pixels
    WindowWidth     dd ?            ; in pixels ( automatically stretched if needed )
    WindowHeight    dd ?            ; in pixels ( automatically stretched if needed )
    DepthPos        real4 ?         ; 1.0 = max. depth position, 0.0 = min. depth position ( 16 bit range, 65536 steps, 1 step = 0.0000152587890625 )   
WINDOWCOORDINATES ends

WINDOWSCROLL struct ; infinite scrolling background
    Texture         LPDIRECT3DTEXTURE9 ?
    VertexBuffer    LPDIRECT3DVERTEXBUFFER9 ?
    WindowPosition  WINDOWCOORDINATES <?>
    ScrollField     dd ?            ; in pixels, range of the background image presented on the screen
    Direction       dd ?            ; choose a direction: SCROLL_HORIZONTAL or SCROLL_VERTICAL
    ScrollPosA      real4 ?         ; variable for scroll position A, the distance between A and B is the range presented on the screen
    ScrollPosB      real4 ?         ; variable for scroll position B
WINDOWSCROLL ends

SCROLL_HORIZONTAL           equ 0
SCROLL_VERTICAL             equ 1

CreateImageVertexQuad       PROTO   :DWORD,:DWORD

InitD3DDrawText             PROTO   :DWORD
D3DDrawText                 PROTO   :DWORD,:REAL4,:REAL4,:REAL4,:DWORD,:DWORD
D3DStartTextMode            PROTO   :DWORD
D3DEndTextMode              PROTO   :DWORD
ReleaseD3DDrawText          PROTO

D3DLoadImage                PROTO   :DWORD,:DWORD,:DWORD,:DWORD

InitD3DWindowScroller       PROTO   :DWORD,:DWORD,:DWORD,:DWORD
D3DWindowScroller           PROTO   :DWORD,:REAL4,:DWORD
ReleaseD3DWindowScroller    PROTO   :DWORD

InitTimers                  PROTO   :DWORD,:DWORD
UpdateTimers                PROTO


MEDIATIMERS struct  ; don't change the order of the members!
    Timer1          real4 ?
    Timer2          real4 ?
    Timer3          real4 ?
    Timer4          real4 ?
    Timer5          real4 ?
    Timer6          real4 ?
    Timer7          real4 ?
    Timer8          real4 ?
    Timer9          real4 ?
    Timer10         real4 ?
    Timer11         real4 ?
    Timer12         real4 ?
    Timer13         real4 ?
    Timer14         real4 ?
    Timer15         real4 ?
    TotalTime       real4 ?
    TimeElapsed     real8 ?
    FramesPerSecond real8 ?
    FrameTimeDelta  real4 ?
MEDIATIMERS ends

ENABLE_PRINT_FPS    equ 1


MONO                        equ 1
STEREO                      equ 2
DSADAPTER_DEFAULT           equ NULL

InitDSoundFormat            PROTO   :DWORD,:DWORD,:DWORD,:DWORD
CreateDSound9Playback       PROTO   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
DSLoadWavFromFile           PROTO   :DWORD,:DWORD,:DWORD,:DWORD