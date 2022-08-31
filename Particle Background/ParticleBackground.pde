

ArrayList<Particle> particles = new ArrayList<Particle>();
int pNum = 75;
final float maxVel = .5;
boolean recording = false;

void setup() {
  size(1080, 1080);
  for (int i = 0; i< pNum; i++) {
    particles.add(new Particle());
  }
}


void draw() {
  background(0);
  for (Particle p : particles) {
    p.update();
    p.show();
  }

  for (Particle p : particles) {
    p.bounds();
  }
  
  if(recording){
    saveFrame("pb_####.png");
  }
}


void line(PVector a, PVector b) {
  line(a.x, a.y, b.x, b.y);
}
