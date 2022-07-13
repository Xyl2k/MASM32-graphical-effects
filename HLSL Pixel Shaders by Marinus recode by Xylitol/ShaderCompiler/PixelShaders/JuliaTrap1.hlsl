// Created by inigo quilez - iq/2014
// https://www.shadertoy.com/view/4d23WG

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 z = 1.15*(-iResolution.xy+2.0*fragCoord.xy)/iResolution.y;
    float2 an = 0.51*cos( float2(0.0,1.5708) + 0.1*iTime ) - 0.25*cos( float2(0.0,1.5708) + 0.2*iTime );
    an.y=-an.y; // flip the y viewport coords, glsl to hlsl
    float f = 1e20;
    for( int i=0; i<128; i++ ) 
    {
        z = float2( z.x*z.x-z.y*z.y, 2.0*z.x*z.y ) + an;
        f = min( f, dot(z,z) );
    }

    f = 1.0+log(f)/16.0;

    return float4(f,f*f,f*f*f,1.0);  // -> r,g,b,a
}
