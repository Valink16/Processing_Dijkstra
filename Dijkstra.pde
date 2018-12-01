import java.util.LinkedList;

int cols = 20;
int rows = 20;
int cellWidth = 50;

Cell[][] grid = new Cell[cols][rows]; // double array representing the grid
LinkedList<Cell> toVisit = new LinkedList<Cell>();

Cell start;
Cell end;

Cell current;
LinkedList<Cell> currentNeighbours;
LinkedList<Cell> path;
float tmpDist;

void settings() {
  size(cols*cellWidth, rows*cellWidth);
}

void setup() {
  frameRate(10);
  // Setting up the grid
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Cell(i, j, cellWidth);
    }
  }
  
  // Initialising important variables
  for (Cell[] row : grid) {
    for (Cell cell: row) {
      cell.dist = Float.POSITIVE_INFINITY;
      toVisit.add(cell);
    }
  }
  
  start = grid[0][0];
  end = grid[cols-1][rows-1];
  
  start.dist = 0;
}

void draw() {
  for (Cell[] row : grid) {
    for (Cell cell: row) {
      cell.show(color(0, 255, 255), true);
    }
  }
  
  if (toVisit.size() > 0) {
    current = toVisit.get(0);
    for (Cell cell : toVisit) {
      if (cell.dist < current.dist) {
        current = cell;
      }
    }
    toVisit.remove(current);
    current.show(color(0, 255, 0), true);
    if (current == end) {
      println("We finally arrived !");
      path = retrace(end, start);
      println("Path's length : ", path.size());
      for (Cell cell : path) {
        cell.show(color(0), false);
      }
      noLoop();
    }
    
    currentNeighbours = current.getNeighbours(grid, toVisit, cols, rows);
    
    for (Cell neighbour : currentNeighbours) {
      if (toVisit.contains(neighbour)) {
        neighbour.show(color(255, 0, 0), false);
        tmpDist = current.dist + dist(current.x, current.y, neighbour.x, neighbour.y);
        if (tmpDist < neighbour.dist) {
          neighbour.dist = tmpDist;
          neighbour.previous = current;
        }
      }
    }
  }
}

void mouseClicked() {
  // Resetting everything
  toVisit.clear();
  currentNeighbours.clear();
  path.clear();
  
  for (Cell[] row : grid) {
    for (Cell cell: row) {
      cell.dist = Float.POSITIVE_INFINITY;
      cell.previous = null;
      toVisit.add(cell);
    }
  }
  
  start.dist = 0;
  
  end = grid[floor(mouseX / cellWidth)][floor(mouseY / cellWidth)];
  loop();
}
