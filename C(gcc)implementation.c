/* not clean but should be branchless */
#define ABS(x)(x*((x>0)*2-1))
int clamp(int x,int min, int max){
int temp = min*(x<min) + max*(x>max);
return temp + x * !temp;
}

/* shuffle components to meet your needs */
typedef union color{
struct {char blue,green,red,alpha;};
signed int i;
unsigned int u;
}color;

/* fixed range 360,100,100 -> 255 */
color hsb2rgb(int H, int S, int V) {
  int R, G, B;
  H *= 17;
  R = -1020+abs(H-3060);
  G =  2040-abs(H-2040);
  B =  2040-abs(H-4080);
  R = clamp(R, 0, 1020)-1020;
  G = clamp(G, 0, 1020)-1020;
  B = clamp(B, 0, 1020)-1020;

  R = ((R*S+102000)*V)/40000;
  G = ((G*S+102000)*V)/40000;
  B = ((B*S+102000)*V)/40000;

  /* shuffle components to meet your needs */
  color ret = {B,G,R,255};
  return ret;
}

int main(void){
color mycolor = hsb2rgb(200,80,80);
printf("0x%x\n",mycolor);
mycolor = hsb2rgb(120,100,100);
printf("0x%x\n",mycolor);
return 0;
}
