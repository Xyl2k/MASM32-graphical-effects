// basic HLSL example

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 uv = fragCoord.xy / iResolution.xy; // now "uv" contains the normalized viewport x,y resolution ( 0.0 <> 1.0 )

    float3 color = 0.0; // is the same as: float3 color = float3(0.0,0.0,0.0); // black background color (rgb)

    // Paint the right half of the screen blue or purple, origin of the screen is at the left-top position
    if(uv.x > 0.5)
    {
        color.b = 1.0; // set the blue color component to 1.0

        if(uv.y > 0.5)
        {
            color.r = 1.0; // set the red color component to 1.0
            // color.b is is already set, so the color will be purple.
        }
    }

    return float4(color,1.0);  // -> (r,g,b),a
}



