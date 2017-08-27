// Author: Prince Polka
// Title: hsb2rgb

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
vec3 hue(float H){
    H*=6.0;
    return clamp(vec3(abs(H-3.)-1.0,2.-abs(H-2.),2.-abs(H-4.)),vec3(0.0),vec3(1.0));
}
float dist(vec2 A,vec2 B) {
    A=abs(A-B);
    A*=A;
return sqrt(A.x+A.y);
}
vec3 hsb2rgb(vec3 hsb){
    vec3 rgb=vec3(mix(vec3(1.0),hue(hsb.r),hsb.g));
         rgb=vec3(mix(vec3(0.0),rgb,hsb.b));
    return clamp(rgb,vec3(0.0),vec3(1.0));
}

vec3 hsl2rgb(vec3 hsb){
    vec3 rgb=vec3(mix(vec3(hsb.b),hue(hsb.r),1.0-abs(hsb.b-0.5)*2.0));
    rgb=vec3(mix(vec3(hsb.b),rgb,hsb.g));
    return rgb;
}

vec3 rgb2hsb(vec3 c){
    float low=min(min(c.r,c.g),c.b);
    float high=max(max(c.r,c.g),c.b);
    float D=1.0/(high-low);
    float h=float(c.r==high)*(c.g-c.b)*D;
    h+=float(c.g==high)*((c.b-c.r)*D+2.0);
    h+=float(c.b==high)*((c.r-c.g)*D+4.0);
    h=mod(h,6.0)/6.0;
    return clamp(vec3(h,(high-low)/high,high),vec3(0.0),vec3(1.0));
}
void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 test = vec3(0.167,0.149,0.200);
    test=rgb2hsb(test);
    test=hsb2rgb(test);
    gl_FragColor =vec4(test,1.0);
    //gl_FragColor = vec4(hsb2rgb(vec3(mod(u_time,1.0),st.x,1.0-st.y)),1.0);
}
