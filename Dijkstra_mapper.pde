import java.util.LinkedList;

int cols = 100;
int rows = 100;
int cellWidth = 10;

Cell[][] grid = new Cell[cols][rows]; // double array representing the grid

Cell start;
Cell end;
LinkedList<Cell> path = new LinkedList<Cell>();


void settings() {
  size(cols*cellWidth, rows*cellWidth);
}

void setup() {
  frameRate(10);
  // Setting up the grid
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      Boolean r = random(1) < 0.9;
      //println(r);
      grid[i][j] = new Cell(i, j, cellWidth, r);
    }
  }
  
  start = grid[0][0];
  end = grid[cols-1][rows-1];
  
  start.accessible = true;
  
  mapDijkstra(grid, start);
  
  path.add(start);
}

void draw() {
  for (Cell[] row : grid) {
    for (Cell cell : row) {
      cell.show(color(0, 255, 255), true);
    }
  }
  
  for (Cell[] row : grid) {
    for (Cell cell : row) {
      cell.linkToPrevious();
    }
  }
  
  for (Cell cell : path) {
    cell.show(color(0, 0, 255), false);
  }
}

void mousePressed() {
  int mx = floor(mouseX/cellWidth);
  int my = floor(mouseY/cellWidth);
  println(mx, my);
  
  end = grid[mx][my];
  
  path = retrace(end, start);
}
