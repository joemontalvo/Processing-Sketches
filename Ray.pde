class Ray {
  PVector pos;
  PVector dir;
  Ray(PVector pos, float angle) {
    this.pos = pos;
    this.dir = PVector.fromAngle(angle);
  }

 
  void show() {
    stroke(255);
    pushMatrix();
    translate(this.pos.x, this.pos.y);
    line(0, 0, this.dir.x*10, this.dir.y*10);
    popMatrix();
  }
  PVector cast(Boundary wall) {
    float x1 = wall.pt1.x;
    float y1 = wall.pt1.y;
    float x2 = wall.pt2.x;
    float y2 = wall.pt2.y;

    float x3 = this.pos.x;
    float y3 = this.pos.y;
    float x4 = this.pos.x + this.dir.x;
    float y4 = this.pos.y + this.dir.y;

    float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (den == 0) {
      return null;
    }
    float t = ((x1- x3) * (y3 -y4) - (y1 - y3) * (x3 - x4)) / den;
    float u = -((x1- x2) * (y1 -y3) - (y1 - y2) * (x1 - x3)) / den;

    if (t> 0 && t<1 && u>0) {
      return new PVector(x1+t*(x2-x1), y1+t*(y2-y1));
    } else {
      return null;
    }
  }
}
