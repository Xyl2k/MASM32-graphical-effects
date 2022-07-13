/*
To change the "scroll restart" edit the "4.0" value line 548:
_ST(a - fmod(iTime, a * 4.0), -0.7, 0.15)_S _H _A _D _E _R

No long scroller, or it will take a while to compile.
*/

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w

static float2 uv;
static float3 col = float3(0.0f,0.0f,0.0f);
static float3 fill = float3(0.0f,0.0f,0.0f);
static float width = 0.01;
static float3 color = float3(0.0f,0.0f,0.0f);
static float cx = 0.0;
static float cy = 0.0;
static float cs = 0.0;

#define _ST(x, y, s) cx = x; cy = y; cs = s;
#define _ADV cx += cs * (3.0 / 5.0) * 1.1;
#define _LET(let) let(cx, cy, cs); _ADV
#define _A _LET(A)
#define _B _LET(B)
#define _C _LET(C)
#define _D _LET(D)
#define _E _LET(E)
#define _F _LET(F)
#define _G _LET(G)
#define _H _LET(H)
#define _I _LET(I)
#define _J _LET(J)
#define _K _LET(K)
#define _L _LET(L)
#define _M _LET(M)
#define _N _LET(N)
#define _O _LET(O)
#define _P _LET(P)
#define _Q _LET(Q)
#define _R _LET(R)
#define _S _LET(S)
#define _T _LET(T)
#define _U _LET(U)
#define _V _LET(V)
#define _W _LET(W)
#define _X _LET(X)
#define _Y _LET(Y)
#define _Z _LET(Z)
#define _SP _ADV

void rect(float x, float y, float w, float h)
{
    if(uv.x >= x && uv.x <= x + w && uv.y >= y && uv.y <= y + h)
        if(!(uv.x >= x + width && uv.x <= x + w - width && uv.y >= y + width && uv.y <= y + h - width))
            color = col;
        else
            color = fill;
}

void A(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
}

void B(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
}

void C(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
}

void D(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
}

void E(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
}

void F(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void G(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
}

void H(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void I(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 1.0, y + d * 1.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 1.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
}


void J(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
}

void K(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void L(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
}

void M(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 1.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
}

void N(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
}

void O(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
}

void P(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
}

void Q(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
}

void R(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void S(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void T(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 1.0, y + d * 1.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 1.0, y + d * 3.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void U(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void V(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void W(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 2.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void X(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 2.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void Y(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 3.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
    rect(x + d * 1.0, y + d * 1.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
}

void Z(float x, float y, float s)
{
    float size = 5.0;
    float w = s / size;
    float d = w - width;
    rect(x + d * 0.0, y + d * 0.0, w, w);
    rect(x + d * 1.0, y + d * 0.0, w, w);
    rect(x + d * 2.0, y + d * 0.0, w, w);
    rect(x + d * 0.0, y + d * 1.0, w, w);
    rect(x + d * 1.0, y + d * 2.0, w, w);
    rect(x + d * 2.0, y + d * 3.0, w, w);
    rect(x + d * 2.0, y + d * 4.0, w, w);
    rect(x + d * 1.0, y + d * 4.0, w, w);
    rect(x + d * 0.0, y + d * 4.0, w, w);
}

#define PI  3.14159265359
#define PI2 6.28318530718

#define COLOR1 float3(0.9, 0.9, 0.9)
#define COLOR2 float3(0.03, 0.03, 0.03)
#define LIGHTCOLOR  float3(0.94, 0.95, 1.)

#define ARMS 10.
#define DENSITY 2.
#define ANGLE_SPEED 2.
#define ANGLE_TEMPO 3.
#define SPEED 2.
#define SMOOTH 0.02

//Mostly taken from: https://www.shadertoy.com/view/WtVGDw
float smoothstepCheckerboard(in float2 uv) 
{
    uv = frac(uv + 0.25);
    float sm2 = SMOOTH * 0.5;
    float2 p01 = smoothstep(0.25 - sm2, 0.25 + sm2, uv) - smoothstep(0.75 - sm2, 0.75 + sm2, uv);
    float2 pn11 = (p01 - 0.5) * 2.;
    return 0.5 - 0.5 * pn11.x * pn11.y;
}

//Mostly taken from: https://www.shadertoy.com/view/WtVGDw
void checkerboardTunnel()
{
    float a = atan2(uv.x, uv.y);
    float r = length(uv);
    float w = a - sin(1. / r) * r * ANGLE_SPEED * sin((iTime - 1./r) / ANGLE_TEMPO);
    float2 polar = float2(w * ARMS / PI2, 1. / r * DENSITY + iTime * SPEED );
    float3 checker = lerp(COLOR1, COLOR2,smoothstepCheckerboard(polar));
    float light = smoothstep(0.7, 0.2, r);
    color = lerp(checker, LIGHTCOLOR, light);
    color = pow(color, float3(1./2.2, 1./2.2, 1./2.2));
}

float4 ps_main(float2 fragCoord:vpos):color
{
    fragCoord.y = iResolution.y - fragCoord.y;
    uv = (2. * fragCoord - iResolution.xy) / min(iResolution.x, iResolution.y);

    uv = float2(int2(uv * iResolution.xy * 0.15)) / (iResolution.xy * 0.15);
    checkerboardTunnel();
    uv = (2. * fragCoord - iResolution.xy) / min(iResolution.x, iResolution.y);
    col = color * 0.4;
    fill = lerp(color, float3(1.0, uv.yx),  0.9);
    width = 0.0125;
    _ST(-0.7, 0.1 + sin(iTime * 4.0) * 0.03, 0.75)_X _Y _L
    
    float a = iResolution.x/iResolution.y;
    fill = color * 0.2;
    width = 0.03;
    rect(-a * 2.0, -0.8, a * 4.0, 0.35);
    
    col = float3(0.0f,0.0f,0.0f);
    fill = float3(1.0f,1.0f,1.0f);
    fill = float3(sin(iTime * 3.0) * 0.5 + 1.2, sin(-iTime * 3.0) * 0.5 + 1.2, cos(iTime * 3.0) * 0.5 + 1.2); //Colorful play text
    width = 0.0;
    _ST(a - fmod(iTime, a * 4.0), -0.7, 0.15)_S _H _A _D _E _R _SP _T _E _M _P _L _A _T _E _SP _B _Y _SP _X _Y _L _I _T _O _L
    
    color = color * (1.0 - pow(length(uv), 3.0) * 0.1);
    
    return float4(color, 1.0f);
}