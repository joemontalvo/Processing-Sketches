class Particle {
  PVector pos;
  ArrayList<Ray> rays = new ArrayList<Ray>();
  int fov = 45;
  int viewDist = 3*width/4;
  float step = 1;
  float heading = 0;
  Particle() {
    pos = new PVector(scl/2, scl/2);
    for (float a = -(fov/2); a <=fov/2; a+=step) {
      rays.add(new Ray(pos, radians(a)));
    }
  }

  void rot(float angle) {
    this.heading +=angle;
    rays.clear();
    for (float a = -(fov/2); a <=fov/2; a+=step) {
      rays.add(new Ray(pos, radians(a)+this.heading));
    }
  }
  void move(float val){
    PVector move = PVector.fromAngle(heading).normalize();
    move.setMag(val);
    pos.add(move);
    rays.clear();
    for (float a = -(fov/2); a <=fov/2; a+=step) {
      rays.add(new Ray(pos, radians(a)+this.heading));
    }
    
  }

  void update(float x, float y) {
    pos.set(x, y);
  }
  void show() {
    for (Ray r : rays) {
      r.show();
    }
  }

  float[] rayCast() {
    float [] scene = new float [rays.size()];
    
    for (int i = 0; i<this.rays.size(); i++) {
      float record = 99999999;
      for (Boundary wall : walls) {
        PVector pt = rays.get(i).cast(wall);
        if (pt != null) {
          float d = this.pos.dist(pt);
          float a = rays.get(i).dir.heading() - this.heading;
          d *= cos(a);
          if (d<record) {
            record = d;
          }
        }
      }
      scene[i] = record;
    }
    return scene;
  }
}
