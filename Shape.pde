/**
 * La classe qui gère les formes
 * @author YANG Mattew
 */

class Shape{
  ArrayList<Face> faces = new ArrayList<Face>();
  ArrayList<ArrayList<Integer>> pointsUsed = new ArrayList<ArrayList<Integer>>();
  HashMap<Point, Integer> points = new HashMap<Point, Integer>();
  
  Shape(){}
  
  /**
   * Make a deep copy of a Shape
   *
   * @param s The shape we are making a deep copy of
   */
  Shape(Shape s){
    this.faces = new ArrayList<Face>();
    for(Face f : s.getFaces()){
      this.faces.add(new Face(f));
    }
    
    this.pointsUsed = new ArrayList<ArrayList<Integer>>();
    for(ArrayList<Integer> innerList : s.getPointsUsed()) {
      ArrayList<Integer> copiedInnerList = new ArrayList<>(innerList);
      this.pointsUsed.add(copiedInnerList);
    }
    
    this.points = new HashMap<Point, Integer>();
    for (Point pointKey : s.getPoints().keySet()) {
      int originalInt = s.getPoints().get(pointKey);
      Point copiedPoint = new Point(pointKey);
      this.points.put(copiedPoint, originalInt);
    }
    
  }
  
  /**
   * Créer un polygone
   */
  Shape(Point centre, float taille, int shapeType){
    switch (shapeType){
      case 0:
        makeCube(centre, taille);
        break;
      case 1:
        makePyramid(centre, taille);
        break;
      case 2:
        makeTorus(taille);
        break;
    }
  }
  
  void makeTorus(float taille){
    ArrayList<Point> allPoints = new ArrayList<Point>();
    
    int nbCotes = sliderValues[4];
    double angleIncrement = 2 * Math.PI / nbCotes;
  
    // Pour que le bas du polygon soit paralèlle avec l'axe d'abscisses
    double adjust = 0;
    if (nbCotes % 4 == 0) {
      adjust = Math.PI / nbCotes;
    }
  
    int widthTorus = 50;
    // Calcul des coordonnées des points du polygone et ajout à la liste
    for (int i = 0; i < nbCotes; i++) {
      double angle = i * angleIncrement - adjust;
      
      // Pattern: inner, front, back, outer
      for(int j = -1; j <= 1; j++){
        float xVal = (float) ((taille + widthTorus*j) * Math.cos(angle));
        float yVal = (float) ((taille + widthTorus*j) * Math.sin(angle));
        
        if(j==0){
          allPoints.add(new Point(xVal, yVal, widthTorus));
          allPoints.add(new Point(xVal, yVal, -widthTorus));
        } else {
          allPoints.add(new Point(xVal, yVal, 0));
        }
      }
    }
    
    for(int i = 0; i<allPoints.size(); i++){
      points.put(allPoints.get(i), i);
    }
    
    for (int i = 0; i < nbCotes - 1; i++) {
      Point inner = allPoints.get(i*4);
      Point front = allPoints.get(i*4 + 1);
      Point back = allPoints.get(i*4 + 2);
      Point outer = allPoints.get(i*4 + 3);
      
      Point nextInner = allPoints.get((i+1)*4);
      Point nextFront = allPoints.get((i+1)*4 + 1);
      Point nextBack = allPoints.get((i+1)*4 + 2);
      Point nextOuter = allPoints.get((i+1)*4 + 3);
      
      faces.add(new Face(inner, nextInner, nextFront, front)); // Connecting: front inner
      pointsUsed.add(new ArrayList<>(Arrays.asList(i*4, (i+1)*4, (i+1)*4 + 1, i*4 + 1)));
    
      faces.add(new Face(inner, nextInner, nextBack, back)); // Connecting: back inner
      pointsUsed.add(new ArrayList<>(Arrays.asList(i*4, (i+1)*4, (i+1)*4 + 2, i*4 + 2)));
      
      faces.add(new Face(outer, nextOuter, nextFront, front)); // Connecting: front outer
      pointsUsed.add(new ArrayList<>(Arrays.asList(i*4 + 3, (i+1)*4 + 3, (i+1)*4 + 1, i*4 + 1)));
      
      faces.add(new Face(outer, nextOuter, nextBack, back)); // Connecting: back outer
      pointsUsed.add(new ArrayList<>(Arrays.asList(i*4 + 3, (i+1)*4 + 3, (i+1)*4 + 2, i*4 + 2)));
    }
    
    int i = 0;
    Point inner = allPoints.get(i*4);
    Point front = allPoints.get(i*4 + 1);
    Point back = allPoints.get(i*4 + 2);
    Point outer = allPoints.get(i*4 + 3);
    
    Point nextInner = allPoints.get((nbCotes - 1)*4);
    Point nextFront = allPoints.get((nbCotes - 1)*4 + 1);
    Point nextBack = allPoints.get((nbCotes - 1)*4 + 2);
    Point nextOuter = allPoints.get((nbCotes - 1)*4 + 3);
    
    faces.add(new Face(inner, nextInner, nextFront, front)); // Connecting: front inner
    pointsUsed.add(new ArrayList<>(Arrays.asList(i*4, (nbCotes - 1)*4, (nbCotes - 1)*4 + 1, i*4 + 1)));
  
    faces.add(new Face(inner, nextInner, nextBack, back)); // Connecting: back inner
    pointsUsed.add(new ArrayList<>(Arrays.asList(i*4, (nbCotes - 1)*4, (nbCotes - 1)*4 + 2, i*4 + 2)));
    
    faces.add(new Face(outer, nextOuter, nextFront, front)); // Connecting: front outer
    pointsUsed.add(new ArrayList<>(Arrays.asList(i*4 + 3, (nbCotes - 1)*4 + 3, (nbCotes - 1)*4 + 1, i*4 + 1)));
    
    faces.add(new Face(outer, nextOuter, nextBack, back)); // Connecting: back outer
    pointsUsed.add(new ArrayList<>(Arrays.asList(i*4 + 3, (nbCotes - 1)*4 + 3, (nbCotes - 1)*4 + 2, i*4 + 2)));
  }
  
