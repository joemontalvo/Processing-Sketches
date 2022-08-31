class Boundary {
  PVector pt1;
  PVector pt2;

  Boundary(float x1, float y1, float x2, float y2) {
    pt1 = new PVector(x1, y1);
    pt2 = new PVector(x2, y2);
  }
  Boundary(PVector pt_1, PVector pt_2) {
    pt1 = pt_1;
    pt2 = pt_2;
  }
}
