//The road to Hell
//https://www.shadertoy.com/view/Mds3Rn


const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds


static const float PI=3.14159265358979323846;

#define mod(x,y) (x-y*floor(x/y))
#define speed (iTime*0.2975)
#define ground_x (1.0-0.325*sin(PI*speed*0.25))
static float ground_y=1.0;
static float ground_z=0.5;


float2 rotate(float2 k,float t)
    {
    return float2(cos(t)*k.x-sin(t)*k.y,sin(t)*k.x+cos(t)*k.y);
    }

float draw_scene(float3 p)
    {
    float tunnel_m=0.125*cos(PI*p.z*1.0+speed*4.0-PI);
    float tunnel1_p=2.0;
    float tunnel1_w=tunnel1_p*0.225;
    float tunnel1=length(mod(p.xy,tunnel1_p)-tunnel1_p*0.5)-tunnel1_w;  // tunnel1
    float tunnel2_p=2.0;
    float tunnel2_w=tunnel2_p*0.2125+tunnel2_p*0.0125*cos(PI*p.y*8.0)+tunnel2_p*0.0125*cos(PI*p.z*8.0);
    float tunnel2=length(mod(p.xy,tunnel2_p)-tunnel2_p*0.5)-tunnel2_w;  // tunnel2
    float hole1_p=1.0;
    float hole1_w=hole1_p*0.5;
    float hole1=length(mod(p.xz,hole1_p).xy-hole1_p*0.5)-hole1_w;   // hole1
    float hole2_p=0.25;
    float hole2_w=hole2_p*0.375;
    float hole2=length(mod(p.yz,hole2_p).xy-hole2_p*0.5)-hole2_w;   // hole2
    float hole3_p=0.5;
    float hole3_w=hole3_p*0.25+0.125*sin(PI*p.z*2.0);
    float hole3=length(mod(p.xy,hole3_p).xy-hole3_p*0.5)-hole3_w;   // hole3
    float tube_m=0.075*sin(PI*p.z*1.0);
    float tube_p=0.5+tube_m;
    float tube_w=tube_p*0.025+0.00125*cos(PI*p.z*128.0);
    float tube=length(mod(p.xy,tube_p)-tube_p*0.5)-tube_w;          // tube
    float bubble_p=0.05;
    float bubble_w=bubble_p*0.5+0.025*cos(PI*p.z*2.0);
    float bubble=length(mod(p.yz,bubble_p)-bubble_p*0.5)-bubble_w;  // bubble
    return max(min(min(-tunnel1,lerp(tunnel2,-bubble,0.375)),max(min(-hole1,hole2),-hole3)),-tube);
    }

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 position=(fragCoord.xy/iResolution.xy);
    float2 p=-1.0+2.0*position;
    float3 dir=normalize(float3(p*float2(1.77,1.0),1.0));       // screen ratio (x,y) fov (z)
    //dir.yz=rotate(dir.yz,PI*0.5*sin(PI*speed*0.125)); // rotation x
    dir.zx=rotate(dir.zx,-PI*speed*0.25);               // rotation y
    dir.xy=rotate(dir.xy,-speed*0.5);                   // rotation z
    float3 ray=float3(ground_x,ground_y,ground_z-speed*2.5);
    float t=0.0;
    const int ray_n=96;
    for(int i=0;i<ray_n;i++)
        {
        float k=draw_scene(ray+dir*t);
        t+=k*0.75;
        }
    float3 hit=ray+dir*t;
    float2 h=float2(-0.0025,0.002); // light
    float3 n=normalize(float3(draw_scene(hit+h.xyx),draw_scene(hit+h.yxy),draw_scene(hit+h.yyx)));
    float c=(n.x+n.y+n.z)*0.35;
    float3 color=float3(c,c,c)+t*0.0625;
    return float4(float3(c-t*0.0375+p.y*0.05,c-t*0.025-p.y*0.0625,c+t*0.025-p.y*0.025)+color*color,1.0);
}
