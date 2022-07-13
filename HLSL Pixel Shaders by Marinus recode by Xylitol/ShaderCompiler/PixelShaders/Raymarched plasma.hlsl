//Raymarched plasma
//https://www.shadertoy.com/view/ldSfzm

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float m(float3 p) 
{ 
    p.z+=5.*iTime; // time
    return length(.2*sin(p.x-p.y)+cos(p/3.))-.8;
}


float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float3 d=.5-float3(fragCoord,0)/iResolution.x,o=d;
    for(int i=0;i<64;i++) o+=m(o)*d;
    return float4( abs(m(o+d)*float3(.3,.15,.1)+m(o*.5)*float3(.1,.05,0))*(8.-o.x/2.),1.0 );
}

