/*
To test this on shadered.org:
Line 29 to 32 -> uncomment these lines
Line 38 to 40 -> comment these lines out

To change scroll speed:
Line 44(SCROLLSPEED) -> change the float value

To change how much time passes before the
scroll text starts again:
Line 43(ROLLOVER) -> Change the float value

To Test out the different rim lighting versions:
Line 45(LIGHTING_VERSION) -> Change the integer value to:
	- 0: No rim lighting, less aliasing
	- 1: Original lighting, lots of aliasing
	- 2: Faked rim lighting and less aliasing

The metallic features of the logo's gold rim may show
up more when the material is darker. So I've added
a variable to adjust this. It may look better with a lower 
value closer to "0.05". It is initialized to "0.2".

To adjust the logo's metallic feature:
Line 46(GOLD_VERSION) -> change the float value
*/

/*
cbuffer vars : register(b0)
{
	float2 uResolution;
	float uTime;
};*/




const float4 constant_pool:register(c0); // constants received from CPU
#define  uResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  uTime constant_pool.w // time in seconds


#define ROLLOVER 14.2
#define SCROLLSPEED 0.3
#define LIGHTING_VERSION 0
#define GOLD_VERSION 0.2
#define SPECULAR 100.
#define FRESNEL 200.
#define TEST_FACTOR 0.15
#define mod(x,y) (x-y*floor(x/y))
#define fract frac
#define iTime uTime
#define iResolution uResolution
#define mix lerp
#define atan atan2


static const float CH_A = 0x69f99;
static const float CH_B = 0x79797;
static const float CH_C = 0xe111e;
static const float CH_D = 0x79997;
static const float CH_E = 0xf171f;
static const float CH_F = 0xf1711;
static const float CH_G = 0xe1d96;
static const float CH_H = 0x99f99;
static const float CH_I = 0xf444f;
static const float CH_J = 0x88996;
static const float CH_K = 0x95159;
static const float CH_L = 0x1111f;
static const float CH_M = 0x9f999;
static const float CH_N = 0x9bd99;
static const float CH_O = 0x69996;
static const float CH_P = 0x79971;
static const float CH_Q = 0x69b5a;
static const float CH_R = 0x79759;
static const float CH_S = 0xe1687;
static const float CH_T = 0xf4444;
static const float CH_U = 0x99996;
static const float CH_V = 0x999a4;
static const float CH_W = 0x999f9;
static const float CH_X = 0x99699;
static const float CH_Y = 0x99e8e;
static const float CH_Z = 0xf843f;
static const float CH_0 = 0x6bd96;

static const float CH_1 = 0x46444;
static const float CH_2 = 0x6942f;
static const float CH_3 = 0x69496;
static const float CH_4 = 0x99f88;
static const float CH_5 = 0xf1687;
static const float CH_6 = 0x61796;
static const float CH_7 = 0xf8421;
static const float CH_8 = 0x69696;
static const float CH_9 = 0x69e84;
static const float CH_APST = 0x66400;
static const float CH_PI = 0x0faa9;
static const float CH_UNDS = 0x0000f;

static const float CH_HYPH = 0x00600; 
static const float CH_TILD = 0x0a500;
static const float CH_PLUS = 0x02720;
static const float CH_EQUL = 0x0f0f0; 
static const float CH_SLSH = 0x08421;
static const float CH_EXCL = 0x33303;
static const float CH_QUES = 0x69404; 
static const float CH_COMM = 0x00032;
static const float CH_FSTP = 0x00002;
static const float CH_QUOT = 0x55000;
static const float CH_BLNK = 0x00000;
static const float CH_COLN = 0x00202;
static const float CH_LPAR = 0x42224;
static const float CH_RPAR = 0x24442;
              
static const float CH_a = 0x0f9f8;
static const float CH_b = 0x11fbf;
static const float CH_c = 0x07117;
static const float CH_d = 0x88f9f;
static const float CH_e = 0x07537;
static const float CH_f = 0x75311;
static const float CH_g = 0x75747;
static const float CH_h = 0x11755;
static const float CH_i = 0x20222;
static const float CH_j = 0x40457;
static const float CH_k = 0x15355;
static const float CH_l = 0x22222;
static const float CH_m = 0x09f99;
static const float CH_n = 0x01f99;
static const float CH_o = 0x07557;
static const float CH_p = 0x07571;
static const float CH_q = 0x0eae8;
static const float CH_r = 0x02e22;
static const float CH_s = 0x0c243;
static const float CH_t = 0x27222;
static const float CH_u = 0x05557;
static const float CH_v = 0x05552;
static const float CH_w = 0x099f9;
static const float CH_x = 0x09669;
static const float CH_y = 0x05723;
              
