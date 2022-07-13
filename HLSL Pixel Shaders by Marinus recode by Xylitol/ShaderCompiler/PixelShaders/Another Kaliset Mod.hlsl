//Another Kaliset Mod
//https://www.shadertoy.com/view/Xls3z2

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

#define mod(x,y) (x-y*floor(x/y)) // add this macro to simulate GLSL mod instrinsic

#define time iTime
#define size iResolution

static float3 mcol,ro;
static float dL=100.0;
static float mxscl, ltpos;

float DE(float3 z0)
{
    float4 z = float4(z0,1.0);
    float d=100.0;
    for (int n = 0; n < 7; n++) {//kaliset mod
        z.xyz=abs(z.yzx+float3(-0.25,-0.75,-1.5)+ro*0.1);
        z/=min(dot(z.xyz,z.xyz),mxscl);
        d=min(d,(length(z.xy)+abs(z.z)*0.01)/z.w);
        if(n==2)dL=min(dL,(length(z.xy)+abs(z.z+ltpos)*0.1)/z.w);
        if(n==3)mcol=float3(0.7,0.6,0.5)+sin(z.xyz)*0.1;
    }
    return d;
}

float rndStart(float2 co){return 0.1+0.9*frac(sin(dot(co,float2(123.42,117.853)))*412.453);}

float3x3 lookat(float3 fw,float3 up){
    fw=normalize(fw);float3 rt=normalize(cross(fw,up));return float3x3(rt,cross(rt,fw),fw);
}

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    mxscl=max(0.5,abs(sin(time*0.1))*2.5);
    ltpos=-1.5+sin(time*10.0);
    float pxl=2.0/size.y;//find the pixel size
    float tim=time*0.3;
    
    //position camera
    ro=float3(cos(tim*1.1),-1.11,sin(tim*0.7))*(2.0+0.7*cos(tim*1.3))+float3(1.0,1.0,1.0);
    float3 rd=normalize(float3((2.0*fragCoord.xy-size.xy)/size.y,2.0));

    rd= mul(lookat(float3(1.0,0.0,0.0)-ro,float3(0.0,1.0,0.0)),rd);
    //ro=eye;rd=normalize(dir);
    float3 LDir=normalize(float3(0.4,0.75,0.4));//direction to light
    float3 bcol=float3(0.0,0.0,0.0);
    //march
    
    
    float t=DE(ro)*rndStart(fragCoord.xy),d,od=1.0;
    float4 col=float4(0.0,0.0,0.0,0.0);//color accumulator
    for(int i=0;i<99;i++){
        d=DE(ro+rd*t);
        float px=pxl*(1.0+t);
        if(d<px){
            float3 scol=mcol;
            float d2=DE(ro+rd*t+LDir*px);
            float shad=abs(d2/d),shad2=max(0.0,1.0-d/od);
            scol=scol*shad+float3(0.2,0.0,-0.2)*(shad-0.5)+float3(0.1,0.15,0.2)*shad2;
            scol*=3.0*max(0.2,shad2);
            scol/=(1.0+t)*(0.2+10.0*dL*dL);
            
            float alpha=(1.0-col.w)*saturate(1.0-d/(px));
            col+=float4(saturate(scol),1.0)*alpha;
            if(col.w>0.9)break;
        }
        col.rgb+=float3(0.01,0.02,0.03)/(1.0+1000.0*dL*dL)*(1.0-col.w);
        od=d;
        t+=d*0.5;
        if(t>20.0)break;
    }
    col.rgb+=bcol*(1.0-saturate(col.w));

    return float4(col.rgb,1.0);
}