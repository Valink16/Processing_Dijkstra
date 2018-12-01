LinkedList<Cell> retrace(Cell from, Cell to) {
  LinkedList<Cell> path = new LinkedList<Cell>();
  
  Boolean done = false;
  Cell current = from;
   
  while(!done) {
    if (current == to || current == null) {
      done = true;
    }
    path.add(current);
    current = current.previous;
  }
  return path;
}
