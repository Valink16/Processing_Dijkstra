class Cell {
  int x, y, w;
  float dist;
  Boolean accessible;
  Cell previous = null;
  
  Cell(int argx, int argy, int argw, Boolean argaccessible) {
    x = argx;
    y = argy;
    w = argw;
    accessible = argaccessible;
  }
  
  void show(color c, Boolean debug) {
    // "Real" x,y positions
    int rx = x * w;
    int ry = y * w;
    
    stroke(0);
    fill(c);
    rect(rx, ry, w, w);
    if (!accessible) {
      ellipseMode(CORNER);
      noFill();
      ellipse(rx, ry, w, w);
    }
    if (debug) {
      textSize(w / 6);
      textAlign(CENTER, CENTER);
      fill(0);
      String prevTxt;
      if (previous != null)
        prevTxt = String.valueOf(previous.x) + " " + String.valueOf(previous.y);
       else
        prevTxt = "";
      String txt = "x: " + String.valueOf(x) + 
                   "\ny: " + String.valueOf(y) + 
                   "\nd: " + String.valueOf(dist) +
                   "\na: " + prevTxt;
      text(txt, rx, ry, w, w);
    }
  }
  
  void linkToPrevious() {
    if (previous != null) {
        // Previous cell's x, y positions
        float rx = x * w + w*0.5;
        float ry = y * w + w*0.5;
        float px = previous.x * w + w*0.5;
        float py = previous.y * w + w*0.5;
        line(rx, ry, px, py);
      }
  }
  
  LinkedList<Cell> getNeighbours(Cell[][] grid, LinkedList<Cell> toVisit) {
    LinkedList<Cell> neighbours = new LinkedList<Cell>();
    if (x > 0) 
      neighbours.add(grid[x-1][y]);
    if (x < grid.length-1) 
      neighbours.add(grid[x+1][y]);
    if (y > 0) 
      neighbours.add(grid[x][y-1]);
    if (y < grid[0].length-1) 
      neighbours.add(grid[x][y+1]);
      
    /*
    if (x > 0 && y > 0) 
      neighbours.add(grid[x-1][y-1]);
    if (x < grid.length-1 && y > 0) 
      neighbours.add(grid[x+1][y-1]);
    if (x > 0 && y < grid[0].length-1) 
      neighbours.add(grid[x-1][y+1]);
    if (x < grid.length-1 && y < grid[0].length-1) 
      neighbours.add(grid[x+1][y+1]);
    */
    
    // Removing the neighbours which are inaccessible
    for (int i = neighbours.size() - 1; i >= 0; i--) {
      if (!neighbours.get(i).accessible)
        neighbours.remove(i);
    }
    return neighbours;
  }
}
