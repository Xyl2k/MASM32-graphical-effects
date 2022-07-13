const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float r(float2 n)
{
    return frac(cos(dot(n,float2(36.26,73.12)))*354.63);
}
float noise(float2 n)
{
    float2 fn = floor(n);
    float2 sn = smoothstep(float2(0.0,0.0),float2(1.0,1.0),frac(n));
    float h1 = lerp(r(fn),r(fn+float2(1.0,0.0)),sn.x);
    float h2 = lerp(r(fn+float2(0.0,1.0)),r(fn+float2(1.0,1.0)),sn.x);
    return lerp(h1,h2,sn.y);
}

float value(float2 n)
{
    return noise(n/32.0)*0.5875+noise(n/16.0)*0.2+noise(n/8.0)*0.1+noise(n/4.0)*0.05+noise(n/2.0)*0.025+noise(n)*0.0125;
}

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float pn = value(iTime*16.0+fragCoord.xy/4.0);
    return float4(pn,pn,pn,1.0);
}