static const float CH_AT = 0x6bd16;
              
static const float CH_z = 0x0742f;

static const float2 MAP_SIZE = float2(4.,5.);


float getBit( in float map, in float index )
{
    // shifting bits //we use negative exponents since this
    //also shifts bits and doesn't require a divinde
    return mod( floor( map*exp2(-index) ), 2.0 );
}

float drawChar( in float charr, in float2 pos, in float2 size, in float2 uv )
{
    //Our pos variable is where we want to start from
    uv-=pos;
    
    // We divide our pixel uv coords by the resolution to get
    //0 to  1
    uv /= size;    
    
    // result will be here
    float res;
    
    // Branchless bounding box check.
    res = step(0.0,min(uv.x,uv.y)) - step(1.0,max(uv.x,uv.y));
    
    // multiply by our map size 4x5 so the dimentions match or 
    //letter dimetions 
    uv *= MAP_SIZE;
    
    // get our bit out of our 4x5 letter
    res*=getBit( charr, 4.0*floor(uv.y) + floor(uv.x) );
    return clamp(res,0.0,1.0);
}

#define ch(c) drawChar( c, charPos, charSize, uv); charPos.x += .06;


float text( in float2 uv )
{
    // Set a general character size...
    float2 charSize = float2(.05, .05);
    // and a starting position.
    float2 charPos = float2(0.05, 0.1);
    // Draw some text!
    float chr = 0.0;
    // Bitmap text rendering!
    chr += ch(CH_X);
chr += ch(CH_y);
chr += ch(CH_l);
chr += ch(CH_i);
chr += ch(CH_t);
chr += ch(CH_o);
chr += ch(CH_l);
chr += ch(CH_BLNK);
chr += ch(CH_s);
chr += ch(CH_h);
chr += ch(CH_a);
chr += ch(CH_d);
chr += ch(CH_e);
chr += ch(CH_r);
chr += ch(CH_V);
chr += ch(CH_i);
chr += ch(CH_e);
chr += ch(CH_w);
chr += ch(CH_e);
chr += ch(CH_r);
chr += ch(CH_COMM);
chr += ch(CH_BLNK);
chr += ch(CH_b);
chr += ch(CH_a);
chr += ch(CH_s);
chr += ch(CH_e);
chr += ch(CH_d);
chr += ch(CH_BLNK);
chr += ch(CH_o);
chr += ch(CH_n);
chr += ch(CH_BLNK);
chr += ch(CH_t);
chr += ch(CH_h);
chr += ch(CH_e);
chr += ch(CH_BLNK);
chr += ch(CH_w);
chr += ch(CH_o);
chr += ch(CH_r);
chr += ch(CH_k);
chr += ch(CH_BLNK);
chr += ch(CH_o);
chr += ch(CH_f);
chr += ch(CH_BLNK);
chr += ch(CH_M);
chr += ch(CH_a);
chr += ch(CH_r);
chr += ch(CH_i);
chr += ch(CH_n);
chr += ch(CH_u);
chr += ch(CH_s);
chr += ch(CH_COMM);
chr += ch(CH_BLNK);
chr += ch(CH_t);
chr += ch(CH_h);
chr += ch(CH_i);
chr += ch(CH_s);
chr += ch(CH_BLNK);
chr += ch(CH_v);
chr += ch(CH_e);
chr += ch(CH_r);
chr += ch(CH_s);
chr += ch(CH_i);
chr += ch(CH_o);
chr += ch(CH_n);
chr += ch(CH_BLNK);
chr += ch(CH_u);
chr += ch(CH_s);
chr += ch(CH_e);
chr += ch(CH_BLNK);
chr += ch(CH_D);
chr += ch(CH_i);
chr += ch(CH_a);
chr += ch(CH_l);
chr += ch(CH_o);
chr += ch(CH_g);
chr += ch(CH_B);
chr += ch(CH_o);
chr += ch(CH_x);
chr += ch(CH_BLNK);
chr += ch(CH_i);
chr += ch(CH_n);
chr += ch(CH_s);
chr += ch(CH_t);
chr += ch(CH_e);
chr += ch(CH_a);
chr += ch(CH_d);
chr += ch(CH_BLNK);
chr += ch(CH_o);
chr += ch(CH_f);
chr += ch(CH_BLNK);
chr += ch(CH_C);
chr += ch(CH_r);
chr += ch(CH_e);
chr += ch(CH_a);
chr += ch(CH_t);
chr += ch(CH_e);
chr += ch(CH_W);
chr += ch(CH_i);
chr += ch(CH_n);
chr += ch(CH_d);
chr += ch(CH_o);
chr += ch(CH_w);
chr += ch(CH_COMM);
chr += ch(CH_BLNK);
chr += ch(CH_t);
chr += ch(CH_h);
chr += ch(CH_e);
chr += ch(CH_BLNK);
chr += ch(CH_s);
chr += ch(CH_h);
chr += ch(CH_a);
chr += ch(CH_d);
chr += ch(CH_e);
chr += ch(CH_r);
chr += ch(CH_BLNK);
chr += ch(CH_s);
chr += ch(CH_q);
chr += ch(CH_u);
chr += ch(CH_a);
chr += ch(CH_d);
chr += ch(CH_BLNK);
chr += ch(CH_i);
chr += ch(CH_s);
chr += ch(CH_BLNK);
chr += ch(CH_a);
chr += ch(CH_l);
chr += ch(CH_s);
chr += ch(CH_o);
chr += ch(CH_BLNK);
chr += ch(CH_t);
chr += ch(CH_i);
chr += ch(CH_e);
chr += ch(CH_d);
chr += ch(CH_BLNK);
chr += ch(CH_t);
chr += ch(CH_o);
chr += ch(CH_BLNK);
chr += ch(CH_a);
chr += ch(CH_BLNK);
chr += ch(CH_r);
chr += ch(CH_e);
chr += ch(CH_s);
chr += ch(CH_s);
chr += ch(CH_o);
chr += ch(CH_u);
chr += ch(CH_r);
chr += ch(CH_c);
chr += ch(CH_e);
chr += ch(CH_BLNK);
chr += ch(CH_c);
chr += ch(CH_o);
chr += ch(CH_n);
chr += ch(CH_t);
chr += ch(CH_r);
chr += ch(CH_o);
chr += ch(CH_l);
chr += ch(CH_EXCL);
chr += ch(CH_BLNK);
chr += ch(CH_g);
chr += ch(CH_r);
chr += ch(CH_e);
chr += ch(CH_e);
chr += ch(CH_t);
chr += ch(CH_i);
chr += ch(CH_n);
chr += ch(CH_g);
chr += ch(CH_BLNK);
chr += ch(CH_t);
chr += ch(CH_o);
chr += ch(CH_BLNK);
chr += ch(CH_R);
chr += ch(CH_E);
chr += ch(CH_D);
chr += ch(CH_BLNK);
chr += ch(CH_p);
chr += ch(CH_e);
chr += ch(CH_o);
chr += ch(CH_p);
chr += ch(CH_l);
chr += ch(CH_e);
chr += ch(CH_BLNK);
chr += ch(CH_a);
chr += ch(CH_n);
chr += ch(CH_d);
chr += ch(CH_BLNK);
chr += ch(CH_e);
chr += ch(CH_v);
chr += ch(CH_e);
chr += ch(CH_r);
chr += ch(CH_y);
chr += ch(CH_o);
chr += ch(CH_n);
chr += ch(CH_e);
chr += ch(CH_BLNK);
chr += ch(CH_o);
chr += ch(CH_n);
chr += ch(CH_BLNK);
chr += ch(CH_s);
chr += ch(CH_c);
chr += ch(CH_e);
chr += ch(CH_n);
chr += ch(CH_e);
chr += ch(CH_FSTP);
    
 
return chr;
}


