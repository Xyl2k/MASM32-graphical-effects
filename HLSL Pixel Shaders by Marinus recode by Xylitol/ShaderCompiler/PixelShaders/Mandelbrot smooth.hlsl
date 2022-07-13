//Mandelbrot - smooth
// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

//https://www.shadertoy.com/view/4df3Rn

// See here for more information on smooth iteration count:
//
// http://iquilezles.org/www/articles/mset_smooth/mset_smooth.htm

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds


// increase this if you have a very fast GPU
#define AA 2

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float3 col = 0.0; //float3(0.0,0.0,0.0);
    
#if AA>1
    for( int m=0; m<AA; m++ )
    for( int n=0; n<AA; n++ )
    {
        float2 p = (-iResolution.xy + 2.0*(fragCoord.xy+float2(float(m),float(n))/float(AA)))/iResolution.y;

        float w = float(AA*m+n);
        float time = iTime + 0.5*(1.0/24.0)*w/float(AA*AA);
#else    
        float2 p = (-iResolution.xy + 2.0*fragCoord.xy)/iResolution.y;
        float time = iTime;
#endif
   
        float zoo = 0.62 + 0.38*cos(.07*time);
        float coa = cos( 0.15*(1.0-zoo)*time );
        float sia = sin( 0.15*(1.0-zoo)*time );
        zoo = pow( zoo,8.0);
        float2 xy = float2( p.x*coa-p.y*sia, p.x*sia+p.y*coa);
        float2 c = float2(-.745,.186) + xy*zoo;

        const float B = 256.0;
        float l = 0.0;
        float2 z  = 0.0; //float2(0.0,0.0);
        for( int i=0; i<200; i++ )
        {
            // z = z*z + c      
            z = float2( z.x*z.x - z.y*z.y, 2.0*z.x*z.y ) + c;
        
            if( dot(z,z)>(B*B) ) break;

            l += 1.0;
        }

        // ------------------------------------------------------
        // smooth interation count
        //float sl = l - log(log(length(z))/log(B))/log(2.0);
        
        // equivalent optimized smooth interation count
        float sl = l - log2(log2(dot(z,z))) + 4.0; 
        // ------------------------------------------------------
    
        float al = 1.0; //smoothstep( -0.1, 0.0, sin(0.5*6.2831*iTime ) );
        l = lerp( l, sl, al );

        col += 0.5 + 0.5*cos( 3.0 + l*0.15 + float3(0.0,0.6,1.0));
#if AA>1
    }
    col /= float(AA*AA);
#endif

    return float4( col, 1.0 );
}