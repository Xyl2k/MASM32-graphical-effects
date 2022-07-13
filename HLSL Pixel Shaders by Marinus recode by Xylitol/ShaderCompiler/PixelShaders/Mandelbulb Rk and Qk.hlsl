// Mandelbulb Rk and Qk
// https://www.shadertoy.com/view/4d3XDl


const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

static float k,qk,rk;
static float3 mcol;

float Rk(float k){return 1.0/pow(k,1./(k-1.))-1.0/pow(k,k/(k-1.));}
float Qk(float k){return pow(2.,1./(k-1.));}

float DE(float3 z0){//mandelBulb by twinbee
   float4 c = float4(z0,1.0),z = c;
   float r = length(z.xyz),zo,zi,r1=r;
   for (int n = 0; n < 7; n++) {
      if(r>qk+0.25)break;//experimenting with early bailout
      zo = asin(z.z / r) * k +iTime;
      zi = atan2(z.x, z.y) * 7.0;//even messing with the rotations stays in bounds
      z=pow(r, k-1.0)*float4(r*float3(cos(zo)*float2(cos(zi),sin(zi)),sin(zo)),z.w*k)+c;
      r = length(z.xyz);
   }
   mcol=10.0*z.xxz/z.w+clamp(r-rk,0.0,3.0)*0.15;
   return 0.5 * min(r1-rk,log(r) * r / z.w);
}

float rndStart(float2 co){return 0.1+0.9*frac(sin(dot(co,float2(123.42,117.853)))*412.453);}

float sphere( in float3 ro, in float3 rd, in float r){
   float b=dot(-ro,rd);
   float h=b*b-dot(ro,ro)+r*r;
   if(h<0.0)return -1.;
   return b-sqrt(h);
}

float3x3 lookat(float3 fw,float3 up){
   fw=normalize(fw);float3 rt=normalize(cross(fw,up));return float3x3(rt,cross(rt,fw),fw);
}


float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
   float pxl=1.0/iResolution.x;//find the pixel size
   float tim=iTime*0.3;
   k=7.0+sin(tim)*3.0;
   qk=Qk(k);
   rk=Rk(k);
   //position camera
   float3 ro=float3(abs(cos(tim)),sin(tim*0.3),abs(sin(tim)))*(qk+0.5);
   float3 rd=normalize(float3((fragCoord-0.5*iResolution.xy)/iResolution.y,1.0));
   rd= mul(lookat(-ro,float3(0.0,1.0,0.0)),rd);
   float3 LDir=normalize(float3(0.4,0.75,0.4));//direction to light
   float3 bcol=float3(0.5+0.25*rd.y,0.5+0.25*rd.y,0.5+0.25*rd.y);
   float4 col=float4(0.0,0.0,0.0,0.0);//color accumulator
   //march
   float t=sphere(ro,rd,qk+0.01);
   
  if(t>0.0){
   t+=DE(ro+rd*t)*rndStart(fragCoord);
   float d,od=1.0;
   for(int i=0;i<99;i++){
      d=DE(ro+rd*t);
      float px=pxl*(1.+t);
      if(d<px){
         float3 scol=mcol;
         float d2=DE(ro+rd*t+LDir*px);
         float shad=abs(d2/d),shad2=max(0.0,1.0-d/od);
         scol=scol*shad+float3(0.2,0.0,-0.2)*(shad-0.5)+float3(0.1,0.15,0.2)*shad2;
         scol*=3.0*max(0.2,shad2);
         scol/=(1.0+t);//*(0.2+10.0*dL*dL);
         
         float alpha=(1.0-col.w)*clamp(1.0-d/(px),0.0,1.0);
         col+=float4(clamp(scol,0.0,1.0),1.0)*alpha;
         if(col.w>0.9)break;
      }
      od=d;
      t+=d;
      if(t>6.0)break;
   }
  }
    col.rgb+=bcol*(1.0-clamp(col.w,0.0,1.0));

    return float4(col.rgb,1.0);
}