float hash(float p)
{
	 return fract(sin(p*324.341)*23402.43);
}

//noise function used for the truchet texture.
float noise(float2 st){
    return fract(sin(dot(float2(12.23,74.343),st))*43254.);  
}






//////////////////////////////////////////////////////////////////
#define MAX_STEPS 100
#define MAX_DIST 75.
#define SURF_DIST .001
#define TAU 6.283185

#define S smoothstep
#define T iTime
#define PI 3.141592

float2x2 Rot(float a) {
    float s=sin(a);
    float c=cos(a);
    return float2x2(c, -s, s, c);
}

static const float COS_45 = cos(PI*0.25);
static const float SIN_45 = sin(PI*0.25);
static const float NCOS_45 = cos(-PI*0.25);
static const float NSIN_45 = sin(-PI*0.25);
float2x2 Rot_45 = float2x2(COS_45, -SIN_45, SIN_45, COS_45);
float2x2 Rot_N45 = float2x2(NCOS_45, -NSIN_45, NSIN_45, NCOS_45);

float magic_box(float3 p, float3 s) {
    p = abs(p)-s;
	return length(max(p, 0.))+min(max(p.x, max(p.y, p.z)), 0.);
}
float magic_box_2d(float2 p, float2 s) {
    p = abs(p)-s;
	return max(p.x,p.y);
}
float2 sdBox(float3 p, float3 s) {

     s.z += min(cos((p.x/s.x)*PI)*0.05*step(p.z,0.),
               cos((p.y/s.y)*PI)*0.05*step(p.z,0.));
             
   if(s.x < s.y)         
   s.x += max(0.,fract((1.-abs(p.y/s.y)))-0.75)*0.5*step(abs(p.y),0.2);    
    
    
    p = abs(p)-s;
	float d3 = length(max(p, 0.))+min(max(p.x, max(p.y, p.z)), 0.);
    float d2 = length(max(p.xy, 0.))+min(max(p.x,p.y), 0.);// max(p.x,p.y);
    return float2(d2,d3);
}

