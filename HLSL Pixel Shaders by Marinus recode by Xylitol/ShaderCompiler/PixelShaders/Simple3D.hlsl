// "ShaderToy Tutorial - Simplest 3D"
// https://www.shadertoy.com/view/XdsfW8
// by Martijn Steinrucken aka BigWings/CountFrolic - 2017
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
//
// This shader is part of my ongoing tutorial series on how to ShaderToy
// For an explanation go here: 
// https://www.youtube.com/watch?v=dKA5ZVALOhs

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float DistLine(float3 ro, float3 rd, float3 p) {
    return length(cross(p-ro, rd))/length(rd);
}

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 uv = fragCoord.xy / iResolution.xy; // 0 <> 1
    uv.y = 1.0 - uv.y; // flip the viewport y coords, glsl to hlsl

    uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    
    float3 ro = float3(0.0, 0.0, -1.0);
    float3 rd = float3(uv.x, uv.y, 0.0)-ro;
    
    float t = iTime;
    float3 p = float3(sin(t), 0.0, 1.0+cos(t));
    float d = DistLine(ro, rd, p);
    
    d = smoothstep(0.1, 0.09, d);
    
    return float4(d,d,d,1.0);
}

