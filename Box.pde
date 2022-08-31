class Box {
  PVector pos;
  float h;
  float w;
  ArrayList<Boundary> sides = new ArrayList<Boundary>();
  Box(PVector pos, float w, float h) {
    this.pos = pos;
    this.w = w;
    this.h = h;
    sides.add(new Boundary(pos.x, pos.y, pos.x+w, pos.y));
    sides.add(new Boundary(pos.x, pos.y, pos.x, pos.y+h));
    sides.add(new Boundary(pos.x+w, pos.y, pos.x+w, pos.y+h));
    sides.add(new Boundary(pos.x, pos.y+h, pos.x+w, pos.y+h));
  }
}