float2 sdBox_slant(float3 p, float3 s, float3 slant) {

     s.z += min(cos((p.x/s.x)*PI)*0.05*step(p.z,0.),
               cos((p.y/s.y)*PI)*0.05*step(p.z,0.));
             
   if(s.x < s.y)         
   s.x += max(0.,fract((1.-abs(p.y/s.y)))-0.75)*0.5*step(abs(p.y),0.2);    
    
    p += slant;
    p = abs(p)-s;
	float d3 = length(max(p, 0.))+min(max(p.x, max(p.y, p.z)), 0.);
    float d2 = length(max(p.xy, 0.))+min(max(p.x,p.y), 0.);// max(p.x,p.y);
    return float2(d2,d3);
}


static float objID = 0.;

bool checkLogoBoundingBox(float3 p){
    
    return (p.x < -4.5 || p.x > 4.5 || 
            p.y < -3. || p.y > 2. || 
            p.z < -4. || p.z > 4.);
    
}

float GetDist(float3 p) {
    //p.z *= 0.8;
    float3 oldP = p;
    float3 sp = p;
    float th = 0.0;
    float wt = 0.2 +th;
    float ht0 = 1.2 + th;
    float ht1 = 1. + th;
    float ht2 = 0.8 + th;
    float ht3 = 0.5 + th ;
    float alle = 100.;
    float tunnel;//= triTunnel(p);
    
    sp.z += iTime*6.;
    float id = floor(sp.z/2.);
    sp.z = mod(sp.z,2.)-1.;
    
    
  //   float y_tilt = sin(id*0.2)*0.01;
  ////  sp.xz *= float2x2(cos(y_tilt),-sin(y_tilt),sin(y_tilt),cos(y_tilt));
 //  float x_tilt = cos(id*0.2)*0.01;
 //   sp.yz *= float2x2(cos(x_tilt),-sin(x_tilt),sin(x_tilt),cos(x_tilt));
    
    float z = sin(id*0.2);
	sp.xy = mul(Rot(z),sp.xy);
   
    sp.x += sin(id/3.)*2.;
    sp.y += cos(id/3.)*2.;
    float rim = magic_box(sp, float3(6.3, 6.3, 0.01))-0.02;
    float wall = magic_box(sp, float3(10.5, 10.5, 0.01));
    tunnel = min(rim, wall);
    tunnel = max(tunnel, -magic_box(sp,float3(5.5,5.5,1.))+0.6);
    
    
    
    if(checkLogoBoundingBox(oldP) == false){
  //  p.x += sin(iTime+id)*3.;
  // p.y += cos(iTime+id)*3.;
    float theNoise = 0.0;
    sp = p - float3(-0.5, 0., 0.); 
    float2 d = float2(1000.,1000.);
    p -= float3(-2.3,0.,0.); 

    
    sp = p; sp-=float3(-0.6,0.,0.); sp.xy = mul(Rot(-0.7),sp.xy);///Rot_45;
    d = min(d,sdBox_slant(sp, float3(wt, ht0, wt),+float3(0., sp.x, 0.)*0.8));
    
    sp = p; sp-=float3(-0.6,0.,0.); sp.xy = mul(Rot(0.7),sp.xy);//Rot_N45;
    d = min(d,sdBox_slant(sp, float3(wt, ht0, wt),-float3(0., sp.x, 0.)*0.8));
    

    p -= float3(1.6, 0., 0.);
    sp = p; sp-=float3(-0.9,-0.4,0.); sp.xy = mul(Rot(-0.6),sp.xy);
    d = min(d,sdBox_slant(sp, float3(wt, ht2*0.6, wt),float3(0., sp.x, 0.)*0.8));
    
    sp = p; sp-=float3(-0.6,-1.,0.); sp.xy = mul(Rot(0.6),sp.xy);
    d = min(d,sdBox_slant(sp, float3(wt, ht0, wt),-float3(0., sp.x, 0.)*0.8));

    p -= float3(1.4, 0., 0.);
    d = min(d,sdBox(p-float3(-0.6,0.,0.), float3(wt, ht1, wt)));
    
    p -= float3(1.4, 0., 0.);
    sp = p;
    d = min(d,sdBox(sp-float3(-.6,0.8,0.), float3(ht2, wt, wt)));
    d = min(d,sdBox(sp-float3(0.,0.5,0.), float3(wt, ht3, wt)));
    d = min(d,sdBox(sp-float3(-.6,0.,0.), float3(ht2, wt, wt)));
    d = min(d,sdBox(sp-float3(-1.2,-0.5,0.), float3(wt, ht3, wt)));
    d = min(d,sdBox(sp-float3(-.6,-0.8,0.), float3(ht2, wt, wt)));
   
   
    p -= float3(2., 0., 0.);
    sp = p;
    d = min(d,sdBox(sp-float3(-1.2,0.,0.), float3(wt, ht1, wt)));
    d = min(d,sdBox(sp-float3(-(sin(-p.y*0.7)+0.9),0.2,0.), 
                      float3(wt, ht3*0.6, wt)));
    d = min(d,sdBox(sp-float3(sin(-p.y*0.7)-0.9,-0.5,0.), 
                      float3(wt, ht3, wt)));
   

    objID = 2.;
    
    //inner border
    if(smoothstep(-0.08,0.,min(d.x,0.)) > 0.)objID = 4.;
    
    //frame
    if(smoothstep(-0.04,0.,min(d.x,0.)) > 0.)objID = 1.;
    //if(smoothstep(0.2,0.1,abs(min(d.x,0.)-0.1)) > 0.)objID = 2.;
    float logo = d.y-smoothstep(-0.05,0.,min(d.x,0.))*.05 ;///+ d.x*0.3;
    //*  smoothstep(0.2,0.4,fract((p.x+p.y)*5.))*0.03;
    alle = min(logo,tunnel);
        if(abs(rim-alle) <0.0001){
            objID = 3.;
        }
        else if(abs(wall-alle) < 0.0001){
            objID = 5.;
        }
    
    }
    else {
    
        alle = tunnel;
        if(abs(rim-alle) <0.0001){
            objID = 3.;
        }
        else if(abs(wall-alle) < 0.0001){
            objID = 5.;
        }
    }
    return alle;
}

