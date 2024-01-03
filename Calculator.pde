class Calculator{
  Calculator(){}
  
  public Point edgeCalc(Face f1, Face f2){
    Point avg1 = faceCenter(f1), avg2 = faceCenter(f2);
    ArrayList<Point> pCommon = findCommonEdgePoints(f1, f2);
    if(pCommon.size() == 0) throw new RuntimeException("Erreur: Facettes n'ont rien en commun.");
    pCommon.add(avg1);
    pCommon.add(avg2);
    return dividePoint(centerOfPoints(pCommon), 4);
  }
  
  public Point faceCenter(Face f) throws ArithmeticException{
      return centerOfPoints(f.getPoints());
  }
  
  public Point centerOfPoints(ArrayList<Point> pts) throws ArithmeticException{
      Point centerP = new Point();
      for(Point p : pts){
        centerP = addPoints(centerP, p);
      }
      return dividePoint(centerP, pts.size());
  }
  
  public ArrayList<Point> findCommonEdgePoints(Face f1, Face f2){
    ArrayList<Point> p1 = f1.getPoints();
    ArrayList<Point> p2 = f2.getPoints();
    ArrayList<Point> p3 = new ArrayList<Point>();
    for(Point p : p1){
      if(p2.contains(p)) p3.add(p);
    }
    return p3;
  }
  
  public Point addPoints(Point p1, Point p2){
    return new Point(p1.getX() + p2.getX(), p1.getY() + p2.getY(), p1.getZ() + p2.getZ());
  }
  
  public Point multiplyPoint(Point p, float f){
    if(f == 0.0) return new Point();
    return dividePoint(p, 1/f);
  }
  
  public Point dividePoint(Point p, float f) throws ArithmeticException{
    if(f == 0.0){
      throw new ArithmeticException("Division par 0.");
    }
    return new Point(p.getX()/f, p.getY()/f, p.getZ()/f);
  }
}
