// basic HLSL example

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

// "ps_main" is called for every pixel, starting with the pixel located at the left-top position ( origin of the screen ).
// "fragCoord" contains the x,y screen view-port position for the pixel to draw.

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{

    // Normalize the viewport XY resolution to 1.0 both horizontal and vertical.
    float2 uv = fragCoord.xy / iResolution.xy; // now "uv" contains the normalized viewport x,y resolution ( 0.0 <> 1.0 )

    // paint the screen from blue to purple, using uv.x or uv.y positions as the value to calculate the red part of the gradient.

//  return float4(uv.x,0.0,1.0,1.0);  // -> r,g,b,a from left to right
    return float4(uv.y,0.0,1.0,1.0);  // -> r,g,b,a from top to bottom
}



