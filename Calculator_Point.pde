/**
 * Methods specifically for a/multiple Point/s
 */
import java.util.Collection;
 
 public Point averageOfPoints(ArrayList<Point> pts){
  Point centerP = new Point();
  for(Point p : pts){
    centerP = addPoints(centerP, p);
  }
  
  Point res = new Point();
  try{
    res = dividePoint(centerP, pts.size());
  } catch(ArithmeticException ae){
    print("In averageOfPoints(ArrayList<Point>) function: " + ae + "\n");
  }
  return res;
}

public Point averageOfPoints(Collection<Point> pts){
  Point centerP = new Point();
  for(Point p : pts){
    centerP = addPoints(centerP, p);
  }
  
  Point res = new Point();
  try{
    res = dividePoint(centerP, pts.size());
  } catch(ArithmeticException ae){
    print("In averageOfPoints(Collection<Point>) function: " + ae + "\n");
    exit();
  }
  return res;
}

public Point addPoints(Point p1, Point p2){
  return new Point(p1.getX() + p2.getX(), p1.getY() + p2.getY(), p1.getZ() + p2.getZ());
}

public Point multiplyPoint(float f, Point p){
  if(f == 0.0) return new Point();
  Point res = new Point();
  try{
    res = dividePoint(p, 1/f);
  } catch(ArithmeticException ae){
    print("In multiplyPoint function: " + ae + "\n");
    exit();
  }
  return res;
}

public Point dividePoint(Point p, float f) throws ArithmeticException{
  if(f == 0.0){
    throw new ArithmeticException("Division par 0.");
  }
  return new Point(p.getX()/f, p.getY()/f, p.getZ()/f);
}

public ArrayList<Point> findCommonEdgePoints(ArrayList<Point> a1, ArrayList<Point> a2){
  ArrayList<Point> a3 = new ArrayList<Point>();
  for(Point p : a1){
    if(a2.contains(p)) a3.add(p);
  }
  return a3;
}
