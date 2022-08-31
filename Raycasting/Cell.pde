class Cell {
  int x;
  int y;
  boolean[] walls = {true, true, true, true};
  boolean visited = false;
  Cell(int i, int j) {
    x = i;
    y = j;
  }


  public void show() {
    pushMatrix();
    translate(x*scl, y*scl);
    stroke(255);
    strokeWeight(10);
    if (visited) {
      if (walls[0]) {
        line(0, 0, scl, 0);//T
      }
      if (walls[1]) {
        line(scl, 0, scl, scl);//R
      }
      if (walls[2]) {
        line(scl, scl, 0, scl);//B
      }
      if (walls[3]) {
        line(0, scl, 0, 0);//L
      }
    }
    popMatrix();
  }
  public void highlight() {
    pushMatrix();
    translate(x*scl, y*scl);
    fill(0, 0, 255, 100);
    noStroke();
    square(0, 0, scl);
    popMatrix();
  }

  public Cell checkNeighbors() {
    ArrayList <Cell> neighbors = new ArrayList<Cell>();
    int [] indices = {index(x, y-1), index(x+1, y), index(x, y+1), index(x-1, y)};
    for (int i : indices) {
      if (i!=-1) {
        Cell n = grid.get(i);
        if (!n.visited) {
          neighbors.add(n);
        }
      }
    }
    if (neighbors.size()>0) {
      return neighbors.get(floor(random(0, neighbors.size())));
    }
    return null;
  }
}
