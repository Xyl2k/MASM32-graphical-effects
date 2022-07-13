
const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds
#define  cdimTeja 64.0
#define  deg2rad  0.01745329251994329576923690768489

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (uv.x,uv.y) location. This is only valid with ps_3_0.
{
    float2 uv = fragCoord.xy / iResolution.xy; // now "uv" contains the normalized viewport uv.x,uv.y resolution ( 0.0 <> 1.0 )
    float2 cc = fragCoord.xy;
    float2 rr = iResolution.xy;
    float2 kk;
    float3 color = 0;
    kk.x = rr.x/2.*cos(iTime*deg2rad) - rr.y/4.*sin(iTime*deg2rad);
    kk.y = rr.x/2.*sin(iTime*deg2rad) + rr.y/4.*cos(iTime*deg2rad);
    color.b = ((((cc.x-kk.x)*(cc.x-kk.x)+(cc.y+kk.y)*(cc.y+kk.y))/(abs(cc.y)+1))%cdimTeja)/cdimTeja;
    // color.b = ((((cc.x-rr.x/2)*(cc.x-rr.x/2)+(cc.y+rr.y/2)*(cc.y+rr.y/2))/(abs(cc.y)+1))%cdimTeja)/cdimTeja;
    return float4(color,1.0);  // -> (r,g,b),a
}