float RayMarch(float3 ro, float3 rd) {
	float dO=0.;
    
    for(int i=0; i<MAX_STEPS; i++) {
    	float3 p = ro + rd*dO;
        float dS = GetDist(p);
        dO += dS*0.8;
        if(dO>MAX_DIST || abs(dS)<SURF_DIST) break;
    }
    
    return dO;
}


float3 GetNormal(float3 p) {
	float d = GetDist(p);
    float2 e = float2(.001, 0);
    
    float3 n = d - float3(
        GetDist(p-e.xyy),
        GetDist(p-e.yxy),
        GetDist(p-e.yyx));
    
    return normalize(n);
}


//thanks to Shane
float softShadow(float3 ro, float3 lp, float k){

    const int maxIterationsShad = 24; 
    
    float3 rd = lp - ro; 

    float shade = 1.;
    float dist = .002;    
    float end = max(length(rd), .001);
    float stepDist = end/float(maxIterationsShad);
    
    rd /= end;

    // Max shadow iterations - More iterations make nicer shadows, but slow things down. Obviously, the lowest 
    // number to give a decent shadow is the best one to choose. 
    for (int i = 0; i<maxIterationsShad; i++){

        float h = GetDist(ro + rd*dist);
        //shade = min(shade, k*h/dist);
        shade = min(shade, smoothstep(0., 1., k*h/dist)); // Subtle difference. Thanks to IQ for this tidbit.
        // So many options here, and none are perfect: dist += min(h, .2), dist += clamp(h, .01, .2), 
        // clamp(h, .02, stepDist*2.), etc.
        dist += clamp(h, .02, .25);
        
        // Early exits from accumulative distance function calls tend to be a good thing.
        if (h<0. || dist>end) break; 
        //if (h<.001 || dist > end) break; // If you're prepared to put up with more artifacts.
    }

    // I've added 0.5 to the final shade value, which lightens the shadow a bit. It's a preference thing. 
    // Really dark shadows look too brutal to me.
    return min(max(shade, 0.) + .25, 1.); 
}


