/**
 * Methods specifically for a/multiple Face/s
 */
 
 public Face getRealPosition(Face f){
  Point rotation = f.getRotation();
  
  float rotaYZ = rotation.getX(), rotaZX = rotation.getY(), rotaXY = rotation.getZ(); // Rotation: yz, xz, xy
  double matxTrans[][] = { {cos(rotaXY)*cos(rotaZX), -sin(rotaXY)           ,             sin(rotaZX)},
                           {sin(rotaXY)            , cos(rotaXY)*cos(rotaYZ), -sin(rotaYZ)           },
                           {           -sin(rotaZX),             sin(rotaYZ), cos(rotaYZ)*cos(rotaZX)},
                         };
  Face res = new Face(f);
  for(int i = 0; i < res.getPoints().size(); i++){
    Point newP = res.getNthPoint(i);
    float x = newP.getX(),y = newP.getY(), z = newP.getZ();
    newP.x = (float)(x*matxTrans[0][0] + y*matxTrans[0][1] + z*matxTrans[0][2] + f.getCentre().x);
    newP.y = (float)(x*matxTrans[1][0] + y*matxTrans[1][1] + z*matxTrans[1][2] + f.getCentre().y);
    newP.z = (float)(x*matxTrans[2][0] + y*matxTrans[2][1] + z*matxTrans[2][2] + f.getCentre().z);
    res.modifyNthPoint(i, newP);
  }
  
  return res;
}

/**
 * Calculates the edge point between two faces knowing their centers.
 *
 * @param f1   The first face.
 * @param f2   The second face.
 * @param avg1 The center point of the first face.
 * @param avg2 The center point of the second face.
 * @return The calculated edge point.
 * @throws RuntimeException If the faces have no common edge points.
 */
public Point edgeCalc(Face f1, Face f2, Point avg1, Point avg2) throws RuntimeException{
  ArrayList<Point> pCommon = findCommonEdgePoints(f1, f2);
  if(pCommon.size() == 0) throw new RuntimeException("Erreur: Facettes n'ont rien en commun.");
  pCommon.add(avg1);
  pCommon.add(avg2);
  
  Point res = new Point();
  res = averageOfPoints(pCommon);
  return res;
}

public ArrayList<Point> findCommonEdgePoints(Face f1, Face f2){
  return findCommonEdgePoints(f1.getPoints(), f2.getPoints());
}
