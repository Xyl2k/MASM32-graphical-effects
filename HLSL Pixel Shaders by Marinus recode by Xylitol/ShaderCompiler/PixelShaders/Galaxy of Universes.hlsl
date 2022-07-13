//Galaxy of Universes
//https://www.shadertoy.com/view/MdXSzS

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{

    float2 uv = (fragCoord.xy / iResolution.xy) - .5;

    float t = iTime * .1 + ((.25 + .05 * sin(iTime * .1))/(length(uv.xy) + .07)) * 2.2;
    float si = sin(t);
    float co = cos(t);
    float2x2 ma = {co, si, -si, co};

    float v1, v2, v3;
    v1 = v2 = v3 = 0.0;
    
    float s = 0.0;
    for (int i = 0; i < 90; i++)
    {
        float3 p = s * float3(uv, 0.0);
        p.xy = mul(p.xy, ma);       

        p += float3(.22, .3, s - 1.5 - sin(iTime * .13) * .1);
        for (int i = 0; i < 8; i++) p = abs(p) / dot(p,p) - 0.659;
        v1 += dot(p,p) * .0015 * (1.8 + sin(length(uv.xy * 13.0) + .5  - iTime * .2));
        v2 += dot(p,p) * .0013 * (1.5 + sin(length(uv.xy * 14.5) + 1.2 - iTime * .3));
        v3 += length(p.xy*10.) * .0003;
        s  += .035;
    }
    
    float len = length(uv);
    v1 *= smoothstep(.7, .0, len);
    v2 *= smoothstep(.5, .0, len);
    v3 *= smoothstep(.9, .0, len);
    
    float3 col = float3( v3 * (1.5 + sin(iTime * .2) * .4),
                    (v1 + v3) * .3,
                     v2) + smoothstep(0.2, .0, len) * .85 + smoothstep(.0, .6, v3) * .3;

    return float4(min(pow(abs(col), float3(1.2,1.2,1.2)), 1.0), 1.0);
}
