const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float rand(float2 r) // fast random
{
    return frac(sin(dot(r.xy ,float2(12.9898,78.233))) * 43758.5453);
}

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
	float3 col = rand(fragCoord.xy * 0.001 * iTime);
    return float4(col,1.0);
}