// by Nikos Papadopoulos, 4rknova / 2016
// https://www.shadertoy.com/view/4tdGWX

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds


#define SPECULAR

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float4 col = 0.0;

    float2 a = float2(iResolution.x /iResolution.y, 1.0);
    float2 c = fragCoord.xy / iResolution.xy * a * 4. + iTime * .3;
    c=1.0-c;

    float k = .1 + cos(c.y + sin(.148 - iTime)) + 2.4 * iTime;
    float w = .9 + sin(c.x + cos(.628 + iTime)) - 0.7 * iTime;
    float d = length(c);
    float s = 7. * cos(d+w) * sin(k+w);
    
    col = float4(.5 + .5 * cos(s + float3(.2, .5, .9)), 1.0);
    col *= float4(1, .7, .4, 1.0) * pow(max(normalize(float3(length(ddx(col)), length(ddy(col)), .5/iResolution.y)).z, 0.), 2.) + .75; 

    return col;
}

