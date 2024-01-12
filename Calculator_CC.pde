import java.util.Arrays;
import java.util.Set;
import java.util.Iterator;
/**
 * Methods specifically to implement the Catmull Clark algorithm
 */


public Shape newPointCalc(Shape s, Point p, int ithPoint, Shape newShape){
  ArrayList<ArrayList<Integer>> pointsUsed = s.getPointsUsed();
  ArrayList<Face> faces = s.getFaces();
  
  // Find the faces that have the point in the parameter
  ArrayList<Integer> facesWithPoint = findFacesWithPoint(pointsUsed, ithPoint);
  
  HashMap<Point, ArrayList<Point>> facePoints = new HashMap<Point, ArrayList<Point>>();
  ArrayList<Point> edgeMidpoints = new ArrayList<Point>(); // Midpoint of vertexes to calculate THE VERTEX POINT
  
  // Finding the average of the face centers and the average of the midPoint of the vertexes
  for (int i : facesWithPoint) {
    Face faceI = getRealPosition(new Face(faces.get(i)));

    Point faceCenterI = faceCenter(faceI);
    facePoints.put(faceCenterI, new ArrayList<>());

    for (int j : facesWithPoint) {
      if (i != j) {
        Face faceJ = getRealPosition(new Face(faces.get(j)));
        ArrayList<Point> commonEdgePoints = findCommonEdgePoints(faceI, faceJ);

        if (commonEdgePoints.size() == 2) {
          edgeMidpoints.add(averageOfPoints(commonEdgePoints));

          Point edgePoint = edgeCalc(faceI, faceJ);
          facePoints.get(faceCenterI).add(edgePoint);
        }
    }
    }
  }
  Point faceAvg = averageOfPoints(facePoints.keySet());
  Point edgeAvg = averageOfPoints(edgeMidpoints);
  
  Point newVertex = new Point();
  Point F = faceAvg;
  Point R = multiplyPoint(2, edgeAvg);
  Point P = multiplyPoint(facesWithPoint.size()-3, p);
  
  newVertex = dividePoint(addPoints(addPoints(F, R), P), (float)facesWithPoint.size());
  newShape = connectCreatedPoints(newShape, newVertex, facePoints);
  
  return newShape;
}

private ArrayList<Integer> findFacesWithPoint(ArrayList<ArrayList<Integer>> pointsUsed, int ithPoint) {
  ArrayList<Integer> facesWithPoint = new ArrayList<>();

  for (int i = 0; i < pointsUsed.size(); i++) {
    if (pointsUsed.get(i).contains(ithPoint)) {
      facesWithPoint.add(i);
    }
  }

  return facesWithPoint;
}
public Point hasKey(Set<Point> pts, Point pt){
  Point hasK = null;
  for(Iterator i = pts.iterator(); i.hasNext() && hasK == null;){
    Point p = (Point) i.next();
    if(pt.equals(p)){
      hasK = p;
    }
  }
  return hasK;
}

public Shape connectCreatedPoints(Shape s, Point newVertex, HashMap<Point, ArrayList<Point>> facePAssoEdge){
  // We don't need to check if it already exists by virtue of the fact that this point
  // depends on newPointCalc's point, which changes at every call
  s.addPoint(newVertex);
  int nVValue = s.getPoints().get(newVertex);
  int p1Value=0, fPValue=0, p3Value=0;
  
  for(Point facePoint : facePAssoEdge.keySet()){
    // We do need to check for this point because this point represents its face's center
    // and is thus shared by the other points making up the face
    Point pTest = hasKey(s.getPoints().keySet(), facePoint);
    fPValue = addPointAndGetIndex(s, facePoint, pTest);
    
    // A neat property of the Catmull Clarked shape is that it is comprised of only quadralaterals
    // We can take advantage of this fact to avoid a for loop
    Point p1 = facePAssoEdge.get(facePoint).get(0);
    Point p3 = facePAssoEdge.get(facePoint).get(1);
    
    Face f = new Face(p1, facePoint, p3, newVertex);

    p1Value = addPointAndGetIndex(s, p1, hasKey(s.getPoints().keySet(), p1));
    p3Value = addPointAndGetIndex(s, p3, hasKey(s.getPoints().keySet(), p3));

    ArrayList<Integer> a = new ArrayList<>();
    a.add(p1Value);
    a.add(fPValue);
    a.add(p3Value);
    a.add(nVValue);
    s.addFace(f, a);
  }
  return s;
}

private int addPointAndGetIndex(Shape s, Point point, Point pTest) {
    if (pTest == null) {
        s.addPoint(point);
        return s.getPoints().get(point);
    } else {
        return s.getPoints().get(pTest);
    }
}

/**
 * Calculates the edge point between two faces
 *
 * @param f1   The first face.
 * @param f2   The second face.
 * @return The calculated edge point.
 */
public Point edgeCalc(Face f1, Face f2) throws RuntimeException{
  Point avg1 = faceCenter(f1), avg2 = faceCenter(f2);
  return edgeCalc(f1, f2, avg1, avg2);
}

/**
 * Find the point that is in the center of the face
 */
public Point faceCenter(Face f){
   return averageOfPoints(f.getPoints());
}