// Based on original by IQ.
float calculateAO(float3 p, float3 n){

    const float AO_SAMPLES = 5.0;
    float r = 0.0, w = 1.0, d;
    
    for (float i=1.0; i<AO_SAMPLES+1.1; i++){
        d = i/AO_SAMPLES;
        r += w*(d - GetDist(p + n*d));
        w *= .5;
    }
    
    return 1.-clamp(r,0.0,1.0);
}


float3 GetRayDir(float2 uv, float3 p, float3 l, float z) {
    float3 f = normalize(l-p),
        r = normalize(cross(float3(0,1,0), f)),
        u = cross(f,r),
        c = f*z,
        i = c + uv.x*r + uv.y*u,
        d = normalize(i);
    return d;
}


float rnd(float2 id){
    return fract(sin(id.x*12.49 + id.y*78.99)*41235.32);
}


float hexTexture(float2 p, float2 asdf) {
        p.x *= 0.57735*2.0;
        p.y += mod(floor(p.x), 2.0)*0.5;
        p = abs((mod(p, 1.0) - 0.5));
        float q = abs(max(p.x*1.5 + p.y, p.y*2.0) - 1.0);
		return 1.-smoothstep(0.,1.2,(q*8.));
}
//a modified truchet pattern function so that
//I can make dashed lines if cut = 1. instead of solid 
float truchet(float2 st,float edge, float cut){
    float d;
    
    st*=16.;
    float2 stFL = floor(st);
    float2 stFR = fract(st)-0.5;
    float id = floor(noise(stFL)*4.)*0.25;
    
    float spacing = 0.5;
    float width = 0.45;
    stFR = mul(Rot(id*TAU),stFR);
    
    float2 pos = stFR-spacing;
    
    d = abs(length(pos)-spacing) + 
            smoothstep(0.4,0.5,
            abs(fract(16.*(atan2(pos.y,pos.x)+PI)/PI)-0.5))*cut;

    pos = stFR+spacing;
    d = min(d,abs(length(pos)-spacing) + 
            smoothstep(0.4,0.5,
            abs(fract(16.*(atan2(pos.y,pos.x)+PI)/PI)-0.5))*cut
            );
    
    return smoothstep(edge,edge-0.07,d+0.1);
}

float3 pattern(float2 uv){
    float3 col = float3(0.,0.,0.);
    col = mix(col, float3(1.,1.,1.)*0.95, truchet(uv,0.25,1.));

    
    return col;
}

float getGrey(float3 p)
{
    return p.x*0.299 + p.y*0.587 + p.z*0.114;
       }



