LinkedList<Cell> retrace(Cell from, Cell to) {
  LinkedList<Cell> path = new LinkedList<Cell>();
  
  Boolean done = false;
  Cell current = from;
   
  while(!done) {
    if (current.previous != null) {
      path.add(current);
      current = current.previous;
    } else {
      done = true;
    } 
  }
  
  println(path.size());
  return path;
}

Boolean mapDijkstra(Cell[][] grid, Cell start) {
  
  Cell current;
  LinkedList<Cell> toVisit = new LinkedList<Cell>();
  LinkedList<Cell> currentNeighbours;
  float tmpDist;
  
  // Setting up the grid
  for (Cell[] row : grid) {
    for (Cell cell: row) {
      cell.dist = Float.POSITIVE_INFINITY;
      toVisit.add(cell);
    }
  }
  start.dist = 0;
  
  while (toVisit.size() > 0) {
    current = toVisit.get(0);
    for (Cell cell : toVisit) {
      if (cell.dist < current.dist) {
        current = cell;
      }
    }
    toVisit.remove(current);
    current.show(color(0, 255, 0), true);
    
    currentNeighbours = current.getNeighbours(grid, toVisit);
    
    for (Cell neighbour : currentNeighbours) {
      if (toVisit.contains(neighbour)) {
        tmpDist = current.dist + dist(current.x, current.y, neighbour.x, neighbour.y);
        if (tmpDist < neighbour.dist) {
          neighbour.dist = tmpDist;
          neighbour.previous = current;
        }
      }
    }
  }
  return true;
}
