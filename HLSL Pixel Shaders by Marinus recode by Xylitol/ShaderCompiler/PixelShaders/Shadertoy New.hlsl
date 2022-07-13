// Shadertoy "New" example -> https://www.shadertoy.com/new

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 uv = fragCoord.xy / iResolution.xy;  // now "uv" contains the normalized viewport x,y resolution ( 0.0 <> 1.0 )
    uv.y = 1.0-uv.y;    // flip the y coord if you convert WebGL or GLSL shaders to HLSL shaders. 

    return float4(uv,0.5+0.5*sin(iTime),1.0);  // -> r,g,b,a
}