float3 triPlanar(float3 p, float3 n)
{
    
    ///old comments
    //this thing gets the normal, abs because we only need positive values, 
    //negative ones are going into the surface so not needed?
    //we get max I guess because I guess if the normal is 0 or too small it's not helpful lol
    //we get the sum and use it to get the percentage each component contributes to the whole.
 float3 norm = max(abs(n), float3(0.0001,0.0001,0.0001));	//I'll keep it simple with just this
 float sum = norm.x+norm.y+norm.z;
// norm = norm/sum;//so now the normal is a weighting factor, each component is  weight out of 100 percent
  norm = normalize(norm);
  // p/=10.;
    //I kinda get this. it's doing the scaling here, but it's still hard to visualize 
    //that adding texures of the yz, xz, and xy planes would result it a crisp image.
    //for example, if the texture was a chess board pattern...hmmm maybe.
    return float3(pattern(p.yz*1.)*norm.x + 
                pattern(p.xz*1.)*norm.y +
                pattern(p.xy*1.)*norm.z ) ;
    
}



float4 ps_main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
    float2 uv = (fragCoord.xy-.5*iResolution.xy)/iResolution.y;
	uv.y*=-1.;   // flip the y coord if you convert WebGL or GLSL shaders to HLSL shaders. 
	//float2 m = iMouse.xy/iResolution.xy;

    float3 ro = float3(0, 1, -7);
    
    //ro.yz *= Rot(-m.y*PI+1.);
   ///ro.xz *= Rot(-m.x*TAU+PI);
    
    float3 rd = GetRayDir(uv, ro, float3(0,0.,0), 1.);
	
	uv.y *= -1.;// flip the y coord back after rd generation to avoid errors
    ro.y += sin(iTime)*2.;
    ro.x += cos(iTime*0.7)*2.;
    //Ray tracing plane y=-2.0 and y=1.0
    float s = (-3.0-ro.y)/rd.y;
    if( s<0.0 ) s = (3.0-ro.y)/rd.y;
    float3 planePos=ro + rd*s;
    
   
   
    
    float3 col = float3(0.2,0.1,0.13);
    float d = RayMarch(ro, rd);

    float3 sunPos = ro+float3(1.,1.,-1.)*1.;
    float3 sunCol = float3(1.,1.,1.);
    float3 skyCol = float3(0.2,0.6,0.9)*0.4;
    float3 indCol = float3(0.5,0.9,0.5)*0.5;
    float svObjID = objID;
    
    if(d<MAX_DIST) {
        float3 sp;
        float3 p = ro + rd * d;
        float3 n = GetNormal(p);


        float sh = softShadow(p +  n*.0015, sunPos, 10.);
        float dist = max(length(sunPos-p), .001);
        float atten = (15.-(max(1.+dist*.25 + dist*dist*.5, .0)/MAX_DIST))/15.;
        
        float ao = calculateAO(p,n);
        float3 sunDir = normalize(sunPos-p);
        float sun = clamp(dot(n, sunDir), 0., 1.);
        float sky = 0.2*clamp(0.5 + 0.5*n.y, 0., 1.);
        float ind = 0.2*clamp(dot(n, normalize(sunDir*float3(-1., 0., -1.))), 0., 1.);
        float3 soil = 0.15*float3(0.4,0.2,0.15);
        float3 material = mix( float3(0.075,0.075,0.075), float3(0.1,0.1,0.1), smoothstep(0.6,0.73,p.y));
        material = mix( material, float3(0.1,0.1,0.1), 1.-smoothstep(-15.5,-15.,p.y));
        float grass = smoothstep(0.9+0.5*(p.y/15.),1.0, smoothstep(0.,1.,n.y));
        
        if(svObjID == 2.){
            material = float3(0.15,abs(p.y*0.2+0.3)*0.03,0.0);
            material = float3(0.0,0.1,abs(p.y*0.2+0.3))*0.7;
           sp = p;
           
     float3 truchetTexture = (0.5+float3(triPlanar(sp/1.5, n)))*0.5;
     
            material = pow(truchetTexture*0.3,float3(2.,2.,2.));
            material *= float3(0.7,0.12,0.05)*1.8;
            sun +=pow(1.-abs(dot(rd,n)),4.)*20.;
            sun +=pow(1.-abs(dot(rd,n)),2.)*1000.*(pow(truchetTexture.x,10.));
        }
        else if(svObjID == 1.){
            material = float3(0.0,0.15,abs(p.y*0.2+0.3));
            material = float3(0.45,0.3,0.1);
            sp = p*2.;

        material *= GOLD_VERSION;
            sun += pow(max(0.,dot(reflect(sunDir, n),-rd)),100.)*100.;
            sun +=pow(1.-abs(dot(rd,n)),8.)*200.;
            
            
        }
         else if(svObjID == 3.){
               material = float3(0.45,0.3,0.1);
            sp = p;
            material *= 0.2;
			
			if(LIGHTING_VERSION == 1){
				sun += pow(max(0.,dot(reflect(sunDir, n),-rd)),100.)*100.;
				sun +=pow(1.-abs(dot(rd,n)),8.)*1000.;
			}
			else if(LIGHTING_VERSION == 2){
				sp.z += iTime*6.;
				float id = floor(sp.z/2.);
				float z = sin(id*0.2);
				sp.xy = mul(Rot(z),sp.xy);
				sp.x += sin(id/3.)*2.;
				sp.y += cos(id/3.)*2.;
				float square = magic_box_2d(sp.xy, float2(6.3, 6.3))-0.09;
				material += max(smoothstep(-0.2,-0.5,square),0.)*0.7;
			}
			else{
				
			}
         }
        else if(svObjID == 4.){
            material = float3(0.001,0.001,0.001);
            sun += pow(max(0.,dot(reflect(sunDir, n),-rd)),10.)*10.;
            sun += pow(1.-abs(dot(rd,n)),3.)*200.;
        }
        else if(svObjID == 5.){
            sp = p;
           float id = floor(sp.z+iTime*6.);
           // sp.z = mod(sp.z,1.)-0.5;
           
            float3 gold_hex;
            if(hash(id+4.) < 0.5){
				float hx = clamp(hexTexture(sp.xy*2.,float2(5.,0.)),0.,1.)*0.3;
                gold_hex = float3(hx,hx,hx);
            }
            else{
                float tr = truchet(sp.xy*0.15,0.2,0.)*0.4;
                gold_hex =  float3(tr,tr,tr);//pattern(sp.xy*0.15)*0.4;
            }
            material = mix(float3(hash(id)+0.2,0.2,0.1),gold_hex,gold_hex.x)*0.01;//float3(0.6,0.2,0.1);
            //float gold_hex = pow(truchetTexture*0.3,float3(2.));
            //material *= float3(0.6,0.2,0.1);
            sun += pow(1.-abs(dot(rd,n)),4.)*200.;
            sun += pow(1.-abs(dot(rd,n)),2.)*1000.*(pow(gold_hex.x,1.));
        
            
        }
        
        float3 li = sun*sunCol*10.*pow(float3(sh,sh,sh),float3(1.0,1.2,1.5));
       // li += sky*skyCol*ao;
     //   li += 5.*ind*indCol*ao;
        col = material*li*1.*atten;
        
    }
    //float3 fogCol = float3(.001,0.001,0.001);//float3(0.);
    col = mix(col, float3(0.,0.,0.), step(MAX_DIST-0.001,d));
   // col = mix(col, fogCol, max(pow(d/MAX_DIST,3.),0.));
    col = pow(max(col,float3(0.,0.,0.)), float3(.545,.545,.545))*1.;	// gamma correction
    
    float2 st = fragCoord.xy/iResolution.xy;
	st.y = 1.-st.y;
    st *=  1.0 - st.yx;
    float vig = st.x*st.y * 15.0;
    vig = pow(max(vig,0.), 0.25); 
    
    col = pow(col*vig, float3(0.9,0.9,0.9));
    
    
    st = abs(uv-float2(0.,0.3));
    
    float chatBox = max(st.x-0.5,st.y+0.2);
    col = mix(col, float3(0.01,0.02,0.04),(1.-smoothstep(0.3,0.31,chatBox))*0.7);
    
    // Draw some text!
    // Get normalized UV coords.
	uv.y *= -1.;// flip the y coord if you convert WebGL or GLSL shaders to HLSL shaders.
    float2 startUV = uv;
	uv = fragCoord.xy / iResolution.xy;
	uv.y = 1.-uv.y;
    uv.x *= iResolution.x/iResolution.y; 
    uv.y += sin(uv.x*8.)*0.05+0.02;
    uv.x += iTime*0.3;
    uv.x += 12.2;
    uv.x = mod(uv.x, ROLLOVER);
    float txt = text(uv);

   uv.y -= 0.1;
    txt = text(uv);
    if(txt > 0.5 && startUV.x > -0.8 && startUV.x < 0.8){
    col = float3(1.,0.8,0.8);//float3(0.4,0.4,startUV.x*0.45+0.75)*txt;
    }
    return float4(col,1.0);
}