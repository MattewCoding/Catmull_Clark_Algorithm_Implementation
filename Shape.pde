/**
 * La classe qui gère les formes
 * @author YANG Mattew
 */

class Shape{
  ArrayList<Face> faces = new ArrayList<Face>();
  ArrayList<ArrayList<Integer>> pointsUsed = new ArrayList<ArrayList<Integer>>();
  HashMap<Integer, Point> points = new HashMap<Integer, Point>();
  
  Shape(){}
  
  Shape(Face firstFace){
    addFace(firstFace);
  }
  
  Shape(int x, int y, int z){
    addFace(x,y,z);
  }
  
  /**
   * Créer un cube
   */
  Shape(Point centre, float taille){
    float trueTaille = taille/2;
    float x = centre.x;
    float y = centre.y;
    float z = centre.z;
    
    Face rightFace = new Face(new Point(x+trueTaille,y,z), taille, new Point(0, PI/2, 0));
    Face leftFace = new Face(new Point(x-trueTaille,y,z), taille, new Point(0, PI/2, 0));
    
    ArrayList<Point> allPoints = rightFace.getPoints();
    allPoints.addAll(leftFace.getPoints());
    for(int i = 0; i<allPoints.size(); i++){
      points.put(i, allPoints.get(i));
    }
    
    faces.add(rightFace);
    ArrayList<Integer> r = new ArrayList<>(Arrays.asList(0,1,2,3));
    
    faces.add(leftFace);
    ArrayList<Integer> l = new ArrayList<>(Arrays.asList(4,5,6,7));
    
    faces.add(new Face(new Point(x,y+trueTaille,z), taille, new Point(PI/2, 0, 0)));
    ArrayList<Integer> bo = new ArrayList<>(Arrays.asList(0,1,2,3));
    
    faces.add(new Face(new Point(x,y-trueTaille,z), taille, new Point(PI/2, 0, 0)));
    ArrayList<Integer> t = new ArrayList<>(Arrays.asList(0,1,2,3));
    
    faces.add(new Face(new Point(x,y,z+trueTaille), taille));
    ArrayList<Integer> f = new ArrayList<>(Arrays.asList(0,1,2,3));
    
    faces.add(new Face(new Point(x,y,z-trueTaille), taille));
    ArrayList<Integer> ba = new ArrayList<>(Arrays.asList(0,1,2,3));
    
    pointsUsed.add(r);
    pointsUsed.add(l);
    pointsUsed.add(bo);
    pointsUsed.add(t);
    pointsUsed.add(f);
    pointsUsed.add(ba);
  }
  
  void addFace(Face nextFace){
    faces.add(nextFace);
  }
  
  void addFace(int x, int y, int z){
    faces.add(new Face(x,y,z));
  }
  
  
  ArrayList<Face> getFaces(){
    return faces;
  }
  
  ArrayList<ArrayList<Integer>> getPointsUsed(){
    return pointsUsed;
  }
  
  HashMap<Integer, Point> getPoints(){
    return points;
  }
  
  void displayShape(){
    for(Face f : faces){
      f.displayFace();
    }
  }
}
