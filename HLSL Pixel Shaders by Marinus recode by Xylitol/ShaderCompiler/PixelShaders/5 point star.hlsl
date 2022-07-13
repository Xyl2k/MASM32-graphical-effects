// 5 point star

// https://www.shadertoy.com/view/lsccR8

// The MIT License
// Copyright © 2018 Inigo Quilez
// An antialiased 5 point 2d star. Not an euclidean distance field in its interior nor exterior.

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

#define  mod(x,y) (x-y*floor(x/y))  // HLSL mod macro ( mod intrinsic is only available in GLSL )

static const float kPi = 3.1415927;    
static const float2 k1 = float2(0.809016994375, -0.587785252292); // pi/5
static const float2 k2 = float2(-k1.x,k1.y);
static const float2 k3 = float2(0.951056516295,  0.309016994375); // pi/10

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    // coords
    float px = 2.0/iResolution.y;
    float2 q = (2.0*fragCoord-iResolution.xy)/iResolution.y;

    // rotate
    float2x2 m = {cos(iTime*0.2),sin(iTime*0.2),-sin(iTime*0.2),cos(iTime*0.2)};
    q = mul(m,q);
    
    // repeat domain 5x
    #if 0
        // using polar coordinates
        float fa = (mod( atan2(q.y,q.x)*5.0 + kPi/2.0, 2.0*kPi ) - kPi)/5.0;
        q = length(q)*float2( sin(fa), cos(fa) );
    #else
        // using reflections
        q.x = abs(q.x);
        q -= 2.0*max(dot(k1,q),0.0)*k1;
        q -= 2.0*max(dot(k2,q),0.0)*k2;
    #endif
    
    // draw triangle
    float d = dot( float2(abs(q.x)-0.3,q.y), k3);
        
    // colorize
    float3 col = float3(0.4,0.7,0.4) - sign(d)*float3(0.2,0.1,0.0);
    col *= smoothstep(0.005,0.005+2.0*px,abs(d));
    col *= 1.1-0.2*length(q);
    
    return float4( col, 1.0 );
}