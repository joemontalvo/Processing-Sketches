

class Particle {
  PVector pos;
  PVector vel;
  float radius;
  int size;
  Particle() {
    randomize();
  }

  void update() {
    pos.add(vel);
  }

  void show() {
    stroke(255);
    strokeWeight(size);
    point(this.pos.x, this.pos.y);
    lines();
  }

  void lines() {
    for (Particle p : particles) {
      if (p != this) {
        float d = PVector.dist(pos, p.pos);
        if (d <= radius && radius > p.radius) {
          float stroke = map(d, 0, radius, 255, 0);
          float thickness = map(d, 0, radius, 3, 1);
          stroke(255, stroke);
          strokeWeight(thickness);
          line(pos, p.pos);
        }
      }
    }
  }

  void bounds() {
    if (pos.x > width || pos.y > height || pos.x < 0 || pos.y < 0) {
      randomize();
    }
  }

  void randomize() {
    pos = new PVector(random(width), random(height));
    vel = new PVector();
    vel = PVector.random2D();
    vel.setMag(random(0, maxVel));
    radius = random(width/4);
    size = (int)map(radius, 0, width/4, 5, 10);
  }
  
};
