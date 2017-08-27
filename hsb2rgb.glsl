// Author: Prince Polka
// Title: hsb <--> rgb

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
const vec3 _024 =vec3(0.0,2.0,4.0);
const vec3 zero=vec3(0.0);
const vec3 one=vec3(1.0);

vec3 hue(float H){
    H*=6.0;
    return clamp(vec3(abs(H-3.)-1.0,2.-abs(H-2.),2.-abs(H-4.)),zero,one);
}

vec3 hsb2rgb(vec3 hsb){
    vec3 rgb=vec3(mix(vec3(1.0),hue(hsb.r),hsb.g));
         rgb=vec3(mix(vec3(0.0),rgb,hsb.b));
    return clamp(rgb,vec3(0.0),vec3(1.0));
}

vec3 rgb2hsb(vec3 c){
    float low=min(min(c.r,c.g),c.b);
    float high=max(max(c.r,c.g),c.b);
    vec3 foo =((c-c.gbr)/(high-low)+_024)*vec3(c.b==high,c.r==high,c.g==high);
    return clamp(vec3(mod(4.0+dot(foo,one),6.0)/6.0,(high-low)/high,high),zero,one);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 test = vec3(0.490,0.266,0.363);
    test=rgb2hsb(test);
    test=hsb2rgb(test);
    gl_FragColor = vec4(hsb2rgb(vec3(mod(u_time,1.0),st.x,1.0-st.y)),1.0);
    //gl_FragColor =vec4(test,1.0);
}
