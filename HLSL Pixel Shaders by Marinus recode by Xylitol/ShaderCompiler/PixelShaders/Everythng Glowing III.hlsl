//Everything Glowing.glsl
//Created by 834144373  2015/11/8
//https://www.shadertoy.com/view/Xt2SDc

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

///////////////////////////////////////////////////////////////////////////////////////
float3 roty(float3 p,float angle){
  float s = sin(angle),c = cos(angle);
    float3x3 rot = float3x3(
//      c, 0.,-s,
//       0.,1., 0.,
//        s, 0., c

    // hlsl rotation
      s, 0.,-c, 
       0.,1., 0.,
        c, 0., s
    );
//    return p*rot; 
    return mul(p,rot); 
}
///////////////////////////////////
//raymaching step I for normal obj
///////////////////////////////////
float obj(float3 pos){
    pos -= float3(0.,-.6,0.);
    //here you can see "inigo quilez's particles about the distance field function" who's id named "iq"....
    float res =  length(max(abs(pos)-float3(0.8,0.2,0.35),0.0))-0.1;
    res = min(res,length(abs(pos-float3(0.,0.7,0.))-float3(0.7,0.4,0.4))-.3);
    return res;
}

//raymarching step I
//find object
float disobj(float3 pointpos,float3 dir){
    float dd = 1.;
    float d = 0.;
    for(int i = 0;i<45;++i){
      float3 sphere = pointpos + dd*dir;
          d = obj(sphere);
      dd += d;
    if(d<0.02)break;
    }
    return dd;
}

//////raymarching step II for detail obj
/////////////////////////////////////////////////////////////
//Inspired form guil https://www.shadertoy.com/view/MtX3Ws
//and I changed something
float objdetal(in float3 p) {
    float res = 0.;
    float3 c = p;
    for (int i = 0; i < 10; ++i) {
        p =1.7*abs(p)/dot(p,p) -0.8;
        p=p.zxy;
        res += exp(-20. * abs(dot(p,c)));        
  }
  return res/2.;
}
////////////////////////////////////////////////////
//raymarching step II 
//raymarching  inside of the objects
//and sample the "density"="min distance" with the raymarching
float4 objdensity(float3 pointpos,float3 dir,float finaldis){
  float4 color=float4(0.,0.,0.,0.);
    float den = 0.;
    float3 sphere = pointpos + finaldis*dir;
    float dd = 0.;
    for(int j = 0;j<45;++j){
        float4 col;
        col.a = objdetal(sphere);
        float c = col.a/200.;
        col.rgb = float3(c,c,c*c);
        col.rgb *= col.a;
        col.rgb *= float(j)/20.;
        dd = 0.01*exp(-2.*col.a);
        sphere += dd*dir;
        color += col*0.8;
        if(color.a/200.>.9 || dd>200.)break;
    }
    return color*4.5;
}

/////////////////////////////////////////
/////////////////////////////////////////
#define time iTime*0.3
float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
    float2 uv = (fragCoord.xy / iResolution.xy-0.5)*2.;
    uv.x *= iResolution.x/iResolution.y;
    uv.y=-uv.y; // flip the y viewport coords, glsl to hlsl
    ///////////////////
    float3 dir = normalize(float3(uv,2.));
         dir = roty(dir,time);
    ///////////////////
    float3 campos = float3(0.,0.,-2.8);
         campos = roty(campos,time);
    //raymarching step I
    float finaldis = disobj(campos,dir);
    float4 col = float4(0.061,0.06,0.061,1.);
    if(finaldis < 20.){
        //raymarching step II
        //raymarching in raymarching, no raymarching and raymarching
        col = objdensity(campos,dir,finaldis);
        col += 0.6*col*float4(1.0,.0,.0,1.);
    }
    return float4(col.rgb,1.0);
}

