/*
To test this on shadered.org:
Line 9 to 13 -> uncomment these lines
Line 17 to 19 -> comment these lines out
Line 35-39 -> see these for Mouse
*/

/*
cbuffer vars : register(b0)
{
	float2 uResolution;
	float uTime;
};
*/


const float4 constant_pool:register(c0); // constants received from CPU
#define  uResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  uTime constant_pool.w // time in seconds


#define MAX_STEPS 100
#define MAX_DIST 100.
#define SURF_DIST .001
#define TAU 6.283185
#define PI 3.141592
#define S smoothstep
#define T iTime
#define mod(x,y) (x-y*floor(x/y))
#define iTime uTime
#define iResolution uResolution
//Whenn the name of your mouse constanst
//Change the zero after MouseOn to 1
//and change the float2(...) after iMouse to mouse constant name
#define MouseOn 0
#define iMouse float2(0.5,0.45) //or MouseName
#define ROLLOVER 14.2
#define SCROLLSPEED 0.3
#define SPECULAR 100.
#define FRESNEL 200.
#define TEST_FACTOR 0.15

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




float smin3(float a, float b, float k)
{
    float x = exp(-k * a);
    float y = exp(-k * b);
    return (a * x + b * y) / (x + y);
}


float smax2(float a, float b, float k)
{
    return smin3(a, b, -k);
}
////////////////////////////NOISE///////////////////


float opSmoothUnion( float d1, float d2, float k )
{
    float h = max(k-abs(d1-d2),0.0);
    return min(d1, d2) - h*h*0.25/k;
}
//  1 out, 3 in...
float hash3(float3 p3)
{
	p3  = frac(p3 * .131);
    p3 += dot(p3, p3.zyx + 31.32);
    return frac((p3.x + p3.y) * p3.z);
}

