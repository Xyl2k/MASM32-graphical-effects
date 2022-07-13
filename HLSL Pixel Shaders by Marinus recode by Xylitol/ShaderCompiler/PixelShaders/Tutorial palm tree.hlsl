// Created by inigo quilez - iq/2014
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
// https://www.shadertoy.com/view/XssSRX

// The final product of some live coding improv. The process is live narrated in this video:
// https://www.youtube.com/watch?v=0ifChJ0nJfM

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 p = fragCoord.xy / iResolution.xy; // 0.0 <> 1.0
    p.y = 1.0 - p.y; // flip the viewport y coord, glsl to hlsl

    float2 q = p - float2(0.33,0.7);
        
    float3 col = lerp( float3(1.0,0.3,0.0), float3(1.0,0.8,0.3), sqrt(p.y) );
    
    float r = 0.2 + 0.1*cos( atan2(q.y,q.x)*10.0 + 20.0*q.x + 1.0);
    col *= smoothstep( r, r+0.01, length( q ) );

    r = 0.015;
    r += 0.002*sin(120.0*q.y);
    r += exp(-40.0*p.y);
    col *= 1.0 - (1.0-smoothstep(r,r+0.002, abs(q.x-0.25*sin(2.0*q.y))))*(1.0-smoothstep(0.0,0.1,q.y));

    return float4(col,1.0); // return the pixel color ( == fragColor in GLSL )
}
