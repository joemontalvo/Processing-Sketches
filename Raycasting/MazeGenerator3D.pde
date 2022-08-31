ArrayList<Cell> grid = new ArrayList<Cell>();
ArrayList <Cell> stack = new ArrayList<Cell>();
int cols, rows;
Cell current;
float scl;
ArrayList<Boundary> walls = new ArrayList<Boundary>();
ArrayList<Box> boxes = new ArrayList<Box>();
Particle p;
boolean running = false;


void setup() {
  size(800 , 800);
  scl = width / 8;
  rectMode(CENTER);
  boxes.add(new Box(new PVector(-1, -1), (width/2)+1, height+1));
  for (Box b : boxes) {
    for (int i = 0; i<b.sides.size(); i++) {
      walls.add(b.sides.get(i));
    }
  }
  p = new Particle();
  GenerateMaze();
}

void draw() {
  background(0);
  float [] scene = p.rayCast();
  float w = (width) / scene.length;
  pushMatrix();
  for (int i = 0; i<scene.length; i++) {
    noStroke();
    float n = map(scene[i], 0, p.viewDist, 0, 1);
    //n = cos(n);
    float b = map(n, 0, 1, 255, 0);
    float h = map(n, 0, 1, 3*height/4, 0);
    fill(b);
    rect(i*w+w/2, height/2, w, h);
  }
  popMatrix();

  drawMap();
}

void drawMap(){
  pushMatrix();
  translate(0, 0);
  scale(.1);
  for (Cell c : grid) {
    c.show();
  }
  p.show();
  popMatrix();
}

void GenerateMaze() {
  cols = (int) (width/scl);
  rows = (int) (height/scl);

  for (int y = 0; y<rows; y++) {
    for (int x = 0; x<cols; x++) { 
      grid.add(new Cell(x, y));
    }
  }
  
  current = grid.get(0);

  while (allVisited()) {
    current.visited = true;
    current.highlight();
    //STEP 1
    Cell next = current.checkNeighbors();
    if (next != null) {
      next.visited = true;
      //STEP 2
      stack.add(current);
      //STEP 3
      removeWalls(current, next);    
      //STEP 4
      current = next;
    } else if (stack.size()>0) {
      current = stack.remove(stack.size()-1);
    }
  }

  for (Cell c : grid) {
    int x = c.x;
    int y = c.y;
    if (c.walls[0]) {
      walls.add(new Boundary(x*scl, y*scl, (x*scl)+scl, y*scl));//T
    }
    if (c.walls[1]) {
      walls.add(new Boundary((x*scl)+scl, y*scl, (x*scl)+scl, (y*scl)+scl));//R
    }
    if (c.walls[2]) {
      walls.add(new Boundary((x*scl)+scl, (y*scl)+scl, (x*scl), (y*scl)+scl));//B
    }
    if (c.walls[3]) {
      walls.add(new Boundary((x*scl), (y*scl)+scl, (x*scl), (y*scl)));//L
    }
  }
}

public void removeWalls(Cell a, Cell b) {
  int xDif = a.x - b.x;
  int yDif = a.y - b.y;

  if (xDif == 1) {
    a.walls[3] = false;
    b.walls[1] = false;
  } else if (xDif == -1) {
    a.walls[1] = false;
    b.walls[3] = false;
  }
  if (yDif == 1) {
    a.walls[0] = false;
    b.walls[2] = false;
  } else if (yDif == -1) {
    a.walls[2] = false;
    b.walls[0] = false;
  }
}

public int index(int x, int y) {
  if (x<0|| y<0||x>cols-1 || y>rows-1) {
    return -1;
  } else {
    return x + y *cols;
  }
}


public boolean allVisited() {
  for (Cell c : grid) {
    if (!c.visited) {
      return true;
    }
  }
  return false;
}

void keyPressed() {
  if (key == 'a') {
    p.rot(-.1);
  }
  if (key == 'd') {
    p.rot(.1);
  }
  if (key == 'w') {
    p.move(5);
  }
  if (key == 's') {
    p.move(-5);
  }
}
