// "ShaderToy Tutorial - CameraSystem" 
// https://www.shadertoy.com/view/4dfBRf
// by Martijn Steinrucken aka BigWings/CountFrolic - 2017
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
//
// This shader is part of my ongoing tutorial series on how to ShaderToy
// For an explanation go here: 
// https://www.youtube.com/watch?v=PBxuVlp7nuM

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float DistLine(float3 ro, float3 rd, float3 p) {
    return length(cross(p-ro, rd))/length(rd);
}

float DrawPoint(float3 ro, float3 rd, float3 p) {
    float d = DistLine(ro, rd, p);
    d = smoothstep(.06, .05, d);
    return d;
}


float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 uv = fragCoord.xy / iResolution.xy; // 0 <> 1
    uv.y = 1.0 - uv.y; // flip the viewport y coords, glsl to hlsl

    uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    float t = iTime;
    
    float3 ro = float3(3.0*sin(t), 2.0, -3.0*cos(t));
    
    float3 lookat = float3(0.5,0.5,0.5);
    
    float zoom = 1.0;
    
    float3 f = normalize(lookat-ro);
    float3 r = cross(float3(0.0, 1.0, 0.0), f);
    float3 u = cross(f, r);
    
    float3 c = ro + f*zoom;
    float3 i = c + uv.x*r + uv.y*u;
    float3 rd = i-ro;
        
    float d = 0.;
    
    d += DrawPoint(ro, rd, float3(0.0, 0.0, 0.0));
    d += DrawPoint(ro, rd, float3(0.0, 0.0, 1.0));
    d += DrawPoint(ro, rd, float3(0.0, 1.0, 0.0));
    d += DrawPoint(ro, rd, float3(0.0, 1.0, 1.0));
    d += DrawPoint(ro, rd, float3(1.0, 0.0, 0.0));
    d += DrawPoint(ro, rd, float3(1.0, 0.0, 1.0));
    d += DrawPoint(ro, rd, float3(1.0, 1.0, 0.0));
    d += DrawPoint(ro, rd, float3(1.0, 1.0, 1.0));
    
    return float4(d,d,d,1.0);
}


