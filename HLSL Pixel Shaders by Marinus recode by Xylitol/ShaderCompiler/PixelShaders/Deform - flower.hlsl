// Deform - flower
// https://www.shadertoy.com/view/4dX3Rn
// Created by inigo quilez - iq/2013

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 p = (2.0*fragCoord-iResolution.xy)/min(iResolution.y,iResolution.x);
    float a = atan2(p.x,p.y);
    float r = length(p)*(0.8+0.2*sin(0.3*iTime));

    float w = cos(2.0*iTime-r*2.0);
    float h = 0.5+0.5*cos(12.0*a-w*7.0+r*8.0+ 0.7*iTime);
    float d = 0.25+0.75*pow(h,1.0*r)*(0.7+0.3*w);

    float f = sqrt(1.0-r/d)*r*2.5;
    f *= 1.25+0.25*cos((12.0*a-w*7.0+r*8.0)/2.0);
    f *= 1.0 - 0.35*(0.5+0.5*sin(r*30.0))*(0.5+0.5*cos(12.0*a-w*7.0+r*8.0));
    
    float3 col = { f, f-h*0.5+r*0.2 + 0.35*h*(1.0-r), f-h*r + 0.1*h*(1.0-r) };
    col = saturate( col );

    float3 bcol = lerp( 0.5*float3(0.8,0.9,1.0), float3(1.0,1.0,1.0), 0.5+0.5*p.y);
    col = lerp( col, bcol, smoothstep(-0.3,0.6,r-d) );
    
    return float4( col, 1.0 );
}



