/* ----------------------------------------------------------------------------
   -       TITULO  : Sine Wave Plasma Demo Tiny C Pixel Shader                -
   -                 My greetings to Siekmanski and Optimus                   -
   -----                                                                  -----
   -       AUTOR   : Alfonso Víctor Caballero Hurtado                         -
   -----                                                                  -----
   -       VERSION : 1.0                                                      -
   -----                                                                  -----
   -      (c) 2018. http://www.abreojosensamblador.net                        -
   -               Abre los Ojos a los Gráficos sobre Windows                 -
   ---------------------------------------------------------------------------- */

const    float4 constant_pool:register(c0); // constants received from CPU
#define  iResolution constant_pool.xyz  // viewport resolution in pixels (width, heigth, aspect ratio)
#define  iTime constant_pool.w // time in seconds

#define cdIncremento    82.
#define cdLongBase      2048.

float fsen1 (float a) {
  return (sin(a/30.)*45.);
}

float fsen2 (float a) {
  return (sin(a/60.)*90.);
}

float fsen3 (float a) {
  return (sin(a/140.)*75.);
}

float3 DaleColor (float m) {
  float3 c;
  float  d = m/256., e = 1.-d;
  c = float3(m<128.?d:e,m<128.?d:e,0);
  return (c);
}

float4 ps_main(float2 fragCoord:vpos):color // ps_3_0 input semantics, vpos contains the current pixel (x,y) location. This is only valid with ps_3_0.
{
  float2 q = fragCoord.xy;
  float K1, m;
  
  K1 = iTime*20.;
  m  = fsen2(q.x - q.y + K1+cdLongBase)+fsen1(q.y - fsen2(q.x - K1 + fsen3(fsen1(q.x - (K1+cdLongBase)) + fsen1(q.y + K1+cdLongBase) + q.y + fsen2(q.x + K1+cdLongBase) - q.y + K1+cdLongBase)+q.x +cdLongBase)+cdLongBase)+cdIncremento;
  if (m < 0) m = 0;
  return float4(DaleColor(m),1.0);
}