float noise_3(in float3 p) {
    float3 i = floor( p );
    float3 f = frac( p );	
	float3 u = f*f*(3.0-2.0*f);
    
    float a = hash3( i + float3(0.0,0.0,0.0) );
	float b = hash3( i + float3(1.0,0.0,0.0) );    
    float c = hash3( i + float3(0.0,1.0,0.0) );
	float d = hash3( i + float3(1.0,1.0,0.0) ); 
    float v1 = lerp(lerp(a,b,u.x), lerp(c,d,u.x), u.y);
    
    a = hash3( i + float3(0.0,0.0,1.0) );
	b = hash3( i + float3(1.0,0.0,1.0) );    
    c = hash3( i + float3(0.0,1.0,1.0) );
	d = hash3( i + float3(1.0,1.0,1.0) );
    float v2 = lerp(lerp(a,b,u.x), lerp(c,d,u.x), u.y);
        
    return abs(lerp(v1,v2,u.z));
}
float hash2(float2 p)
{
	float3 p3  = frac(float3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return frac((p3.x + p3.y) * p3.z);
}

float noise_2(in float2 p) {
    float2 i = floor( p );
    float2 f = frac( p );	
	float2 u = f*f*(3.0-2.0*f);
    
    float a = hash2( i + float2(0.0,0.0) );
	float b = hash2( i + float2(1.0,0.0) );    
    float c = hash2( i + float2(0.0,1.0) );
	float d = hash2( i + float2(1.0,1.0) ); 
    return lerp(lerp(a,b,u.x), lerp(c,d,u.x), u.y);
}

//noise function used for the truchet texture.
float noise(float2 st){
    return frac(sin(dot(float2(12.23,74.343),st))*43254.);  
}


float terrain(float3 p) {
   float h = 0.;
   float s = 24.;
   float f = 0.06;
   float sh = 1.;
   
   for(int i = 0; i < 1; i ++){
       h += (noise_3((p+sh)*f))*s;
       f*=2.9;
       s/=2.9;
       sh += 0.;
   }
   
   return h;
}




/////////////////////////////////////////////////

// Textures
float3 checkerboard(float2 p,float size){
  p.y -= iTime*2.;
  p*=size;
  float2 f=frac(p.xy)-0.5;
  return (f.x*f.y>0.0?float3(0.7,0.7,0.7):float3(0.2,0.2,0.2));
}

// Object Color
float3 objcolor(float3 p){
  return clamp(checkerboard(p.xz,0.4),0.,1.);
}


float2x2 Rot(float a) {
    float s = sin(a);
    float c = cos(a);
    return float2x2(c, -s, s, c);
}

float sdBox(float3 p, float3 s) {
    p = abs(p)-s;
	return length(max(p, 0.))+min(max(p.x, max(p.y, p.z)), 0.);
}

float sdBox_slant(float3 p, float3 s, float3 slant) {

     s.z += min(cos((p.x/s.x)*PI)*0.05*step(p.z,0.),
               cos((p.y/s.y)*PI)*0.05*step(p.z,0.));
             
 //  if(s.x < s.y)         
  // s.x += max(0.,frac((1.-abs(p.y/s.y)))-0.75)*0.5*step(abs(p.y),0.2);    
    
    p += slant;
    p = abs(p)-s;
	float d3 = length(max(p, 0.))+min(max(p.x, max(p.y, p.z)), 0.);
    //float d2 = length(max(p.xy, 0.))+min(max(p.x,p.y), 0.);// max(p.x,p.y);
    return d3;// float2(d2,d3);
}

static float objID = 0.;

float GetDist(float3 p) {
    //p.z *= 0.8;
    float3 oldP = p;
    float th = 0.0;
    float wt = 0.2 +th;
    float ht1 = 1. + th;
    float ht2 = 0.8 + th;
    float ht3 = 0.5 + th ;
    float ht0 = 1.2 + th;
  //  p.xz *= Rot(iTime);
    
    float theNoise = 0.0;//(terrain(p*16.))*0.01;
    
    //p.yz *= Rot(theNoise*1.);
    //p.xz *= Rot(theNoise*1.);
    float3 sp = p - float3(-0., 0., 0.); 
    float d = 1000.;
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
   
   
    p -= float3(1.9, 0., 0.);
    sp = p;
    d = min(d,sdBox(sp-float3(-1.2,0.,0.), float3(wt, ht1, wt)));
    d = min(d,sdBox(sp-float3(-(sin(-p.y*0.7)+0.9),0.2,0.), 
                      float3(wt, ht3*0.6, wt)));
    d = min(d,sdBox(sp-float3(sin(-p.y*0.7)-0.9,-0.5,0.), 
                      float3(wt, ht3, wt)));
    
    float logo = d;
    sp = p;
    sp.z = abs(sp.z)-.25;
    float slice = sdBox(sp, float3(8., 8., 0.15));
    float outerLogo = d;
    outerLogo -= .02;//theNoise*2.2;
  
    outerLogo = smax2(outerLogo, -slice,8.);
    float innerLogo = logo;// max(logo,slice);
    
    //outerLogo += abs(terrain(p*16.))*0.005-0.06;
    d = min(outerLogo, innerLogo);

    
    //the twisties
    sp = p+float3(3.9,0.,-4.);
   // sp.xz *= Rot(iTime);
    sp.x = abs(sp.x)-(7.);
    sp.xz = mul(Rot(iTime + sp.y*0.71),sp.xz);
    float twisties = sdBox(sp,float3(.75, 4, .75));
     sp = p+float3(3.9,0.,-4.);
   // sp.xz *= Rot(iTime);
    sp.x = abs(sp.x)-(7.);
    sp.y = abs(sp.y)-4.5;
    twisties = min(twisties,sdBox(sp,float3(1., 0.4, 1.)));
    
    d = min(d,twisties);
    
    sp = oldP;
    //sp.y = abs(sp.y)-6.;
    float planes = -sp.y+4.;
   planes = min(planes, (sp.y+4.));
    
 //   d =min(d, planes);
    
    if(abs(outerLogo-d) < 0.001){
        objID = 1.;
    }
    else if(abs(innerLogo-d) < 0.001){
        objID = 2.;
    }
    else if(abs(twisties-d) < 0.001){
        objID = 3.;
    }
    else{
        objID = 4.;
    }
    
    return d-0.02;
}

float RayMarch(float3 ro, float3 rd) {
	float dO=0.;
    
    for(int i=0; i<MAX_STEPS; i++) {
    	float3 p = ro + rd*dO;
        float dS = GetDist(p);
        dO += dS*0.7;
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

float calcSoftshadow( in float3 ro, in float3 rd, in float mint, in float tmax)
{
	float res = 1.0;
    float t = mint;
    float ph = 1e10; // big, such that y = 0 on the first iteration
    
    for( int i=0; i<15; i++ )
    {
		float h = GetDist( ro + rd*t );
        float y = h*h/(2.0*ph);
        float d = sqrt(h*h-y*y);
        res = min( res, 10.0*d/max(0.0,t-y) );
        ph = h; 
        t += h;
        
        if( res<0.0001 || t>tmax ) break;
        
    }
    res = clamp( res, 0.0, 1.0 );
    return res*res*(3.0-2.0*res);
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
        r = normalize(cross(float3(0.,1.,0.), f)),
        u = cross(f,r),
        c = f*z,
        i = c + uv.x*r + uv.y*u,
        d = normalize(i);
    return d;
}


float rnd(float2 id){
    return frac(sin(id.x*12.49 + id.y*78.99)*41235.32);
}

float hextex2D(float2 uv,  float2 firstXY)
{
	float2 u = 6.*uv;;
    float2 s = float2(1.,1.732);
    float2 a = mod(u,s)*2.-s;
    float2 idA = floor(u/s);
    float2 b = mod(u+s*.5,s)*2.-s;
    float2 idB = floor((u+s*.5)/s);
    
    float la = length(a);
    float lb = length(b);
    
    u = la < lb ? a : b;
    float2 idSeed = la < lb ? idA : idB*1000.;
    float id = rnd(idSeed+firstXY.x*firstXY.y/800.);
    float2 st = abs(u);
    float q = max(st.x, dot(st,normalize(s)));
    float radius = pow(id*0.2,4.);
    float f = smoothstep(radius + 0., radius + 0.05, 1.0-q);
    //+firstXY.y/16.
    return frac(8.*id)*0.5;//,f*step(0.2,id));
  // return col;
}

//a modified truchet pattern function so that
//I can make dashed lines if cut = 1. instead of solid 
float truchet(float2 st,float edge, float cut){
    float d;
    
    st*=16.;
    float2 stFL = floor(st);
    float2 stFR = frac(st)-0.5;
    float id = floor(noise(stFL)*4.)*0.25;
    
    float spacing = 0.5;
    float width = 0.45;
    stFR = mul(Rot(id*TAU),stFR);
    
    float2 pos = stFR-spacing;
    
    d = abs(length(pos)-spacing) + 
            smoothstep(0.4,0.5,
            abs(frac(16.*(atan2(pos.y,pos.x)+PI)/PI)-0.5))*cut;
    //only cut if cut == 1
    pos = stFR+spacing;
    d = min(d,abs(length(pos)-spacing) + 
            smoothstep(0.4,0.5,
            abs(frac(16.*(atan2(pos.y,pos.x)+PI)/PI)-0.5))*cut
            );
    
    return smoothstep(edge,edge-0.07,d+0.1);
}

float pattern(float2 uv){
float3 col = float3(0., 0., 0.);
    ///return truchet(uv,0.2,1.);
    col = lerp(col, float3(1., 1., 1.)*0.95, truchet(uv,0.25,1.));
	//col = lerp(col, float3(0.2, 0.2, 0.2)*0.1, truchet(uv,0.22,1.)*0.8);
    //col = lerp(col, float3(1., 1., 1.)*0.99,truchet(uv, 0.1,1.));
    return col.x;
    
    return hextex2D(uv*2., float2(0.2,0.2));
}

float getGrey(float3 p)
{
    return p.x*0.299 + p.y*0.587 + p.z*0.114;
       }



float3 triPlanar(float3 p, float3 n)
{
    
  //we get the sum and use it to get the percentage each component contributes to the whole.
 float3 norm = max(abs(n), 0.0001);	//I'll keep it simple with just this
 float sum = norm.x+norm.y+norm.z;
// norm = norm/sum;//so now the normal is a weighting factor, each component is  weight out of 100 percent
  norm = normalize(norm);
  float patternResult = pattern(p.yz*8.)*norm.x + 
						pattern(p.xz*8.)*norm.y +
						pattern(p.xy*8.)*norm.z;
   return float3(patternResult, patternResult, patternResult);
    
}




float4 ps_main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
   // float2 uv = fragCoord.xy/uResolution.xy;
    
    float2 uv = (fragCoord.xy-.5*iResolution.xy)/iResolution.y;
	uv.y*=-1.;   // flip the y coord if you convert WebGL or GLSL shaders to HLSL shaders. 
    float2 m = float2(0.5,0.45);
    if(MouseOn == 1){
		m = iMouse.xy/iResolution.xy;
	}
    float3 ro = float3(0., 3., -7.);
    ro.yz = mul(Rot(-m.y*PI+1.),ro.yz);
    ro.xz = mul(Rot(-m.x*TAU+PI),ro.xz);
    
    float3 rd = GetRayDir(uv, ro, float3(0.,0.,0.), 1.);
    
    //Ray tracing plane y=-2.0 and y=1.0
    float s = (-3.0-ro.y)/rd.y;
    if( s<0.0 ) s = (3.0-ro.y)/rd.y;
    float3 planePos= ro + rd*s;
    
    float3 sunPos = ro+float3(1.,1.,-1.)*1.;
    float3 sunCol = float3(1., 1., 1.);//float3(0.7,0.2,0.2)*1.7;
    //float3 objPos = float3(Bx(14.),Bx(13.),0.);
    float3 skyCol = float3(0.2,0.6,0.9)*0.4;
    float3 indCol = float3(0.5,0.9,0.5)*0.5;
    
    float3 col = float3(0.1,0.2,0.3)*objcolor(planePos) * smoothstep( 0.3,0.8,(1.-s/MAX_DIST)-0.29);
   
    float d = RayMarch(ro, rd);

    float svObjID = objID;
    float3 sp;
    if(d<MAX_DIST*TEST_FACTOR) {
	
        float3 p = ro + rd * d;
        float3 n = GetNormal(p);
        
        float sh = calcSoftshadow( p, sunPos, 0.01, 20.0);//softShadow(p +  n*.0015,sunPos,19.);
		sh = max(sh,0.);
        float ao = calculateAO(p,n);
		ao = max(ao,0.);
		
        float3 sunDir = normalize(sunPos-p);
        float sun = clamp(dot(n, sunDir), 0., 1.);
        float sky = 0.2*clamp(0.5 + 0.5*n.y, 0., 1.);
        float ind = 0.2*clamp(dot(n, normalize(sunDir*float3(-1., 0., -1.))), 0., 1.);
        float3 soil = 0.15*float3(0.4,0.2,0.15);
        float3 material = lerp( float3(0.075,0.075,0.075), float3(0.1,0.1,0.1), smoothstep(0.6,0.73,p.y));
        material = lerp( material, float3(0.1, 0.1, 0.1), 1.-smoothstep(-15.5,-15.,p.y));
        float grass = smoothstep(0.9+0.5*(p.y/15.),1.0, smoothstep(0.,1.,n.y));
        
        if(svObjID == 2.){
            material = float3(0.15,abs(p.y*0.2+0.3)*0.03,0.0);
            material = float3(0.0,0.1,abs(p.y*0.2+0.3))*0.36;
            sp = p;
     //     sp.xz *= Rot(iTime);
            float3 truchetTexture = (0.5+float3(triPlanar(sp*0.05, n)))*0.5;
     
            material *= truchetTexture;
            sun +=pow(1.-abs(dot(rd,n)),4.)*20.;
           // sun +=pow(1.-abs(dot(rd,n)),2.)*1000.*(pow(truchetTexture.x,10.));
            material *= 3.;
        }
        else if(svObjID == 1.){
            material = float3(0.0,0.15,abs(p.y*0.2+0.3));
            material = float3(0.45,0.3,0.1);
            sp = p*2.;
            
            if(n.y >= 0.){
                material *= objcolor(sp + n*(3.-sp.y)/n.y);
            }
            else{
                material *= objcolor(sp + n*(-3.-sp.y)/n.y);
            }
            
        
            sun += pow(max(0.,dot(reflect(sunDir, n),-rd)),100.)*SPECULAR;
            sun += pow(1.-abs(dot(rd,n)),8.)*FRESNEL;
            
            
        }
         else if(svObjID == 3.){
              material = float3(0.45,0.3,0.1)*0.4;
            sp = p;
            
            if(n.y >= 0.01){
                material *= objcolor(sp + n*(3.-sp.y)/n.y);
            }
            else if(n.y < -0.01){
                material *= objcolor(sp + n*(-3.-sp.y)/n.y);
            }
            
        
            sun += pow(max(0.,dot(reflect(sunDir, n),-rd)),100.)*SPECULAR;
            sun += pow(1.-abs(dot(rd,n)),8.)*FRESNEL;
         
         }
		 /*
         else if(svObjID == 4.){
              material = float3(0.1,0.2,0.3);
            sp = p;
            
            if(n.y >= 0.){
                material *= objcolor(sp + n*(3.-sp.y)/n.y);
            }
            else{
                material *= objcolor(sp + n*(-3.-sp.y)/n.y);
            }
            
        
            //sun += pow(max(0.,dot(reflect(sunDir, n),-rd)),100.)*100.;
            //sun +=pow(1.-abs(dot(rd,n)),8.)*200.;
         
         }
		 */
		 
        float3 li = sun*sunCol*5.*0.6*pow(float3(sh,sh,sh),float3(1.0,1.2,1.5));
        li += sky*skyCol*ao;
        li += 5.*ind*indCol*ao;
        col = clamp(material*li,0.,1.);
        float3 fogCol = float3(0.,0.,0.);
		
        //col = lerp(col, fogCol, 1.-exp( -0.0006*0.92*d*d*d ));
    }
    
    col = pow(col, float3(.4545,.4545,.4545))*1.5;	// gamma correction
    
    float2 st = fragCoord.xy/iResolution.xy;
	st.y = 1.-st.y;
    st *=  1.0 - st.yx;
    float vig = st.x*st.y * 15.0;
    vig = pow(vig, 0.25); 
    
    col = pow(col*vig, float3(0.9,0.9,0.9));
    
    
    st = abs(uv+float2(0.,0.3));
    
    float chatBox = max(st.x-0.5,st.y+0.15);
    col = lerp(col, float3(0.07,0.04,0.04),(1.-smoothstep(0.3,0.31,chatBox))*0.6);
    
    // Draw the text
    float2 startUV = uv;
	uv = fragCoord.xy / iResolution.xy;
	uv.y = 1.-uv.y;
    uv.x *= iResolution.x/iResolution.y; 
    uv.y += sin(uv.x*8.)*0.05;
    uv.x += iTime*SCROLLSPEED - 2.;
    uv.x = mod(uv.x, ROLLOVER);
    float txt = text(uv);
	    
    uv.y -= 0.1;
    txt = text(uv);
    if(txt > 0.5 && startUV.x > -0.8 && startUV.x < 0.8){
    col =  float3(.2,0.8,startUV.x)*txt;
    }
    
    return float4(col,1.0);

}