
float inc = TWO_PI / 600;
float n = 3;
float d = 1;
float a = 0;
ArrayList<PVector> points;
color b = color(0,0,255);
color r = color(255,0,0);
boolean recording = false;
void setup() {
  points = new ArrayList<PVector>();
  size(650, 650);
  strokeWeight(20);
  
  
  //noFill();
}


void draw() {
  background(0);
  float k = n/d;
  float r = 300 * sin(k * a);
  float x = r * cos(a);
  float y = r * sin(a);
  points.add(new PVector(x, y));

  for (int i = 0; i < points.size(); i++) {
    pushMatrix();
    translate(width/2, height/2);
    float grd = map(i, 0, points.size(),0,1);
    color c = lerpColor(color(255,0,0),color(0,0,255),grd);
    float alp = map(i,0,points.size(),0,255);
    stroke(c,alp);
    point(points.get(i).x,points.get(i).y);
    popMatrix();
  }
  if(points.size() > 1000 * (1/n)){
    recording = true;
    points.remove(0);
  }
  a += inc;
  
  if(a-(d/2)*TWO_PI > d*TWO_PI){
    exit();
  }
  
  if(recording){
    saveFrame("/Users/joseph/Desktop/Polar Equations/pe_####.png");
  }
}