  void makePyramid(Point centre, float taille){
    float trueTaille = taille/2;
    float x = centre.x;
    float y = centre.y;
    float z = centre.z;
    
    Face base = new Face(new Point(x,y+trueTaille,z), new Point(PI/2, 0, 0), sliderValues[4], taille*2);
    Point top = new Point(addPoints(centre, new Point(0.0, -trueTaille, 0.0)));
    ArrayList<Point> allPoints = getRealPosition(base).getPoints();
    allPoints.add(top);
    for(int i = 0; i<allPoints.size(); i++){
      points.put(allPoints.get(i), i);
    }
    
    faces.add(base);
    ArrayList<Integer> bs = new ArrayList<Integer>();
    for(int i = 0; i < sliderValues[4]; i++){
      bs.add(i);
    }
    pointsUsed.add(bs);
      
    for(int i = 0; i < sliderValues[4]; i++){
      faces.add(new Face(allPoints.get(i), allPoints.get((i+1)%sliderValues[4]), allPoints.get(sliderValues[4])));
      ArrayList<Integer> faceNums = new ArrayList<Integer>(Arrays.asList(i,(i+1)%sliderValues[4],sliderValues[4]));
      pointsUsed.add(faceNums);
    }
  }
  
  void makeCube(Point centre, float taille){
    float trueTaille = taille/2;
    float x = centre.x;
    float y = centre.y;
    float z = centre.z;
    
    Face rightFace = new Face(new Point(x+trueTaille,y,z), taille, new Point(0, PI/2, 0));
    Face leftFace = new Face(new Point(x-trueTaille,y,z), taille, new Point(0, PI/2, 0));
    
    ArrayList<Point> allPoints = getRealPosition(rightFace).getPoints();
    allPoints.addAll(getRealPosition(leftFace).getPoints());
    for(int i = 0; i<allPoints.size(); i++){
      points.put(allPoints.get(i), i);
    }
    
    faces.add(rightFace);
    ArrayList<Integer> r = new ArrayList<>(Arrays.asList(0,1,2,3));
    
    faces.add(leftFace);
    ArrayList<Integer> l = new ArrayList<>(Arrays.asList(4,5,6,7));
    
    faces.add(new Face(new Point(x,y+trueTaille,z), taille, new Point(PI/2, 0, 0)));
    ArrayList<Integer> bo = new ArrayList<>(Arrays.asList(1,2,6,5));
    
    faces.add(new Face(new Point(x,y-trueTaille,z), taille, new Point(PI/2, 0, 0)));
    ArrayList<Integer> t = new ArrayList<>(Arrays.asList(0,3,7,4));
    
    faces.add(new Face(new Point(x,y,z+trueTaille), taille));
    ArrayList<Integer> f = new ArrayList<>(Arrays.asList(2,3,7,6)); 
    
    faces.add(new Face(new Point(x,y,z-trueTaille), taille));
    ArrayList<Integer> ba = new ArrayList<>(Arrays.asList(0,1,5,4));
    
    pointsUsed.add(r);
    pointsUsed.add(l);
    pointsUsed.add(bo);
    pointsUsed.add(t);
    pointsUsed.add(f);
    pointsUsed.add(ba);
  }
  
  /**
   * Adds an edge point to the shape
   *
   * @param p The new edge point
   */
  void addPoint(Point p){
    points.put(p, points.size());
  }
  
  void addFace(Face f, ArrayList<Integer> pointNum){
    faces.add(f);
    pointsUsed.add(pointNum);
  }
  
  ArrayList<Face> getFaces(){
    return faces;
  }
  
  ArrayList<ArrayList<Integer>> getPointsUsed(){
    return pointsUsed;
  }
  
  HashMap<Point, Integer> getPoints(){
    return points;
  }
  
  void displayShape(int... faces){
    for(int i : faces){
      getFaces().get(i).displayFace();
    }
  }
  
  void displayShape(){
    for(Face f : faces){
      f.displayFace();
    }
  }
  
  void displayPoints(){
    HashMap<Point, Integer> ps = getPoints();
    for(Point p : ps.keySet()){
      p.displayPoint();
    }
  }
}
