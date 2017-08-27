// Author: Prince Polka
// Title: hsb2rgb

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
vec3 hue(float H){
    H*=6.0;
    return clamp(vec3(abs(H-3.)-1.0,2.-abs(H-2.),2.-abs(H-4.)),vec3(0.0),vec3(1.0));
}
vec3 hsb2rgb(vec3 hsb){
    return vec3(mix(vec3(hsb.b),hue(hsb.r),hsb.g));
}
float rgb2hue(vec3 c){
    float low=min(min(c.r,c.g),c.b);
    float high=max(max(c.r,c.g),c.b);
    float D=1.0/(high-low);
    float h=float(c.r==high)*(c.g-c.b)*D;
    h+=float(c.g==high)*((c.b-c.r)*D+2.0);
    h+=float(c.b==high)*((c.r-c.g)*D+4.0);
    return mod(h,6.0)/6.0;
}
void main() {
    vec2 st = gl_FragCoord.xy/resolution.xy;
    gl_FragColor = vec4(hsb2rgb(vec3(mod(time,1.0),st.x,1.0-st.y)),1.0);
}
