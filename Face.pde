class Face{
  ArrayList<Point> points = new ArrayList<Point>();
  
  Face(){}
  
  Face(Point firstPoint){
    addPoint(firstPoint);
  }
  
  Face(int x, int y, int z){
    addPoint(x,y,z);
  }
  
  Face(Point p1, Point p2, Point p3, Point p4){
    points.add(p1);
    points.add(p2);
    points.add(p3);
    points.add(p4);
  }
  
  void addPoint(Point nextPoint){
    points.add(nextPoint);
  }
  
  void addPoint(int x, int y, int z){
    points.add(new Point(x,y,z));
  }
  
  ArrayList<Point> getPoints(){
    return points;
  }
  
  void displayFace(){
    beginShape();
    for(Point p : points){
      vertex(p.getX(), p.getY(), p.getZ());
    }
    endShape(CLOSE);
  }
}
