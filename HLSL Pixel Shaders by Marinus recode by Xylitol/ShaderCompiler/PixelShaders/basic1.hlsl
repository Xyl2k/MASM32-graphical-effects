// basic HLSL example

// Painting all pixels blue, starting at the left-top of the screen to the right-bottom of the screen.

// "ps_main" is called for every pixel starting with the pixel located at 0.0, 0.0
// "fragCoord" contains the actual x,y screen position for the pixel to draw.

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    // return the pixel color
    return float4(0.0,0.0,1.0,1.0);  // -> r,g,b,a
}
