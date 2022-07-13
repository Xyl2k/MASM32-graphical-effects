// David Hoskins.
// https://www.shadertoy.com/view/Md2GDy


const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

static float gTime;

float3 Fractal(float2 uv)
{
    float2 p = gTime * ((iResolution.xy-uv)/iResolution.y) - gTime * 0.5 + 0.363 - (smoothstep(0.05, 1.5, gTime)*float2(.5, .365));
    p.y=-p.y; // flip the y viewport coords, glsl to hlsl
    float2 z = p;
    float g = 4.0, f = 4.0;

    for( int i = 0; i < 90; i++ ) 
    {
        float w = float(i)*22.4231+iTime*2.0;
        float2 z1 = float2(2.*cos(w),2.*sin(w));           
        z = float2( z.x*z.x-z.y*z.y, 2.0 *z.x*z.y ) + p;
        g = min( g, dot(z-z1,z-z1));
        f = min( f, dot(z,z) );
    }
    g =  min(pow(max(1.0-g, 0.0), .15), 1.0);
    // Eye colours...
    float3 col = lerp(float3(g,g,g), float3(.3, .5, .1), smoothstep(.89, .91, g));
    col = lerp(col, float3(.0,.0,.0), smoothstep(.98, .99, g));
    float c = abs(log(f)/25.0);
    col = lerp(col, float3(f*.03, c*.4, c ), 1.0-g);
    return saturate(col);
}

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    gTime = pow(abs((.57+cos(iTime*.2)*.55)), 3.0);

    float expand = smoothstep(1.2, 1.6, gTime)*32.0+.5;
    // Anti-aliasing...
    float3 col = 0.0;
    for (float y = 0.; y < 2.; y++)
    {
        for (float x = 0.; x < 2.; x++)
        {
            col += Fractal(fragCoord.xy + float2(x, y) * expand);
        }
    }
    return float4(sqrt(col/4.0), 1.0);
}
