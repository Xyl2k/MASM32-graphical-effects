// Eye Candy by Siekmanski

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 uv = fragCoord.xy / iResolution.xy; // now "uv" contains the normalized viewport x,y resolution ( 0.0 <> 1.0 )

    float3 color = 0.0;

    color.xy = 0.5 - uv; // center of the screen.

    float time = iTime * 1.5; // speed of animation
    float num = atan2(color.x,color.y) * 5.0; // number of wavy arms.
    float pos = cos(num + sin(time * 0.1)) + 0.5 + sin(uv.x * 10.0 + time * 1.3) * 0.333; // get the position

    // do some wavy coloring stuff on the color channels.
    color.r = 1.2 + cos(num - time * 0.3) + sin(uv.y * 10.0 + time * 1.5) * 0.5;
    color.gb = float2( sin(pos * 4.0) * 0.35, sin(pos + pos) * 0.3 ) + color.r * 0.5;

    // add some specular lighting
    color *= float3(1.0, 0.7, 0.5) * pow(max(normalize(float3(length(ddx(color)), length(ddy(color)), 0.5/iResolution.y)).z, 0.0), 2.0) + 0.333;

    return float4(color,1.0);
}
