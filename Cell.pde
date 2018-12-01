class Cell {
  int x, y, w;
  float dist;
  Cell previous = null;
  
  Cell(int argx, int argy, int argw) {
    x = argx;
    y = argy;
    w = argw;
  }
  
  void show(color c, Boolean debug) {
    // "Real" x,y positions
    int rx = x * w;
    int ry = y * w;
    
    stroke(0);
    fill(c);
    rect(rx, ry, w, w);
    
    if (debug) {
      textSize(w / 6);
      textAlign(CENTER, CENTER);
      fill(0);
      String txt = "x: " + String.valueOf(x) + 
                   "\ny: " + String.valueOf(y) + 
                   "\nd: " + String.valueOf(dist);
      text(txt, rx, ry, w, w);
      
      if (previous != null) {
        // Previous cell's x, y positions
        int px = previous.x * w + w/2;
        int py = previous.y * w + w/2;
        line(rx + w/2, ry + w/2, px, py);
      }
    }
  }
  
  LinkedList<Cell> getNeighbours(Cell[][] grid, LinkedList<Cell> toVisit, int cols, int rows) {
    LinkedList<Cell> neighbours = new LinkedList<Cell>();
    if (x > 0) 
      neighbours.add(grid[x-1][y]);
    if (x < cols-1) 
      neighbours.add(grid[x+1][y]);
    if (y > 0) 
      neighbours.add(grid[x][y-1]);
    if (y < rows-1) 
      neighbours.add(grid[x][y+1]);
      
    if (x > 0 && y > 0) 
      neighbours.add(grid[x-1][y-1]);
    if (x < cols-1 && y > 0) 
      neighbours.add(grid[x+1][y-1]);
    if (x > 0 && y < rows-1) 
      neighbours.add(grid[x-1][y+1]);
    if (x < cols-1 && y < rows-1) 
      neighbours.add(grid[x+1][y+1]);
      
    return neighbours;
  }
}
