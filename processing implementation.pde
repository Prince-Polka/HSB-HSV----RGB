/*
tested for all integer inputs in ranges (360,100,100) inclusive  
99.95 % of inputs give pixel perfect results, 
the rest of by one or two (manhattan distance)
no input was off by more than 2

Note if porting:
The 'color' type is syntactic sugar for 'int'  
constrain(,,) is clamp(,,) or min(max(val,0),1020)
*/
color hsb2rgb(int H, int S, int V) {
  int R, G, B;
  H *= 17;
  R = -1020+abs(H-3060);
  G =  2040-abs(H-2040);
  B =  2040-abs(H-4080);
  R = (int)constrain(R, 0, 1020)-1020;
  G = (int)constrain(G, 0, 1020)-1020;
  B = (int)constrain(B, 0, 1020)-1020;

  R = ((R*S+102000)*V)/40000;
  G = ((G*S+102000)*V)/40000;
  B = ((B*S+102000)*V)/40000;

  return (color)(0xFF000000 | R<<16 | G<<8 | B);
}
