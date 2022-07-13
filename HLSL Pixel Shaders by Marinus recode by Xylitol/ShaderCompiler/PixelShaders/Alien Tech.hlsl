// Alien Tech
// https://www.shadertoy.com/view/XtX3zj

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

#define mod(x,y) (x-y*floor(x/y)) // macro to simulate GLSL mod instrinsic function

//#define SHOWLIGHT //comment this line if you find the moving ligth annoying like Dave :D
#define BLINKINGLIGHTS 1.

// change this to tweak the fractal
#define c float2(2.,4.5) 

//other cool params (comment default then uncomment one of this):
//#define c float2(1.,5.)
//#define c float2(4.,.5)
//#define c float2(4.-length(p)*.2)
//#define c float2(abs(sin(p.y*2.)),5.) //love this one with blinking


#define ti iTime
static float3 ldir;
static float ot;
static float blur;


// 2D fractal based on Mandelbox
float formula(float2 p) {
    float2 t = float2(sin(ti * .3) * .1 + ti * .05, ti * .1); // move fractal
    //t+= iMouse.xy / iResolution.xy;
    p=abs(.5 - frac(p * .4 + t)) * 1.3; // tiling
    ot=1000.; 
    float l, expsmo;
    float aav=0.;
    l=0.; expsmo=0.;
    for (int i = 0; i < 11; i++) { 
        p = abs(p + c) - abs(p - c) - p; 
        p/= clamp(dot(p, p), .0007, 1.);
        p = p* -1.5 + c;
        if ( mod(float(i), 2.) < 1. ) { // exponential smoothing calc, with iteration skipping
            float pl = l;
            l = length(p);
            expsmo+= exp(-1. / abs(l - pl));
            ot=min(ot, l);
        }
    }
    return expsmo;
}

float3 light(float2 p, float3 col) {
    
    // calculate normals based on horizontal and vertical floattors being z the formula result
    float2 d = float2(0., .003);
    float d1 = formula(p - d.xy) - formula(p+d.xy);
    float d2 = formula(p - d.yx) - formula(p+d.yx); 
    float3 n1 = float3(0.    , d.y*2., -d1*.05);
    float3 n2 = float3(d.y*2., 0.    , -d2*.05);
    float3 n = normalize(cross(n1, n2));

    // lighting
    float diff = pow( max(0., dot(ldir, n)) , 2.) + .2; // lambertian diffuse + ambient
    float3 r = reflect(float3(0.,0.,1.), ldir); // half floattor
    float spec = pow( max(0., dot(r,n)) , 30.); // specular
    return diff*col + spec*.8;
}

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 uv = fragCoord.xy / iResolution.xy - .5;
    float2 aspect = float2(iResolution.x / iResolution.y, 1.);
    uv*= aspect;
    float2 pixsize = .25 / iResolution.xy * aspect; // pixel size for antialias
    float sph = length(uv); sph = sqrt(1. - sph*sph) * 1.5; // curve for spheric distortion
    uv = normalize(float3(uv, sph)).xy * 1.3; // normalize back to 2D and scale (zoom level)
    pixsize = normalize(float3(pixsize, sph)).xy * 1.3; // the same with pixsize for proper AA

    #ifdef SHOWLIGHT
    float3 lightpos = float3(sin(ti), cos(ti * .5), - .7); // moving light
    #else
    float3 lightpos=float3(0.,0.,-1.); // static light
    #endif

    lightpos.xy*= aspect * .25; // correct light coordinates
    float3 col = 0.0; //float3(0.);
    float lig = 0.;
    float titila = 0.5; //texture(iChannel0, float2(ti * .25)).x; // for light intensity variation

    // AA loop
    for ( float aa = 0.; aa<9. ; aa++ ) { 
        float2 aacoord = floor( float2(aa/3., mod(aa,3.)) ); // get coord offset for AA sample
        float2 p = uv + aacoord * pixsize; 
        ldir = normalize(float3(p, .0) + lightpos); // get light direction
        float k = clamp(formula(p) * .25, .8, 1.4); // get value for colors in the desired range
        col+= light(p, float3(k, k*k, k*k*k)); // accumulate surface color (a gradient trick)
        lig+= max(0., 2. - ot) / 2.; // accumulate orbit trap (yellow lights, shared "ot" var)
    }

    col*= .2; // correct brightness
    float2 luv = uv + lightpos.xy; // uv shift by light coords

    // min amb light + spotlight with falloff * varying intensity
    col*= .07 + pow( max(0., 1. - length(luv) * .5), 9. ) * (1. - titila * .3);
    
    // rotating star light
    float star = abs(1.5708 - mod(atan2(luv.y, luv.x) *3. - ti * 10., 3.1416)) * .02 - .05;
    #ifdef SHOWLIGHT
    col+= pow( max(0.,.3 - length(luv * 1.5) - star) / .3 , 5.) * (1. - titila * .5);
    #endif
    
    // yellow lights
    col+= pow(lig * .12, 15.) * float3(1.,.9,.3) * (.8 + BLINKINGLIGHTS * sin(ti * 5. - uv.y * 10.) * .6);
    
    return float4(col, 1.0 );
}
